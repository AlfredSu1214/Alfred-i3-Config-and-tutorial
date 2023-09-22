## 5. 執行程式

* 使用exec
    * e.g.
        ```bash
        bindsym $mod+Return exec alacritty
        bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle 
        ```
    * 語法： 
        ```
        exec [--no-startup-id] <command>
        exec_always [--no-startup-id] <command>
        ```

* 原本的config當中，用 \<Mod\> + Return 時會啓動終端機，預設的是```i3-sensible-terminal```，這個指令會開啓系統中存在的terminal。記得把這個值改成你想要的terminal

* --no-startup-id 是啥？ 看這裏： [link](https://www.reddit.com/r/i3wm/comments/5p75nw/any_reason_to_not_use_nostartupid/)