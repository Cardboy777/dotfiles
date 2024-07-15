import { settings } from "../settings.js";

export function VolumeSettings() {
  return Widget.Button({
    class_name: "volume-settings",
    tooltipMarkup: "L: Control\nR: Helvum\nM:EasyEffects",
    on_primary_click: () =>
      Utils.execAsync(["flatpak", "run", "com.saivert.pwvucontrol"]),
    on_secondary_click: () => Utils.execAsync(["helvum"]),
    on_middle_click: () => Utils.execAsync(["easyeffects"]),
    child: Widget.Icon({
      icon: "audio-volume-high",
      size: settings.systemTray.iconSize,
    }),
  });
}
