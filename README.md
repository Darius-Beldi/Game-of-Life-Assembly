# Conway's Game of Life Implementation

This project implements Conway's Game of Life in x86 assembly. The program reads input configurations for the Game of Life and simulates the evolution of the system, with support for both standard input and file-based input/output operations.

## Project Structure

The project consists of the Implementation of Game of Life  with File I/O 

### Game of Life Rules

The system evolves according to these fundamental rules:

1. Underpopulation: Any live cell with fewer than two live neighbors dies
2. Survival: Any live cell with two or three live neighbors survives
3. Overpopulation: Any live cell with more than three live neighbors dies
4. Creation: Any dead cell with exactly three live neighbors becomes alive

The neighborhood of a cell consists of the 8 adjacent cells in a 2D matrix, including diagonals. For cells on the edges of the matrix, any neighbors that would be outside the matrix bounds are considered dead cells.

## Input Format

### (Standard Input)
The program expects input in the following format:
```
m       // number of rows (1 ≤ m ≤ 18)
n       // number of columns (1 ≤ n ≤ 18)
p       // number of live cells (p ≤ m*n)
x1 y1   // coordinates of first live cell
x2 y2   // coordinates of second live cell
...
k       // number of evolution steps (k ≤ 15)
```

### Task 0x02 (File Input/Output)
- Reads input from `in.txt`
- Writes output to `out.txt`
- Implements file operations using C standard library functions

## Implementation Details

The implementation includes several key features:

- Written in x86 assembly language
- Uses a double-buffering technique with two matrices to track evolution
- Implements border handling by considering cells outside the matrix as dead
- Supports matrices up to 18x18 in size
- Can simulate up to 15 evolution steps
- Includes proper matrix boundary handling for neighbor counting

### Memory Management
- Matrices are allocated statically in the data section
- Uses an extended matrix with additional border cells for simplified neighbor checking
- Efficiently manages memory through register usage and proper stack handling

## Building and Running

### Prerequisites
- x86 assembly environment
- GCC compiler
- Make (optional)

### Compilation
```bash
# Main (File I/O version)
as -32 main.s -o main.o
gcc -m32 main.o -o main
```

### Running
Task 0x02 (File I/O):
```bash
./main
```
Note: The program automatically reads from in.txt and writes to out.txt

## Example

Input:
```
3 4 5
0 1
0 2
1 0
2 2
2 3
5
```

Output (after 5 iterations):
```
0 0 0 0
0 0 0 0
0 0 0 0
```

## Technical Notes

- The program extends the input matrix by adding a border of dead cells to simplify neighbor checking
- The implementation carefully manages system calls for both standard I/O and file operations
- Memory access is optimized through effective use of registers and minimal stack operations
- Output formatting follows the specification with proper spacing and newline characters
