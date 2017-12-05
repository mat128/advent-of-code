class Machine:
    def __init__(self, memory):
        self.memory = memory
        self.ip = 0

    def tick(self):
        old_ip = self.ip
        self.ip += self.memory[self.ip]
        self.memory[old_ip] += 1


class WeirderMachine:
    def __init__(self, memory):
        self.memory = memory
        self.ip = 0

    def tick(self):
        old_ip = self.ip
        jump_size = self.memory[self.ip]
        self.ip += jump_size
        if jump_size >= 3:
            self.memory[old_ip] += -1
        else:
            self.memory[old_ip] += 1


def run(machine):
    counter = 0
    try:
        while True:
            machine.tick()
            counter += 1

    except IndexError:
        return counter
