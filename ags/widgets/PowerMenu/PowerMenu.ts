import { isPowerMenuShown } from "main";

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

export default function PowerMenu(monitor: number) {
    return Widget.Window({
        monitor,
        name: `powermenu${monitor}`,
        anchor: ["top", "right"],
        margins: [60, 20, 0, 0],
        css: "background-color: transparent;",
        exclusivity: "ignore",
        child: Widget.Box({
            css: "padding: 1px; background-color: transparent;",
            child: Widget.Revealer({
                transitionDuration: 200,
                transition: "crossfade",
                child: Widget.Box({
                    className: "power-menu",
                    child: Widget.Box({
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
                    setup: (self) =>
                        self.hook(isPowerMenuShown, (self) => {
                            App.toggleWindow(`powermenu${monitor}`);
                            self.visible = isPowerMenuShown.value;
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
