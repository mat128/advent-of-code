import operator

def redist_until_already_seen_twice(blocks):
    seen = []

    cleared = False
    while True:
        blocks = redistribute(blocks)
        if blocks in seen:
            if not cleared:
                cleared = True
                seen.clear()
            else:
                return len(seen)

        seen.append(blocks)


def redist_until_already_seen(blocks):
    seen = []

    while True:
        blocks = redistribute(blocks)
        if blocks in seen:
            return len(seen) + 1
        seen.append(blocks)


def redistribute(original_blocks):
    blocks = list(original_blocks)
    max_block, max_block_value = max(enumerate(blocks), key=operator.itemgetter(1))

    blocks[max_block] = 0
    offset = 1

    while max_block_value > 0:
        blocks[(max_block + offset) % len(blocks)] += 1
        max_block_value -= 1
        offset += 1

    return blocks
