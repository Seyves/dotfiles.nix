function Bar(monitor) {
    const myLabel = Widget.Label({
        label: "text"
    })

    return Widget.Window({
        monitor,
        name: `bar${monitor}`,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: myLabel,
    });
}

App.config({
    windows: [Bar(0)],
});
