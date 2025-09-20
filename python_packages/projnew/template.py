import os
import logging

from string import Template
from typing import Literal, List
from .policy import is_special, should_update


logger = logging.getLogger(__name__)


def render_template(template_file: str, context: dict | None) -> str:
    with open(template_file, "r") as f:
        content = f.read()

    if context is None:
        return content

    return Template(content).safe_substitute(context)


def populate_directory(
    src_dir: str,
    dest_dir: str,
    context: dict | None,
    update: Literal["none", "older"],
    dry: bool,
    exceptions: List[str] = [],
):
    for dirname, _, filenames in os.walk(src_dir):
        dest_dir = os.path.join(dest_dir, os.path.relpath(dirname, src_dir))
        os.makedirs(dest_dir, exist_ok=True)

        for entry in filenames:
            src_path, dest_path = os.path.join(dirname, entry), os.path.join(
                dest_dir, entry
            )

            if is_special(
                os.path.relpath(dirname, src_dir),
                entry,
                exceptions,
            ):
                logger.info(f"Skipping special file '{src_path}'.")
                continue

            if not should_update(src_path, dest_path, update):
                logger.info(f"File '{dest_path}' is up to date, skipping.")
                continue

            if dry:
                logger.debug(f"'{src_path}' -> '{dest_path}'")
                continue

            with open(dest_path, "w") as dest_f:
                dest_f.write(render_template(src_path, context))
