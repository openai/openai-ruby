import {test} from 'node:test';
import assert from 'node:assert/strict';
import {BrowserPeer} from '../../../../examples/realtime/browser/peer.js';

const deferred = () => { let resolve; const promise = new Promise(r => { resolve = r; }); return {promise, resolve}; };
const tick = () => new Promise(resolve => setImmediate(resolve));
const after = (delay, value, signal) => new Promise((resolve, reject) => {
  setTimeout(() => resolve(value), delay);
  signal?.addEventListener('abort', () => reject(new DOMException('Stopped', 'AbortError')), {once: true});
});

function timedFixture(t) {
  t.mock.timers.enable({apis: ['setTimeout']});
  const f = fixture();
  f.env.setTimeout = setTimeout;
  f.env.clearTimeout = clearTimeout;
  // Node's native AbortSignal clock is separate from the mock timer clock.
  f.env.AbortSignal = {timeout(delay) {
    const controller = new AbortController();
    setTimeout(() => controller.abort(), delay);
    return controller.signal;
  }};
  return f;
}

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
  f.peer.stop(); await start;
  mic.resolve(f.stream); await tick();
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
  assert.equal(f.peer.stopping, true);
  assert.equal([...f.timers.values()].some(t => t.delay === 5000), true);
});

test('backend acknowledges only connected peer and Stop waits for server release', async () => {
  const f = fixture(); await f.peer.start('fake app token');
  assert.deepEqual(f.requests.map(r => r.path), ['/api/calls', '/api/ack']);
  assert.equal(f.status.at(-1), 'Connected');
  assert.equal(await f.peer.stop(), true);
  assert.equal(f.requests.at(-1).path, '/api/stop');
  assert.equal(f.requests.at(-1).signal.aborted, false);
  assert.equal(f.track.stopped, true);
  assert.equal(f.peer.stopping, true);
  assert.equal([...f.timers.values()].some(t => t.delay === 5000), true);
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
  f.env.RTCPeerConnection.prototype.setRemoteDescription = async () => { throw new Error('fake invalid SDP'); };
  await f.peer.start('fake token'); await tick();
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
  [...f.timers.values()].find(t => t.delay === 60000).fn();
  await start; await tick();
  assert.equal(f.status.at(-1), 'Stopped; server cleanup pending. Reload only after backend release is confirmed.');
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


test('startup deadline settles while permission is still unresolved', async () => {
  const f = fixture(); const mic = deferred();
  f.env.navigator.mediaDevices.getUserMedia = () => mic.promise;
  const start = f.peer.start('fake token');
  [...f.timers.values()].find(t => t.delay === 30000).fn();
  await start;
  assert.equal(f.status.at(-1), 'Startup timed out');
  assert.equal(f.peer.current, null);
  mic.resolve(f.stream); await tick();
  assert.equal(f.track.stopped, true);
  assert.deepEqual(f.requests, []);
});


test('Stop and startup timeout settle pending native negotiation operations', async () => {
  for (const method of ['createOffer', 'setLocalDescription', 'setRemoteDescription']) {
    for (const cancel of ['stop', 'timeout']) {
      const f = fixture(); const operation = deferred();
      f.env.RTCPeerConnection.prototype[method] = () => operation.promise;
      const start = f.peer.start('fake token'); await tick();
      if (cancel === 'stop') await f.peer.stop();
      else [...f.timers.values()].find(t => t.delay === (method === 'setRemoteDescription' ? 60000 : 30000)).fn();
      await start;
      assert.equal(f.peer.current, null, `${method}: ${cancel}`);
      assert.equal(f.track.stopped, true);
      assert.equal(f.env.pc.connectionState, 'closed');
      if (method === 'setRemoteDescription') assert.equal(f.requests.at(-1).path, '/api/stop');
      operation.resolve({type: 'offer', sdp: 'fake late offer'}); await tick();
      assert.equal(f.requests.some(r => r.path === '/api/ack'), false);
    }
  }
});


test('failed startup waits for backend cleanup on errors and timeout', async () => {
  for (const failure of ['handoff', 'timeout']) {
    for (const cleanupOK of [true, false]) {
      const f = fixture(); const cleanup = deferred(); const original = f.env.fetch;
      f.env.fetch = (path, options) => path === '/api/stop' ? cleanup.promise : original(path, options);
      f.env.RTCPeerConnection.prototype.setRemoteDescription = failure === 'handoff'
        ? async () => { throw new Error('fake SDP failure'); }
        : () => new Promise(() => {});
      let finished = false;
      const start = f.peer.start('fake token').then(() => { finished = true; });
      await tick();
      if (failure === 'timeout') [...f.timers.values()].find(t => t.delay === 60000).fn();
      await tick();
      assert.equal(f.peer.current, null);
      assert.equal(f.track.stopped, true);
      assert.equal(finished, false, `${failure} must await cleanup`);
      cleanup.resolve({ok: cleanupOK});
      await start;
      assert.equal(finished, true);
      assert.equal(f.status.includes('Connected'), false);
      if (!cleanupOK) assert.equal(f.status.at(-1), 'Stopped; server cleanup pending. Reload only after backend release is confirmed.');
    }
  }
});

test('autoplay rejection preserves the connected lifecycle status', async () => {
  const f = fixture();
  f.audio.play = async () => { throw new DOMException('Autoplay blocked', 'NotAllowedError'); };
  await f.peer.start('fake token');
  f.env.pc.ontrack({streams: [f.stream]});
  await tick();
  assert.equal(f.status.at(-1), 'Connected');
  assert.equal(f.peer.current.pc.connectionState, 'connected');
  await f.peer.stop();
});

test('Stop can await serialized backend setup and hangup', async t => {
  const f = timedFixture(t);
  f.env.fetch = (path, options) => after(path === '/api/stop' ? 35000 : 30000,
    {ok: true, json: async () => ({sdp: 'fake answer'})}, options.signal);
  const start = f.peer.start('fake token'); await tick();
  let result;
  const stopped = f.peer.stop().then(value => { result = value; });
  assert.equal(f.track.stopped, true);
  t.mock.timers.tick(10000); await tick();
  assert.equal(result, undefined, 'cleanup must remain pending during serialized setup');
  t.mock.timers.tick(25000); await tick();
  await stopped; await start;
  assert.equal(result, true);
});

test('unreachable backend cleanup still has a deadline', async t => {
  const f = timedFixture(t);
  await f.peer.start('fake token');
  f.env.fetch = (_path, options) => after(100000, {ok: true}, options.signal);
  const stopped = f.peer.stop();
  t.mock.timers.tick(40000); await tick();
  assert.equal(await stopped, false);
  assert.equal(f.status.at(-1), 'Stopped; server cleanup pending. Reload only after backend release is confirmed.');
});

test('permission time leaves a separate budget for backend setup and peer establishment', async t => {
  const f = timedFixture(t); const original = f.env.fetch;
  f.env.navigator.mediaDevices.getUserMedia = () => after(20000, f.stream);
  f.env.fetch = (path, options) => path === '/api/calls'
    ? after(28000, {ok: true, json: async () => ({sdp: 'fake answer'})}, options.signal)
    : original(path, options);
  const apply = f.env.RTCPeerConnection.prototype.setRemoteDescription;
  f.env.RTCPeerConnection.prototype.setRemoteDescription = async function(answer) {
    await after(10000);
    return apply.call(this, answer);
  };
  const start = f.peer.start('fake token');
  t.mock.timers.tick(20000); await tick();
  t.mock.timers.tick(28000); await tick();
  t.mock.timers.tick(10000); await tick();
  await start;
  assert.equal(f.status.at(-1), 'Connected');
  assert.equal(f.track.stopped, false);
  assert.equal(await f.peer.stop(), true);
});

test('restart waits for cleanup acknowledgment and the full cooldown', async t => {
  const f = timedFixture(t); const cleanup = deferred(); const original = f.env.fetch;
  f.env.fetch = (path, options) => path === '/api/stop' ? cleanup.promise : original(path, options);
  await f.peer.start('fake token');
  const stopped = f.peer.stop();
  const requests = f.requests.length;
  t.mock.timers.tick(5000); await tick();
  await f.peer.start('fake token');
  assert.equal(f.peer.stopping, true);
  assert.equal(f.requests.length, requests);
  cleanup.resolve({ok: true}); await stopped;
  t.mock.timers.tick(4999); await tick();
  await f.peer.start('fake token');
  assert.equal(f.peer.stopping, true);
  assert.equal(f.requests.length, requests);
  t.mock.timers.tick(1); await tick();
  assert.equal(f.peer.stopping, false);
  await f.peer.start('fake token');
  assert.equal(f.status.at(-1), 'Connected');
  await f.peer.stop();
});

test('failed cleanup keeps restart disabled and explains recovery', async t => {
  const f = timedFixture(t);
  await f.peer.start('fake token');
  f.env.fetch = async () => ({ok: false});
  assert.equal(await f.peer.stop(), false);
  t.mock.timers.tick(100000); await tick();
  await f.peer.start('fake token');
  assert.equal(f.peer.current, null);
  assert.equal(f.peer.stopping, true);
  assert.equal(f.status.at(-1), 'Stopped; server cleanup pending. Reload only after backend release is confirmed.');
});

test('repeated Stop awaits event-driven cleanup without sending another request', async () => {
  for (const ok of [true, false]) {
    const f = fixture(); const cleanup = deferred(); const original = f.env.fetch;
    let requests = 0; let fromStatus;
    f.env.fetch = (path, options) => {
      if (path !== '/api/stop') return original(path, options);
      requests++;
      return cleanup.promise;
    };
    f.peer.status = value => {
      f.status.push(value);
      if (value === 'Peer failed') fromStatus = f.peer.stop();
    };
    await f.peer.start('fake token');
    f.env.pc.connectionState = 'failed';
    f.env.pc.onconnectionstatechange();
    const stopped = f.peer.stop();
    assert.ok(stopped instanceof Promise);
    assert.equal(stopped, fromStatus);
    assert.equal(stopped, f.peer.stop());
    let finished = false;
    const awaited = stopped.then(value => { finished = true; return value; });
    await tick();
    assert.equal(finished, false);
    cleanup.resolve({ok});
    assert.equal(await awaited, ok);
    assert.equal(await f.peer.stop(), ok);
    assert.equal(requests, 1);
  }
});

test('a new run does not inherit the previous cleanup acknowledgment', async () => {
  const f = fixture();
  await f.peer.start('fake token');
  assert.equal(await f.peer.stop(), true);
  [...f.timers.values()].find(t => t.delay === 5000).fn();
  const mic = deferred();
  f.env.navigator.mediaDevices.getUserMedia = () => mic.promise;
  const start = f.peer.start('fake token');
  assert.equal(f.peer.stop(), undefined);
  mic.resolve(f.stream); await start;
});
