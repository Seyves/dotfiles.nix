import Bar from "widgets/Bar/Bar";
import Corners from "widgets/Bar/Corners";
import PowerMenu from "widgets/PowerMenu/PowerMenu";

export const isPowerMenuShown = Variable(false)

Utils.monitorFile("/home/seyves/.config/ags/style/style.css", () => {
    App.applyCss("/home/seyves/.config/ags/style/style.css", true)
})

App.config({
    windows: [Bar(0), Corners(0), PowerMenu(0)],
    style: "./style/style.css",
});
