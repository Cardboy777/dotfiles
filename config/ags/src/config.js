import { Workspaces } from "./widgets/workspaces.js";
import { Taskbar } from "./widgets/taskbar.js";
import { ClientTitle } from "./widgets/clientTitle.js";
// import { MediaControls } from "./widgets/mediaControls.js";
// import { VolumeSlider } from "./widgets/volumeSlider.js";
import { SystemTray } from "./widgets/systemTray.js";
// import { BatteryLabel } from "./widgets/batteryLabel.js";
import { Clock } from "./widgets/clock.js";
// import { Notifications } from "./widgets/notifications.js";
import { Calendar } from "./widgets/calendar.js";
//import { NotificationPopups } from "./widgets/notificationPopup.js";

import styles from "./style.css";

// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [Widget.Separator(), Workspaces(), Taskbar()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [ClientTitle()],
  });
}

function Right(monitor = 0) {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      // MediaControls(),
      // VolumeSlider(),
      SystemTray(),
      // BatteryLabel(),
      Clock(monitor),
      Widget.Separator(),
    ],
  });
}

function Windows(monitor = 0) {
  return [
    Widget.Window({
      name: `bar-${monitor}`, // name has to be unique
      class_name: "bar",
      monitor,
      anchor: ["bottom", "left", "right"],
      layer: "top",
      exclusivity: "exclusive",
      child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(monitor),
      }),
    }),
    Widget.Window({
      name: `bar-${monitor}-calendar`,
      class_name: "calendar-container",
      monitor,
      anchor: ["bottom", "right"],
      layer: "top",
      exclusivity: "ignore",
      child: Widget.Box({
        child: Calendar(monitor),
        css: "padding: 1px;",
      }),
      margins: [0, 0, 36, 0],
    }),
  ];
}

const monitors = [0, 1, 2];

App.config({
  style: styles,
  windows: monitors.map((m) => Windows(m)).flat(),
  //.concat([NotificationPopups()])
});
