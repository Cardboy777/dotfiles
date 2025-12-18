import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"
// import Niri from "gi://AstalNiri"

export function Workspaces() {
	const hypr = Hyprland.get_default()
	// const niri = Niri.get_default()

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

