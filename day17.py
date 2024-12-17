# lines = open('sample.txt','r').readlines()
# values = [list(map(int,line.strip().split(','))) for line in lines]
# print(values)
# "inputs/input-17.txt"


def parse_input(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Parse initial register values
    registers = {'A': 0, 'B': 0, 'C': 0}
    for line in lines:
        if line.startswith("Register A"):
            registers['A'] = int(line.split(":")[1].strip())
        elif line.startswith("Register B"):
            registers['B'] = int(line.split(":")[1].strip())
        elif line.startswith("Register C"):
            registers['C'] = int(line.split(":")[1].strip())
        elif line.startswith("Program"):
            # Parse program instructions
            program = list(map(int, line.split(":")[1].strip().split(",")))

    return registers, program

def get_combo_value(operand, registers):
    """Resolve combo operand to its value."""
    if operand <= 3:  # Literal value
        return operand
    elif operand == 4:
        return registers['A']
    elif operand == 5:
        return registers['B']
    elif operand == 6:
        return registers['C']
    elif operand == 7:
        raise ValueError("Invalid combo operand 7 encountered.")
    return 0

def execute_program(registers, program):
    """Simulate the 3-bit computer."""
    output = []
    ip = 0  # Instruction Pointer

    while ip < len(program):
        opcode = program[ip]
        operand = program[ip + 1] if ip + 1 < len(program) else 0

        if opcode == 0:  # adv
            divisor = 2 ** get_combo_value(operand, registers)
            registers['A'] //= divisor

        elif opcode == 1:  # bxl
            registers['B'] ^= operand

        elif opcode == 2:  # bst
            registers['B'] = get_combo_value(operand, registers) % 8

        elif opcode == 3:  # jnz
            if registers['A'] != 0:
                ip = operand
                continue  # Skip incrementing IP

        elif opcode == 4:  # bxc
            registers['B'] ^= registers['C']

        elif opcode == 5:  # out
            output.append(get_combo_value(operand, registers) % 8)

        elif opcode == 6:  # bdv
            divisor = 2 ** get_combo_value(operand, registers)
            registers['B'] = registers['A'] // divisor

        elif opcode == 7:  # cdv
            divisor = 2 ** get_combo_value(operand, registers)
            registers['C'] = registers['A'] // divisor

        else:
            raise ValueError(f"Unknown opcode {opcode} encountered.")

        ip += 2  # Move to the next instruction

    return output


def find_lowest_a(program):


    steps = []
    registers={'A': 0, 'B': 0, 'C': 0}
    for a in range(2 ** 10):
        registers={'A': a, 'B': 0, 'C': 0}
        steps.append(execute_program(registers,program)[0])


    ll = [[i] for i in range(2 ** 10) if steps[i] == program[0]]


    for k in program[1:]:
        ll_ = []
        for l in ll:
            current = l[-1] >> 3
            for i in range(8):
                if steps[(i << 7) + current] == k:
                    ll_.append(l + [(i << 7) + current])

        ll = ll_

    def recombine(l):
        i = l[0]
        d = 10

        for c in l[1:]:
            i += (c >> 7) << d
            d += 3

        return i

    ans = float('inf')
    for l in ll:
        i = recombine(l)
        registers={'A': i, 'B': 0, 'C': 0}
        if execute_program(registers,program) == program:
            ans = min(i, ans)

    return ans

if __name__ == "__main__":
    # Parse input file
    input_file = "inputs/input-17.txt"
    # input_file = "sample.txt"
    registers, program = parse_input(input_file)
    x = execute_program(registers,program)
    print(",".join(map(str, x)))
    print(find_lowest_a(program))