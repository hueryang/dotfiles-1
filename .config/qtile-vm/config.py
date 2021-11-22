import os
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.utils import guess_terminal
from libqtile import qtile
import distro
import subprocess

distro_logo = "/work/Pictures/distro/os_%s.png" % (distro.id())

@hook.subscribe.startup_once
def autostart():
    autostart = os.path.expanduser('~/.config/qtile/autostart.sh')
    os.system(f'{autostart}')

@hook.subscribe.screen_change
def randrchange(qtile, ev):
    qtile.cmd_restart()

mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),

    Key([mod, "control"], "g", lazy.layout.grow()),
    Key([mod, "control"], "s", lazy.layout.shrink()),
    Key([mod, "control"], "n", lazy.layout.normalize()),
    Key([mod, "control"], "m", lazy.layout.maximize()),

    # Toggle between split and unsplit sides of stack.
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),

    # qtile restart and quite
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),


    # size
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod], "Return", lazy.spawn(terminal)),
    Key([], 'F12', lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], "r", lazy.spawn(
        "rofi -combi-modi window,drun -show combi -show-icons -sidebar-mode")),
]
layouts = [
    layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=2),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = {
    'font': 'JetBrainsMono Nerd Font Mono',
    'fontsize': 12,
    'padding': 2,
}

extension_defaults = widget_defaults.copy()

# groups
for i in '1234567890':
    keys.append(Key([mod], i, lazy.group[i].toscreen(toggle=False)))
    keys.append(Key([mod, 'shift'], i, lazy.window.togroup(i)))

groups = [Group(i, label="♥") for i in "1234567890"]

groups.append(
    ScratchPad("scratchpad", [
        DropDown("term",
                 terminal, opacity=0.8, width=0.96, height=0.4, x=0.02, on_focus_lost_hide=False )]),
)

# screens
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(filename=distro_logo, mouse_callbacks={
                    'Button1': lambda: qtile.cmd_spawn("rofi -combi-modi window,drun -show combi -show-icons -sidebar-mode")}),
                widget.GenPollText(update_interval=1, func=lambda: subprocess.check_output(
                    "hostname -i", shell=True).decode("utf-8").rstrip()),

                widget.Prompt(),
                widget.Spacer(),
                widget.CurrentLayoutIcon(scale=0.6),
                widget.GroupBox(
                    highlight_method="text",
                    urgent_alert_method="text",
                    inactive="404040",
                    active="404040",
                    this_current_screen_border='ff00ff',
                    font="JetBrainsMono Nerd Font Mono",
                    fontsize=20,
                ),
                widget.TextBox(
                    text='✨',
                    fontsize=14,
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn('emacsclient --alternate-editor "" --create-frame')},
                    padding_y=5,
                ),
                widget.Spacer(),
                widget.Systray(),
                widget.Clock(format='%H:%M'),

            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# Miscellaneous Config Variables
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=2)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"


# references
# https://github.com/FrostyX/dotfiles/blob/master/.config/qtile/config.py
# https://github.com/qtile/qtile/issues/1271
