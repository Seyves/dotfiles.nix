type Props = {
    size: number;
};

export default function Avatar(props: Props) {
    return Widget.Box({
        class_name: "avatar",
        vexpand: false,
        hexpand: false,
        css: `
            min-width: ${props.size}px;
            min-height: ${props.size}px;
            border-radius: 50%;
            background-image: url('/home/seyves/.face');
            background-size: cover;
        `,
    });
}
