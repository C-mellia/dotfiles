import os
import sys

from typing import List


def find_candidate(prefix, template_name):
    candidates = [os.path.join(p, template_name) for p in prefix]
    for candidate in candidates:
        if os.path.isdir(candidate) and os.access(candidate, os.R_OK):
            return candidate
    return None


def info(
    prefix: List[str],
    exec_file: str,
    info_file: str,
    quiet: bool,
    template_name: str,
    pager: str | None,
    *args,
    **kwargs,
):
    candidate = find_candidate(prefix, template_name)
    if not candidate:
        print(
            f"Template '{template_name}' not found in any of the template directories.",
            file=sys.stderr,
        )

        for dir_ in prefix:
            print(f"  - {dir_}", file=sys.stderr)

        sys.exit(1)

    info_path = os.path.join(candidate, info_file)
    if os.path.isfile(info_path) and os.access(info_path, os.R_OK):
        if pager:
            os.system(f"{pager} {info_path}")
            return
        with open(info_path, "r") as f:
            sys.stdout.write(f.read())
    else:
        print(f"No info file '{info_file}' found for template '{template_name}'.")


def init(
    prefix: List[str],
    exec_file: str,
    info_file: str,
    quiet: bool,
    template_name: str,
    chdir: str | None,
    update: str,
    dry: bool,
    no_exec: bool,
    extra_args: List[str],
    *args,
    **kwargs,
):
    def print_(*args, **kwargs):
        if not quiet:
            print(*args, **kwargs)

    candidate = find_candidate(prefix, template_name)
    if not candidate:
        print(
            f"Template '{template_name}' not found in any of the template directories.",
            file=sys.stderr,
        )

        for dir_ in prefix:
            print(f"  - {dir_}", file=sys.stderr)

        sys.exit(1)

    print_(f"Using template: {candidate}")
    if chdir:
        os.makedirs(chdir, exist_ok=True)

    print_(f"Copying template '{template_name}' to current directory...")
    dest = os.path.join(os.getcwd(), chdir) if chdir else os.getcwd()

    for dirname, _, filenames in os.walk(candidate):
        dirname = os.path.normpath(dirname)
        dest_dir = os.path.join(dest, os.path.relpath(dirname, candidate))
        os.makedirs(dest_dir, exist_ok=True)

        for entry in filter(lambda f: f not in [info_file, exec_file], filenames):
            src_path = os.path.join(dirname, entry)
            dest_path = os.path.join(dest_dir, entry)

            def __copy():
                if dry:
                    print(f"'{src_path}' -> '{dest_path}'")
                else:
                    with open(src_path, "rb") as src_f, open(dest_path, "wb") as dest_f:
                        dest_f.write(src_f.read())

            match update:
                case "none":
                    if os.path.exists(dest_path):
                        print_(f"File '{dest_path}' already exists, skipping.")
                        continue
                    __copy()

                case "older":
                    if os.path.exists(dest_path):
                        src_mtime = os.path.getmtime(src_path)
                        dest_mtime = os.path.getmtime(dest_path)
                        if dest_mtime >= src_mtime:
                            print_(f"File '{dest_path}' is up to date, skipping.")
                            continue
                    __copy()

    exec_file = os.path.join(candidate, exec_file)

    if not no_exec:
        if os.path.isfile(exec_file) and os.access(exec_file, os.R_OK):
            print_(f"Executing commands from '{exec_file}'...")
            if not dry:
                try:
                    os.system(f'"{exec_file}" {" ".join(extra_args)}')
                except Exception as e:
                    print(f"Error executing commands: {e}", file=sys.stderr)
                    sys.exit(1)
        else:
            print_(
                f"No executable commands file '{exec_file}' found, skipping execution."
            )


def list_(
    prefix: List[str],
    exec_file: str,
    info_file: str,
    quiet: bool,
    *args,
    **kwargs,
):
    prefix_ = filter(
        lambda dir_: os.path.isdir(dir_) and os.access(dir_, os.R_OK), prefix
    )
    templates = {}

    for dir_ in prefix_:
        for name in os.listdir(dir_):
            template_path = os.path.join(dir_, name)
            paths = templates.get(name, [])
            if os.path.isdir(template_path) and os.access(template_path, os.R_OK):
                paths.append(template_path)

            templates[name] = paths

    for name, paths in templates.items():
        print(name)
        for path in paths:
            print(f"  - {path}")

    if not templates:
        print("No templates found.")
