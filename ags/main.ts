App.addIcons(`${App.configDir}/assets`)

import Bar from "./widgets/Bar/Bar";
import Corners from "./widgets/Bar/Corners";
import PowerMenu from "./widgets/PowerMenu/PowerMenu";

export const whoami = Utils.exec("whoami")
export const configDir = `/home/${whoami}/.config/ags`

export const isPowerMenuShown = Variable(false)

Utils.monitorFile(`${configDir}/style/style.css`, () => {
    App.applyCss(`${configDir}/style/style.css`, true)
})

App.config({
    icons: "./assets",
    windows: [PowerMenu(0), Bar(0), Corners(0)],
    style: "./style/style.css",
    closeWindowDelay: {
        "powermenu0": 300, // milliseconds
    }
});
