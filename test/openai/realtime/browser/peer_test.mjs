import {test} from 'node:test';
import assert from 'node:assert/strict';
import {BrowserPeer} from '../../../../examples/realtime/browser/peer.js';

const deferred = () => { let resolve; const promise = new Promise(r => { resolve = r; }); return {promise, resolve}; };
const tick = () => new Promise(resolve => setImmediate(resolve));
function fixture(mode = 'backend') {
  const track = {stopped: false, stop() { this.stopped = true; }, addEventListener() {}};
  const stream = {getTracks: () => [track]};
  const timers = new Map();
  const requests = [];
  const status = [];
  const audio = {srcObject: null, pause() {}, play: async () => {}};
  const env = {
    crypto: {randomUUID: () => '00000000-0000-4000-8000-000000000001'},
    AbortController, AbortSignal,
    setTimeout(fn, delay) { const key = {}; timers.set(key, {fn, delay}); return key; },
    clearTimeout(key) { timers.delete(key); },
    navigator: {mediaDevices: {getUserMedia: async () => stream}},
    RTCPeerConnection: class {
      constructor() { env.pc = this; this.connectionState = 'new'; }
      addTrack() {}
      getReceivers() { return []; }
      createDataChannel() {
        this.dc = {readyState: 'connecting', close() { this.readyState = 'closed'; this.onclose?.(); }};
        return this.dc;
      }
      async createOffer() { return {type: 'offer', sdp: 'fake native offer'}; }
      async setLocalDescription(offer) { this.localDescription = offer; }
      async setRemoteDescription(answer) {
        this.answer = answer;
        this.connectionState = 'connected';
        this.dc.readyState = 'open';
        this.onconnectionstatechange();
        this.dc.onopen();
      }
      close() { this.connectionState = 'closed'; this.onconnectionstatechange?.(); }
    },
    async fetch(path, options) {
      requests.push({path, ...options});
      return {ok: true, json: async () => ({value: 'ek_fake', sdp: 'fake answer'}), text: async () => 'fake answer'};
    },
  };
  const peer = new BrowserPeer({mode, audio, environment: env, status: value => status.push(value)});
  return {peer, env, track, stream, timers, requests, status, audio};
}

test('Stop during permission prompt closes late microphone without allocating', async () => {
  const f = fixture(); const mic = deferred();
  f.env.navigator.mediaDevices.getUserMedia = () => mic.promise;
  const start = f.peer.start('fake app token');
  f.peer.stop(); mic.resolve(f.stream); await start;
  assert.equal(f.track.stopped, true);
  assert.equal(f.env.pc, undefined);
  assert.deepEqual(f.requests, []);
  assert.equal(f.status.at(-1), 'Stopped');
});

test('Stop aborts pending secret delivery and ignores stale startup', async () => {
  const f = fixture('direct'); const reply = deferred();
  f.env.fetch = async (path, options) => { f.requests.push({path, ...options}); return reply.promise; };
  const start = f.peer.start('fake token'); await tick();
  f.peer.stop();
  reply.resolve({ok: true, json: async () => ({value: 'ek_fake'})}); await start;
  assert.equal(f.requests.length, 1);
  assert.equal(f.requests[0].signal.aborted, true);
  assert.equal(f.track.stopped, true);
  assert.equal(f.env.pc.dc.readyState, 'closed');
});

test('direct flow sends only ephemeral credential to OpenAI and closes media on Stop', async () => {
  const f = fixture('direct');
  await f.peer.start('fake app token');
  assert.equal(f.status.at(-1), 'Connected');
  assert.equal(f.requests[0].path, '/api/secret');
  assert.equal(f.requests[1].headers.Authorization, 'Bearer ek_fake');
  assert.equal(f.requests[1].body, 'fake native offer');
  assert.equal(f.env.pc.answer.sdp, 'fake answer');
  f.peer.stop();
  assert.equal(f.track.stopped, true);
  assert.equal(f.env.pc.connectionState, 'closed');
  assert.equal(f.audio.srcObject, null);
  assert.equal(f.timers.size, 0);
});

test('backend acknowledges only connected peer and Stop waits for server release', async () => {
  const f = fixture(); await f.peer.start('fake app token');
  assert.deepEqual(f.requests.map(r => r.path), ['/api/calls', '/api/ack']);
  assert.equal(f.status.at(-1), 'Connected');
  assert.equal(await f.peer.stop(), true);
  assert.equal(f.requests.at(-1).path, '/api/stop');
  assert.equal(f.requests.at(-1).signal.aborted, false);
  assert.equal(f.track.stopped, true);
  assert.equal(f.timers.size, 0);
});

test('Stop during backend allocation uses independent cleanup even if answer is lost', async () => {
  const f = fixture(); const answer = deferred(); const original = f.env.fetch;
  f.env.fetch = (path, options) => path === '/api/calls' ? answer.promise : original(path, options);
  const start = f.peer.start('fake token'); await tick();
  assert.equal(await f.peer.stop(), true);
  answer.resolve({ok: true, json: async () => ({sdp: 'fake answer'})}); await start;
  assert.equal(f.env.pc.answer, undefined);
  assert.deepEqual(f.requests.map(r => r.path), ['/api/stop']);
  assert.equal(f.track.stopped, true);
});

test('failed remote SDP handoff reclaims backend call and microphone', async () => {
  const f = fixture();
  const start = f.peer.start('fake token');
  await Promise.resolve();
  f.env.pc.setRemoteDescription = async () => { throw new Error('fake invalid SDP'); };
  await start; await tick();
  assert.equal(f.requests.at(-1).path, '/api/stop');
  assert.equal(f.status.at(-1), 'Start failed');
  assert.equal(f.track.stopped, true);
});

test('terminal peer and data channel failures clean up established sessions', async () => {
  for (const failure of ['peer', 'channel', 'api']) {
    const f = fixture(); await f.peer.start('fake token');
    if (failure === 'peer') { f.env.pc.connectionState = 'failed'; f.env.pc.onconnectionstatechange(); }
    if (failure === 'channel') f.env.pc.dc.onclose();
    if (failure === 'api') f.env.pc.dc.onmessage({data: '{"type":"error","error":"private"}'});
    await tick();
    assert.equal(f.track.stopped, true);
    assert.equal(f.peer.current, null);
    assert.equal(f.requests.at(-1).path, '/api/stop');
    assert.equal(f.status.join(' ').includes('private'), false);
  }
});

test('startup timeout covers stalled negotiation and failed hangup is reported', async () => {
  const f = fixture();
  f.env.RTCPeerConnection.prototype.setRemoteDescription = async () => {};
  const original = f.env.fetch;
  f.env.fetch = (path, options) => path === '/api/stop' ? Promise.resolve({ok: false}) : original(path, options);
  const start = f.peer.start('fake token'); await tick();
  [...f.timers.values()].find(t => t.delay === 30000).fn();
  await start; await tick();
  assert.equal(f.status.at(-1), 'Stopped; server cleanup pending');
  assert.equal(f.track.stopped, true);
});

test('lease renewal failure stops rather than leaving live media without server ownership', async () => {
  const f = fixture(); await f.peer.start('fake token');
  const original = f.env.fetch;
  f.env.fetch = (path, options) => path === '/api/renew' ? Promise.resolve({ok: false}) : original(path, options);
  await [...f.timers.values()].find(t => t.delay === 10000).fn();
  assert.equal(f.peer.current, null);
  assert.equal(f.track.stopped, true);
});
