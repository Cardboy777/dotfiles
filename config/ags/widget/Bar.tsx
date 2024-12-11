import { Astal, Gtk, Gdk } from "astal/gtk3"
import { Workspaces } from "./Workspaces"
import { FocusedClient } from "./FocusedClient"
import { EnteAuth } from "./EnteAuth"
import { Media } from "./Media"
import { MicrophoneMute } from "./MicrophoneMute"
import { Clock } from "./Clock"
import { SystemTray } from "./SystemTray"

export default function Bar(monitor: Gdk.Monitor) {
    const anchor = Astal.WindowAnchor.BOTTOM
        | Astal.WindowAnchor.LEFT
        | Astal.WindowAnchor.RIGHT

    return <window
        className="Bar"
        gdkmonitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={anchor}>
        <centerbox>
            <box hexpand halign={Gtk.Align.START}>
                <Workspaces />
                <FocusedClient />
            </box>
            <box>
                <Media />
            </box>
            <box hexpand halign={Gtk.Align.END} >
                <MicrophoneMute />
                <EnteAuth />
                <SystemTray />
                <Clock />
            </box>
        </centerbox>
    </window>
}
