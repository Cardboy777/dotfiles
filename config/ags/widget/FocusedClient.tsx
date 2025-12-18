import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

export function FocusedClient() {
	const hypr = Hyprland.get_default()
	const focused = bind(hypr, "focusedClient")

	return <box
		className="Focused"
		visible={focused.as(Boolean)}>
		<label
			label={focused.as(c => c?.title ?? "")}
			ellipsize="3"
			max-width-chars="50"
		/>
	</box>
}

