def next_number(numbers, i):
    next_pos = (i+1) % len(numbers)
    return numbers[next_pos]


def reverse_captcha(numbers):
    current_value = 0

    for (i, number) in enumerate(numbers):
        if number == next_number(numbers, i):
            current_value += int(number)

    return current_value
