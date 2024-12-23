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
                let overrideIcon = new Variable<string | undefined>(trayIconOverride[item.id])
                if (item.iconThemePath) {
                    App.add_icons(item.iconThemePath)
                }

                return <menubutton
                    tooltipMarkup={bind(item, "tooltipMarkup")}
                    usePopover={false}
                    actionGroup={bind(item, "action-group").as(ag => ["dbusmenu", ag])}
                    menuModel={bind(item, "menu-model")}
                >
                    {
                        bind(overrideIcon).as(v =>
                            v
                                ? (<icon icon={v} />)
                                : (<icon gicon={bind(item, "gicon")} />)
                        )
                    }
                </menubutton>
            }))}
    </box>
}
