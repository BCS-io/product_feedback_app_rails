// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js or *_controller.ts.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

// Import and register all TailwindCSS Components
import {
  Alert,
  Dropdown,
  Tabs,
  Toggle,
  Slideover,
} from "tailwindcss-stimulus-components"

application.register("alert", Alert)
application.register("dropdown", Dropdown)
application.register("tabs", Tabs)
application.register("toggle", Toggle)
application.register("slideover", Slideover)
