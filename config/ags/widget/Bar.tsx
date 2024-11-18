import { App } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"
import Tray from "gi://AstalTray"


const excludeList = ["Xwayland Video Bridge_pipewireToXProxy"];
function SysTray() {
    const tray = Tray.get_default()

    return <box className="Tray">
        {bind(tray, "items").as(items => items
            .filter(item => !excludeList.includes(item.id))
            .map(item => {
                //console.log(item.id)
                if (item.iconThemePath)
                    App.add_icons(item.iconThemePath)

                const menu = item.create_menu()

                return <button
                    tooltipMarkup={bind(item, "tooltipMarkup")}
                    onDestroy={() => menu?.destroy()}
                    onClickRelease={self => {
                        menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
                    }}>
                    <icon gIcon={bind(item, "gicon")} />
                </button>
            }))}
    </box>
}

function Wifi() {
    const { wifi } = Network.get_default()

    return <icon
        tooltipText={bind(wifi, "ssid").as(String)}
        className="Wifi"
        icon={bind(wifi, "iconName")}
    />
}

const mutedIcon = "microphone-sensitivity-muted";
const unmutedIcon = "microphone-sensitivity-high";
const errorIcon = "dialog-error";

function MuteIcon() {
    const mic = Wp.get_default()?.audio.default_microphone;

    if (!mic) {
        return <icon className="mic-status" icon={errorIcon} />
    }

    let isMuted = bind(mic!, "mute")

    const iconName = isMuted.as(v => v ? mutedIcon : unmutedIcon)

    return <icon className="mic-status" icon={iconName} />
}

function Media() {
    const mpris = Mpris.get_default()

    return <box className="Media">
        {bind(mpris, "players").as(ps => ps[0] ? (
            <box>
                <box
                    className="Cover"
                    valign={Gtk.Align.CENTER}
                    css={bind(ps[0], "coverArt").as(cover =>
                        `background-image: url('${cover}');`
                    )}
                />
                <label
                    label={bind(ps[0], "title").as(() =>
                        `${ps[0].title} - ${ps[0].artist}`
                    )}
                />
            </box>
        ) : (
            "Nothing Playing"
        ))}
    </box>
}

function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .sort((a, b) => a.id - b.id)
            .map(ws => (
                <button
                    className={bind(hypr, "focusedWorkspace").as(fw =>
                        ws === fw ? "focused" : "")}
                    onClicked={() => ws.focus()}>
                    {ws.id}
                </button>
            ))
        )}
    </box>
}

function FocusedClient() {
    const hypr = Hyprland.get_default()
    const focused = bind(hypr, "focusedClient")

    return <box
        className="Focused"
        visible={focused.as(Boolean)}>
        <label label={focused.as(c => c?.title ?? "")} />
    </box>
}

function Time({ format = "%l:%M %p" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        className="Time"
        onDestroy={() => time.drop()}
        label={time()}
    />
}

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
                <MuteIcon />
                <SysTray />
                <Wifi />
                <Time />
            </box>
        </centerbox>
    </window>
}

