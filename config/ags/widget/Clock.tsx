import { Variable, GLib, bind } from "astal"

const shortFormat = "%l:%M %p";
const longFormat = "%a %b %d %Y";

export function Clock() {
    const time = Variable<GLib.DateTime>(new GLib.DateTime()).poll(1000, () => GLib.DateTime.new_now_local())

    const displayTime = bind(time).as(t => t.format(shortFormat) ?? "");
    const tooltipText = bind(time).as(t => t.format(longFormat) ?? "");

    return <label
        className="Time"
        onDestroy={() => time.drop()}
        label={displayTime}
        tooltipText={tooltipText}
        hasTooltip={true}
    />
}
