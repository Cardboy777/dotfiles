import { settings } from "../settings.js";

const audio = await Service.import("audio");
const mutedIcon = "microphone-sensitivity-muted";
const unmutedIcon = "microphone-sensitivity-high";
const errorIcon = "dialog-error";

const MICROPHONE_NAME_MATCHERS = ["Focusrite_Scarlett_2i2", "Mic1__source"];

export function MicrophoneMute() {
  const isMuted = Utils.watch(null, audio, "changed", () => {
    console.warn(audio.microphones);
    const microphone = audio.microphones.find((mic) =>
      MICROPHONE_NAME_MATCHERS.every((match) =>
        mic.stream?.name?.includes(match),
      ),
    );
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
