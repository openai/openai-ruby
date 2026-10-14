import {createConversation} from "./conversation.mjs";

const start = document.querySelector("#start");
const stop = document.querySelector("#stop");
const conversation = createConversation({
  audio: document.querySelector("audio"),
  status: (message) => { document.querySelector("#status").textContent = message; },
  playbackHint: (message) => { document.querySelector("#playback-hint").textContent = message; },
  controls: (running, canStop) => { start.disabled = running; stop.disabled = !canStop; }
});
start.addEventListener("click", () => conversation.start());
stop.addEventListener("click", () => conversation.stop());
window.addEventListener("pagehide", () => conversation.dispose());
