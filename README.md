# Half-Precision Floating-Point Calculator

**A half-precision (FP16) calculator built on the DE10-Lite FPGA, featuring a custom hexadecimal keypad for input and a custom LCD board for output. The system performs floating-point addition in IEEE 754 format written in System Verilog and in Intel's Quartus (version 20.1)**

---

## Overview 
This project implements a **half-precision floating-point calculator** capable of adding binary numbers represented in FP16 format. Operands may be expressed in different levels of scientific notation for extra flexibility. 

## Hardware Components 
- **DE10-Lite FPGA Board**  
  Acts as the main processing and control unit. Implements register storage, arithmetic logic, and peripheral interfacing.

- **Custom Hexadecimal Keypad**  
  Allows users to input operands directly in FP16 format using hex digits. The keypad interface loads values into internal registers.
  

- **Custom LCD Display Module**
  Displays the computed FP16 result after calculation, providing direct feedback to the user. 

## Functional Flow 
1. Operand A is entered through the keypad → stored in **Register A**.  
2. Operand B is entered through the keypad → stored in **Register B**.  
3. The FPGA executes **FP16 addition logic** on the two registers.  
4. The final FP16 result is displayed on the **LCD output board**.


## FP16 Format Details 
- **Standard**: IEEE 754 Half-Precision  
- **Bit Breakdown**:  
  - 1 sign bit  
  - 5 exponent bits  
  - 10 mantissa bits  

This structure allows representation of numbers with scientific notation in a compact 16-bit word. 

## Features 
- Implements **floating-point addition** with proper normalization.  
- Integrates custom hardware peripherals for input (keypad) and output (LCD).  
- Designed to be extensible for other operations (e.g., subtraction, multiplication, division). 

## Purpose 
This project demonstrates the practical implementation of floating-point arithmetic on FPGA hardware, highlighting both the **digital design challenges** of FP16 operations and the **system integration** required to build a working calculator.

---

## Credits 
- This project was built under the instruction of [Professor Carroll](https://www.uta.edu/academics/faculty/profile?user=carroll) at the University of Texas at Arlington.  
- Custom Boards were provided by University of Texas at Arlington's CPE Department. 
