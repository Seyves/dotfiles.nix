const applications = await Service.import("applications");

export const isLauncherShown = Variable(false);

export default function Launcher(monitor: number) {
    return Widget.Window({
        monitor,
        name: `launcher${monitor}`,
        anchor: ["top"],
        keymode: "on-demand",
        margins: [0, 20, 0, 0],
        css: "background-color: transparent;",
        className: "launcher-window",
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
                        className: "launcher",
                        vertical: true,
                        spacing: 12,
                        children: [
                            Widget.Entry({
                                placeholderText: "I want...",
                                text: 'initial text',
                                className: "",
                                editable: true,
                            }),
                        ],
                    }),
                }),
                setup: (self) =>
                    self.hook(isLauncherShown, () => {
                        self.set_reveal_child(isLauncherShown.value);
                    }),
                revealChild: true,
            }),
        }),
    });
}
