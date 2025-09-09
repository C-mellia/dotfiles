import logging
import importlib

from typing import Any, List, Dict


logger = logging.getLogger(f"{__name__}")


def run_tests(
    module_name: str,
    keepgoing: bool,
    method_name: str | None,
    extra_args: List[Any],
    extra_kwargs: Dict[str, Any],
) -> None:
    fail = 0
    module = importlib.import_module(module_name)

    try:
        test_cases = module.test_cases
        solution = getattr(module.Solution, method_name or module_name)
        validate = getattr(module.Solution, "validate", _validate)

    except AttributeError as e:
        raise RuntimeError("Missing 'Solution' class or 'test_cases' variable.") from e

    for i, (*inputs, output) in enumerate(test_cases):
        try:
            result = solution(*inputs, *extra_args, **extra_kwargs)
            validate(result=result, output=output, index=i + 1, inputs=inputs)

        except Exception as e:
            msg = f"Test case {i + 1} failed"
            if keepgoing:
                fail += 1
            else:
                raise RuntimeError(msg) from e

    if fail:
        msg = f"{fail} test cases failed out of {len(test_cases)}."
        raise RuntimeError(msg)
    else:
        logger.success("All test cases passed!")


def _validate(result, output, index, **kwargs):
    if result != output:
        raise AssertionError(
            f"Test case {index} failed: Expected {output}, got {result}"
        )
