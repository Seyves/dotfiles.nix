import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { bind, Variable } from "astal"
import Logo from "./Logo"
import Workspaces from "./Workspaces"
import { isPowerMenuShown } from "../../app"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    const time = Variable("").poll(1000, "date")

    return (
        <window
            application={App}
            anchor={TOP | LEFT | RIGHT}
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            className="bar"
        >
            <centerbox
                startWidget={
                    <box>
                        <Logo />
                        <Workspaces />
                    </box>
                }
                centerWidget={<label className="date" label={bind(time)} />}
                endWidget={
                    <button
                        cursor="pointer"
                        halign={Gtk.Align.END}
                        vexpand={true}
                        onClicked={() =>
                            isPowerMenuShown.set(!isPowerMenuShown.get())
                        }
                    >
                        <icon
                            className="power-menu-icon"
                            icon="system-shutdown-symbolic"
                        />
                    </button>
                }
            ></centerbox>
        </window>
    )
}
