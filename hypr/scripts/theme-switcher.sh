#!/bin/zsh

THEMES_DIR="$HOME/.config/themes/colors"
CURRENT_THEME="$HOME/.config/themes/current"

#Create Current if it doesn't exist
mkdir -p "$(dirname "$CURRENT_THEME")"

# Get available themes
themes=($THEMES_DIR/*.conf)
theme_names=()

for theme in $themes; do
    name=$(basename "$theme" .conf)
    theme_names+=("$name")
done

# Show theme selection menu
selected=$(printf "%s\n" "${theme_names[@]}" | rofi -dmenu -p -i "Select Theme" -theme-str '
    window {
        width: 20%;
    }
    listview {
        lines: 6;
        fixed-height: true;
      }')

if [[ -z "$selected" ]]; then
    exit 0
fi

# Find the selected theme file
selected_file="$THEMES_DIR/${selected}.conf"

if [[ ! -f "$selected_file" ]]; then
    echo "Theme file not found: $selected_file"
    exit 1
fi

# Super simple color extractor (no spaces after =)
get_color() {
    local theme_file="$1"
    local color_name="$2"
    grep "^$color_name=" "$theme_file" | cut -d= -f2
}

# Convert hex to Hyprland RGBA format
hex_to_rgba() {
    local hex="$1"
    echo "rgba(${hex}ff)"
}

# Globally defined color values (One time file read to get colors)
# Base colors
background=$(get_color "$selected_file" "background")
foreground=$(get_color "$selected_file" "foreground")
background_alt=$(get_color "$selected_file" "background_alt")
background_dim=$(get_color "$selected_file" "background_dim")
foreground_dim=$(get_color "$selected_file" "foreground_dim")
cursor=$(get_color "$selected_file" "cursor")

# Accent colors
accent=$(get_color "$selected_file" "accent")
accent_alt=$(get_color "$selected_file" "accent_alt")

# Status colors
error=$(get_color "$selected_file" "error")
warning=$(get_color "$selected_file" "warning")
success=$(get_color "$selected_file" "success")
info=$(get_color "$selected_file" "info")
orange=$(get_color "$selected_file" "orange")
bright_orange=$(get_color "$selected_file" "bright_orange")

# UI colors
selection=$(get_color "$selected_file" "selection")
border=$(get_color "$selected_file" "border")
background_highlight=$(get_color "$selected_file" "background_highlight")
overlay=$(get_color "$selected_file" "overlay")

# Standard 16-color palette
black=$(get_color "$selected_file" "black")
red=$(get_color "$selected_file" "red")
green=$(get_color "$selected_file" "green")
yellow=$(get_color "$selected_file" "yellow")
blue=$(get_color "$selected_file" "blue")
magenta=$(get_color "$selected_file" "magenta")
cyan=$(get_color "$selected_file" "cyan")
white=$(get_color "$selected_file" "white")

bright_black=$(get_color "$selected_file" "bright_black")
bright_red=$(get_color "$selected_file" "bright_red")
bright_green=$(get_color "$selected_file" "bright_green")
bright_yellow=$(get_color "$selected_file" "bright_yellow")
bright_blue=$(get_color "$selected_file" "bright_blue")
bright_magenta=$(get_color "$selected_file" "bright_magenta")
bright_cyan=$(get_color "$selected_file" "bright_cyan")
bright_white=$(get_color "$selected_file" "bright_white")

# Grayscale
gray1=$(get_color "$selected_file" "gray1")
gray2=$(get_color "$selected_file" "gray2")
gray3=$(get_color "$selected_file" "gray3")
gray4=$(get_color "$selected_file" "gray4")
gray5=$(get_color "$selected_file" "gray5")
gray6=$(get_color "$selected_file" "gray6")
gray7=$(get_color "$selected_file" "gray7")


# Generate Hyprland colors with RGBA format
generate_hyprland_colors() {
    
    
    cat << EOF
# Auto-generated from $(basename "$theme_file")
# Only colors used in hyprland.conf
\$border = $(hex_to_rgba "$border")
\$accent = $(hex_to_rgba "$accent")
\$accent_alt = $(hex_to_rgba "$accent_alt")
\$gray3 = $(hex_to_rgba "$gray3")
\$background = $(hex_to_rgba "$background")
\$background_alt = $(hex_to_rgba "$background_alt")
EOF
}

# Generate Rofi colors (stays with hex)
generate_rofi_colors() {
    
    
    cat << EOF
* {
    background: #$background;
    foreground: #$foreground;
    background-alt: #$background_alt;
    accent: #$accent;
    accent-alt: #$accent_alt;
    border: #$border;
    warning: #$warning;
    error: #$error;
    success: #$success;
    info: #$info;
    selected: #$selection;
    gray1: #$gray1;
    gray2: #$gray2;
    gray3: #$gray3;
    gray4: #$gray4;
    gray5: #$gray5;
    gray6: #$gray6;
    gray7: #$gray7;
    background-dim: #$background_dim;
    foreground-dim: #$foreground_dim;
    background-highlight: #$background_highlight;
}
EOF
}

# Generate Kitty colors (stays with hex)
generate_kitty_colors() {
    
    
    
    cat << EOF
foreground #$foreground
background #$background
selection_background #$selection
selection_foreground #$foreground
cursor #$cursor

color0 #$black
color8 #$bright_black
color1 #$red
color9 #$bright_red
color2 #$green
color10 #$bright_green
color3 #$yellow
color11 #$bright_yellow
color4 #$blue
color12 #$bright_blue
color5 #$magenta
color13 #$bright_magenta
color6 #$cyan
color14 #$bright_cyan
color7 #$white
color15 #$bright_white
EOF
}

generate_waybar_colors() {
    
    

    cat << EOF
/* Auto-generated from $(basename "$theme_file") */
@define-color background #$background;
@define-color background_alt #$background_alt;
@define-color background_dim #$background_dim;
@define-color foreground #$foreground;
@define-color foreground_dim #$foreground_dim;
@define-color cursor #$cursor;
@define-color accent #$accent;
@define-color accent_alt #$accent_alt;
@define-color error #$error;
@define-color warning #$warning;
@define-color success #$success;
@define-color info #$info;
@define-color orange #$orange;
@define-color bright_orange #$bright_orange;
@define-color selection #$selection;
@define-color border #$border;
@define-color background_highlight #$background_highlight;
@define-color overlay #$overlay;
@define-color black #$black;
@define-color red #$red;
@define-color green #$green;
@define-color yellow #$yellow;
@define-color orange #$orange;
@define-color blue #$blue;
@define-color magenta #$magenta;
@define-color cyan #$cyan;
@define-color white #$white;
@define-color bright_black #$bright_black;
@define-color bright_red #$bright_red;
@define-color bright_green #$bright_green;
@define-color bright_yellow #$bright_yellow;
@define-color bright_orange #$bright_orange;
@define-color bright_blue #$bright_blue;
@define-color bright_magenta #$bright_magenta;
@define-color bright_cyan #$bright_cyan;
@define-color bright_white #$bright_white;
@define-color gray1 #$gray1;
@define-color gray2 #$gray2;
@define-color gray3 #$gray3;
@define-color gray4 #$gray4;
@define-color gray5 #$gray5;
@define-color gray6 #$gray6;
@define-color gray7 #$gray7;
EOF
}

generate_swaync_css() {
    
    

    cat << EOF
/* Auto-generated from $(basename "$theme_file") */
* {
  all: unset;
  font-size: 16px;
  font-family: "JetBrainsMono Nerd Font";
  transition: 200ms;
}

trough highlight {
  background: #$accent;
}

scale {
  margin: 0 7px;
}

scale trough {
  margin: 0rem 1rem;
  min-height: 8px;
  min-width: 70px;
  border-radius: 12.6px;
}

trough slider {
  margin: 0px;
  border-radius: 12.6px;
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
  transition: all 0.2s ease;
  background-color: #$accent;
}

trough slider:hover {
  box-shadow: 0 0 2px rgba(0, 0, 0, 0.8), 0 0 8px #$accent;
}

trough {
  background-color: #$gray3;
}

/* notifications */
.notification-background {
  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #$border;
  margin: 18px;
  background: #$background_alt;
  color: #$foreground;
  padding: 0;
}

.notification-background .notification {
  padding: 7px;
}

.notification-background .notification.critical {
  box-shadow: inset 0 0 7px 0 #$error;
}

.notification .notification-content {
  margin: 7px;
}

.notification .notification-content overlay {
  /* icons */
  margin: 4px;
}

.notification-content .summary {
  color: #$accent;
  font-weight: 700;
}

.notification-content .time {
  color: #$foreground_dim;
}

.notification-content .body {
  margin-top: 5px;
  color: #$foreground;
  font-size: 14px;
}

.notification > *:last-child > * {
  min-height: 3.4em;
}

.notification-background .close-button {
  margin: 7px;
  padding: 2px;
  border-radius: 6.3px;
  color: #$foreground;
  background-color: #$gray3;
}

.notification-background .close-button:hover {
  background-color: #$accent;
}

.notification-background .close-button:active {
  background-color: #$accent_alt;
}

.notification .notification-action {
  border-radius: 7px;
  color: #$foreground;
  box-shadow: inset 0 0 0 1px #$border;
  margin: 4px;
  padding: 8px;
  font-size: 0.2rem;
}

.notification .notification-action {
  background-color: #$gray3;
}

.notification .notification-action:hover {
  background-color: #$accent;
}

.notification .notification-action:active {
  background-color: #$accent_alt;
}

.notification.critical progress {
  background-color: #$error;
}

.notification.low progress,
.notification.normal progress {
  background-color: #$accent;
}

.notification progress,
.notification trough,
.notification progressbar {
  border-radius: 12.6px;
  padding: 3px 0;
}

/* control center */
.control-center {
  box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #$border;
  background-color: #$background_alt;
  color: #$foreground;
  padding: 14px;
}

.control-center .notification-background {
  border-radius: 7px;
  box-shadow: inset 0 0 0 1px #$border;
  margin: 4px 10px;
}

.control-center .notification-background .notification {
  border-radius: 7px;
}

.control-center .notification-background .notification.low {
  opacity: 0.8;
}

.control-center .widget-title > label {
  color: #$foreground;
  font-size: 1.3em;
}

.control-center .widget-title button {
  border-radius: 7px;
  color: #$foreground;
  background-color: #$gray3;
  box-shadow: inset 0 0 0 1px #$border;
  padding: 8px;
}

.control-center .widget-title button:hover {
  background-color: #$accent;
}

.control-center .widget-title button:active {
  background-color: #$accent_alt;
}

.control-center .notification-group {
  margin-top: 10px;
}

.control-center .notification-group:focus .notification-background {
  background-color: #$background_highlight;
}

scrollbar slider {
  margin: 3px;
  opacity: 0.8;
}

scrollbar trough {
  margin: 2px 0;
}

/* dnd */
.widget-dnd {
  margin-top: 5px;
  border-radius: 8px;
  font-size: 1.1rem;
}

.widget-dnd > switch {
  font-size: initial;
  border-radius: 8px;
  background: #$gray3;
  box-shadow: none;
}

.widget-dnd > switch:checked {
  background: #$accent;
}

.widget-dnd > switch slider {
  background: #$foreground;
  border-radius: 8px;
}

/* mpris */
.widget-mpris-player {
  background: #$background;
  border-radius: 12.6px;
  color: #$foreground;
}

.mpris-overlay {
  background-color: #$background;
  opacity: 0.9;
  padding: 15px 10px;
}

.widget-mpris-album-art {
  -gtk-icon-size: 100px;
  border-radius: 12.6px;
  margin: 0 10px;
}

.widget-mpris-title {
  font-size: 1.2rem;
  color: #$foreground;
}

.widget-mpris-subtitle {
  font-size: 1rem;
  color: #$foreground_dim;
}

.widget-mpris button {
  border-radius: 12.6px;
  color: #$foreground;
  margin: 0 5px;
  padding: 2px;
}

.widget-mpris button image {
  -gtk-icon-size: 1.8rem;
}

.widget-mpris button:hover {
  background-color: #$accent;
}

.widget-mpris button:active {
  background-color: #$accent_alt;
}

.widget-mpris button:disabled {
  opacity: 0.5;
}

.widget-menubar > box > .menu-button-bar > button > label {
  font-size: 3rem;
  padding: 0.5rem 2rem;
}

.widget-menubar > box > .menu-button-bar > :last-child {
  color: #$accent;
}

.power-buttons button:hover,
.powermode-buttons button:hover,
.screenshot-buttons button:hover {
  background: #$accent;
}

.control-center .widget-label > label {
  color: #$foreground;
  font-size: 2rem;
}

.widget-buttons-grid {
  padding-top: 1rem;
}

.widget-buttons-grid > flowbox > flowboxchild > button label {
  font-size: 2.5rem;
}

.widget-volume {
  padding: 1rem 0;
}

.widget-volume label {
  color: #$foreground;
  padding: 0 1rem;
}

.widget-volume trough highlight {
  background: #$accent;
}

.widget-backlight trough highlight {
  background: #$accent;
}

.widget-backlight label {
  font-size: 1.5rem;
  color: #$foreground;
}

.widget-backlight .KB {
  padding-bottom: 1rem;
}

.image {
  padding-right: 0.5rem;
}
EOF
}

generate_nvim_colors() {
    
    

    cat << EOF
-- Auto-generated from $(basename "$theme_file")
return {
    -- Base / Core tones
    bg        = "#$background",
    bg_alt    = "#$background_alt",
    bg_dim    = "#$background_dim",
    fg        = "#$foreground",
    fg_dim    = "#$foreground_dim",
    cursor    = "#$cursor",

    -- Accent / highlights
    accent            = "#$accent",
    accent_alt        = "#$accent_alt",

    -- Status / semantic
    error             = "#$error",
    warning           = "#$warning",
    success           = "#$success",
    info              = "#$info",
    orange            = "#$orange",
    bright_orange     = "#$bright_orange",

    -- UI / structural
    selection         = "#$selection",
    border            = "#$border",
    background_highlight = "#$background_highlight",
    overlay           = "#$overlay",

    -- Standard 16-color palette
    black             = "#$black",
    red               = "#$red",
    green             = "#$green",
    yellow            = "#$yellow",
    blue              = "#$blue",
    magenta           = "#$magenta",
    cyan              = "#$cyan",
    white             = "#$white",

    bright_black      = "#$bright_black",
    bright_red        = "#$bright_red",
    bright_green      = "#$bright_green",
    bright_yellow     = "#$bright_yellow",
    bright_blue       = "#$bright_blue",
    bright_magenta    = "#$bright_magenta",
    bright_cyan       = "#$bright_cyan",
    bright_white      = "#$bright_white",

    -- Grayscale
    gray1             = "#$gray1",
    gray2             = "#$gray2",
    gray3             = "#$gray3",
    gray4             = "#$gray4",
    gray5             = "#$gray5",
    gray6             = "#$gray6",
    gray7             = "#$gray7",
}
EOF
}

generate_btop_colors() {
    
    
    
    cat << EOF
# Auto-generated from $(basename "$theme_file")
# Main background
theme[main_bg]="#$background"

# Main text color
theme[main_fg]="#$foreground"

# Title color for boxes
theme[title]="#$accent"

# Highlight color for keyboard shortcuts
theme[hi_fg]="#$orange"

# Background color of selected items
theme[selected_bg]="#$selection"

# Foreground color of selected items
theme[selected_fg]="#$foreground"

# Color of inactive/disabled text
theme[inactive_fg]="#$foreground_dim"

# Color of text appearing on top of graphs
theme[graph_text]="#$foreground"

# Misc colors for processes box
theme[proc_misc]="#$foreground"

# Cpu box outline color
theme[cpu_box]="#$accent"

# Memory/disks box outline color
theme[mem_box]="#$accent"

# Net up/down box outline color
theme[net_box]="#$accent"

# Processes box outline color
theme[proc_box]="#$accent"

# Box divider line and small boxes line color
theme[div_line]="#$accent"

# Temperature graph colors
theme[temp_start]="#$green"
theme[temp_mid]="#$yellow"
theme[temp_end]="#$orange"

# CPU graph colors
theme[cpu_start]="#$cyan"
theme[cpu_mid]="#$blue"
theme[cpu_end]="#$accent"

# Mem/Disk free meter
theme[free_start]="#$cyan"
theme[free_mid]="#$blue"
theme[free_end]="#$accent"

# Mem/Disk cached meter
theme[cached_start]="#$cyan"
theme[cached_mid]="#$blue"
theme[cached_end]="#$accent"

# Mem/Disk available meter
theme[available_start]="#$cyan"
theme[available_mid]="#$blue"
theme[available_end]="#$accent"

# Mem/Disk used meter
theme[used_start]="#$cyan"
theme[used_mid]="#$blue"
theme[used_end]="#$accent"

# Download graph colors
theme[download_start]="#$bright_blue"
theme[download_mid]="#$blue"
theme[download_end]="#$bright_cyan"

# Upload graph colors
theme[upload_start]="#$bright_cyan"
theme[upload_mid]="#$green"
theme[upload_end]="#$bright_green"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="#$bright_green"
theme[process_mid]="#$bright_yellow"
theme[process_end]="#$bright_red"
EOF
}

generate_rmpc_theme() {
    
    local theme_name=$(basename "$theme_file" .conf)
    
    
    cat << EOF
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    show_song_table_header: true,
    draw_borders: true,
    format_tag_separator: " | ",
    browser_column_widths: [20, 38, 42],
    background_color: Some("#$background"),
    text_color: Some("#$foreground"),
    header_background_color: Some("#$background"),
    modal_background_color: Some("#$background"),
    modal_backdrop: true,
    preview_label_style: (fg: "#$accent", modifiers: "Bold"),
    preview_metadata_group_style: (fg: "#$accent", modifiers: "Bold"),
    tab_bar: (
        enabled: true,
        active_style: (fg: "#$background", bg: "#$accent", modifiers: "Bold"),
        inactive_style: (fg: "#$foreground_dim", bg: "#$background"),
    ),
    highlighted_item_style: (fg: "#$accent", modifiers: "Bold"),
    current_item_style: (fg: "#$background", bg: "#$accent", modifiers: "Bold"),
    borders_style: (fg: "#$accent"),
    highlight_border_style: (fg: "#$accent"),
    symbols: (
        song: "S",
        dir: "D",
        playlist: "P",
        marker: "M",
        ellipsis: "...",
        song_style: (fg: "#$accent"),
        dir_style: (fg: "#$success"),
        playlist_style: (fg: "#$warning"),
    ),
    level_styles: (
        info: (fg: "#$accent", bg: "#$background"),
        warn: (fg: "#$warning", bg: "#$background"),
        error: (fg: "#$error", bg: "#$background"),
        debug: (fg: "#$info", bg: "#$background"),
        trace: (fg: "#$accent_alt", bg: "#$background"),
    ),
    progress_bar: (
        symbols: ["█", "█", "█", "█", "█"],
        track_style: (bg: "#$background_alt"),
        elapsed_style: (fg: "#$accent", bg: "#$background_alt"),
        thumb_style: (fg: "#$accent", bg: "#$background_alt"),
    ),
    scrollbar: (
        symbols: ["│", "█", "▲", "▼"],
        track_style: (fg: "#$gray2"),
        ends_style: (fg: "#$accent"),
        thumb_style: (fg: "#$accent"),
    ),
    song_table_format: [
        (
            prop: (kind: Property(Artist),
                default: (kind: Text("Unknown"))
            ),
            width: "20%",
            style: (fg: "#$accent_alt"),
        ),
        (
            prop: (kind: Property(Title),
                default: (kind: Text("Unknown"))
            ),
            width: "45%",
            style: (fg: "#$accent", modifiers: "Bold"),
        ),
        (
            prop: (kind: Property(Album),
                default: (kind: Text("Unknown Album"))
            ),
            width: "20%",
            style: (fg: "#$foreground_dim"),
        ),
        (
            prop: (kind: Property(Duration),
                default: (kind: Text("-"))
            ),
            width: "15%",
            alignment: Right,
            style: (fg: "#$gray4"),
        ),
    ],
    components: {},
    layout: Split(
        direction: Vertical,
        panes: [
            (
                pane: Pane(Header),
                size: "2",
            ),
            (
                pane: Pane(Tabs),
                size: "3",
            ),
            (
                pane: Pane(TabContent),
                size: "100%",
            ),
            (
                pane: Pane(ProgressBar),
                size: "1",
            ),
        ],
    ),
    header: (
        rows: [
            (
                left: [
                    (kind: Text("["), style: (fg: "#$accent", modifiers: "Bold")),
                    (kind: Property(Status(StateV2(playing_label: "Playing", paused_label: "Paused", stopped_label: "Stopped"))), style: (fg: "#$accent", modifiers: "Bold")),
                    (kind: Text("]"), style: (fg: "#$accent", modifiers: "Bold"))
                ],
                center: [
                    (kind: Property(Song(Title)), style: (fg: "#$accent", modifiers: "Bold"),
                        default: (kind: Text("No Song"), style: (fg: "#$accent", modifiers: "Bold"))
                    )
                ],
                right: [
                    (kind: Property(Widget(ScanStatus)), style: (fg: "#$success")),
                    (kind: Property(Widget(Volume)), style: (fg: "#$accent"))
                ]
            ),
            (
                left: [
                    (kind: Property(Status(Elapsed)), style: (fg: "#$foreground")),
                    (kind: Text(" / "), style: (fg: "#$gray4")),
                    (kind: Property(Status(Duration)), style: (fg: "#$foreground")),
                    (kind: Text(" ("), style: (fg: "#$info")),
                    (kind: Property(Status(Bitrate)), style: (fg: "#$info")),
                    (kind: Text(" kbps)"), style: (fg: "#$info"))
                ],
                center: [
                    (kind: Property(Song(Artist)), style: (fg: "#$info", modifiers: "Bold"),
                        default: (kind: Text("Unknown"), style: (fg: "#$info", modifiers: "Bold"))
                    ),
                    (kind: Text(" - "), style: (fg: "#$gray4")),
                    (kind: Property(Song(Album)), style: (fg: "#$info"),
                        default: (kind: Text("Unknown Album"), style: (fg: "#$info"))
                    )
                ],
                right: [
                    (kind: Text("[ "), style: (fg: "#$accent")),
                    (kind: Property(Status(RepeatV2(
                        on_label: "", off_label: "",
                        on_style: (fg: "#$info", modifiers: "Bold"), 
                        off_style: (fg: "#$foreground_dim", modifiers: "Bold")
                    )))),
                    (kind: Text(" | "), style: (fg: "#$accent")),
                    (kind: Property(Status(RandomV2(
                        on_label: "", off_label: "",
                        on_style: (fg: "#$info", modifiers: "Bold"), 
                        off_style: (fg: "#$foreground_dim", modifiers: "Bold")
                    )))),
                    (kind: Text(" | "), style: (fg: "#$accent")),
                    (kind: Property(Status(SingleV2(
                        on_label: "󰎤", off_label: "󰎦", oneshot_label: "󰇊", off_oneshot_label: "󱅊",
                        on_style: (fg: "#$info", modifiers: "Bold"), 
                        off_style: (fg: "#$foreground_dim", modifiers: "Bold")
                    )))),
                    (kind: Text(" | "), style: (fg: "#$accent")),
                    (kind: Property(Status(ConsumeV2(
                        on_label: "󰮯", off_label: "󰮯", oneshot_label: "󰮯󰇊",
                        on_style: (fg: "#$info", modifiers: "Bold"), 
                        off_style: (fg: "#$foreground_dim", modifiers: "Bold")
                    )))),
                    (kind: Text(" ]"), style: (fg: "#$accent")),
                ],
            ),
        ],
    ),
    browser_song_format: [
        (
            kind: Group([
                (kind: Property(Track), style: (fg: "#$accent")),
                (kind: Text(" "), style: (fg: "#$gray4")),
            ])
        ),
        (
            kind: Group([
                (kind: Property(Artist), style: (fg: "#$foreground")),
                (kind: Text(" - "), style: (fg: "#$gray4")),
                (kind: Property(Title), style: (fg: "#$accent", modifiers: "Bold")),
            ]),
            default: (kind: Property(Filename), style: (fg: "#$foreground_dim"))
        ),
    ],
    lyrics: (
        timestamp: false,
        current_line_style: (fg: "#$accent", modifiers: "Bold"),
        other_lines_style: (fg: "#$foreground_dim"),
    )
)
EOF
}

generate_yazi_theme() {
    
    
    
    cat << EOF
# Yazi theme generated from: $theme_name
# Auto-generated by theme switcher

"$schema" = "https://yazi-rs.github.io/schemas/theme.json"

# : Flavor {{{
[flavor]
dark  = ""
light = ""
# : }}}

# : Manager {{{
[mgr]
cwd = { fg = "#$accent" }

# Hovered
hovered         = { bg = "#$accent", fg = "#$background" }
preview_hovered = { fg = "#$accent", underline = true }

# Find
find_keyword  = { fg = "#$accent_alt", bold = true, italic = true, underline = true }
find_position = { fg = "#$accent_alt", bg = "reset", bold = true, italic = true }

# Symlink
symlink_target = { fg = "#$accent", italic = true }

# Marker
marker_copied   = { fg = "#$success", bg = "#$success" }
marker_cut      = { fg = "#$error", bg = "#$error" }
marker_marked   = { fg = "#$info", bg = "#$info" }
marker_selected = { fg = "#$accent", bg = "#$accent" }

# Count
count_copied   = { fg = "#$white", bg = "#$success" }
count_cut      = { fg = "#$white", bg = "#$error" }
count_selected = { fg = "#$white", bg = "#$accent" }

# Border
border_symbol = "│"
border_style  = { fg = "#$border" }

# Highlighting
syntect_theme = ""
# : }}}

# : Tabs {{{
[tabs]
active   = { bg = "#$accent", fg = "#$background", bold = true }
inactive = { fg = "#$accent", bg = "#$background_alt" }

# Separator
sep_inner = { open = "", close = "" }
sep_outer = { open = "", close = "" }
# : }}}

# : Mode {{{
[mode]
normal_main = { bg = "#$accent", fg = "#$background", bold = true }
normal_alt  = { fg = "#$accent", bg = "#$background_alt" }

# Select mode
select_main = { bg = "#$warning", fg = "#$background", bold = true }
select_alt  = { fg = "#$warning", bg = "#$background_alt" }

# Unset mode
unset_main = { bg = "#$error", fg = "#$background", bold = true }
unset_alt  = { fg = "#$error", bg = "#$background_alt" }
# : }}}

# : Status bar {{{
[status]
overall   = { fg = "#$foreground", bg = "#$background_alt" }
sep_left  = { open = "", close = "" }
sep_right = { open = "", close = "" }

# Permissions
perm_sep   = { fg = "#$foreground_dim" }
perm_type  = { fg = "#$success" }
perm_read  = { fg = "#$warning" }
perm_write = { fg = "#$error" }
perm_exec  = { fg = "#$accent" }

# Progress
progress_label  = { fg = "#$accent", bold = true }
progress_normal = { fg = "#$accent", bg = "#$background_highlight" }
progress_error  = { fg = "#$error", bg = "#$background_highlight" }
# : }}}

# : Which {{{
[which]
cols            = 3
mask            = { bg = "#$background_dim" }
cand            = { fg = "#$accent" }
rest            = { fg = "#$foreground_dim" }
desc            = { fg = "#$accent_alt" }
separator       = "  "
separator_style = { fg = "#$border" }
# : }}}

# : Confirmation {{{
[confirm]
border     = { fg = "#$accent" }
title      = { fg = "#$accent", bold = true }
body       = { fg = "#$foreground" }
list       = { fg = "#$foreground" }
btn_yes    = { bg = "#$accent", fg = "#$background", bold = true }
btn_no     = { fg = "#$foreground_dim" }
btn_labels = [ "  [Y]es  ", "  (N)o  " ]
# : }}}

# : Notification {{{
[notify]
title_info  = { fg = "#$success", bold = true }
title_warn  = { fg = "#$warning", bold = true }
title_error = { fg = "#$error", bold = true }

# Icons
icon_info  = ""
icon_warn  = ""
icon_error = ""
# : }}}

# : Picker {{{
[pick]
border   = { fg = "#$accent" }
active   = { fg = "#$accent", bold = true }
inactive = { fg = "#$foreground_dim" }
# : }}}

# : Input {{{
[input]
border   = { fg = "#$accent" }
title    = { fg = "#$accent" }
value    = { fg = "#$foreground" }
selected = { bg = "#$accent", fg = "#$background" }
# : }}}

# : Completion {{{
[cmp]
border   = { fg = "#$accent" }
active   = { bg = "#$accent", fg = "#$background" }
inactive = { fg = "#$foreground" }

# Icons
icon_file    = ""
icon_folder  = ""
icon_command = ""
# : }}}

# : Task manager {{{
[tasks]
border  = { fg = "#$accent" }
title   = { fg = "#$accent" }
hovered = { fg = "#$accent", bold = true }
# : }}}

# : Help menu {{{
[help]
on      = { fg = "#$accent" }
run     = { fg = "#$accent_alt" }
desc    = { fg = "#$foreground" }
hovered = { fg = "#$background", bg = "#$overlay", bold = true }
footer  = { fg = "#$background", bg = "#$accent" }
# : }}}

# : File-specific styles {{{
[filetype]
rules = [
	# Image
	{ mime = "image/*", fg = "#$accent_alt" },
	# Media
	{ mime = "{audio,video}/*", fg = "#$info" },
	# Archive
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "#$warning" },
	# Document
	{ mime = "application/{pdf,doc,rtf}", fg = "#$success" },
	# Virtual file system
	{ mime = "vfs/{absent,stale}", fg = "#$foreground_dim" },
	# Special file
	{ url = "*", is = "orphan", bg = "#$error" },
	{ url = "*", is = "exec"  , fg = "#$success" },
	# Dummy file
	{ url = "*", is = "dummy", bg = "#$error" },
	{ url = "*/", is = "dummy", bg = "#$error" },
	# Fallback
	{ url = "*/", fg = "#$accent" }
]
# : }}}
EOF
}

generate_wifitui_theme() {
    
    local theme_name=$(basename "$theme_file" .conf)
    cat << EOF
# wifitui theme generated from $theme_name
# Auto-generated by theme switcher

# Primary colors (light, dark pairs)
Primary = ["#$accent", "#$accent"]
Subtle = ["#$foreground", "#$foreground"]
Success = ["#$success", "#$success"]
Error = ["#$error", "#$error"]
Normal = ["#$foreground", "#$foreground"]
Disabled = ["#$error", "#$error"]
Border = ["#$border", "#$border"]

# WiFi-specific colors
SignalHigh = ["#$success", "#$success"]
SignalLow = ["#$error", "#$error"]
Saved = ["#$accent_alt", "#$accent_alt"]

# Icons
TitleIcon = "📶 "
NetworkSecureIcon = "🔒 "
NetworkOpenIcon = "🔓 "
NetworkUnknownIcon = "❓ "
NetworkSavedIcon = "💾 "
EOF
}

# Apply theme
apply_theme() {
    local theme_file="$1"  # ADDED: Accept the theme file as parameter
    local theme_name=$(basename "$theme_file" .conf)

    echo "Applying theme: $theme_name"

    # Update current theme symlink
    rm -f "$CURRENT_THEME"
    ln -sf "$theme_file" "$CURRENT_THEME"

    # Generate color files (REMOVED parameters since we use global variables)
    generate_hyprland_colors > ~/.config/hypr/colors.conf
    generate_rofi_colors > ~/.config/rofi/colors.rasi
    generate_kitty_colors > ~/.config/kitty/colors.conf
    generate_waybar_colors > ~/.config/waybar/colors.css
    generate_swaync_css > ~/.config/swaync/style.css
    generate_nvim_colors > ~/.config/nvim/lua/colors.lua
    generate_btop_colors > ~/.config/btop/themes/theme.conf 
    generate_rmpc_theme > ~/.config/rmpc/themes/generatedtheme.ron
    generate_yazi_theme > ~/.config/yazi/theme.toml
    generate_wifitui_theme > ~/.config/wifitui/theme.toml
    
    # Reload applications
    sleep 0.2
    echo "Reloading..."
    #Reload Swaync config   
    swaync-client -rs

    hyprctl reload

    #Custom Wallpaper setter based on theme
    $HOME/.config/hypr/scripts/set-theme-wallpaper.sh

    #Reload Kitty
    pkill -USR1 kitty

    # Restart Waybar
    pkill waybar
    sleep 0.2
    waybar &
    
    notify-send "Theme Changed" "Applied: $theme_name"
}

apply_theme "$selected_file"
