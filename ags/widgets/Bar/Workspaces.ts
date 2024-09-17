const hyprland = await Service.import("hyprland");

export default function Workspaces() {
    return Widget.Box({
        spacing: 8,
        vpack: "center",
        className: "workspaces",
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
    });
}
