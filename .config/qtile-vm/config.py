import os
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.utils import guess_terminal

mod = "mod4"

terminal = guess_terminal()
color = {
    'background': '#21222c',
    'foreground': '#f8f8f2',
    'active': '#6272a4',
    'inactive': '#44475a',
    'urgent': '#ff5555',
    'floating': '#8be9fd',
}
colors = {
    "greybg": "#2d2d2d",
    "greyfg": "#d3d0c8",
    "red": "#f2777a",
    "blue": "#6699cc",
    "lgrey": "#747369",
    "green": "#99cc99",
}

base16_chalk = {
    "black": "#151515",
    "red": "#fb9fb1",
    "green": "#acc267",
    "yellow": "#ddb26f",
    "blue": "#6fc2ef",
    "magenta": "#e1a3ee",
    "cyan": "#12cfc0",
    "white": "#d0d0d0",
    "gray": "#505050",
}


@hook.subscribe.startup_once
def autostart():
    autostart = os.path.expanduser('~/.config/qtile/autostart.sh')
    os.system(f'{autostart}')


def set_keybindings():
    return [
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

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
        Key([mod], "Return", lazy.spawn(terminal)),

        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout()),
        Key([mod], "w", lazy.window.kill()),

        Key([mod, "control"], "r", lazy.restart()),
        Key([mod, "control"], "q", lazy.shutdown()),

        Key([], 'F12', lazy.group['scratchpad'].dropdown_toggle('term')),
        Key([mod], "d", lazy.spawn(
            "rofi -combi-modi window,drun -show combi -show-icons -sidebar-mode")),

        # Toggle between different layouts
        Key([mod], "space", lazy.window.toggle_floating()),
        Key([mod], "f", lazy.window.toggle_fullscreen()),
    ]


def set_groups(g: str):

    groups = [Group(i, label='♥') for i in g]

    for i in groups:
        # mod1 + letter of group = switch to group
        keys.append(
            Key([mod], i.name, lazy.group[i.name].toscreen(toggle=False))
        )
        # mod1 + shift + letter of group = switch to & move focused window to group
        keys.append(
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
        )

    groups.append(
        ScratchPad("scratchpad", [
            DropDown("term",


                     terminal, opacity=0.8, width=0.96, height=0.4, x=0.02)]),
    )

    return groups

# My preferred layouts


def set_layouts():
    return [
        layout.Columns(border_focus_stack=color['active'], border_width=2),
        layout.Max(),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        layout.Bsp(),
        # layout.Matrix(),
        # layout.MonadTall(),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    ]


def set_widget_defaults():
    return {
        'font': 'JetBrainsMono Nerd Font Mono',
        'fontsize': 12,
        'padding': 2,
    }


def set_widgets():
    return [
        widget.CurrentLayoutIcon(),
        widget.Systray(),
        widget.Prompt(),
        widget.Spacer(),
        widget.GroupBox(
            highlight_method="text",
            urgent_alert_method="text",
            inactive="777777",
            active="777777",
            block_highlight_text_color="FFFF00",
            foreground="ff0000",
            font="JetBrainsMono Nerd Font Mono",
            fontsize=16,
        ),
        widget.Spacer(),
        widget.Clock(format='📅%m-%d %a %H:%M'),
    ]


keys = set_keybindings()
layouts = set_layouts()
groups = set_groups('1234567890')
widget_defaults = set_widget_defaults()

screens = [
    Screen(
        top=bar.Bar(
            set_widgets(),
            24, background=color['background'],
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
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=color['floating'], border_width=2)
auto_fullscreen = True
focus_on_window_activation = "smart"
extentions = []
wmname = "LG3D"
