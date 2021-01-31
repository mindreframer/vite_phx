// imported from phx
import './vendor/phx-app.css'
import "./vendor/phx-app.js"

// polyfills for production
import 'vite/dynamic-import-polyfill'

import { render, h } from 'preact'
import { App } from './app'
import './index.css'

render(<App />, document.getElementById('app')!)
