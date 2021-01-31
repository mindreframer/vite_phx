// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html";
import { Socket } from "phoenix";

import NProgress from "nprogress";
import { LiveSocket } from "phoenix_live_view";

try {
  let csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content");
  let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken },
  });

  // Show progress bar on live navigation and form submits
  let progressTimeout = null;
  window.addEventListener("phx:page-loading-start", () => {
    clearTimeout(progressTimeout);
    progressTimeout = setTimeout(NProgress.start, 300);
  });
  window.addEventListener("phx:page-loading-stop", () => {
    clearTimeout(progressTimeout);
    NProgress.done();
  });

  // connect if there are any LiveViews on the page
  liveSocket.connect();

  // expose liveSocket on window for web console debug logs and latency simulation:
  // >> liveSocket.enableDebug()
  // >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
  // >> liveSocket.disableLatencySim()
  window.liveSocket = liveSocket;
} catch (error) {
  console.error(error);
}
