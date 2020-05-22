鼠标点击顶部状态栏切换桌面！！！
每一个桌面都不一样哦

# i3wm

我在这个机器上装的是这个桌面系统  
参考 https://i3wm.org/docs/userguide.html  
具体配置在 ~/.config/i3/config

## 基本命令

```
#(Mod1=<Alt>, Mod4=<Super>)

在mac上$mod应该是command键

$mod+Enter 打开terminal
$mod+数字 切换桌面
$mod+m 隐藏顶部状态栏
$mod+shift+m 打开顶部状态栏
```

# 一些配置好的快捷键

## 中文输入法

已经配置了 fcitx-rime 输入法
用 ctl + space 切换输入法,
右上角有输入法图标

## 打开应用程序

command + d

## 杀掉应用窗口

command + F4

## 打开 yakuake，这个强力推荐

F12

# vnc viewer

在 mac 上用这个  
https://www.realvnc.com/en/connect/download/viewer/macos/  
效果是最好的

# 远程桌面

```
#如何开启远程桌面
/opt/TurboVNC/bin/vncserver -geometry 1440x900
#查看当前远程桌面会话
/opt/TurboVNC/bin/vncserver -list
#杀掉远程桌面会话
/opt/TurboVNC/bin/vncserver -kill  :n

修改远程桌面密码
/opt/TurboVNC/bin/vncpasswd
```

# 修改桌面分辨率

```
参考脚本
~/.screenlayout/macbook.sh
~/.screenlayout/desktop.sh
```

# enjoy

慢慢探索吧，玩的开心：）
申请开发这个机器的 5900:9999 端口，然后可以在家里用
