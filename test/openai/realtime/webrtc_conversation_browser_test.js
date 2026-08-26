"use strict";

const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const test = require("node:test");
const vm = require("node:vm");

class Element {
  constructor() {
    this.listeners = new Map();
    this.disabled = false;
    this.textContent = "";
    this.value = "";
    this.srcObject = null;
    this.children = [];
    this.scrollHeight = 0;
  }

  addEventListener(name, callback) {
    this.listeners.set(name, callback);
  }

  dispatch(name, event = {}) {
    return this.listeners.get(name)?.(event);
  }

  append(value) {
    this.children.push(value);
  }

  replaceChildren() {
    this.children = [];
  }

  play() {
    return Promise.resolve();
  }
}

function deferred() {
  let resolve;
  let reject;
  const promise = new Promise((fulfill, fail) => {
    resolve = fulfill;
    reject = fail;
  });
  return {promise, resolve, reject};
}

function flush() {
  return new Promise((resolve) => setImmediate(resolve));
}

function createBrowser({microphone, fetch}) {
  const elements = new Map();
  for (const selector of [
    "#application-token",
    "#start",
    "#stop",
    "#status",
    "#transcript",
    "#remote-audio"
  ]) {
    elements.set(selector, new Element());
  }
  elements.get("#application-token").value = "synthetic-application-token";
  elements.get("#stop").disabled = true;

  const page = new Element();
  const connections = [];
  const tracks = [];
  const channels = [];
  const requests = [];

  class PeerConnection extends Element {
    constructor() {
      super();
      this.closed = false;
      this.connectionState = "new";
      this.localDescription = null;
      this.remoteDescription = null;
      connections.push(this);
    }

    addTrack(track) {
      tracks.push(track);
    }

    createDataChannel() {
      const channel = new Element();
      channel.closed = false;
      channel.close = () => { channel.closed = true; };
      channels.push(channel);
      return channel;
    }

    async createOffer() {
      return {type: "offer", sdp: "synthetic-offer"};
    }

    async setLocalDescription(description) {
      this.localDescription = description;
    }

    async setRemoteDescription(description) {
      this.remoteDescription = description;
    }

    close() {
      this.closed = true;
      this.connectionState = "closed";
    }
  }

  const context = {
    AbortController,
    document: {
      querySelector: (selector) => elements.get(selector),
      createTextNode: (text) => text
    },
    navigator: {mediaDevices: {getUserMedia: microphone}},
    RTCPeerConnection: PeerConnection,
    window: page,
    fetch: (url, options) => {
      requests.push({url, options});
      return fetch(url, options);
    }
  };
  const html = fs.readFileSync(
    path.resolve(__dirname, "../../../examples/realtime/webrtc_conversation.html"),
    "utf8"
  );
  const script = html.match(/<script nonce="__CSP_NONCE__">([\s\S]*?)<\/script>/);
  assert.ok(script, "browser example must contain its nonce-protected script");
  vm.runInNewContext(script[1], context);

  return {elements, page, connections, tracks, channels, requests};
}

function microphoneStream() {
  const track = {stopped: false, stop() { this.stopped = true; }};
  return {
    track,
    getAudioTracks: () => [track],
    getTracks: () => [track]
  };
}

test("stop remains available during pending microphone permission and stops stale tracks", async () => {
  const permission = deferred();
  const browser = createBrowser({
    microphone: () => permission.promise,
    fetch: () => assert.fail("cancelled microphone startup must not mint a credential")
  });

  const startup = browser.elements.get("#start").dispatch("click");
  assert.equal(browser.elements.get("#stop").disabled, false);
  browser.elements.get("#stop").dispatch("click");

  const stream = microphoneStream();
  permission.resolve(stream);
  await startup;

  assert.equal(stream.track.stopped, true);
  assert.equal(browser.connections[0].closed, true);
  assert.equal(browser.elements.get("#start").disabled, false);
  assert.equal(browser.elements.get("#stop").disabled, true);
  assert.equal(browser.requests.length, 0);
});

test("stopping during token issuance aborts fetch and releases every media resource", async () => {
  const stream = microphoneStream();
  const issued = deferred();
  const browser = createBrowser({microphone: async () => stream, fetch: () => issued.promise});

  const startup = browser.elements.get("#start").dispatch("click");
  await flush();
  assert.equal(browser.requests[0].url, "/token");
  const signal = browser.requests[0].options.signal;

  browser.elements.get("#stop").dispatch("click");
  issued.reject(Object.assign(new Error("aborted"), {name: "AbortError"}));
  await startup;

  assert.equal(signal.aborted, true);
  assert.equal(stream.track.stopped, true);
  assert.equal(browser.channels[0].closed, true);
  assert.equal(browser.connections[0].closed, true);
  assert.equal(browser.elements.get("#remote-audio").srcObject, null);
});

test("page dismissal aborts pending browser-owned SDP exchange", async () => {
  const stream = microphoneStream();
  const negotiation = deferred();
  const browser = createBrowser({
    microphone: async () => stream,
    fetch: async (url) => {
      if (url === "/token") {
        return {ok: true, json: async () => ({value: "ek_synthetic_ephemeral"})};
      }
      return negotiation.promise;
    }
  });

  const startup = browser.elements.get("#start").dispatch("click");
  await flush();
  assert.equal(browser.requests[1].url, "https://api.openai.com/v1/realtime/calls");
  assert.equal(browser.requests[1].options.headers.Authorization, "Bearer ek_synthetic_ephemeral");

  browser.page.dispatch("pagehide");
  negotiation.reject(Object.assign(new Error("aborted"), {name: "AbortError"}));
  await startup;

  assert.equal(browser.requests[1].options.signal.aborted, true);
  assert.equal(stream.track.stopped, true);
  assert.equal(browser.channels[0].closed, true);
  assert.equal(browser.connections[0].closed, true);
});

test("failed peer connections release microphone and channel without exposing details", async () => {
  const stream = microphoneStream();
  const browser = createBrowser({
    microphone: async () => stream,
    fetch: async (url) => {
      if (url === "/token") {
        return {ok: true, json: async () => ({value: "ek_synthetic_ephemeral"})};
      }
      return {ok: true, text: async () => "synthetic-answer"};
    }
  });

  await browser.elements.get("#start").dispatch("click");
  const connection = browser.connections[0];
  assert.equal(connection.remoteDescription.type, "answer");
  assert.equal(connection.remoteDescription.sdp, "synthetic-answer");

  connection.connectionState = "failed";
  connection.dispatch("connectionstatechange");

  assert.equal(stream.track.stopped, true);
  assert.equal(browser.channels[0].closed, true);
  assert.equal(connection.closed, true);
  assert.equal(browser.elements.get("#status").textContent, "Connection failed.");
});

test("application secrets remain on loopback while ephemeral secrets go only to OpenAI", async () => {
  const stream = microphoneStream();
  const browser = createBrowser({
    microphone: async () => stream,
    fetch: async (url) => {
      if (url === "/token") {
        return {ok: true, json: async () => ({value: "ek_synthetic_ephemeral"})};
      }
      return {ok: true, text: async () => "synthetic-answer"};
    }
  });

  await browser.elements.get("#start").dispatch("click");

  assert.equal(browser.requests.length, 2);
  assert.equal(browser.requests[0].options.headers.Authorization, "Bearer synthetic-application-token");
  assert.equal(browser.requests[0].options.headers["X-Realtime-CSRF"], "__CSRF_TOKEN__");
  assert.equal(browser.requests[0].options.cache, "no-store");
  assert.equal(browser.requests[1].options.headers.Authorization, "Bearer ek_synthetic_ephemeral");
  assert.equal(browser.requests[1].options.body, "synthetic-offer");
  assert.equal(browser.requests[1].options.cache, "no-store");
  assert.equal(browser.requests[1].options.headers["X-Realtime-CSRF"], undefined);

  browser.elements.get("#stop").dispatch("click");
});
