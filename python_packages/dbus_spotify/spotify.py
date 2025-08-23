import dbus


_item = "org.mpris.MediaPlayer2.spotify"
_path = "/org/mpris/MediaPlayer2"
_dbus_prop = "org.freedesktop.DBus.Properties"
_dbus_player = "org.mpris.MediaPlayer2.Player"


class Spotify:

    def __init__(self):
        self.bus = dbus.SessionBus()
        try:
            self.proxy = self.bus.get_object(_item, _path)

        except dbus.exceptions.DBusException as e:
            raise SpotifyDBusError("No player is running") from e

        self.prop_iface = dbus.Interface(self.proxy, _dbus_prop)
        self.player_iface = dbus.Interface(self.proxy, _dbus_player)

    def get_status(self):
        try:
            return self.prop_iface.Get(_dbus_player, "PlaybackStatus")

        except dbus.exceptions.DBusException:
            raise SpotifyDBusError("Failed to get playback status from spotify")

    def get_metadata(self):
        try:
            return self.prop_iface.Get(_dbus_player, "Metadata")

        except dbus.exceptions.DBusException as e:
            raise SpotifyDBusError("Failed to get metadata from spotify") from e

    def perform_action(self, action):
        try:
            if action == "play":
                self.player_iface.Play()
            elif action == "pause":
                self.player_iface.Pause()
            elif action == "next":
                self.player_iface.Next()
            elif action == "previous":
                self.player_iface.Previous()

        except dbus.exceptions.DBusException as e:
            raise SpotifyDBusError(f"Failed to perform action: {action}") from e


class SpotifyDBusError(Exception):
    def __init__(self, message):
        self.message = message
        super().__init__(message)

    def __str__(self):
        return f"SpotifyDBusError: {self.args[0]}"
