import GLib from "gi://GLib"

export default function Date() {
    const clock = Variable(GLib.DateTime.new_now_local(), {
        poll: [1000, () => GLib.DateTime.new_now_local()],
    })   

    return Widget.Label({
        label: clock.bind().as((val) => formatDate(val)),
        className: "date",
    })
}

function formatDate(date: GLib.DateTime) {
    const withZero = (val: number) => val < 10 ? `0${val}` : val

    return `${date.get_year()}-${date.get_month()}-${date.get_day_of_month()} ${withZero(date.get_hour())}:${withZero(date.get_minute())}`
}
