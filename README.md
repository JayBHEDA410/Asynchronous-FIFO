# Asynchronous-FIFO

This repository contains an implementation of an asynchronous FIFO (First-In-First-Out) data structure using Verilog HDL.


# Overview
The Asynchronous FIFO is a widely used data structure in digital design for buffering data between two asynchronous clock domains. This implementation provides a basic FIFO with configurable depth.


# Features
Suitable for interfacing between two clock domains with different frequencies.

Configurable Depth: Easily adjustable FIFO depth to meet specific requirements.

Binary to Gray Conversion: Utilizes binary to Gray code conversion for addressing to mitigate glitches.

used synchronizer circuits to prevent metastability issues between asynchronous clock domains.

# Files

f: Verilog module containing the asynchronous FIFO implementation.
transmitter_test/: Folder containing Verilog testbenches to validate the transmitter module.
receiver_test/: Folder containing Verilog testbenches to validate the receiver module.
README.md: This file, containing information about the project.

# testing

The test_Asynchronous_FIFO file contains a Verilog testbench to validate the functionality of the FIFO module. Simulation can be performed using a Verilog simulator such as ModelSim or QuestaSim.
