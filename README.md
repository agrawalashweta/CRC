# CRC (CYCLIC REDUNDANCY CHECK)

Cyclic Redundancy Check (CRC) is an error-detecting code used to detect accidental changes to raw data in digital networks and storage devices. It is widely used in protocols such as Ethernet, USB, and in file formats to verify data integrity.
This project implements a hardware module for computing the **CRC-16-CCITT** checksum, commonly used for error detection in communication protocols such as HDLC, X.25, and Bluetooth.

## Specifications
- Implements **CRC-16-CCITT** standard
- Polynomial: `0x1021` (x¹⁶ + x¹² + x⁵ + 1)
- Configurable initial value (e.g., `0xFFFF` or `0x1D0F`)
- Supports bit-serial or byte-parallel input (based on implementation)
- Synthesizable and simulation-ready
- Verilog 2001 compatible

## 🔧 How CRC Works
CRC works by treating data as a binary number and dividing it by a fixed generator polynomial using modulo-2 arithmetic. The remainder of this division is the CRC value or checksum, which is appended to the message. At the receiving end, the same division is performed. If the remainder is non-zero, it indicates an error.

## 📐 CRC Components
- Message: The data to transmit.
- Generator Polynomial (G): A fixed binary number (e.g., 1001 for a simple 4-bit CRC).
- Divisor: The polynomial used to divide the message.
- Remainder (CRC): The bits that are appended to the original message.

## Key Features
- Fast and simple hardware implementation (using shift registers and XOR gates).
- Detects common transmission errors: single-bit errors, double-bit errors, burst errors.
- More reliable than checksums or parity bits for data integrity.

## Test Vector
To validate the implementation we have used the standard input: "123456789" (ASCII). 
Expected CRC: 0x29B1

## Contributions 
Contributions, suggestions, and improvements are always welcome!  

Feel free to open a pull reuqest or create an issue if you have ideas or find bugs.






