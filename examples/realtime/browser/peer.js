// Native browser APIs own negotiation, ICE, media and data channels.
export class BrowserPeer {
  constructor({mode, audio, status, environment = globalThis}) {
    this.mode = mode;
    this.audio = audio;
    this.status = status;
    this.env = environment;
    this.current = null;
    this.stopping = false;
  }

  async request(run, path, body = '', type = 'text/plain', cleanup = false) {
    const response = await this.env.fetch(path, {
      method: 'POST', body, cache: 'no-store', redirect: 'error',
      headers: {Authorization: `Bearer ${run.token}`, 'Content-Type': type,
        'X-Operation-Id': run.id},
      // Cleanup may wait for serialized creation (15s), sideband (15s), then hangup (5s).
      signal: cleanup ? this.env.AbortSignal.timeout(40000) : run.abort.signal,
      keepalive: cleanup,
    });
    if (!response.ok) throw new Error('Application request failed.');
    return response;
  }

  check(run) {
    if (this.current !== run) throw new DOMException('Stopped', 'AbortError');
  }

  async wait(run, operation) {
    let cancel;
    const cancelled = new Promise((_, reject) => {
      cancel = () => reject(new DOMException('Stopped', 'AbortError'));
      run.abort.signal.addEventListener('abort', cancel, {once: true});
      if (run.abort.signal.aborted) cancel();
    });
    try { return await Promise.race([operation, cancelled]); }
    finally { run.abort.signal.removeEventListener('abort', cancel); }
  }

  async start(token) {
    if (this.current || this.stopping) return;
    const run = {token, id: this.env.crypto.randomUUID(), abort: new this.env.AbortController()};
    this.current = run;
    this.status('Starting');
    run.deadline = this.env.setTimeout(() => this.stop('Startup timed out'), 30000);
    try {
      // The permission prompt itself cannot be aborted. Settle start on Stop,
      // and separately release any tracks that arrive after cancellation.
      const media = this.env.navigator.mediaDevices.getUserMedia({audio: true}).then(stream => {
        if (this.current !== run) stream.getTracks().forEach(track => track.stop());
        else run.stream = stream;
        return stream;
      });
      const stream = await this.wait(run, media);
      this.check(run);
      run.stream = stream;
      run.pc = new this.env.RTCPeerConnection();
      stream.getTracks().forEach(track => {
        track.addEventListener('ended', () => { if (this.current === run) this.stop('Microphone ended'); });
        run.pc.addTrack(track, stream);
      });
      run.pc.ontrack = event => {
        if (this.current === run) {
          this.audio.srcObject = event.streams[0] || new this.env.MediaStream([event.track]);
          // Playback help remains beside the controls, independent of connection status.
          this.audio.play().catch(() => {});
        }
      };
      run.dc = run.pc.createDataChannel('oai-events');
      const ready = new Promise((resolve, reject) => {
        const checkReady = () => {
          if (run.pc.connectionState === 'connected' && run.dc.readyState === 'open') resolve();
        };
        run.abort.signal.addEventListener('abort', () => reject(new DOMException('Stopped', 'AbortError')), {once: true});
        run.pc.onconnectionstatechange = () => {
          if (this.current !== run) return;
          if (['failed', 'closed'].includes(run.pc.connectionState)) this.stop('Peer failed');
          else checkReady(); // disconnected is transient; backend lease still bounds abandonment.
        };
        run.dc.onopen = checkReady;
        run.dc.onclose = () => { if (this.current === run) this.stop('Data channel closed'); };
        run.dc.onerror = () => { if (this.current === run) this.stop('Data channel failed'); };
      });
      // Attach a rejection handler now; negotiation can fail before awaiting ready.
      ready.catch(() => {});
      run.dc.onmessage = event => {
        if (this.current !== run) return;
        try {
          const message = JSON.parse(event.data);
          if (message.type === 'error') this.stop('Realtime error');
        } catch { this.stop('Invalid Realtime event'); }
      };
      const offer = await this.wait(run, run.pc.createOffer());
      this.check(run);
      await this.wait(run, run.pc.setLocalDescription(offer));
      this.check(run);
      // Give signaling its own budget after permission/local offer preparation:
      // creation (15s), optional sideband (15s), handoff (20s), and delivery time.
      this.env.clearTimeout(run.deadline);
      run.deadline = this.env.setTimeout(() => this.stop('Startup timed out'), 60000);
      let answer;
      if (this.mode === 'direct') {
        const secretResponse = await this.request(run, '/api/secret');
        const secret = await secretResponse.json();
        this.check(run);
        const response = await this.env.fetch('https://api.openai.com/v1/realtime/calls', {
          method: 'POST', body: run.pc.localDescription.sdp, signal: run.abort.signal,
          headers: {Authorization: `Bearer ${secret.value}`, 'Content-Type': 'application/sdp'},
          cache: 'no-store', redirect: 'error',
        });
        if (!response.ok) throw new Error('Direct SDP exchange failed.');
        answer = await response.text();
      } else {
        run.submitted = true;
        const response = await this.request(run, '/api/calls', run.pc.localDescription.sdp, 'application/sdp');
        answer = (await response.json()).sdp;
      }
      this.check(run);
      await this.wait(run, run.pc.setRemoteDescription({type: 'answer', sdp: answer}));
      this.check(run);
      await ready;
      this.check(run);
      if (this.mode === 'backend') {
        await this.request(run, '/api/ack');
        this.check(run);
        // No overlapping renewals. A stalled request times out and stops locally.
        const renew = async () => {
          if (this.current !== run) return;
          run.renewDeadline = this.env.setTimeout(() => this.stop('Lease renewal timed out'), 10000);
          try {
            await this.request(run, '/api/renew');
            this.env.clearTimeout(run.renewDeadline);
            if (this.current === run) run.heartbeat = this.env.setTimeout(renew, 10000);
          } catch { if (this.current === run) this.stop('Lease renewal failed'); }
        };
        run.heartbeat = this.env.setTimeout(renew, 10000);
      }
      this.env.clearTimeout(run.deadline);
      this.status('Connected');
    } catch {
      if (this.current === run) this.stop('Start failed');
      // A timeout or peer callback may already have stopped this run.
      await run.cleanup;
    }
  }

  stop(message = 'Stopped') {
    const run = this.current;
    if (!run) return;
    this.stopping = true;
    this.current = null; // Invalidate callbacks before closing owned resources.
    run.abort.abort();
    this.env.clearTimeout(run.deadline);
    this.env.clearTimeout(run.heartbeat);
    this.env.clearTimeout(run.renewDeadline);
    run.stream?.getTracks().forEach(track => track.stop());
    run.dc?.close();
    run.pc?.getReceivers().forEach(receiver => receiver.track?.stop());
    run.pc?.close();
    this.audio.pause();
    this.audio.srcObject = null;
    this.status(message);
    const allowRestart = () => this.env.setTimeout(() => {
      this.stopping = false;
      this.status(message);
    }, 5000);
    if (run.submitted) {
      // Independent of the aborted startup request. If delivery fails, the
      // application lease reclaims the known call; pagehide is only best effort.
      run.cleanup = this.request(run, '/api/stop', '', 'text/plain', true).then(() => true).catch(() => {
        this.status('Stopped; server cleanup pending. Reload only after backend release is confirmed.');
        return false;
      });
      run.cleanup.then(released => { if (released) allowRestart(); });
      return run.cleanup;
    }
    allowRestart();
  }
}
