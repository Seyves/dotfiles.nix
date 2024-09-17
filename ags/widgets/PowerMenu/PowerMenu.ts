import { isPowerMenuShown } from "main";
import Avatar from "../components/Avatar";
import Gtk from "gi://Gtk";
import { Icon } from "types/widget";

const audio = await Service.import("audio");

function getIcon() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    const icon = audio.speaker.is_muted
        ? 0
        : [101, 67, 34, 1, 0].find(
              (threshold) => threshold <= audio.speaker.volume * 100,
          );

    return `audio-volume-${icons[icon]}-symbolic`;
}

export default function PowerMenu(monitor: number) {
    let username = Utils.exec("whoami");
    username = username[0].toUpperCase() + username.slice(1);

    const top = Widget.Box({
        spacing: 8,
        children: [
            Widget.Box({
                className: "avatar",
                vexpand: false,
                hexpand: false,
            }),
            Widget.Box({
                spacing: 8,
                vertical: true,
                hexpand: true,
                css: "padding: 8px 0px;",
                children: [
                    Widget.Label({
                        label: username,
                        className: "username",
                        vpack: "start",
                        hpack: "start",
                    }),
                    Widget.Box({
                        vpack: "end",
                        vexpand: true,
                        spacing: 4,
                        children: [
                            Widget.Button({
                                vexpand: false,
                                hexpand: false,
                                className: "reboot",
                                child: Widget.Icon({
                                    icon: "system-reboot-symbolic",
                                }),
                                onClicked: () => Utils.exec("reboot")
                            }),
                            Widget.Button({
                                vexpand: false,
                                hexpand: false,
                                className: "reboot",
                                child: Widget.Icon({
                                    icon: "system-shutdown-symbolic",
                                }),
                            }),
                        ],
                    }),
                ],
            }),
        ],
    });

    return Widget.Window({
        monitor,
        name: `powermenu${monitor}`,
        anchor: ["top", "right"],
        margins: [0, 20, 0, 0],
        css: "background-color: transparent;",
        exclusivity: "ignore",
        child: Widget.CenterBox({
            css: "padding: 1px; background-color: transparent;",
            child: Widget.Revealer({
                transitionDuration: 200,
                transition: "slide_down",
                child: Widget.CenterBox({
                    vertical: true,
                    centerWidget: Widget.EventBox({
                        canFocus: false,
                        hexpand: true,
                        vexpand: true,
                        child: Widget.Box({
                            className: "padding",
                        }),
                    }),
                    endWidget: Widget.Box({
                        className: "power-menu",
                        vertical: true,
                        spacing: 12,
                        children: [
                            top,
                            Widget.Box({
                                spacing: 12,
                                children: [
                                    Widget.Icon({
                                        icon: Utils.watch(
                                            getIcon(),
                                            audio.speaker,
                                            getIcon,
                                        ),
                                    }),
                                    Widget.Slider({
                                        className: "volume-slider",
                                        drawValue: false,
                                        onChange: ({ value }) => {
                                            audio.speaker.volume = value;
                                        },
                                        value: audio.speaker.bind("volume"),
                                    }),
                                ],
                            }),
                        ],
                    }),
                }),
                setup: (self) =>
                    self.hook(isPowerMenuShown, () => {
                        self.set_reveal_child(isPowerMenuShown.value);
                    }),
                revealChild: true,
            }),
        }),
    });
}
