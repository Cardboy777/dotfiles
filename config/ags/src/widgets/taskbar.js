import { settings } from "../settings.js";

const applications = await Service.import("applications");
const hyprland = await Service.import("hyprland");

const focus = ({ address }) =>
  hyprland.sendMessage(`dispatch focuswindow address:${address}`);

/** @param {import('types/widgets/button').ButtonProps & { icon: string, pinned?: boolean }} o */
const AppButton = ({ icon, ...rest }) => {
  const indicators = Widget.Box({
    vpack: "end",
    hpack: "center",
    children: [0, 1, 2, 3, 4].map(() =>
      Widget.Box({
        class_name: "indicator",
        visible: false,
      }),
    ),
  });

  return Widget.Button({
    ...rest,
    child: Widget.Box({
      class_name: "box",
      children: [
        Widget.Overlay({
          child: Widget.Icon({
            icon,
            size: settings.tasklist.iconSize,
          }),
          pass_through: true,
          overlays: [indicators],
        }),
      ],
    }),
  });
};

export function Taskbar() {
  return Widget.Box({
    children: hyprland.bind("clients").transform((c) =>
      c
        .map((client) => {
          for (const app of applications.list) {
            if (
              (client.title && app.match(client.title)) ||
              (client.class && app.match(client.class))
            ) {
              return AppButton({
                icon: app.icon_name || "",
                tooltip_text: app.name,
                on_primary_click: () => focus(client),
              });
            }
          }
        })
        .filter((a) => !!a),
    ),
    class_name: "taskbar",
  });
}
