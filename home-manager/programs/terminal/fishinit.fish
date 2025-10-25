# utilities
function itl-app-sync -a sandbox
    sshpass -p "root" rsync -avz -e 'ssh' --exclude='media/vue/node_modules' --exclude='media/vue/.dev' --exclude='.git' --exclude='media/vue/dist' --exclude='media/vue/.temp_cache' /home/seyves/work/webapp root@core-dev.$sandbox.kube.itoolabs:/root
    sshpass -p "root" ssh root@centrex-1.$sandbox.kube.itoolabs 'exec /usr/local/bin/centrex-configure -log -install-app '\' 'file "/root/webapp"'\' ' '
end

function sf
    ~/.config/tmux/tmux-session-dispensary.sh
end

# VI mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert block

function fish_mode_prompt 
    echo ''    
end
