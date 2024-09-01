# sourcing p10k
source ~/.p10k.zsh

# starting ssh-agent
eval $(ssh-agent) > /dev/null

# vi mode
bindkey -v

# some userful scripts
function tm {
    function tmux-start {
        SESSION_NAME=$1
        tmux new -s $SESSION_NAME
        tmux attach -t $SESSION_NAME
    }

    DIR_NAME=${PWD##*/}

    tmux has-session -t $DIR_NAME 2>/dev/null
    if [ $? -eq 1 ]
    then
        tmux-start $DIR_NAME
    else
        tmux attach -t $DIR_NAME
    fi
}

function sf {
    selected=$(find ~/work ~/ ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)  
    if [ $? -eq 0 ]; then
        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        if [ "$TMUX" ]; then 
            tmux switch -t $selected_name
        else 
            tmux attach -t $selected_name
        fi
    fi
}

function itl-app-sync {
    sshpass -p "root" rsync -avz -e 'ssh' --exclude='media/vue/node_modules' --exclude='media/vue/.dev' --exclude='.git' --exclude='media/vue/dist' --exclude='media/vue/.temp_cache' /home/seyves/work/webapp root@core-dev.$1.kube.itoolabs:/root
    sshpass -p "root" ssh root@centrex-1.$1.kube.itoolabs 'exec /usr/local/bin/centrex-configure -log -install-app '\' 'file "/root/webapp"'\' ' '
}

function itl-app-clear {
    rsync -avh --exclude='media/vue/node_modules' --exclude='media/vue/.dev' --exclude='.git' --exclude='media/vue/dist' --exclude='media/vue/.temp_cache' --delete-excluded /home/seyves/work/webapp root@core-dev.$1.kube.itoolabs:/root --delete
}

function itl-dev {
    ssh -A root@docker-dev.itoolabs
}
