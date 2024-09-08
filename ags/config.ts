const hyprland = await Service.import("hyprland");

function Workspaces() {
    return Widget.Box({
        children: [1, 2, 3, 4, 5].map((i) => {
            return Widget.Label({
                className: "workspace",
                setup: (self) => {
                    self.hook(hyprland.active.workspace, (self) => {
                        self.toggleClassName(
                            "active",
                            hyprland.active.workspace.id === i,
                        );
                    });
                },
            });
        }),
        className: "workspaces"
    });
}

function Bar(monitor) {
    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Workspaces(),
        className: "bar"
    });
}

App.config({
    windows: [Bar(0)],
    style: "./style/style.css",
});
