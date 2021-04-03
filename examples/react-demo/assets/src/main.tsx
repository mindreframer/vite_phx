// imported from phx
import "./vendor/phx-app.css";
import "./vendor/phx-app.js";

// polyfills for production
import "vite/dynamic-import-polyfill";

import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import { App } from "./App";

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById("app")
);
