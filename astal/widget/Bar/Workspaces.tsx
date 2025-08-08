import { Gtk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import { className } from "../../utils"
import { bind } from "astal"

const hyprland = Hyprland.get_default()

export default function Workspaces() {
    return (
        <box spacing={8} valign={Gtk.Align.CENTER} className="workspaces">
            {[1, 2, 3, 4, 5, 6, 7].map((index) => (
                <Workspace index={index} />
            ))}
        </box>
    )
}

function Workspace({ index }: { index: number }) {
    const isFocused = (ws: Hyprland.Workspace) => ws.id === index
    const isExists = (workspaces: Hyprland.Workspace[]) => {
        return workspaces.some((ws) => ws.id === index)
    }

    return (
        <button
            setup={(self) => {
                self.hook(bind(hyprland, "focusedWorkspace"), (self, ws: Hyprland.Workspace) =>
                    self.toggleClassName("active", isFocused(ws)),
                )
                self.hook(bind(hyprland, "workspaces"), (self, workspaces: Hyprland.Workspace[]) =>
                    self.toggleClassName("exists", isExists(workspaces)),
                )
                self.className = className({
                    workspace: true,
                    active: isFocused(hyprland.focusedWorkspace),
                    exists: isExists(hyprland.workspaces),
                })
            }}
            cursor="pointer"
        ></button>
    )
}
