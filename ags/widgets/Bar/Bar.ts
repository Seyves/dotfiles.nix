import { isPowerMenuShown } from "main";
import Date from "./Date";
import Logo from "./Logo";
import Workspaces from "./Workspaces";

export default function Bar(monitor: number) {
    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        className: "bar",
        child: Widget.CenterBox({
            startWidget: Widget.Box({
                children: [Logo(), Workspaces()],
            }),
            centerWidget: Date(),
            endWidget: Widget.Box({
                hpack: "end",
                vexpand: true,
                className: "power-menu-button",
                child: Widget.Button({
                    cursor: "pointer",
                    child: Widget.Icon({
                        icon: "system-shutdown-symbolic",
                        className: "power-menu-icon"
                    }),
                    onClicked: () =>
                        (isPowerMenuShown.value = !isPowerMenuShown.value),
                }),
            }),
        }),
    });
}
