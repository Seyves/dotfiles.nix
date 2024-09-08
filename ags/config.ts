const time = Variable("", {
  poll: [
    1000,
    function () {
      return Date().toString();
    },
  ],
});

console.log("Tes");

function Bar(monitor) {
  return Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Widget.Label({
        hpack: "center",
        label: "Welcome to AGS!",
      }),
      end_widget: Widget.Label({
        hpack: "center",
        label: time.bind(),
      }),
    }),
  });
}
App.config({
  windows: [Bar(0)],
});
