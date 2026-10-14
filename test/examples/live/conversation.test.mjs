import test from "node:test";
import assert from "node:assert/strict";
import {getEventListeners} from "node:events";
import {setImmediate} from "node:timers/promises";
import {createConversation} from "../../../examples/live/conversation/conversation.mjs";

const deferred = () => {
  let resolve, reject;
  const promise = new Promise((yes, no) => { resolve = yes; reject = no; });
  return {promise, resolve, reject};
};
class Track extends EventTarget {
  enabled = true;
  stopped = false;
  stop() { this.stopped = true; }
}
const stream = () => {
  const track = new Track();
  return {track, getTracks: () => [track], getAudioTracks: () => [track]};
};
class Channel extends EventTarget {
  readyState = "open";
  sent = [];
  send(value) { this.sent.push(JSON.parse(value)); }
  close() { this.readyState = "closed"; this.dispatchEvent(new Event("close")); }
  emit(event) { this.dispatchEvent(new MessageEvent("message", {data: JSON.stringify(event)})); }
}
function harness(iceGatheringState = "complete") {
  const peers = [], statuses = [], buttons = [], hints = [], timers = new Map();
  const microphone = stream();
  const audio = {srcObject: null, pause() {}, play: async () => {}};
  let nextTimer = 0;
  class Peer extends EventTarget {
    connectionState = "new";
    iceGatheringState = iceGatheringState;
    channel = new Channel();
    constructor() { super(); peers.push(this); }
    addTrack() {}
    createDataChannel(name) { assert.equal(name, "oai-events"); return this.channel; }
    async createOffer() { return {type: "offer", sdp: "fake offer"}; }
    async setLocalDescription(value) { this.localDescription = value; }
    async setRemoteDescription(value) { this.remoteDescription = value; }
    close() { this.connectionState = "closed"; this.dispatchEvent(new Event("connectionstatechange")); }
  }
  const platform = {
    AbortController, RTCPeerConnection: Peer,
    navigator: {mediaDevices: {getUserMedia: async () => microphone}},
    fetch: async (_url, options) => {
      assert.equal(options.body, "fake offer");
      return {ok: true, json: async () => ({session: {id: "live_fake"}, transport: {type: "webrtc", sdp: "fake answer"}})};
    },
    setTimeout: (callback, ms) => { const id = ++nextTimer; timers.set(id, {callback, ms}); return id; },
    clearTimeout: (id) => timers.delete(id)
  };
  const controller = createConversation({audio, platform, status: (s) => statuses.push(s),
    controls: (...args) => buttons.push(args), playbackHint: (s) => hints.push(s)});
  const ready = () => peers.at(-1).channel.emit({type: "session.started", session: {id: "live_fake"}});
  const fire = (ms) => {
    const entry = [...timers].find(([, value]) => value.ms === ms);
    assert.ok(entry, `timer ${ms} exists`);
    timers.delete(entry[0]); entry[1].callback();
  };
  return {controller, platform, peers, statuses, buttons, hints, microphone, audio, timers, ready, fire};
}

test("session close waits for its final event before releasing native resources", async () => {
  const h = harness();
  await h.controller.start(); h.ready();
  h.controller.stop(); h.controller.stop();
  const peer = h.peers[0];
  assert.deepEqual(peer.channel.sent, [{type: "session.close"}]);
  assert.equal(h.microphone.track.enabled, false);
  assert.equal(h.microphone.track.stopped, false);
  assert.notEqual(peer.connectionState, "closed");
  peer.channel.emit({type: "session.closed", session: {id: "live_fake"}, usage: {seconds: 12.5}, reason: "close_requested"});
  assert.equal(h.microphone.track.stopped, true);
  assert.equal(peer.connectionState, "closed");
  assert.match(h.statuses.at(-1), /finalized.*12.5/);
  assert.deepEqual(h.buttons.at(-1), [false, false]);
  assert.equal(h.timers.size, 0);
});

test("cancelling microphone permission stops late tracks and cannot start a connection", async () => {
  const h = harness(), permission = deferred();
  h.platform.navigator.mediaDevices.getUserMedia = () => permission.promise;
  const starting = h.controller.start(); h.controller.stop();
  permission.resolve(h.microphone); await starting;
  assert.equal(h.microphone.track.stopped, true);
  assert.equal(h.peers.length, 0);
  assert.match(h.statuses.at(-1), /cancelled/);
});

test("stop during fetch aborts it and ignores a late answer", async () => {
  const h = harness(), fetched = deferred(), entered = deferred();
  let signal;
  h.platform.fetch = (_url, options) => { signal = options.signal; entered.resolve(); return fetched.promise; };
  const starting = h.controller.start(); await entered.promise;
  h.controller.stop();
  assert.equal(signal.aborted, true);
  fetched.resolve({ok: true, json: async () => { throw new Error("late result must not be read"); }});
  await starting;
  assert.equal(h.peers[0].remoteDescription, undefined);
  assert.equal(h.microphone.track.stopped, true);
  assert.equal(h.timers.size, 0);
});

test("the offer includes gathered candidates before the one-shot SDP exchange", async () => {
  const h = harness("gathering");
  let requests = 0;
  const fetch = h.platform.fetch;
  h.platform.fetch = (url, options) => {
    requests++;
    assert.equal(options.body, "offer with candidates");
    return fetch(url, {...options, body: "fake offer"});
  };
  const starting = h.controller.start();
  await setImmediate();
  assert.equal(requests, 0);
  const peer = h.peers[0];
  peer.localDescription = {type: "offer", sdp: "offer with candidates"};
  peer.iceGatheringState = "complete";
  peer.dispatchEvent(new Event("icegatheringstatechange"));
  await starting;
  assert.equal(requests, 1);
  assert.equal(getEventListeners(peer, "icegatheringstatechange").length, 0);
  h.controller.dispose();
});

test("cancellation and deadline settle ICE gathering without sending a late offer", async () => {
  for (const timeout of [false, true]) {
    const h = harness("gathering");
    let requests = 0;
    h.platform.fetch = () => { requests++; throw new Error("must not send"); };
    const starting = h.controller.start();
    await setImmediate();
    const peer = h.peers[0];
    assert.equal(getEventListeners(peer, "icegatheringstatechange").length, 1);
    if (timeout) h.fire(30_000); else h.controller.stop();
    await starting;
    assert.equal(getEventListeners(peer, "icegatheringstatechange").length, 0);
    peer.iceGatheringState = "complete";
    peer.dispatchEvent(new Event("icegatheringstatechange"));
    assert.equal(requests, 0);
    assert.equal(h.microphone.track.stopped, true);
    assert.equal(peer.connectionState, "closed");
    assert.equal(h.timers.size, 0);
  }
});

test("startup and finalization deadlines release resources without claiming success", async () => {
  for (const started of [false, true]) {
    const h = harness(); await h.controller.start();
    if (started) { h.ready(); h.controller.stop(); h.fire(15_000); } else h.fire(30_000);
    assert.match(h.statuses.at(-1), /unconfirmed/);
    assert.equal(h.microphone.track.stopped, true);
    assert.equal(h.peers[0].connectionState, "closed");
    assert.equal(h.timers.size, 0);
  }
});

test("terminal loss and service error clean up without exposing event contents", async () => {
  for (const kind of ["failed", "error", "close", "malformed", "wrong-session"]) {
    const h = harness(); await h.controller.start(); h.ready();
    const peer = h.peers[0];
    if (kind === "failed") { peer.connectionState = "failed"; peer.dispatchEvent(new Event("connectionstatechange")); }
    if (kind === "error") peer.channel.emit({type: "error", error: {message: "private sample"}});
    if (kind === "close") peer.channel.close();
    if (kind === "malformed") peer.channel.dispatchEvent(new MessageEvent("message", {data: "private sample"}));
    if (kind === "wrong-session") peer.channel.emit({type: "session.closed", session: {id: "other"}, usage: {seconds: 1}, reason: "close_requested"});
    assert.equal(h.microphone.track.stopped, true);
    assert.match(h.statuses.at(-1), /unconfirmed/);
    assert.doesNotMatch(h.statuses.join(" "), /private sample/);
  }
});

test("temporary disconnect recovers and persistent disconnect times out", async () => {
  const h = harness(); await h.controller.start(); h.ready();
  const peer = h.peers[0];
  peer.connectionState = "disconnected"; peer.dispatchEvent(new Event("connectionstatechange"));
  peer.connectionState = "connected"; peer.dispatchEvent(new Event("connectionstatechange"));
  assert.ok(![...h.timers.values()].some((t) => t.ms === 10_000));
  assert.equal(h.microphone.track.stopped, false);
  peer.connectionState = "disconnected"; peer.dispatchEvent(new Event("connectionstatechange"));
  h.fire(10_000);
  assert.equal(h.microphone.track.stopped, true);
});

test("session duration requests graceful close and page exit is best effort", async () => {
  const h = harness(); await h.controller.start(); h.ready(); h.fire(300_000);
  assert.deepEqual(h.peers[0].channel.sent, [{type: "session.close"}]);
  h.controller.dispose();
  assert.equal(h.microphone.track.stopped, true);
  assert.equal(h.timers.size, 0);
  assert.match(h.statuses.at(-1), /unconfirmed/);
});

test("permission denial is recoverable and stale events do not end a new run", async () => {
  const h = harness();
  h.platform.navigator.mediaDevices.getUserMedia = async () => { throw new Error("private browser detail"); };
  await h.controller.start();
  assert.deepEqual(h.buttons.at(-1), [false, false]);
  h.platform.navigator.mediaDevices.getUserMedia = async () => stream();
  await h.controller.start(); h.ready(); const old = h.peers[0]; h.controller.dispose();
  await h.controller.start(); h.ready();
  old.channel.emit({type: "error"});
  assert.equal(h.peers[1].connectionState, "new");
  assert.match(h.statuses.at(-1), /Connected/);
  h.controller.dispose();
});

test("playback rejection leaves a usable audio control and releases remote tracks on stop", async () => {
  const h = harness(); h.audio.play = async () => { throw new Error("blocked"); };
  await h.controller.start(); h.ready(); const remote = stream();
  const trackEvent = new Event("track"); trackEvent.streams = [remote];
  h.peers[0].dispatchEvent(trackEvent); await Promise.resolve();
  assert.match(h.hints.at(-1), /Play button/);
  assert.equal(h.audio.srcObject, remote);
  h.controller.dispose();
  assert.equal(remote.track.stopped, true);
  assert.equal(h.audio.srcObject, null);
});
