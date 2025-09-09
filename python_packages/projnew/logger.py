import logging

from colorful_formatter import ColorfulFormatter


logging.addLevelName(60, "SUCCESS")


class CustomLogger(logging.Logger):
    def success(self, msg, *args, **kwargs):
        if self.isEnabledFor(60):
            self._log(60, msg, args, **kwargs)


logging.setLoggerClass(CustomLogger)

root_logger = logging.getLogger(f"{__package__}")

ch = logging.StreamHandler()
ch.setFormatter(ColorfulFormatter())

root_logger.addHandler(ch)
root_logger.setLevel(logging.DEBUG)
