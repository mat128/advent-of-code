#!/bin/bash

test_basic() {
    echo "1122" > $workspace/input.txt
    result=$(./day1.sh $workspace/input.txt)
    assert "$result" equals "3"
}

# missing loop
