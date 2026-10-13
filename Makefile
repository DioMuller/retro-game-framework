
# Library Paths
GBDK_PATH := $(CURDIR)/tools/sdk/gbdk

# Compiler Paths
LCC := $(GBDK_PATH)/bin/lcc

# Game Definitions
ROM_NAME := game

FRAMEWORK_SRC := $(wildcard src/*.c)
OUT := bin/$(ROM_NAME)

gb:
	rm -rf bin
	mkdir bin
	$(LCC) -o $(OUT).gb $(FRAMEWORK_SRC)

gbc:
	rm -rf bin
	mkdir bin
	$(LCC) -o $(OUT).gbc $(FRAMEWORK_SRC)

clean:
	rm -rf bin