const notifications = await Service.import("notifications");

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
export function Notifications() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    children: [
      Widget.Icon({
        icon: popups.as((p) =>
          p.length > 0 ? "mail-read-symbolic" : "mail-unread-symbolic",
        ),
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}
