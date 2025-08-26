#!/bin/env python

# exit is not defined in the bundled executable file
from sys import exit

def main() -> int:
    print('Hello world!')
    return 0

if __name__ == '__main__':
    exit(main())
