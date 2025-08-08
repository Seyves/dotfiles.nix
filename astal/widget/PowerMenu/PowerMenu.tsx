import { bind, exec } from "astal"
import { Astal, Gdk, Gtk } from "astal/gtk3"
import Wp from "gi://AstalWp"
import PWButton from "./PWButton"
import Weather from "../../lib/weather"
import * as vars from "../../vars"
import { isPowerMenuShown } from "../../app"

const audio = Wp.get_default()?.audio
const speaker = audio?.defaultSpeaker
const weather = Weather.get_default()

function audioIcon() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    if (!speaker) return

    const icon = speaker.mute
        ? 0
        : ([101, 67, 34, 1, 0].find(
              (threshold) => threshold <= speaker.volume * 100,
          ) as keyof typeof icons)

    return `audio-volume-${icons[icon]}-symbolic`
}

export default function PowerMenu(gdkmonitor: Gdk.Monitor) {
    const { TOP, RIGHT } = Astal.WindowAnchor

    return (
        <window
            anchor={TOP | RIGHT}
            marginRight={20}
            name="powermenu0"
            css="background-color: transparent;"
            exclusivity={Astal.Exclusivity.IGNORE}
            startupId="powermenu0"
            gdkmonitor={gdkmonitor}
            className="power-menu-window"
        >
            <centerbox css="padding: 1px; background-color: transparent;">
                <revealer
                    transitionDuration={200}
                    transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
                    revealChild={bind(isPowerMenuShown)}
                >
                    <centerbox
                        vertical={true}
                        centerWidget={
                            <eventbox
                                canFocus={false}
                                hexpand={true}
                                vexpand={true}
                            >
                                <box className="padding"></box>
                            </eventbox>
                        }
                        endWidget={
                            <box
                                spacing={12}
                                vertical={true}
                                className="power-menu"
                            >
                                <Top />
                                <Center />
                            </box>
                        }
                    />
                </revealer>
            </centerbox>
        </window>
    )
}

function Top() {
    return (
        <box spacing={16} className="toppw">
            <box
                vexpand={false}
                hexpand={false}
                valign={Gtk.Align.CENTER}
                className="avatar"
            ></box>
            <box
                spacing={4}
                vertical={true}
                hexpand={true}
                valign={Gtk.Align.CENTER}
            >
                <label halign={Gtk.Align.START} className="username">
                    {vars.username}
                </label>
                <label halign={Gtk.Align.START} className="osname">
                    {vars.os}
                </label>
            </box>
            <box
                spacing={4}
                vexpand={true}
                valign={Gtk.Align.START}
                halign={Gtk.Align.END}
            >
                <PWButton
                    icon="system-reboot-symbolic"
                    className="reboot"
                    onClicked={() => exec("reboot")}
                />
                <PWButton
                    icon="system-log-out-symbolic"
                    className="log-out"
                    onClicked={() => ""}
                />
                <PWButton
                    icon="system-shutdown-symbolic"
                    className="shutdown"
                    onClicked={() => exec("shutdown now")}
                />
            </box>
        </box>
    )
}

function Center() {
    return (
        <box spacing={12}>
            <box vertical={true} halign={Gtk.Align.START} className="weather">
                <box
                    className="weather-icon"
                    halign={Gtk.Align.CENTER}
                    css={bind(weather, "weather_value").as(
                        (value) =>
                            `background-image: url("${vars.configDir}/img/weather/${value.icon}@4x.png");`,
                    )}
                ></box>
                <label className="weather-temp">
                    {bind(weather, "weather_value").as(
                        (value) => `${value.temp}℃`,
                    )}
                </label>
                <label className="weather-desc">
                    {bind(weather, "weather_value").as(
                        (value) => `feels like ${value.feelsLike}℃`,
                    )}
                </label>
                <label className="weather-desc">
                    {bind(weather, "weather_value").as(
                        (value) => value.description,
                    )}
                </label>
            </box>
        </box>
    )
}
