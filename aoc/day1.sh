#!/bin/bash
set -ux
input=$1

read_byte() {
    file=$1
    pos=$2

    dd if=$file skip=$pos bs=1 count=1 2>/dev/null
}

file_length() {
    file=$1
    cat $input | _length
}

line_length() {
    file=$1
    line_no=$2

    head -n$line_no $file | tail -n$line_no | tr -d '\n' | _length
}

_length() {
    wc -c | awk '{print $1}'
}


match() {
    local a=$1
    local b=$2

    test "$a" == "$b"
}

#read_byte $input 1
#line_length $input 1

compare_bytes() {
    local input=$1
    local first_offset=$2
    local second_offset=$3

    match "$(read_byte $input $first_offset)" "$(read_byte $input $second_offset)" && read_byte $input $first_offset
}

get_matching_adjacent_bytes() {
    local input=$1

    for i in $(first_line_iterator $input); do
        compare_bytes $input "$i" "$((i + 1))" && printf '\n'
    done
}

first_line_iterator() {
    local input=$1

    seq 0 $(($(line_length $input 1) - 1))
}

sum() {
    tr '\n' '+' | sed 's#\+$##g' | bc
}

get_matching_adjacent_bytes $input | sum
