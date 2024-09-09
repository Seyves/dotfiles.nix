import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

const hyprland = await Service.import("hyprland");

function Workspaces() {
    return Widget.Box({
        spacing: 8,
        children: [1, 2, 3, 4, 5, 6].map((i) => {
            return Widget.Label({
                className: "workspace",
                setup:
                    i === 6
                        ? (self) => {
                              self.hook(hyprland.active.workspace, (self) => {
                                  self.css = `margin-right: ${3 * hyprland.active.workspace.id + 8 * hyprland.active.workspace.id - 1}px`
                                  self.class_name = "workspaces cursor"
                              })
                          }
                        : undefined,
            });
        }),
        className: "workspaces",
    });
}

function Bar(monitor) {
    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Workspaces(),
        className: "bar",
    });
}

App.config({
    windows: [Bar(0)],
    style: "./style/style.css",
});
