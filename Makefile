asm = $(wildcard *.asm)
obj = $(patsubst %.asm,%.o, $(asm))
files = $(patsubst %.asm,%, $(asm))

all: build clean

build: $(asm)
	nasm -f elf $(asm) -o $(obj)
	ld -m elf_i386 $(obj) -o $(files)

clean:
	rm $(obj)