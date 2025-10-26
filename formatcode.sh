#!/bin/bash

# Format all Swift code in the DataStructuresAndAlgorithms Swift Package
swiftformat Sources Tests --indent 4 --swiftversion 6.2 --disable wrapMultilineStatementBraces
