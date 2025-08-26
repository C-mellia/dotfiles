from .args import parse


args = parse()
args.func(**vars(args))
