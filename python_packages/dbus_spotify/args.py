import argparse


parser = argparse.ArgumentParser(
    prog=__package__, description="Get Spotify metadata via D-Bus"
)
parser.add_argument(
    "-v", "--verbose", action="store_true", help="Enable verbose output"
)

sub_parsers = parser.add_subparsers(dest="command", required=True)
parser_get_status = sub_parsers.add_parser("status", help="Get current playback status")
parser_get_track = sub_parsers.add_parser("track", help="Get current track info")
parser_action = sub_parsers.add_parser(
    "action", help="Control playback (play, pause, next, previous)"
)

parser_get_track.add_argument(
    "-f",
    "--format",
    type=str,
    default="$artist - $title",
    help="Output format (default: '$artist - $title'). "
    "Available variables: $artist, $title, $album",
)

parser_action.add_argument(
    "action", choices=["play", "pause", "next", "previous"], help="Action to perform"
)


def parse():
    return parser.parse_args()
