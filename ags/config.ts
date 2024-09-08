const hyprland = await Service.import("hyprland")

function Workspaces () {
    return Widget.Box({
        spacing: 8,
        children: [1, 2, 3, 4, 5].map((i) => {
            return Widget.Label({
                setup: (self) => {
                    self.hook(hyprland.active.workspace, (self) => {
                        self.label = (hyprland.active.workspace.id === i).toString()
                    })
                }
            })
        })
    })
}

function Bar(monitor) {
    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Workspaces(),
    });
}

App.config({
    windows: [Bar(0)],
});
