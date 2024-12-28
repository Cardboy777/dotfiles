import { Variable, bind, interval } from "astal"
import { bashRun } from "../lib/bash";

const recordingIcon = "replay-record";
const notRecordingIcon = "replay-stop";

function isRecorderAppRunning() {
    try {
        const value = bashRun("pgrep gpu-screen-reco", false)
        return value?.trim() !== "";
    }
    catch (e) {
        return false
    }
}

export function GPURecorder() {
    const scriptsDir = `${bashRun("echo $HOME")}/.config/hypr/scripts/gpu-screen-recorder`;
    const isRecording = Variable(true);

    interval(1000, () => {
        isRecording.set(isRecorderAppRunning());
    });

    const isRecordingBinding = bind(isRecording);

    const icon = isRecordingBinding.as((v) => {
        return v ? recordingIcon : notRecordingIcon;
    });

    const class_name = isRecordingBinding.as((v) => {
        return `screen-replay ${v ? "recording" : "not-recording"}`;
    });

    const tooltipMarkup = isRecordingBinding.as((v) => {
        return `Screen Replay\n${v ? "Recording" : "Not Recording"}`;
    });

    return <button
        className={class_name}
        tooltipMarkup={tooltipMarkup}
        onClickRelease={() => bashRun(`${scriptsDir}/save.sh true`)}
    >
        <icon
            icon={icon}
        />
    </button>;
}

