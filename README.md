# UART Receiver with Finite State Machine (FSM)

This project implements a **UART receiver** using a **Finite State Machine (FSM)** architecture. The design includes various components such as counters, a demultiplexer, and state transitions to properly receive serial data.

## 📌 Project Overview
- **Designed using:** VHDL
- **Simulated with:** ModelSim
- **Architecture:** RTL (Register Transfer Level)
- **Key Components:**
  - **FSM (Finite State Machine)** – Controls the data reception flow
  - **Demultiplexer** – Directs input bits to the correct location
  - **CNT_1 Counter** – Measures time intervals for bit sampling
  - **CNT_2 Counter** – Tracks the number of received bits
  - **CNT_STOP Counter** – Ensures proper stop bit timing

## 🛠 How It Works
1. The circuit **waits for the START_BIT**.
2. After detecting the start bit, it **synchronizes with the clock (CLK) using CNT_1** to find the **MIDBIT** position.
3. The **FSM transitions through states** (`Start → First → Read → Stop → q4`), reading **8-bit data words** from the serial input (DIN).
4. A **16-clock cycle interval** is maintained between received bits.
5. The **STOP_BIT must be logic 1**, ensuring correct word reception.
6. The **DOUT_VLD signal** verifies the output data validity.

## 🏗️ FSM Design
- **States:** `Start`, `First`, `Read`, `Stop`, `q4`
- **Input Signals:** `DIN`, `CNT_1`, `CNT_2`, `CNT_STOP`
- **Outputs:** `CLK`, `RST`

The FSM ensures **stable and sequential data reception** by transitioning between these states.

## 📁 Project Files
- `uart.vhd` – UART receiver implementation in VHDL
- `uart_fsm.vhd` – Finite State Machine (FSM) controlling the UART receiver
- `Zprava.pdf` – Report with detailed architecture description and ModelSim simulation results
- `README.md` – Project documentation

## 🚀 Simulation
- The design was **tested in ModelSim**, with **simulation screenshots included in the report** (`Zprava.pdf`).
- The FSM transitions and signal integrity were **verified**.

## 📝 Author
**Dinara Garipova**  
Project for **INC Course**  

## ⚖️ License
This project is licensed under the **MIT License** – you are free to use, modify, and distribute the code with attribution.
