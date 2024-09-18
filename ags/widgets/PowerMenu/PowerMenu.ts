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

type ButtonProps = {
    className?: string
    icon: string
    onClicked: () => any
}

function Button(props: ButtonProps) {
    return Widget.Button({
        vexpand: false,
        hexpand: false,
        cursor: "pointer",
        className: `button ${props.className ?? ""}`,
        child: Widget.Icon({
            icon: props.icon,
            className: "icon"
        }),
        onClicked: props.onClicked
    });
}

const hyprland = await Service.import('hyprland')

export default function PowerMenu(monitor: number) {
    let username = Utils.exec("whoami");
    username = username[0].toUpperCase() + username.slice(1);

    const os = Utils.exec(
        `bash -c "cat /etc/*-release | egrep \\"PRETTY_NAME\\" | cut -d = -f 2 | tr -d '\\"' | tac | tr '\\n' ' '"`,
    );

    const top = Widget.Box({
        spacing: 16,
        children: [
            Widget.Box({
                className: "avatar",
                vexpand: false,
                vpack: "center",
                hexpand: false,
            }),
            Widget.Box({
                spacing: 8,
                vertical: true,
                children: [
                    Widget.Label({
                        label: username,
                        className: "username",
                        vpack: "start",
                        hpack: "start",
                    }),
                    Widget.Label({
                        label: os,
                        className: "osname",
                        vpack: "start",
                        hpack: "start",
                    }),
                    Widget.Box({
                        vpack: "end",
                        vexpand: true,
                        spacing: 4,
                        children: [
                            Button({
                                className: "reboot",
                                icon: "system-reboot-symbolic",
                                onClicked: () => Utils.exec("reboot"),
                            }),
                            Button({
                                className: "log-out",
                                icon: "system-log-out-symbolic",
                                onClicked: () => hyprland.message("dispatch exit"),
                            }),
                            Button({
                                className: "shutdown",
                                icon: "system-shutdown-symbolic",
                                onClicked: () => Utils.exec("shutdown now"),
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
        className: "power-menu-window",
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
