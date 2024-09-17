App.addIcons(`${App.configDir}/assets`)

import Bar from "./widgets/Bar/Bar";
import Corners from "./widgets/Bar/Corners";
import PowerMenu from "./widgets/PowerMenu/PowerMenu";

export const isPowerMenuShown = Variable(false)

Utils.monitorFile("/home/seyves/.config/ags/style/style.css", () => {
    App.applyCss("/home/seyves/.config/ags/style/style.css", true)
})

App.config({
    icons: "./assets",
    windows: [PowerMenu(0), Bar(0), Corners(0)],
    style: "./style/style.css",
    closeWindowDelay: {
        "powermenu0": 300, // milliseconds
    }
});
