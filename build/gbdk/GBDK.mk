#
# A Makefile that compiles all .c and .s files in "src" and "res" 
# subdirectories and places the output in a "obj" subdirectory
#

# If you move this project you can change the directory 
# to match your GBDK root directory (ex: GBDK_HOME = "C:/GBDK/"
GBDK_HOME := $(CURDIR)/tools/sdk/gbdk

PNG2ASSET = $(GBDK_HOME)/bin/png2asset 
LCC = $(GBDK_HOME)/bin/lcc 

# Set platforms to build here, spaced separated. (These are in the separate Makefile.targets)
# They can also be built/cleaned individually: "make gg" and "make gg-clean"
# Possible are: gb gbc pocket megaduck sms gg
TARGETS=gb gbc pocket megaduck sms gg nes

# You can set flags for LCC here
# For example, you can uncomment the line below to turn on debug output
# LCCFLAGS = -debug

# You can set the name of the .gb ROM file here
PROJECTNAME    = platformer_template

SRCDIR      := src
DISTDIR     := dist
OBJDIR      := obj/$(EXT)
RESDIR      := res/$(EXT)
GENDIR      := gen/$(EXT)/src
BINDIR      := build/$(EXT)
MKDIRS      := $(GENDIR) $(OBJDIR) $(BINDIR)
BINS	    := $(OBJDIR)/$(PROJECTNAME).$(EXT)
CSOURCES    := $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) 
GENSOURCES  := $(foreach dir,$(GENDIR), $(wildcard $(dir)/*.c))
ASMSOURCES  := $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS       	:= $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

LCCFLAGS += -Wl-j -Wm-yoA -Wm-ya4 -Wb-ext=.rel $(LCCFLAGS_$(EXT)) # This adds the current platform specific LCC Flags


# Configure platform specific LCC flags here:
LCCFLAGS_gb      = -Wm-ys -Wl-yt0x1B -autobank # Set an MBC for banking (1B-ROM+MBC5+RAM+BATT)
LCCFLAGS_pocket  = -Wm-ys -Wl-yt0x1B -autobank # Usually the same as required for .gb
LCCFLAGS_duck    = -Wm-ys -Wl-yt0x1B -autobank # Usually the same as required for .gb
LCCFLAGS_gbc     = -Wm-ys -Wl-yt0x1B -Wm-yc -autobank # Same as .gb with: -Wm-yc (gb & gbc) or Wm-yC (gbc exclusive)
LCCFLAGS_sms     = -Wm-ys -Wl-yt0x1B -autobank
LCCFLAGS_gg      = -Wm-ys -Wl-yt0x1B -autobank
LCCFLAGS_nes     = -Wm-ys -Wl-yt0x1B -autobank

all: $(TARGETS)

# png2asset settings for backgrounds
PNG2ASSET_BKG_SETTINGS_gg=-pack_mode sms -bpp 4
PNG2ASSET_BKG_SETTINGS_sms=-pack_mode sms -bpp 4
PNG2ASSET_BKG_SETTINGS_nes=-noflip -bpp 2 -pack_mode nes
PNG2ASSET_BKG_SETTINGS_gb=
PNG2ASSET_BKG_SETTINGS_gbc=
PNG2ASSET_BKG_SETTINGS_duck=
PNG2ASSET_BKG_SETTINGS_pocket=

# png2asset settings for sprites
PNG2ASSET_SPRITE_SETTINGS_gg=-noflip -pack_mode sms -bpp 4
PNG2ASSET_SPRITE_SETTINGS_sms=-noflip -pack_mode sms -bpp 4
PNG2ASSET_SPRITE_SETTINGS_nes=
PNG2ASSET_SPRITE_SETTINGS_gb=
PNG2ASSET_SPRITE_SETTINGS_gbc=
PNG2ASSET_SPRITE_SETTINGS_duck=
PNG2ASSET_SPRITE_SETTINGS_pocket=

create-assets:
	# TODO: Call PNG2ASSET to convert all assets in the "res" folder into .c files in the "gen" folder for each platform

# Compile .c files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c 
	$(LCC) $(LCCFLAGS) $(CFLAGS) -I$(GENDIR) -Ires -c -o $@ $<

# Compile .s assembly files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.s
	$(LCC) $(LCCFLAGS) $(CFLAGS) -c -o $@ $<

# If needed, compile .c files in "src/" to .s assembly files
# (not required if .c is compiled directly to .o)
$(OBJDIR)/%.s:	$(SRCDIR)/%.c
	$(LCC) $(LCCFLAGS) $(CFLAGS) -S -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS) 
	$(LCC) $(LCCFLAGS) $(CFLAGS) -I$(GENDIR) -o $(BINDIR)/$(PROJECTNAME).$(EXT) $(OBJS) $(GENSOURCES)


prepare:
	mkdir -p $(OBJDIR)
	mkdir -p $(DISTDIR)
	mkdir -p $(GENDIR)

clean:
	@echo Cleaning
	@for target in $(TARGETS); do \
		$(MAKE) $$target-clean; \
	done

# Include available build targets
include GBDKTargets.mk


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
ifneq ($(strip $(EXT)),)           # Only make the directories if EXT has been set by a target
	$(info $(shell mkdir -p $(MKDIRS)))
endif



# Library Paths
GBDK_PATH := $(CURDIR)/tools/sdk/gbdk

# Compiler Paths
LCC := $(GBDK_PATH)/bin/lcc
PNG2ASSET := $(GBDK_PATH)/bin/png2asset

# Game Definitions
ROM_NAME := game

FRAMEWORK_SRC := $(wildcard src/*.c)
OUT := bin/$(ROM_NAME)

gb:
	# Setup the output directories
	rm -rf resources
	mkdir resources
	mkdir resources/gb

	rm -rf bin	
	mkdir bin

	# Convert Assets
	$(PNG2ASSET) -i assets/sprites/*.png -o res/gb/sprites.c -t tiles -f tiles -p 8x8

	# Compile the game
	$(LCC) -o $(OUT).gb $(FRAMEWORK_SRC)

gbc:
	rm -rf bin
	mkdir bin
	$(LCC) -o $(OUT).gbc $(FRAMEWORK_SRC)

clean:
	rm -rf res
	rm -rf bin