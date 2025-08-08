import { bind, Variable } from "astal";
import { className } from "../../utils";

export default function Logo() {
    const isHovered = Variable(false);

    return (
        <box className="logo">
            <eventbox
                cursor="pointer"
                onHover={() => isHovered.set(true)}
                onHoverLost={() => isHovered.set(false)}
            >
                <icon
                    icon="nixos-symbolic"
                    className={bind(isHovered).as((val) =>
                        className({
                            "logo-icon": true,
                            hovered: val,
                        }),
                    )}
                />
            </eventbox>
        </box>
    );
}
