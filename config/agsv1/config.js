// src/widgets/workspaces.js
var hyprland = await Service.import("hyprland");
function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) => ws.map(({ id }) => Widget.Button({
    on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
    child: Widget.Label(`${id}`),
    class_name: activeId.as((i) => `${i === id ? "focused" : ""}`)
  })));
  return Widget.Box({
    class_name: "workspaces",
    children: workspaces
  });
}

// src/settings.js
var settings = {
  tasklist: { iconSize: 24 },
  systemTray: { iconSize: 20 }
};

// src/widgets/taskbar.js
var applications = await Service.import("applications");
var hyprland2 = await Service.import("hyprland");
var focus = ({ address }) => hyprland2.sendMessage(`dispatch focuswindow address:${address}`);
var AppButton = ({ icon, ...rest }) => {
  const indicators = Widget.Box({
    vpack: "end",
    hpack: "center",
    children: [0, 1, 2, 3, 4].map(() => Widget.Box({
      class_name: "indicator",
      visible: false
    }))
  });
  return Widget.Button({
    ...rest,
    child: Widget.Box({
      class_name: "box",
      children: [
        Widget.Overlay({
          child: Widget.Icon({
            icon,
            size: settings.tasklist.iconSize
          }),
          pass_through: true,
          overlays: [indicators]
        })
      ]
    })
  });
};
function Taskbar() {
  return Widget.Box({
    children: hyprland2.bind("clients").transform((c) => c.map((client) => {
      for (const app of applications.list) {
        if (client.title && app.match(client.title) || client.class && app.match(client.class)) {
          return AppButton({
            icon: app.icon_name || "",
            tooltip_text: app.name,
            on_primary_click: () => focus(client)
          });
        }
      }
    }).filter((a) => !!a)),
    class_name: "taskbar"
  });
}

// src/widgets/clientTitle.js
var hyprland3 = await Service.import("hyprland");
function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland3.active.client.bind("title")
  });
}

// src/widgets/microphoneMute.js
var audio = await Service.import("audio");
var mutedIcon = "microphone-sensitivity-muted";
var unmutedIcon = "microphone-sensitivity-high";
var errorIcon = "dialog-error";
var MICROPHONE_NAME_MATCHERS = ["Focusrite_Scarlett_2i2", "Mic1__source"];
function MicrophoneMute() {
  const isMuted = Utils.watch(null, audio, "changed", () => {
    const microphone = audio.microphones.find((mic) => MICROPHONE_NAME_MATCHERS.every((match) => mic.stream?.name?.includes(match)));
    return microphone?.stream?.is_muted;
  });
  const icon = isMuted.as((muted) => {
    if (muted === null) {
      console.error("Microphone does not exist");
      return errorIcon;
    }
    switch (muted) {
      case true:
        return mutedIcon;
      case false:
        return unmutedIcon;
      case null:
      case undefined:
        return errorIcon;
    }
  });
  const class_name = isMuted.as((muted) => {
    if (muted === null || muted === undefined) {
      return "microphone-mute error";
    }
    return `microphone-mute ${muted ? "muted" : "unmuted"}`;
  });
  return Widget.Button({
    class_name,
    tooltipMarkup: "Toggle Microphone Mute",
    on_primary_click: () => Utils.execAsync([
      "bash",
      "-c",
      "~/.config/hypr/scripts/toggle-mic-mute.sh"
    ]),
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon
    })
  });
}

// src/widgets/authkey.js
var icon = "keepassxc-dark";
function launchEnteAuth() {
  return Utils.execAsync(["bash", "-c", "ente_auth"]);
}
function Auth() {
  return Widget.Button({
    class_name: "auth-launcher",
    tooltipMarkup: "Ente Auth",
    on_primary_click: () => {
      launchEnteAuth();
    },
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon
    })
  });
}

// src/widgets/screenReplay.js
var recordingIcon = "replay-record";
var notRecordingIcon = "replay-stop";
function runCommand(command, runAsyncrounously = true) {
  let func;
  if (runAsyncrounously) {
    func = Utils.execAsync;
  } else {
    func = Utils.exec;
  }
  return func(["bash", "-c", command]);
}
function isRecorderAppRunning() {
  return runCommand("pgrep -x gpu-screen-reco", false).trim() !== "";
}
var scriptsDir = `${runCommand("echo $HOME", false)}/.config/hypr/scripts/gpu-screen-recorder`;
function ScreenRecorder() {
  const isRecording = Variable(true);
  Utils.interval(1000, () => {
    isRecording.value = isRecorderAppRunning();
  });
  const icon2 = isRecording.bind().as((v) => {
    return v ? recordingIcon : notRecordingIcon;
  });
  const class_name = isRecording.bind().as((v) => {
    return `screen-replay ${v ? "recording" : "not-recording"}`;
  });
  const tooltipMarkup = isRecording.bind().as((v) => {
    return `Screen Replay\n${v ? "Recording" : "Not Recording"}`;
  });
  return Widget.Button({
    class_name,
    tooltipMarkup,
    on_primary_click: () => runCommand(`${scriptsDir}/save.sh true`),
    on_middle_click: () => runCommand(`${scriptsDir}/toggleRecorder.sh true`),
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon: icon2
    })
  });
}

// src/widgets/volumeSettings.js
function VolumeSettings() {
  return Widget.Button({
    class_name: "volume-settings",
    tooltipMarkup: "L: Control\nR: Helvum\nM:EasyEffects",
    on_primary_click: () => Utils.execAsync(["flatpak", "run", "com.saivert.pwvucontrol"]),
    on_secondary_click: () => Utils.execAsync(["helvum"]),
    on_middle_click: () => Utils.execAsync(["easyeffects"]),
    child: Widget.Icon({
      icon: "audio-volume-high",
      size: settings.systemTray.iconSize
    })
  });
}

// src/widgets/notificationListToggle.ts
var icon2 = {
  active: "notification-active",
  inactive: "notification-inactive"
};
function launchNotificationTray() {
  return Utils.execAsync(["bash", "-c", "swaync-client -t"]);
}
function clearNotifications() {
  return Utils.execAsync(["bash", "-c", "swaync-client -C"]);
}
function NotificationListToggle() {
  return Widget.Button({
    child: Widget.Icon({
      icon: icon2.inactive,
      size: settings.systemTray.iconSize
    }),
    tooltipMarkup: "View Notifications",
    onPrimaryClick: launchNotificationTray,
    onSecondaryClick: clearNotifications
  });
}

// src/widgets/systemTray.js
var systemtray = await Service.import("systemtray");
var blacklist = [
  "Xwayland Video Bridge",
  "Wallet Manager",
  "Ente Auth"
];
var trayOrder = [
  "spotify-client",
  "chrome_status_icon_1",
  "steam",
  "CopyQ_copyq",
  "privateinternetaccess",
  "nm-applet"
];
var sortItems = (a, b) => {
  const aIndex = trayOrder.indexOf(a.id);
  const bIndex = trayOrder.indexOf(b.id);
  return aIndex - bIndex;
};
var showTrayItem = (item) => {
  for (const blacklistItem of blacklist) {
    if (item.id.includes(blacklistItem)) {
      return false;
    }
  }
  console.log(item.id);
  return true;
};
function SystemTray() {
  const SysTrayItem = (item) => Widget.Button({
    child: Widget.Icon({ size: settings.systemTray.iconSize }).bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip_markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event)
  });
  const extraBefore = [ScreenRecorder(), Auth()];
  const extraAfter = [
    VolumeSettings(),
    MicrophoneMute(),
    NotificationListToggle()
  ];
  return Widget.Box({
    children: systemtray.bind("items").as((i) => [
      ...extraBefore,
      ...i.filter(showTrayItem).sort(sortItems).map(SysTrayItem),
      ...extraAfter
    ]),
    class_name: "system-tray"
  });
}

// src/widgets/calendar.js
var montitorIsVisible = {};
function Calendar(monitor = 0) {
  const isVisible = Variable(false);
  montitorIsVisible[monitor] = isVisible;
  return Widget.Revealer({
    child: Widget.Calendar(),
    transition: "slide_up",
    transitionDuration: 200,
    revealChild: montitorIsVisible[monitor].bind()
  });
}
function toggleCalendarVisibility(monitor = 0) {
  montitorIsVisible[monitor].setValue(!montitorIsVisible[monitor].value);
}

// src/widgets/clock.js
var time = Variable("", {
  poll: [1000, 'date "+%l:%M %p"']
});
var date = Variable("", {
  poll: [1000, 'date "+%c"']
});
function Clock(monitor = 0) {
  return Widget.Button({
    child: Widget.Label({
      class_name: "clock",
      label: time.bind()
    }),
    tooltipMarkup: date.bind(),
    onClicked: () => {
      toggleCalendarVisibility(monitor);
    }
  });
}

// src/style.css
var style_default = "./style-x9m8sm3d.css";

// src/config.js
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [Widget.Separator(), Workspaces(), Taskbar()]
  });
}
function Center() {
  return Widget.Box({
    spacing: 8,
    children: [ClientTitle()]
  });
}
function Right(monitor = 0) {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      SystemTray(),
      Clock(monitor),
      Widget.Separator()
    ]
  });
}
function Windows(monitor = 0) {
  return [
    Widget.Window({
      name: `bar-${monitor}`,
      class_name: "bar",
      monitor,
      anchor: ["bottom", "left", "right"],
      layer: "top",
      exclusivity: "exclusive",
      child: Widget.CenterBox({
        start_widget: Left(),
        center_widget: Center(),
        end_widget: Right(monitor)
      })
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
        css: "padding: 1px;"
      }),
      margins: [0, 0, 36, 0]
    })
  ];
}
var monitors = [0, 1, 2];
App.config({
  style: style_default,
  windows: monitors.map((m) => Windows(m)).flat()
});
