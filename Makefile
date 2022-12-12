# Files Extensions
INC := .inc# include files suffix
ASM := .asm# source files suffix
LST := .lst# listing files suffix
OBJ := .o# object files suffix

# Working Directories
ProjectDir := ./
ifeq ($(pathformat),absolute)
ProjectDir = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
endif
AssemblyDir = $(ProjectDir)assembly/
BuildDir = $(ProjectDir)build/# it does have to be specified in .gitignore
IntDir = $(BuildDir)int/

# Files
AssemblyFiles = $(wildcard $(AssemblyDir)*$(ASM))
SourceFilesNames = $(basename $(notdir $(AssemblyFiles)))
ObjectFiles = $(addprefix $(IntDir),$(addsuffix $(OBJ),$(SourceFilesNames)))

# Miscellaneous Settings
ProjectName = AsmCalc
IncludeDir = $(AssemblyDir)include/ $(AssemblyDir)1/


ifneq ($(OS),Windows_NT)

# OS Specific Commands
TranslateCommand = nasm -f elf32
LinkCommand = ld -m elf_i386
IncludeCommand = -i
Debug = -g
Name = -o
NameListing = -l
CreateDirectories = mkdir -p
RemoveDirectories = rm -r
Print = @echo

# OS Specific Color Output
RedColor = \e[0;31m
GreenColor = \e[0;32m
YellowColor = \e[0;33m
BlueColor = \e[0;34m
MagentaColor = \e[0;35m
CyanColor = \e[0;36m
ResetColor = \e[0m

# Recipes
$(ProjectName): $(ObjectFiles)
	$(Print)
	$(Print) " === Build has finished === "
	$(Print)

$(IntDir)%$(OBJ) %$(ASM): $(IntDir) $(AssemblyDir)%$(ASM)

ifeq ($(debug),enable)

	$(Print) " === $(RedColor)Translating$(ResetColor) $(basename $(notdir $@))$(ASM) in <$(RedColor)debug$(ResetColor)> mode === "

	$(TranslateCommand) $(AssemblyDir)$(basename $(notdir $@))$(ASM) $(Name) $(IntDir)$(basename $(notdir $@))$(OBJ) $(addprefix $(IncludeCommand) ,$(IncludeDir)) \
	$(Debug) $(NameListing) $(IntDir)$(basename $(notdir $@))$(LST)

else

	$(Print) " === $(RedColor)Translating$(ResetColor) $(basename $(notdir $@))$(ASM) in <$(GreenColor)release$(ResetColor)> mode === "

	$(TranslateCommand) $(AssemblyDir)$(basename $(notdir $@))$(ASM) $(Name) $(IntDir)$(basename $(notdir $@))$(OBJ) $(addprefix $(IncludeCommand) ,$(IncludeDir))

endif

	$(Print)

	$(Print) " === $(YellowColor)Linking$(ResetColor) $(basename $(notdir $@))$(OBJ) === "
	$(LinkCommand) $(IntDir)$(basename $(notdir $@))$(OBJ) $(Name) $(BuildDir)$(basename $(notdir $@))

	$(Print)
	$(Print) " === $(GreenColor)Builded$(ResetColor) $(basename $(notdir $@)) === "


clean-int: # deletes Intermediate Directory
	$(RemoveDirectories) $(IntDir)
	$(Print) " === $(BlueColor)Cleared out$(ResetColor) $(IntDir) === "
	$(Print)


clean: # deletes Build Directory
	$(RemoveDirectories) $(BuildDir)
	$(Print) " === $(MagentaColor)Exterminated$(ResetColor) $(BuildDir) === "
	$(Print)

$(IntDir):
	$(Print) " === $(CyanColor)Creating$(ResetColor) $(IntDir) === "
	$(CreateDirectories) $(IntDir)
	$(Print)
else

$(warning We do not support OS Windows!)

endif