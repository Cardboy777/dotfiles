import { bind } from "astal"
import Wp from "gi://AstalWp"
import { bashRun } from "../lib/bash"

const mutedIcon = "microphone-sensitivity-muted";
const unmutedIcon = "microphone-sensitivity-high";
const errorIcon = "dialog-error";

export function MicrophoneMute() {
    const mic = Wp.get_default()?.audio.default_microphone;

    if (!mic) {
        return <icon className="mic-status" icon={errorIcon} />
    }

    let isMuted = bind(mic!, "mute")

    const iconName = isMuted.as(v => v ? mutedIcon : unmutedIcon)

    return <button
        className="MicStatus"
        tooltipMarkup="Toggle Microphone Mute"
        onClickRelease={() => bashRun("$HOME/.config/hypr/scripts/toggle-mic-mute.sh", true)}
    >
        <icon icon={iconName} />
    </button>
}

