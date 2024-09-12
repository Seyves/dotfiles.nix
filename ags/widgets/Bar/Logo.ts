const isHovered = Variable(false);

export default function Logo() {
    return Widget.Box({
        className: "logo",
        child: Widget.EventBox({
            cursor: "pointer",
            onHover: () => isHovered.setValue(true),
            onHoverLost: () => isHovered.setValue(false),
            child: Widget.Icon({
                icon: "nixos-symbolic",
                className: "logo-icon",
                setup: (self) =>
                    self.hook(isHovered, (self) => {
                        self.toggleClassName("hovered", isHovered.value);
                    }),
            }),
        }),
    });
}
