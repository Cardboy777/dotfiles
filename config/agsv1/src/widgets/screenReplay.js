import { settings } from "../settings.js";

const recordingIcon = "replay-record";
const notRecordingIcon = "replay-stop";

const fileEvents = {
  deleted: 2,
  created: 3,
};

function runCommand(command, runAsyncrounously = true) {
  let func;
  if (runAsyncrounously) {
    func = Utils.execAsync;
  } else {
    func = Utils.exec;
  }
  return func(["bash", "-c", command]);
}

function isRecorderAppRunning() {
  return runCommand("pgrep -x gpu-screen-reco", false).trim() !== "";
}

const scriptsDir = `${runCommand("echo $HOME", false)}/.config/hypr/scripts/gpu-screen-recorder`;

export function ScreenRecorder() {
  const isRecording = Variable(true);

  Utils.interval(1000, () => {
    isRecording.value = isRecorderAppRunning();
  });

  const icon = isRecording.bind().as((v) => {
    return v ? recordingIcon : notRecordingIcon;
  });

  const class_name = isRecording.bind().as((v) => {
    return `screen-replay ${v ? "recording" : "not-recording"}`;
  });

  const tooltipMarkup = isRecording.bind().as((v) => {
    return `Screen Replay\n${v ? "Recording" : "Not Recording"}`;
  });

  return Widget.Button({
    class_name,
    tooltipMarkup,
    on_primary_click: () => runCommand(`${scriptsDir}/save.sh true`),
    on_middle_click: () => runCommand(`${scriptsDir}/toggleRecorder.sh true`),
    child: Widget.Icon({
      size: settings.systemTray.iconSize,
      icon,
    }),
  });
}
