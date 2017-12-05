class ReverseCaptcha:
    def __init__(self, numbers):
        self.numbers = numbers
        self.look_ahead = 1

    def next_for(self, i):
        next_pos = (i + self.look_ahead) % len(self.numbers)
        return self.numbers[next_pos]

    def solve(self):
        return sum([int(n) for (i, n) in enumerate(self.numbers) if n == self.next_for(i)])


class HalfwayLookingReverseCaptcha(ReverseCaptcha):
    def __init__(self, numbers):
        super().__init__(numbers)
        self.look_ahead = int(len(numbers)/2)
