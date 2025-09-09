import logging


# https://stackoverflow.com/a/56944256
class ColorfulFormatter(logging.Formatter):

    spring_green = "\x1b[38;5;2m"
    grey = "\x1b[38;20m"
    slate_blue = "\x1b[38;5;5m"
    teal = "\x1b[38;5;4m"
    yellow = "\x1b[33;20m"
    red = "\x1b[31;20m"
    bold_red = "\x1b[31;1m"
    reset = "\x1b[0m"
    format = "[%(levelname)s] (%(name)s) %(asctime)s - %(message)s"

    FORMATS = {
        logging.DEBUG: slate_blue + format + reset,
        logging.INFO: teal + format + reset,
        logging.WARNING: yellow + format + reset,
        logging.ERROR: red + format + reset,
        logging.CRITICAL: bold_red + format + reset,
        60: spring_green + format + reset,
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        formatter.datefmt = "%H:%M"
        return formatter.format(record)
