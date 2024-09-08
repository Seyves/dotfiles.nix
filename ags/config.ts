function Bar(monitor) {
    const myVar = Variable(0)

    Utils.interval(1000, () => {
        myVar.value++
    })

    const myLabel = Widget.Label({
        label: myVar.bind().as(v => `num: ${v}`)
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
