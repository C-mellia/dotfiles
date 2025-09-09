import os
import logging

from argparse import ArgumentParser, ArgumentError
from .command import test_solution


logger = logging.getLogger(f"{__name__}")


class CustomArgumentParser(ArgumentParser):
    def parse_args(self, args=None, namespace=None):
        args, argv = self.parse_known_args(args, namespace)
        if any(filter(lambda x: x.startswith("-"), argv)):
            msg = f"Are you trying to provide extra arguments for Solution? Try without '-' or '--': {invalid_arg.lstrip('-')}"

            if self.exit_on_error:
                self.error(msg)
            else:
                raise ArgumentError(None, msg)

        return args


parser = CustomArgumentParser(
    prog=__package__,
    description=" ".join(
        [
            "Test solution module.",
            "This module also support adding extra arguments to the solution module.",
        ]
    ),
)

modpath = ":".join(
    [
        ".solution",
        os.path.join(os.getenv("HOME"), ".solution"),
        os.path.join(os.getenv("HOME"), ".local", "share", "solution"),
    ]
)

parser.add_argument(
    "module_name",
    help="Name of the solution module to be tested.",
)

parser.add_argument(
    "--method",
    default=None,
    dest="method_name",
    help="Method name to be tested. Default: 'module_name' (same as the module name).",
)

parser.add_argument(
    "--modpath",
    default=modpath,
    dest="modpath",
    help="Module search path, separated by ':'. Default: %(default)s",
)

parser.add_argument(
    "--keepgoing",
    action="store_true",
    help="Keep going on errors.",
)

parser.add_argument(
    "extra_args",
    nargs="*",
    help="Extra arguments to be passed to the solution module. KEY=VALUE for keyword arguments, otherwise positional arguments.",
)

parser.set_defaults(func=test_solution)
