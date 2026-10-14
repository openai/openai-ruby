import {BrowserPeer} from './peer.js';

const mode = location.pathname === '/backend' ? 'backend' : 'direct';
const start = document.querySelector('#start');
const stop = document.querySelector('#stop');
const status = document.querySelector('#status');
const token = document.querySelector('#token');
document.querySelector('#mode').textContent = mode === 'direct'
  ? '1. Browser-owned secret and direct SDP exchange'
  : '2. Backend-owned SDP forwarding and call lifetime';
const peer = new BrowserPeer({mode, audio: document.querySelector('audio'), status(message) {
  status.textContent = message;
  start.disabled = Boolean(peer.current) || peer.stopping;
  stop.disabled = !peer.current;
}});
start.addEventListener('click', () => {
  if (token.value.length < 32) { status.textContent = 'Enter the application token (not an OpenAI API key).'; return; }
  peer.start(token.value);
});
stop.addEventListener('click', () => peer.stop());
window.addEventListener('pagehide', () => peer.stop());
