const hyprland = await Service.import("hyprland");

function Workspaces() {
    return Widget.Box({
        spacing: 8,
        children: [1, 2, 3, 4, 5].map((i) => {
            return Widget.Button({
                className: "workspace",
                setup: (self) => {
                    self.hook(hyprland.active.workspace, (self) => {
                        self.toggleClassName(
                            "active",
                            hyprland.active.workspace.id === i,
                        );
                    });
                },
                onClicked: () => {
                    hyprland.messageAsync(`dispatch workspace ${i}`)
                }
            });
        }),
        className: "workspaces",
    });
}

function Corners(monitor: number) {
    return Widget.Window({
        monitor,
        name: `corner${monitor}`,
        class_name: "screen-corner",
        anchor: ["top", "bottom", "right", "left"],
        click_through: true,
        child: Widget.Box({
            class_name: "shadow",
            child: Widget.Box({
                class_name: "border",
                expand: true,
                child: Widget.Box({
                    class_name: "corner",
                    expand: true,
                }),
            }),
        }),
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
