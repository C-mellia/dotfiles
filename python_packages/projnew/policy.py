import os

from typing import Literal, List


def is_special(rel_dir: str, filename: str, special_files: List[str]) -> bool:
    return rel_dir == "." and filename in special_files


def should_update(
    src_path: str,
    dest_path: str,
    update: Literal["none", "older"],
) -> bool:
    if not os.path.exists(dest_path):
        return True

    if update == "none":
        return False

    elif update == "older":
        src_mtime = os.path.getmtime(src_path)
        dest_mtime = os.path.getmtime(dest_path)
        return src_mtime > dest_mtime

    return False
