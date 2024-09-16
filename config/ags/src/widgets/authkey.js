import { settings } from "../settings.js";
const icon = "keepassxc-dark";

function launchEnteAuth() {
  return Utils.execAsync(["bash", "-c", "ente_auth"]);
}

export function Auth() {
  return Widget.Button({
    class_name: "auth-launcher",
    tooltipMarkup: "Ente Auth",
    on_primary_click: () => {
      launchEnteAuth();
    },
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon,
    }),
  });
}
