# Pipelined-RISCV-processor-with-full-hazard-handling
In this project, I implemented a 32-bit pipelined microarchitecture RISC-V processor based on Harvard Architecture with full hazard handling. In the pipelined microarchitecture, I design it by subdividing the single-cycle processor into five pipeline stages. Thus, five instructions can execute simultaneously, one in each stage. In other words, instruction fetch, instruction decode, execute, write back, and program counter update occurs within a single clock cycle.Because each
stage has only one-fifth of the entire logic, the clock frequency is approximately five times faster. So, ideally, the latency of each instruction is unchanged, but the throughput is five times better.

The Hazard Unit computes control signals for the forwarding multiplexers to choose operands from the register file or from the results in the Memory or Writeback stage (ALUResultM or ResultW). The Hazard Unit should forward from a stage if that stage will write a destination register and the destination register matches the source register. However, x0 is hardwired to 0 and should never be forwarded. If both the Memory and Writeback stages contain matching destination registers, then the Memory stage should have priority because it contains the more recently executed instruction. In summary, the function of the forwarding logic for SrcAE (ForwardAE) is given on the next page. The forwarding logic for SrcBE (ForwardBE) is identical except that it checks Rs2E instead of Rs1E Complete single-cycle RISC-V processor. implementation.



Pipelined processor with full hazard handling
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/8fe9abef-61d9-46d6-8c37-82412b8fb0bd)






in this Project, I ran three projects to test it: 1st program: simple counter program counts from 0 to 255. 2nd program: the Fibonacci series numbers. 3rd program: the factorial of 8.

simulation result of 1st program(simple program counter)
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/7f9b2613-5e58-4f15-83a9-f94f6646e841)





simulation result of 2nd program(the Fibonacci series numbers)
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/9b493681-0465-41cf-9c78-f1f005b0f4b3)





simulation result of 3rd program(the factorial of 8)
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/9534b151-90ab-4d02-ae0e-1dc455c3cda0)





top level view using Quartus Prime Lite Edition
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/4423fa1a-9cd8-4c8d-a805-4426896bb811)
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/7243e25b-4df1-46e0-9b5d-eda1d59ac5b4)
![image](https://github.com/ayaahmed20018414/Pipelined-RISCV-processor-with-full-hazard-handling/assets/82789012/12d698cb-c9a4-4ba8-b0d1-0bf167022df8)




