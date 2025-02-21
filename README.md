Below is a compact x86 (x86-64) assembly cheatsheet designed to help you debug the assembly output generated by g++ (using the -S flag). This guide covers key registers, instruction formats (especially AT&T syntax used by default on Linux), common instructions, addressing modes, and some debugging tips.

---

### 1. Registers

- **General Purpose Registers (64-bit):**
  - `%rax` – Accumulator (often holds return values)
  - `%rbx` – Base register (callee-saved)
  - `%rcx` – Counter register (used in loops and shifts)
  - `%rdx` – Data register (used in I/O and arithmetic)
  - `%rsi` – Source Index (often used for string operations or function arguments)
  - `%rdi` – Destination Index (often used for function arguments)
  - `%r8` to `%r15` – Additional general-purpose registers

- **Special Registers:**
  - `%rsp` – Stack Pointer (points to the top of the stack)
  - `%rbp` – Base Pointer (often used to reference function parameters and local variables)
  - `%rip` – Instruction Pointer (holds the address of the next instruction)

---

### 2. Instruction Format (AT&T Syntax)

- **General Format:**  
  `instruction source, destination`  
  (Note: Unlike Intel syntax, the source comes first in AT&T syntax.)

- **Register Names:**  
  Prefixed with `%` (e.g., `%rax`, `%rbx`).

- **Immediate Values:**  
  Prefixed with `$` (e.g., `$10` for the immediate value 10).

- **Memory Operands:**  
  Written as `offset(base, index, scale)`.  
  For example:
  - `(%rbp)` – The value at the address stored in `%rbp`.
  - `4(%rbp)` – The value at the address `%rbp + 4`.
  - `(%rax, %rcx, 4)` – The value at `%rax + %rcx * 4`.

---

### 3. Common Instructions

- **Data Movement:**
  - `mov src, dest`  
    Example: `mov %rax, %rbx` – Copies the value from `%rax` to `%rbx`.

- **Arithmetic:**
  - `add src, dest`  
    Example: `add $5, %rax` – Adds 5 to `%rax`.
  - `sub src, dest`  
    Example: `sub $2, %rcx` – Subtracts 2 from `%rcx`.
  - `imul src, dest` – Multiply.
  - `div`/`idiv` – Unsigned/signed division (uses `%rax` and `%rdx`).

- **Logical/Bitwise:**
  - `and src, dest`
  - `or src, dest`
  - `xor src, dest`

- **Comparisons and Conditional Jumps:**
  - `cmp src, dest` – Compares two values (sets flags based on `dest - src`).
  - `je` / `jne` / `jg` / `jl` / `jge` / `jle` – Conditional jumps based on flags.
  - `jmp label` – Unconditional jump.

- **Control:**
  - `call label` – Call a function/subroutine.
  - `ret` – Return from function.
  - `push` / `pop` – Save/restore registers on the stack.

---

### 4. Debugging Tips

- **Compile with Debug Symbols:**  
  Use `-g` when compiling to include debug information.
  ```bash
  g++ -std=c++11 -O0 -g yourcode.cpp -S -o yourcode.s
  ```
  Using `-O0` disables optimizations that can make assembly harder to follow.

- **Understanding Function Prologue/Epilogue:**  
  - Look for instructions like `push %rbp` and `mov %rsp, %rbp` at the beginning of functions.
  - At the end, you'll see `pop %rbp` and `ret`.

- **Stack Frame Analysis:**  
  Examine how local variables are stored relative to `%rbp` (e.g., `-8(%rbp)` might be a local variable).

- **Use GDB for In-Depth Debugging:**  
  Run `gdb your_executable` and use commands like:
  - `break main` to set a breakpoint.
  - `disassemble` to see the assembly of a function.
  - `info registers` to inspect register contents.
  - `x/10i $rip` to view the next 10 instructions at the instruction pointer.

- **Viewing the Assembly File:**  
  Open the generated `.s` file in a text editor. Look for labels (e.g., `.LFB0:`) which indicate function boundaries and internal jump targets.

---

### 5. Additional Tools and Commands

- **objdump:**  
  Use `objdump -d your_executable` to see disassembled code along with addresses.
  
- **readelf:**  
  `readelf -a your_executable` provides detailed info on sections, symbols, and more.

- **nm:**  
  `nm your_executable` lists symbols (functions, global variables).

---

This cheatsheet covers the basics you’ll need when stepping through assembly code generated by g++ for your C++ programs. It should help you recognize register usage, instruction patterns, and common calling conventions, which are all crucial for debugging and understanding the generated assembly code.
