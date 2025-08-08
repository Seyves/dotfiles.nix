import { exec } from "astal"

export const whoami = exec("whoami")

export const username = whoami[0].toUpperCase() + whoami.slice(1)

export const configDir = `/home/${whoami}/dotfiles.nix/astal`

export const os = exec(
    `bash -c "cat /etc/*-release | egrep \\"PRETTY_NAME\\" | cut -d = -f 2 | tr -d '\\"' | tac | tr '\\n' ' '"`,
)
