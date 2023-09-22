<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/I3_window_manager_logo.svg/1200px-I3_window_manager_logo.svg.png" width="200" height="200" />

* [i3wm.org](https://i3wm.org/)：這個是官方的documentation，我的文件只會說到對我來說有實用的功能。如果syntax有問題的話也應該找這裏


* 這個說明的目的是介紹i3一些控制視窗的動作，其他的功能：如mode, rule, mark, exec, 多螢幕設定, 滑鼠binding, i3-msg... 等，會放在 advanced.md；還有控制外觀的功能，會放在appearence.md


# i3 介紹

* i3wm 是一個平鋪式的window manager，但是她也支持一般常見的懸浮視窗

    ![img1](../imgsrc/i3/cmp_floating.png)
    > 懸浮視窗，視窗大小、位置可自由調整

    ![img1](../imgsrc/i3/cmp_tiling.png)
    > 平鋪視窗，視窗會將畫面填滿

* 另外，i3 還可以以鍵盤對視窗進行操作
    * 這時，你可能會好奇，爲什麼不要用滑鼠就好？還要記一堆麻煩的東西... 以下是我的經驗
        1. 在打code的時候切換視窗需要將手移開、握住滑鼠、找到視窗將游標移上去。這樣一來，下次要打字的時候又要將手定位到正確的位置。
        2. 每次要執行一個動作的時候，需要依靠視覺定位需要的功能，但是鍵盤shortcut只需要靠感覺
    * 不過i3也可以定義滑鼠動作，有時候也能有所奇效

* 第一次打開i3時，會出現以下視窗(在角落，注意一下)：
    ![img](https://tiagorocha.xyz/img/i3wm/i3wm-first-conf.png)

    * 跟著提示按鍵作即可，建議 generate the config以及使用 \<Win\> (鍵盤上的windows logo鍵)
        * 使用 \<Alt\> 鍵的話可能會和應用程式衝突，而且 \<Win\>鍵在linux上是沒用途的

# 基本動作

* 這裏有cheat sheet:
    * mod 鍵被按下
    ![sheet](https://i3wm.org/docs/keyboard-layer1.png)
    * Shift + mod 鍵同時被按下
    ![sheet](https://i3wm.org/docs/keyboard-layer2.png)


    * 這個是i3使用預設的config檔時的動作，我會用括號表示我的config的設定值，基本config沒有提到的動作我會放後面。

* 個人認爲預設的config已經很好用了，我的動作也是以這個設定爲基礎建立的

## 0.關閉視窗

* 使用 \<Mod\> + Shift + q(c) 關閉目前視窗
    ```bash
    bindsym $mod+Shift+c kill
    ```

## 1.視窗定位

* 一般而言，i3的視窗會有三種狀態：
    1. focused：目前使用的視窗
    2. inactive：放在旁邊的視窗
    3. urgent：有訊息跑出來的視窗

#### 切換使用的視窗

##### 滑鼠

* 將遊標移到那個視窗即可；要關掉的話，可以在config檔寫：
    ```bash
    focus_follows_mouse no
    ```

##### 方向

* &uarr; l(l) 、&darr; k(k)、&larr; ;(;)、&rarr; j(j)

* 將焦點放在目前任一方向的另一視窗
    * 原本的焦點(藍色)![sheet](../imgsrc/i3/before_moved.png)
    * \<Win\> + ;
    * 後來的焦點(藍色)![sheet](../imgsrc/i3/after_moved.png)

* 在config檔當中的文法：

    ```bash
    # Set Modifier Key
    set $mod Mod4
    ...
    bindsym $mod+j focus left
    bindsym $mod+k focus down
    bindsym $mod+l focus up
    bindsym $mod+semicolon focus right 
    ```
    1. config檔的文法與bash相當類似，用```$var```帶入變數
    2. 宣告bindsym形態來設定shortcut
* 註：j、k、l、; 可以用 &larr; &darr; &uarr; &rarr; 代替

##### 浮動視窗

* 注意在i3當中**tiling**和**floating**的視窗是**分開的兩層，所以想要將focus放到其他層，需要做切換

* config
    ```bash
    bindsym $mod+space focus mode_toggle
    ```

#### 移動視窗

* 按下移動shortcut的同時也一起按下Shift鍵

* 視窗會被移動到自己的任意方向
    * 原本視窗位置：![bef](../imgsrc/i3/before_moving.png)
    * Shift + \<Win\> + ;
    * 後來視窗位置：![bef](../imgsrc/i3/after_moving.png)

* config文法
    ```bash
    bindsym $mod+Shift+j move left
    bindsym $mod+Shift+k move down
    bindsym $mod+Shift+l move up
    bindsym $mod+Shift+semicolon move right
    ```

    * 註：j、k、l、; 可以用 &larr; &darr; &uarr; &rarr; 代替

* 也可以利用滑鼠：按住\<Win\>，按住滑鼠左鍵拖動視窗。在tiling mode也可以使用滑鼠shortcut

## 2. 工作區

* linux 桌面有工作區(Workspace)，可以允許視窗放置，類似windows 的 Virtual Desktop 或MacOS的 Space

* i3的工作區採取的是動態建立的方式，空的工作區會自動被刪掉

* 針對工作區最主要有兩個基本動作：
    * focus到不同的工作區 (\<Win\> + 數字列)
    * 將目前視窗移到不同的工作區 (\<Win\> + Shift + 數字列)

* config語法：

    ```bash
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    # ...(跳過)
    set $ws9 "9"
    set $ws10 "10"

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    # ...(跳過)
    bindsym $mod+0 workspace number $ws10

    # move focused container to workspace
    b indsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    # ...(跳過)
    bindsym $mod+Shift+0 move container to workspace number $ws10
    ```
    * 註：工作區的名字必須是 ``` "<number>" | "<number>:<string>```
* 利用```next, prev```可以在存在的工作區移動，```back_and_forth```可以回到上一個所在的工作區
    * e.g.
        ```bash
        bindsym $mod+o workspace next | prev | back_and_forth
        ```

## 3. 視窗狀態

* 一般的floating視窗管理器可以藉由titlebar上的按鈕或是shortcut來調整視窗狀態，例如最大化、全螢幕、最小化...等

#### 最大化

* 沒有這個功能，因爲tiling wm 會自動把螢幕填滿

#### 全螢幕

* 使用 \<Mod\> + f，就可以將目前視窗全螢幕化，類似\<F11\>

* config>
    ```bash
    bindsym $mod+f fullscreen toggle
    ```

#### 最小化

* i3 **沒有** 這個直接implement這個功能，但是有幾個方式可以發揮類似功能

* 取代方案：
    1. 另外定義一個特別的工作區，最小化時將視窗丟過去；如果需要恢復，到那個工作區把視窗移回去即可
    2. 利用scratchpad **(推薦)**

* config (工作區)
    ```bash
    set $hd "0"
    bindsym $mod+Shift+b workspace number $hd
    bindsym $mod+b move container to workspace number $hd
    ```

* scratchpad
    1. 在scratchpad當中的視窗沒辦法被focus，也看不見；與最小化的作用一樣
    2. 每一次scratchpad被打開的時候，會將下一個視窗往上推，所以每一個在裏面的視窗都會輪到，需要用的時候再拿出來
    3. scratchpad顯示的視窗是放在當前的工作區，而且是floating狀態
    ![img](../imgsrc/i3/scratchpad.png)

* config (scratchpad)
    ```bash
    # Make the currently focused window a scratchpad
    bindsym $mod+Shift+minus move scratchpad

    # Show the first scratchpad window 
    bindsym $mod+minus scratchpad show;
    ```

#### 視窗浮動

* 視窗需要的時候可以單獨設爲floating，不需要的時候再放回去

* config
    ```bash
    bindsym $mod+Shift+space floating toggle
    ```

#### 視窗大小

##### 滑鼠

主要有兩種方式：

* 將遊標放在border上拖動
* 按住\<Win\>後用按住右鍵拖動

##### shortcut

* 可以調整當前視窗長寬

* config
    ```bash
        bindsym $mod+Shift+j resize shrink width 10 px
        bindsym $mod+Shift+k resize grow width 10 px
        bindsym $mod+Shift+l resize shrink height 10 px
        bindsym $mod+Shift+semicolon resize grow height 10 px
    ```

## 4. 視窗部署

#### 指定新視窗

* 剛剛仔細看前面的例子，可以注意到有些視窗有黃邊；這些黃邊是用來指示新的視窗會出現的方向
    ![img](../imgsrc/i3/will_spawn.png)
    ![img](../imgsrc/i3/has_spawn.png)

* 指定新視窗的方式預設有spilt這個方式，分爲垂直或水平兩種方式；可惜方向是固定的(水平往右，垂直往下)，需要自己再喬一下

* config語法
    ```bash
    # split in horizontal orientation
    bindsym $mod+h split h

    # split in vertical orientation
    bindsym $mod+v split v

    # split in horizontal, vertical orientation or none
    bindsym $mod+b split toggle
    ```

#### 安排模式

* 除了將所有視窗平鋪在螢幕上的方式之外(splithv)，i3還有提供其他模式：
    * tabbed(看起來像是瀏覽器) 
        ![img](../imgsrc/i3/mode_tabbed.png)
        * 利用左右移動focus
    * stacking(titlebar吃到飽)
        ![img](../imgsrc/i3/mode_stacked.png)
        * 利用上下移動focus

* 這些模式是獨立的，一次只能設定一個，但是所有模式都可以放置floating視窗

* config
    ```bash
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split
    ```

## 5. 其他

* 當你的config檔寫好後，可以重新載入它；如果不行或是有問題直接重新啓動

* 除此之外，要退出(登出)i3可以用```i3-msg exit```，前面的指令是生成退出的圖形界面:
    ![exitimg](../imgsrc/i3/exiti3.png)
    
* config文法

    ```bash
    # reload the configuration file
    bindsym $mod+Shift+p reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Ctrl+p restart
    # exit i3 (logs you out of your X session)
    bindsym $mod+Shift+period exec "i3-nagbar -t warning -m 'End this session?' -B 'Yes, exit i3' 'i3-msg exit'"
    ```