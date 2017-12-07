#!/bin/bash
set -u
input=$1

tmp=$(mktemp -d $TMPDIR/day7.XXXXXXXX)
trap "echo rm -rf $tmp" EXIT

mkdir -p $tmp/nodes

create_nodes() {
    local input=$1
    cat $input | awk '{print $1}' | xargs -I% mkdir -p $tmp/nodes/%
}

create_weights() {
    local input=$1
    for line in $(cat $input | awk '{print $1 "-" $2}'); do
        node=$(echo $line | tr '-' '\n' | head -n1)
        weight=$(echo $line | tr '-' '\n' | head -n2 | tail -n1 | tr -d '(' | tr -d ')')

        mkfile $weight $tmp/nodes/$node/weight
    done
}

create_link() {
    local line=$1

    first=$(echo $line | tr '-' '\n' | head -n1 | tail -n1)
    second=$(echo $line | tr '-' '\n' | head -n2 | tail -n1)
    if [ "$second" != "" ]; then
        ln -sf $tmp/nodes/$second \
               $tmp/nodes/$first/$second
    fi
}

create_layer_1() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $4}' | tr -d ','); do
        create_link $line
    done

}

create_layer_2() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $5}' | tr -d ','); do
        create_link $line
    done
}

create_layer_3() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $6}' | tr -d ','); do
        create_link $line
    done
}

create_layer_4() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $7}' | tr -d ','); do
        create_link $line
    done
}

create_layer_5() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $8}' | tr -d ','); do
        create_link $line
    done
}

create_layer_6() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $9}' | tr -d ','); do
        create_link $line
    done
}

create_layer_7() {
    local input=$1

    for line in $(cat $input | grep -- '->' | awk '{print $1 "-" $10}' | tr -d ','); do
        create_link $line
    done
}

create_nodes $input
create_layer_1 $input
create_layer_2 $input
create_layer_3 $input
create_layer_4 $input
create_layer_5 $input
create_layer_6 $input
create_layer_7 $input

tree -l $tmp

find $tmp/nodes -exec readlink {} \; | sort -u > $tmp/nodes_with_links_pointing_towards_them
find $tmp/nodes -type d -depth 1 | sort -u > $tmp/all_nodes

echo "ANSWER: "
answer=$(basename $(comm -32 $tmp/all_nodes $tmp/nodes_with_links_pointing_towards_them))
echo $answer

sum_file_sizes() {
    path=$1
    echo "$(find -L $path -type f | xargs stat -f%z | awk '{ s+=$1 } END { print s }') $path"
}

create_weights $input

find_heaviest() {
    local base=$1
    for subdir in $(find $base -type l -depth 1); do
        heaviest=$(sum_file_sizes $subdir | sort -n | head -n1 | awk '{print $2}')
        echo "Heaviest was $heaviest"
        find_heaviest $heaviest
    done
}

find_heaviest $tmp/nodes/$answer
