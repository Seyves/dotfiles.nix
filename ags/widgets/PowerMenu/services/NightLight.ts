export default function NightLight() {
    const isEnabled = Variable(false)

    return Widget.Box({
        vertical: true,
        child: Widget.Button({
            cursor: "pointer",
            hexpand: true,
            vpack: "start",
            onPrimaryClick: () => {
                if (isEnabled.value) {
                    Utils.exec("pkill gammastep")
                } else {
                    Utils.execAsync("gammastep -l 54.2:37.61 -t 5500:5000")
                }
                isEnabled.value = !isEnabled.value
            },
            className: isEnabled.bind("value").as((value) => {
                return `service ${value ? "active" : ""}`
            }),
            child: Widget.Box({
                hpack: "center",
                children: [
                    Widget.Icon({
                        className: "service-icon",
                        icon: "night-light-symbolic",
                    }),
                    Widget.Label({
                        className: "service-label",
                        label: "Night Light",
                    }),
                ],
            }),
        }),
    });
}
