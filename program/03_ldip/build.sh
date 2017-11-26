#!/bin/bash

#build elf
echo "Press enter to Build .elf file"
read -n 1
#mips-img-elf-gcc -nostdlib -EL -march=mips32 -T program.ld main.S -o program.elf
readelf -h program.elf
#disassemble.sh
echo "Press enter to Disassemble: "
read -n 1
#mips-img-elf-objdump -M no-aliases -D program.elf > program.dis
cat program.dis
#generate verilog readmem hex file
echo "Press enter to Dump mem hex:"
read -n 1
#echo "@00000000" > program.hex
#mips-img-elf-objdump -D program.elf |  sed -rn 's/\s+[a-f0-9]+:\s+([a-f0-9]*)\s+.*/\1/p' >> program.hex
cat program.hex
#simulate with modelsim
echo "Press enter to Start simulation"
read -n 1
	rm -rf sim 2>/dev/null
	mkdir sim
	cd sim

	cp ../*.hex .

#	vsim -do ../modelsim_script.tcl

	cd ..

#copy hex to board/program
echo "Press enter to copy program to board"
read -n 1
rm -f ../../board/program/program.hex
cp ./program.hex ../../board/program

#simulate with icarus
echo "Press enter to simulate with icarus"
read -n 1
	rm -rf sim
	mkdir sim
	cd sim
	cp ../*.hex .
	# compile
	iverilog -g2005 -D SIMULATION -D ICARUS -I ../../../src -I ../../../testbench -s sm_testbench ../../../src/*.v ../../../testbench/*.v
	# simulation
	vvp -la.lst -n a.out -vcd
	# output
	gtkwave dump.vcd
	cd ..


