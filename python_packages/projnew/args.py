import os

from argparse import ArgumentParser
from .commands import init, list_, info


__user = os.path.expanduser("~")


def posix_list(s: str) -> [str]:
    return s.split(":")


parser = ArgumentParser(
    prog=__package__,
    description="Initializing a new project by choosing a template and copying files from it.",
)

parser.add_argument(
    "--prefix",
    type=posix_list,
    default=f"./.projnew:{__user}/.projnew:{__user}/.local/share/projnew",
    dest="prefix",
    help="Directory to store templates (default: %(default)s); specify multiple directories separated by ':'",
)

parser.add_argument(
    "--exec-file",
    type=str,
    default=".exec",
    dest="exec_file",
    help="File to read executable commands from (default: %(default)s)",
)

parser.add_argument(
    "--info-file",
    type=str,
    default=".info",
    dest="info_file",
    help="File to read detailed information from (default: %(default)s)",
)

parser.add_argument(
    "-q",
    "--quiet",
    dest="quiet",
    action="store_true",
    help="Suppress non-error messages",
)

sub_parsers = parser.add_subparsers(title="commands", dest="command", required=True)

parser_init = sub_parsers.add_parser(
    "init",
    help="Initialize a new project from a template",
)
parser_init.set_defaults(func=init)

parser_init.add_argument(
    "template_name",
    type=str,
    help="Name of the template to use, use list command to see available templates",
)

parser_init.add_argument(
    "--chdir",
    "-C",
    type=str,
    default=None,
    dest="chdir",
    help="Change to this directory before initializing (default: %(default)s)",
)

parser_init.add_argument(
    "--update",
    choices=["none", "older"],
    default="older",
    dest="update",
    help="Update existing files according to the specified mode (default: %(default)s)",
)

parser_init.add_argument(
    "--dry",
    dest="dry",
    action="store_true",
    help="Perform a trial run with no changes made",
)

parser_init.add_argument(
    "--no-exec",
    dest="no_exec",
    action="store_true",
    help="Do not execute commands from the exec file",
)

parser_init.add_argument(
    "extra_args",
    nargs="*",
    help="Extra arguments to pass to the exec file",
)

parser_list = sub_parsers.add_parser(
    "list",
    help="List available templates",
)

parser_list.set_defaults(func=list_)

parser_info = sub_parsers.add_parser(
    "info",
    help="Show detailed information about a specific template",
)

parser_info.set_defaults(func=info)

parser_info.add_argument(
    "template_name",
    type=str,
    help="Name of the template to show information about, use list command to see available templates",
)

parser_info.add_argument(
    "--pager",
    type=str,
    default=None,
    dest="pager",
    help="Program to use for paging output (default: %(default)s)",
)


def parse():
    return parser.parse_args()
