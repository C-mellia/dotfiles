import os
import sys

from .testing import run_tests, logger


def test_solution(args, extra_args, extra_kwargs):
    module_name = args.module_name
    modpath = args.modpath.split(":")
    syspath = sys.path.copy()
    try:
        # avoid accidentally importing modules from syspath
        sys.path = [os.path.abspath(p) for p in modpath] + syspath
        run_tests(
            module_name=module_name,
            keepgoing=args.keepgoing,
            method_name=args.method_name,
            extra_args=extra_args,
            extra_kwargs=extra_kwargs,
        )

    except Exception as e:
        msg = f"Solution '{module_name}' failed the testing."
        logger.exception(msg, exc_info=e)

    finally:
        sys.path = syspath
