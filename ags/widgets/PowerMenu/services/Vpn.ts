import Gtk from "gi://Gtk";

const network = await Service.import("network");

export default function Vpn() {
    const currentConnection = Variable(network.vpn.connections[0]);
    const isVpnExpanded = Variable(false);

    function changeConnection(id: string) {
        const activeConnections = network.vpn.connections.filter(
            (connection) => {
                return (
                    connection.state === "connected" ||
                    connection.state === "connecting"
                );
            },
        );

        activeConnections.forEach((connection) => {
            connection.setConnection(false);
        });

        const choosed = network.vpn.connections.find((connection) => {
            return connection.id === id;
        });

        if (choosed) currentConnection.value = choosed;
    }

    const Combobox = Widget.subclass(Gtk.ComboBoxText);

    return Widget.Box({
        css: "padding: 1px; background-color: transparent;",
        vertical: true,
        children: [
            Widget.Button({
                cursor: "pointer",
                hexpand: true,
                vpack: "start",
                onPrimaryClick: () =>
                    currentConnection.value.setConnection(
                        currentConnection.value.state !== "connected",
                    ),
                onSecondaryClick: () =>
                    isVpnExpanded.setValue(!isVpnExpanded.value),
                setup: (self) => {
                    self.hook(network.vpn, () => {
                        for (const connection of network.vpn.connections) {
                            if (connection.state === "connected") {
                                self.class_name = "service active";
                                return;
                            }
                        }
                        self.class_name = "service";
                    });
                },
                child: Widget.Box({
                    hpack: "center",
                    setup: (self) => {
                        network.vpn.connections.forEach((connection) => {
                            self.hook(connection, () => {
                                if (connection !== currentConnection.value)
                                    return;

                                if (
                                    connection.state === "connecting" ||
                                    connection.state === "disconnecting"
                                ) {
                                    self.child = Widget.Spinner({
                                        hexpand: true,
                                    });
                                } else {
                                    self.child = Widget.Box({
                                        hpack: "center",
                                        children: [
                                            Widget.Icon({
                                                className: "service-icon",
                                                icon: "network-vpn-symbolic",
                                            }),
                                            Widget.Label({
                                                className: "service-label",
                                                label: connection
                                                    .bind("id")
                                                    .as((id) => `VPN (${id})`),
                                            }),
                                        ],
                                    });
                                }
                            });
                        });
                    },
                }),
            }),
            Widget.Revealer({
                transitionDuration: 200,
                transition: "slide_down",
                child: Widget.Box({
                    className: "vpn-choose",
                    hpack: "center",
                    child: Combobox({
                        className: "vpn-combobox",
                        setup(self) {
                            network.vpn.connections.forEach((connection) => {
                                self.append_text(connection.id);
                            });
                            self.set_active(0);
                            self.connect("changed", () => {
                                changeConnection(self.get_active_id());
                            });
                            self.bind();
                        },
                    }),
                }),
                setup: (self) =>
                    self.hook(isVpnExpanded, () => {
                        self.set_reveal_child(isVpnExpanded.value);
                    }),
                revealChild: true,
            }),
        ],
    });
}
