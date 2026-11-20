// tmux-style prefix: ctrl-b opens this popup, the next key runs a command.
import { View, div } from "gpui-kit";
import { run, props, closeOverlay, setShared } from "herdr";

const DIRS = { h: "left", j: "down", k: "up", l: "right", left: "left", down: "down", up: "up", right: "right" };

const KEYS = {
  c: ["tab.new"],
  "&": ["tab.close"],
  ",": ["tab.rename"],
  n: ["tab.next"],
  p: ["tab.prev"],
  "%": ["pane.split", { direction: "right" }],
  '"': ["pane.split", { direction: "down" }],
  x: ["pane.close"],
  z: ["pane.zoom"],
  o: ["agent.next"],
  s: ["mod.open", { name: "picker" }],
  f: ["mod.open", { name: "picker" }],
  $: ["space.rename"],
  ")": ["space.next"],
  "(": ["space.prev"],
  "?": ["app.help"],
};

function resolve(e) {
  const key = e.key_char || e.key;
  if (/^[1-9]$/.test(key)) return ["tab.select", { index: Number(key) }];
  if (DIRS[e.key]) return ["pane.go", { direction: DIRS[e.key] }];
  return KEYS[key] ?? null;
}

export default class TmuxPrefix extends View {
  init(_props, cx) {
    setShared("tmux.prefix", true);
    this.handle = cx.focus_handle();
    this.handle.focus();
    cx.timer.after(150, () => this.handle.focus());
  }

  async close() {
    setShared("tmux.prefix", false);
  }

  key(e, cx) {
    cx.stop_propagation();
    if (["shift", "ctrl", "alt", "cmd"].includes(e.key)) return;
    const action = e.key === "escape" ? null : resolve(e);
    closeOverlay(props().overlay);
    if (action) run(action[0], action[1] ?? {});
  }

  render() {
    return div().id("tmux-prefix").track_focus(this.handle)
      .on_key_down((e, cx) => this.key(e, cx)).size_full();
  }
}
