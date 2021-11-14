#!/usr/bin/env python3
# coding: utf-8

import sys

import pkg_resources
from pkg_resources import DistributionNotFound

if __name__ == "__main__":
    dependencies = sys.argv[1:]
    if not dependencies:
        # No dependencies, nothing to do
        sys.exit(0)

    try:
        # here, if a dependency is not met, a DistributionNotFound exception
        # is thrown.
        pkg_resources.require(dependencies)
    except DistributionNotFound:
        print(
            "python-support.nvim: One more packages are missing,"
            "please run ':PythonSupportInitPython3'",
            file=sys.stderr,
        )
        sys.exit(1)

# vim: set ft=python et ts=4 sw=4 :
