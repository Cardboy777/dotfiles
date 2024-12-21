import { bind, Variable } from "astal"
import { App, Gdk } from "astal/gtk3"
import Tray from "gi://AstalTray"

const excludeList = ["Xwayland Video Bridge_pipewireToXProxy"];

const trayIconOverride: Record<string, string> = {
    'proton-vpn-app': 'proton-vpn-logo'
} as const;

export function SystemTray() {
    const tray = Tray.get_default()

    return <box className="Tray">
        {bind(tray, "items").as(items => items
            .filter(item => !excludeList.includes(item.id))
            .map(item => {
                console.log(item.id, item.iconThemePath);
                let overrideIcon = new Variable<string | undefined>(trayIconOverride[item.id])
                if (item.iconThemePath) {
                    App.add_icons(item.iconThemePath)
                }

                const menu = item.create_menu()

                return <button
                    tooltipMarkup={bind(item, "tooltipMarkup")}
                    onDestroy={() => menu?.destroy()}
                    onClickRelease={self => {
                        menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
                    }}>
                    {
                        bind(overrideIcon).as(v =>
                            v
                                ? (<icon icon={v} />)
                                : (<icon gIcon={bind(item, "gicon")} />)
                        )
                    }
                </button>
            }))}
    </box>
}
