from . import root_logger, parser


try:
    args = parser.parse_args()
    args_, kwargs = [], {}
    for arg in args.extra_args:
        if "=" in arg:
            key, value = arg.split("=", 1)
            kwargs[key] = value
        else:
            args_.append(arg)
    args.func(args, args_, kwargs)

except Exception as e:
    root_logger.exception(e, exc_info=e)
