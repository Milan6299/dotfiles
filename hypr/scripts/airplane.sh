#!/bin/zsh

# Airplane Mode Toggle Script
CONFIG_FILE="$HOME/.config/airplane-mode.conf"

# Load or initialize config
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    AIRPLANE_MODE="off"
    echo "AIRPLANE_MODE='$AIRPLANE_MODE'" > "$CONFIG_FILE"
fi

toggle_airplane_mode() {
    if [[ "$AIRPLANE_MODE" == "off" ]]; then
        enable_airplane_mode
    else
        disable_airplane_mode
    fi
}

enable_airplane_mode() {
    # Save current states
    WIFI_STATE=$(rfkill list wifi | grep -q "Soft blocked: yes" && echo "blocked" || echo "unblocked")
    BLUETOOTH_STATE=$(rfkill list bluetooth | grep -q "Soft blocked: yes" && echo "blocked" || echo "unblocked")

    echo "WIFI_STATE='$WIFI_STATE'" >> "$CONFIG_FILE"
    echo "BLUETOOTH_STATE='$BLUETOOTH_STATE'" >> "$CONFIG_FILE"

    # Turn off wireless
    rfkill block wifi
    rfkill block bluetooth

    # Stop Bluetooth service
    sudo systemctl stop bluetooth 2>/dev/null

    # Disable network manager radio (if using NetworkManager)
    if command -v nmcli &>/dev/null; then
        nmcli radio wifi off
        nmcli radio all off
    fi

    AIRPLANE_MODE="on"
    update_config
    send_notification "✈️ Airplane Mode ON" "All wireless radios disabled" "info"
}

disable_airplane_mode() {
    # Turn on wireless
    rfkill unblock wifi
    rfkill unblock bluetooth

    # Start Bluetooth service
    sudo systemctl start bluetooth 2>/dev/null

    # Enable network manager radio
    if command -v nmcli &>/dev/null; then
        nmcli radio all on
    fi

    # Restore previous states if saved
    if [[ -f "$CONFIG_FILE" ]] && grep -q "WIFI_STATE" "$CONFIG_FILE"; then
        source "$CONFIG_FILE"
        if [[ "$WIFI_STATE" == "blocked" ]]; then
            rfkill block wifi
        fi
        if [[ "$BLUETOOTH_STATE" == "blocked" ]]; then
            rfkill block bluetooth
            sudo systemctl stop bluetooth 2>/dev/null
        fi
    fi

    AIRPLANE_MODE="off"
    update_config
    send_notification "📡 Airplane Mode OFF" "Wireless radios enabled" "info"
}

update_config() {
    cat > "$CONFIG_FILE" << EOF
AIRPLANE_MODE='$AIRPLANE_MODE'
WIFI_STATE='$WIFI_STATE'
BLUETOOTH_STATE='$BLUETOOTH_STATE'
EOF
}

send_notification() {
    local title="$1"
    local message="$2"
    local urgency="${3:-info}"

    if command -v swaync-client &>/dev/null; then
        swaync-client -t "$title" -m "$message" -u "$urgency"
    elif command -v notify-send &>/dev/null; then
        notify-send -u "$urgency" "$title" "$message"
    fi
}

get_status() {
    local wifi_status=$(rfkill list wifi | grep -q "Soft blocked: yes" && echo "OFF" || echo "ON")
    local bt_status=$(rfkill list bluetooth | grep -q "Soft blocked: yes" && echo "OFF" || echo "ON")

    echo "✈️ Airplane Mode: $AIRPLANE_MODE"
    echo "📶 WiFi: $wifi_status"
    echo "🔵 Bluetooth: $bt_status"
}

case "${1:-}" in
    "on")
        enable_airplane_mode
        ;;
    "off")
        disable_airplane_mode
        ;;
    "status")
        get_status
        ;;
    "toggle"|"")
        toggle_airplane_mode
        ;;
    *)
        echo "Usage: $0 [on|off|toggle|status]"
        exit 1
        ;;
esac
