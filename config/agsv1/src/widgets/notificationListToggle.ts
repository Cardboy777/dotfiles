import { settings } from "../settings.js";

const icon = {
  active: "notification-active",
  inactive: "notification-inactive",
};

function launchNotificationTray() {
  return Utils.execAsync(["bash", "-c", "swaync-client -t"]);
}

function clearNotifications() {
  return Utils.execAsync(["bash", "-c", "swaync-client -C"]);
}

export function NotificationListToggle() {
  return Widget.Button({
    child: Widget.Icon({
      icon: icon.inactive,
      size: settings.systemTray.iconSize,
    }),
    tooltipMarkup: "View Notifications",
    onPrimaryClick: launchNotificationTray,
    onSecondaryClick: clearNotifications,
  });
}
