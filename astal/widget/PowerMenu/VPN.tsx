import AstalNetwork from "gi://AstalNetwork?version=0.1";

const network = AstalNetwork.get_default()

export default function VPN() {
    console.log(network.client.get_connections()[0])
}
