import { settings } from "../settings.js";
import { MicrophoneMute } from "./microphoneMute.js";
import { ScreenRecorder } from "./screenReplay.js";
import { VolumeSettings } from "./volumeSettings.js";

const systemtray = await Service.import("systemtray");

const blacklist = ["Xwayland Video Bridge", "Wallet Manager"];
const trayOrder = [
  "spotify-client",
  "chrome_status_icon_1", // webcord
  "steam",
  "CopyQ_copyq",
  "privateinternetaccess",
  "nm-applet",
];

const sortItems = (a, b) => {
  const aIndex = trayOrder.indexOf(a.id);
  const bIndex = trayOrder.indexOf(b.id);
  return aIndex - bIndex;
};

const showTrayItem = (item) => {
  for (const blacklistItem of blacklist) {
    if (item.id.includes(blacklistItem)) {
      return false;
    }
  }
  // console.log(item.id);
  return true;
};

export function SystemTray() {
  /** @param {import('types/service/systemtray').TrayItem} item */
  const SysTrayItem = (item) =>
    Widget.Button({
      child: Widget.Icon({ size: settings.systemTray.iconSize }).bind(
        "icon",
        item,
        "icon",
      ),
      tooltipMarkup: item.bind("tooltip_markup"),
      onPrimaryClick: (_, event) => item.activate(event),
      onSecondaryClick: (_, event) => item.openMenu(event),
    });

  const extraBefore = [ScreenRecorder()];
  const extraAfter = [VolumeSettings(), MicrophoneMute()];

  return Widget.Box({
    children: systemtray
      .bind("items")
      .as((i) => [
        ...extraBefore,
        ...i.filter(showTrayItem).sort(sortItems).map(SysTrayItem),
        ...extraAfter,
      ]),
    class_name: "system-tray",
  });
}
