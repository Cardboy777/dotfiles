import { bind } from "astal"
import { Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"

export function Media() {
    const mpris = Mpris.get_default()

    return <box className="Media">
        {bind(mpris, "players").as(ps => {
            const player = ps[0];
            if (!player) {
                return (
                    <label className="media-not-playing" label="- Nothing Playing -" />
                );
            }

            const isPaused = bind(player, "playbackStatus").as(s => s !== 0);

            return (
                <box>
                    <box
                        className="Cover"
                        valign={Gtk.Align.CENTER}
                        css={bind(player, "coverArt").as(cover =>
                            `background-image: url('${cover}');`
                        )}
                    />
                    <label
                        className="media-label"
                        label={bind(player, "title").as(() =>
                            `${player.title} - ${player.artist}`
                        )}
						ellipsize="3"
						max-width-chars="50"
                    />
                    <button onClicked={() => player.previous()}><icon icon="media-skip-backward-symbolic" /></button>
                    <button onClicked={() => player.play_pause()}><icon icon={isPaused.as(p => p ? "media-playback-start-symbolic" : "media-playback-pause-symbolic")} /></button>
                    <button onClicked={() => player.next()}><icon icon="media-skip-forward-symbolic" /></button>
                </box>
            );
        })}
    </box>
}

