interface Props {
    icon: string
    onClicked: () => any
    className?: string
}

export default function PWButton(props: Props) {
    return (
        <button
            vexpand={false}
            hexpand={false}
            cursor="pointer"
            className={`button ${props.className ?? ""}`}
            onClicked={props.onClicked}
        >
            <icon icon={props.icon} className="icon"></icon>
        </button>
    )
}
