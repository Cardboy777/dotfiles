import { settings } from "../settings.js";

const audio = await Service.import("audio");
const mutedIcon = "microphone-sensitivity-muted";
const unmutedIcon = "microphone-sensitivity-high";
const errorIcon = "dialog-error";

const MICROPHONE_NAME_MATCHERS = ["Focusrite_Scarlett_2i2", "0__source"];

export function MicrophoneMute() {
  const isMuted = Utils.watch(null, audio, "changed", () => {
    console.log(audio.microphones.map(({ name }) => name));
    const microphone = audio.microphones.find((mic) =>
      MICROPHONE_NAME_MATCHERS.every((match) => mic.name?.includes(match)),
    );
    return microphone?.stream?.is_muted;
  });

  const icon = isMuted.as((muted) => {
    if (muted === null) {
      console.error("Microphone does not exist");
      return errorIcon;
    }

    return muted ? mutedIcon : unmutedIcon;
  });

  const class_name = isMuted.as((muted) => {
    if (muted === null) {
      return "microphone-mute error";
    }
    return `microphone-mute ${muted ? "muted" : "unmuted"}`;
  });

  return Widget.Button({
    class_name,
    tooltipMarkup: "Toggle Microphone Mute",
    on_primary_click: () =>
      Utils.execAsync([
        "bash",
        "-c",
        "~/.config/hypr/scripts/toggle-mic-mute.sh",
      ]),
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon,
    }),
  });
}
