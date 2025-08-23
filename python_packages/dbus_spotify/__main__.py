import string
import traceback
import argparse

from .spotify import Spotify, SpotifyDBusError
from .args import parse


args = parse()
try:
    spotify = Spotify()

except SpotifyDBusError as e:
    if args.verbose:
        traceback.print_exception(type(e), e, e.__traceback__)
    else:
        print(e.message)

    exit(0)


if args.command == "status":
    status = spotify.get_status()
    print(status)

if args.command == "action":
    spotify.perform_action(args.action)

elif args.command == "track":
    templ = string.Template(args.format)
    metadata = spotify.get_metadata()

    try:
        artist = metadata["xesam:artist"][0]
        title = metadata["xesam:title"]
        album = metadata["xesam:album"]

    except KeyError:
        artist = "Unknown" if artist is None else artist
        title = "Unknown" if title is None else title
        album = "Unknown" if album is None else album

    print(templ.substitute(artist=artist, title=title, album=album))
