// The browser owns media and peer negotiation. This controller only owns the
// example's lifecycle; it does not implement WebRTC or process audio frames.
export function createConversation({audio, status, playbackHint, controls, platform = globalThis,
  startupMs = 30_000, closeMs = 15_000, sessionMs = 300_000}) {
  let current = null;
  const active = (run) => current === run;
  const stopTracks = (stream) => stream?.getTracks().forEach((track) => track.stop());

  function cleanup(run, message) {
    if (!active(run)) return;
    current = null; // Ignore all events and async completions from this run.
    for (const timer of run.timers) platform.clearTimeout(timer);
    run.abort.abort();
    stopTracks(run.microphone);
    stopTracks(audio.srcObject);
    audio.pause();
    audio.srcObject = null;
    run.channel?.close();
    run.peer?.close();
    controls(false, false);
    status(message);
  }

  function fail(run, message = "Connection failed. Remote finalization is unconfirmed.") {
    cleanup(run, message);
  }

  function timer(run, delay, callback) {
    const id = platform.setTimeout(() => { if (active(run)) callback(); }, delay);
    run.timers.push(id);
    return id;
  }

  function gatherCandidates(peer, signal) {
    return new Promise((resolve) => {
      const check = () => {
        if (!signal.aborted && peer.iceGatheringState !== "complete") return;
        peer.removeEventListener("icegatheringstatechange", check);
        signal.removeEventListener("abort", check);
        resolve();
      };
      peer.addEventListener("icegatheringstatechange", check);
      signal.addEventListener("abort", check);
      check();
    });
  }

  function receive(run, data) {
    if (!active(run)) return;
    try {
      const event = JSON.parse(data);
      if (event.type === "session.started") {
        if (run.started) return;
        if (typeof event.session?.id !== "string" || !event.session.id) throw new Error();
        if (run.sessionId && run.sessionId !== event.session.id) throw new Error();
        run.sessionId = event.session.id;
        run.started = true;
        platform.clearTimeout(run.startupTimer);
        status("Connected. Speak naturally; you can interrupt the reply.");
        timer(run, sessionMs, stop);
      } else if (event.type === "session.closed") {
        if (!run.started || event.session?.id !== run.sessionId ||
            !Number.isFinite(event.usage?.seconds) || event.usage.seconds < 0 ||
            typeof event.reason !== "string") throw new Error();
        cleanup(run, `Session finalized. Voice duration: ${event.usage.seconds.toFixed(1)} seconds.`);
      } else if (event.type === "error") {
        fail(run, "Live reported an error. Remote finalization is unconfirmed.");
      }
    } catch {
      fail(run, "Invalid session event. Remote finalization is unconfirmed.");
    }
  }

  async function start() {
    if (current) return;
    const run = {abort: new platform.AbortController(), timers: [], started: false, closing: false};
    current = run;
    controls(true, true);
    playbackHint("");
    status("Allow microphone access to start.");
    run.startupTimer = timer(run, startupMs, () => fail(run, "Startup timed out. Remote finalization is unconfirmed."));
    try {
      const microphone = await platform.navigator.mediaDevices.getUserMedia({audio: true});
      if (!active(run)) { stopTracks(microphone); return; }
      run.microphone = microphone;
      const peer = run.peer = new platform.RTCPeerConnection();
      for (const track of microphone.getAudioTracks()) {
        peer.addTrack(track, microphone);
        track.addEventListener("ended", () => { if (active(run) && !run.closing) stop(); });
      }
      peer.addEventListener("track", ({streams, track}) => {
        if (!active(run)) return;
        audio.srcObject = streams[0] ?? new platform.MediaStream([track]);
        audio.play().catch(() => {
          if (active(run)) playbackHint("Use the audio Play button below if your browser blocked playback.");
        });
      });
      peer.addEventListener("connectionstatechange", () => {
        if (!active(run)) return;
        if (["failed", "closed"].includes(peer.connectionState)) fail(run);
        // A transient disconnect can recover; bound how long we wait.
        if (peer.connectionState === "disconnected") {
          run.disconnectTimer ??= timer(run, 10_000, () => fail(run));
        } else if (run.disconnectTimer) {
          platform.clearTimeout(run.disconnectTimer);
          run.disconnectTimer = null;
        }
      });
      const channel = run.channel = peer.createDataChannel("oai-events");
      channel.addEventListener("message", ({data}) => receive(run, data));
      channel.addEventListener("error", () => { if (active(run)) fail(run); });
      channel.addEventListener("close", () => { if (active(run)) fail(run); });
      const offer = await peer.createOffer();
      if (!active(run)) return;
      await peer.setLocalDescription(offer);
      if (!active(run)) return;
      status("Connecting…");
      // This endpoint exchanges one complete offer; there is no trickle signaling.
      await gatherCandidates(peer, run.abort.signal);
      if (!active(run)) return;
      const response = await platform.fetch("/session", {
        method: "POST", headers: {"Content-Type": "application/sdp"},
        body: peer.localDescription.sdp, signal: run.abort.signal
      });
      if (!active(run)) return;
      if (!response.ok) throw new Error();
      const result = await response.json();
      if (!active(run)) return;
      if (typeof result.session?.id !== "string" || !result.session.id ||
          result.transport?.type !== "webrtc" || typeof result.transport.sdp !== "string" ||
          !result.transport.sdp || (run.sessionId && run.sessionId !== result.session.id)) throw new Error();
      run.sessionId = result.session.id;
      await peer.setRemoteDescription({type: "answer", sdp: result.transport.sdp});
    } catch {
      if (active(run)) fail(run, "Could not start the conversation. Remote finalization is unconfirmed.");
    }
  }

  function stop() {
    const run = current;
    if (!run || run.closing) return;
    if (!run.started || run.channel?.readyState !== "open") {
      cleanup(run, "Startup cancelled. Any remote session finalization is unconfirmed.");
      return;
    }
    run.closing = true;
    controls(true, false);
    status("Finishing the session…");
    // Stop sending microphone content, keeping media/transport alive to drain.
    for (const track of run.microphone.getAudioTracks()) track.enabled = false;
    timer(run, closeMs, () => fail(run, "Finalization timed out. Resources released; final usage is unconfirmed."));
    try {
      run.channel.send(JSON.stringify({type: "session.close"}));
    } catch {
      fail(run);
    }
  }

  function dispose() {
    const run = current;
    if (!run) return;
    // Navigation cannot wait for a final event. This is best effort only.
    try {
      if (run.started && !run.closing && run.channel?.readyState === "open") {
        run.channel.send(JSON.stringify({type: "session.close"}));
      }
    } finally {
      cleanup(run, "Disconnected. Remote finalization is unconfirmed.");
    }
  }

  return {start, stop, dispose};
}
