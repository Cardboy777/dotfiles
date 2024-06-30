import { settings } from "../settings.js";

const recordingIcon = "media-record";
const notRecordingIcon = "media-playback-stop";

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

const scriptsDir = `${runCommand("echo $HOME", false)}/.config/hypr/scripts/gpu-screen-recorder`;

export function ScreenRecorder() {
  const isRecording = Variable(true);

  Utils.monitorFile(`${scriptsDir}/RUNNING`, (_, event) => {
    if (event === fileEvents.created) {
      isRecording.value = true;
    } else if (event === fileEvents.deleted) {
      isRecording.value = false;
    }
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
