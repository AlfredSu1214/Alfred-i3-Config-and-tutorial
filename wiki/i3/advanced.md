
* 這個說明的目的是以config檔爲主，關於基本的操作；請看basic.md

* i3相對於其他window manager最大的好處是，她預設的config檔可用性已經很高了，只要自己再加一兩行設定就可以忘掉它；不過如果願意燒點腦、花點時間的話，體驗會更加舒適


## 0. 鍵位定義

#### 鍵盤定義
* 使用 ```bindsym``` 或 ```bindcode``` 定義鍵位：
    ```bash
    bindsym [--release] [<Group>+][<Modifiers>+]<keysym> command
    bindcode [--release] [<Group>+][<Modifiers>+]<keycode> command
    ```

* --release 可以規定一個shortcut被放開的時候該執行什麼動作
* Group指的是keyboard Layout，這個功能可以指定同一個binding在不同的layout下做不同的動作，通常用不到

* 怎麼知道keysym或keycode？
    * 在X Server，鍵盤上不同的輸入會被編碼爲不同的代碼；i3會接受這個代碼，如果是有被定義的動作，她就會執行。
    * 一般來說代碼就是鍵盤上寫的東西，但是有時候還是會不知道，例如：亮度調整的代碼是什麼？這個時候，就需要一些工具，像```xev```就是其中一個
* xev
    ![img](../imgsrc/i3/xev.png)
    1. 在terminal 打 ```xev```
    2. 將滑鼠放入視窗裏面，按住你想知道keysym的鍵
    3. 可以開始看到terminal開始輸出，綠色的部分是keycode，黃色的部分是keysym。放到i3 的config檔，就能使用

#### 滑鼠定義
* 也是使用```bindsym```
    ```bash
    bindsym [--release] [--border] [--whole-window] [--exclude-titlebar] [<Modifiers>+]button<n> command
    ```
* --border: 滑鼠按到border時，也會有反應
* --whole-window: 滑鼠按到視窗的任何地方時，就會有反應
* --exclude-titlebar: 忽略titlebar

* 要知道滑鼠按鍵的代碼，也是可以用```xev```
    ![img](../imgsrc/i3/xev_mouse.png)

* e.g.
    ```bash
    bindsym --whole-window $mod+button2 kill
    ```

## 1. 執行程式

#### 自動執行

* config檔當中可以指定在i3開始的時候，要一起執行哪些程式
* config文法
    ```bash
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
    ```
* 建議可以將所有要開始的程式放在一個shell檔裏面，這樣管理上會更有彈性
    ```bash
    exec --no-startup-id bash -c '$HOME/.config/i3/autostart.sh'
    ```
#### 綁定shortcut

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

* --no-startup-id 是啥？ 看這裏： [link](https://www.reddit.com/r/i3wm/comments/5p75nw/any_reason_to_not_use_nostartupid/) ；實際上使用的感覺真的差不多

* 如果需要執行多行程式，也可以用分號隔開
    ```bash
    exec --no-startup-id connman-gtk; cbatticon; variety
    ```

* 如果需要執行shell script，也可以直接將shell script的位置打上去作爲指令

## 2. mode

* 有用過vim 的都知道裏面有許多模式：
    ![vimmode](https://raw.githubusercontent.com/nilp0inter/Vim-for-Muggles/master/modes.png)

    * 不同的mode有不同的功能，例如insert mode可以輸入文字，visual mode可以利用滑鼠操作

* 在i3 當中也有和vim相當類似的功能，可以使用設定好的keybind進入到其他模式
    ```bash
    bindsym $mod+e mode apps
    ```

* 進入到其他模式時，可以用更簡單的按鍵組合做出想要的事

    ```bash
    bindsym $mod+e mode apps
    mode "apps" {
	bindsym u exec firefox
	bindsym --release u mode "default"
	bindsym e exec dolphin
    # 跳過...
	bindsym Return mode "default"
	bindsym Escape mode "default"
	bindsym $mod+e mode "default"
    }
    ```

    * 例如我想要執行Firefox(一個瀏覽器)的話，我會先按 ```<Win> + e``` 進入 ```"app"``` mode，然後按下 ```u``` 開啓後退出 ```"apps"``` 模式

* 優點：
    1. binding多的時候不需要將鍵位安排到整個鍵盤，方便記憶
    2. 不需要壓住 Shift 又壓住 Ctrl 又壓住這個那個，比較舒服
    ![what](https://cdn.trendhunterstatic.com/thumbs/ctrl-alt-del-tool.jpeg?auto=webp)

* 建議
    1. 記得一定要設定回```"default"```mode的binding，不然會卡在那裏
    2. 建議要把mode顯示出來(使用```i3-msg```)
        * 這個會在polybar的設定檔裏面說明
        ![bar](../imgsrc/i3/mode_indicator.png)

## 3. rule

* 有時候會遇到這種情況：
    1. 我的瀏覽器在workspace 1
    2. 我在其他workspace忙我的事情
    3. 突然需要用firefox，但是沒注意到workspace 1有firefox
    4. 我又開了一個新的firefox
    5. 重複 1. ~ 4.直到我發現已經亂掉了
    * 所以要是有一個不用讓我去找firefox的方法就好了

* i3提供了rule的功能，可以讓符合特定條件的視窗自動執行指定的動作

#### criteria

* 這個criteria是基於window的資訊構成的條件，關於完全的定義，請參考：[criteria類型](https://i3wm.org/docs/userguide.html#list_of_commands) ，另外，語法是使用 [regular expression](https://man7.org/linux/man-pages/man3/pcresyntax.3.html)

* 比較常用的資訊通常可以由```xprop```得到
    * 在terminal執行```xprop```後點擊想要知道資訊的視窗
    ![xprop](../imgsrc/i3/xprop.png)
    1. 黃色的部分是 ```window_type```: 分別有 normal, dialog, utility, toolbar, splash, menu, dropdown_menu, popup_menu, tooltip 和notification 這些類型
    2. 橘色是```machine```: 簡單來說就是hostname
    3. 紅色的部分是 ```instance```
    4. 綠色的部分是 ```class```
    5. 藍色的部分是 name: 是視窗的名稱，i3會先參考```_NET_WM_NAME```再參考```WM_NAME```
    * ```instance``` 和 ```class```通常會受到開啓的程式影響，要怎麼利用這些參數需要多抓一些視窗會比較清楚

* 除此之外，還有```workspace, urgent, tiling, floating```，這些資訊都是i3可以直接知道的

#### 相關指令


* assign
    * 將符合條件的視窗放到指定的地方
    * 語法: ```assign [criteria] <workspace/output>```
    ```bash
    # 到特定編碼的workspace
    assign [class="firefox"] 2
    # 到特定名稱的workspace
    assign [class="^Urxvt$"] work
    # 到主要output
    assign [class="Alacritty"] output primary
    ```

* for_window
    * 對符合條件的視窗執行指令
    * 格式： ```for [criteria] <command>```
    * 後面的指令基本上可以是任何config的指令
    * e.g. 
    ```bash
    # 將所有dolphin的視窗設爲floating
    for_window [class="dolphin"] floating enable
    # 打開osu.exe時會傳送通知
    for_window [class="osu.exe"] exec bash -c 'dunstify "Hey" "touch some grass"'
    ```

* focus, move
    * 格式： ```[criteria] focus/move```
    ```bash
    # focus firefox的視窗
    bindsym $mod+F11 [class="firefox"] focus
    ```



## 4. mark

* i3有許多功能參考了vim，除了mode以外，還有mark；那麼mark是什麼意思？可以參考這裏： [vim mark](https://medium.com/unalai/vim-%E5%AD%B8%E7%BF%92%E7%AD%86%E8%A8%98-%E6%A8%99%E8%A8%98-marks-465fe6c7cfb9)。簡單來說，就像是bookmark

* i3

## 5. 多螢幕

* 關於多螢幕的設定，可以看 [xrandr.md](https://github.com/AlfredSu1214/Alfred-i3-Config-and-tutorial/blob/main/wiki/xrandr.md)，i3只負責視窗的部分

* i3 的一個workspace只會出現在一個螢幕，預設創建的方式是看鼠標在哪個螢幕

* 和window一樣，workspace也可以指定在哪一個螢幕創建 

* config語法
    ```bash
    workspace 10 output DP-1
    ```

* 當然，除了指定外，也可以動態的將workspace移到某一個螢幕
    ```bash
    bindsym $mod+x move workspace to output next
    ```

* config語法: workspace總共有幾個變數
    1. (non)primary: (次)主要的輸出 (不知道的請先看xrandr.md)
    2. next/prev:上/下一個
    3. up/down/left/right: 方向
    4. {output1 output2 output3...} 從 output1, output2, output3 內輪流放置
    * e.g.
        ```bash
        bindsym $mod+x move workspace to output VGA1 LVDS1
        ```
