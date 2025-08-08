import { App, Astal, Gdk } from "astal/gtk3";

export default function Corners(gdkmonitor: Gdk.Monitor) {
    const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

    return (
        <window
            application={App}
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            layer={Astal.Layer.BACKGROUND}
            gdkmonitor={gdkmonitor}
            className="screen-corner"
            clickThrough={true}
            focusOnMap={false}
            focusOnClick={false}
        >
            <box className="shadow" expand={true}>
                <box className="border" expand={true}>
                    <box className="corner" expand={true}></box>
                </box>
            </box>
        </window>
    );
}
