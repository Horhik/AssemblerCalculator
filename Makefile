assemblyDirectory = $(notdir $(shell pwd))/assembly
buildDirectory = $(assemblyDirectory)/build

asm = $(wildcard *.asm)
obj = $(patsubst %.asm,%.o, $(asm))
files = $(patsubst %.asm,%, $(asm))

all: run

ifeq ($(OS),Windows_NT)

run:
	$(warning We are currently not supporting Windows)

else

build: $(asm)
	nasm -f elf $(asm) -o $(obj)
	ld -m elf_i386 $(obj) -o $(assemblyDirectory)/$(files)
	$(info $(buildDirectory))

clean:
	rm *.o

run: build
	./$(files)

endif