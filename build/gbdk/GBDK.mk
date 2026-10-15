#
# A Makefile that compiles all .c and .s files in "src" and "res" 
# subdirectories and places the output in a "obj" subdirectory
#

# If you move this project you can change the directory 
# to match your GBDK root directory (ex: GBDK_HOME = "C:/GBDK/"
LCC = $(CURDIR)/tools/sdk/gbdk/bin/lcc 

# Set platforms to build here, spaced separated. (These are in the separate Makefile.targets)
# They can also be built/cleaned individually: "make gg" and "make gg-clean"
# Possible are: gb gbc pocket megaduck sms gg
TARGETS = gb gbc

# You can set flags for LCC here
# For example, you can uncomment the line below to turn on debug output
# LCCFLAGS = -debug

# Directory Definitions
SRCDIR      	= $(CURDIR)/src
DISTDIR     	= $(CURDIR)/dist
GENDIR      	= $(CURDIR)/gen/$(EXT)
OBJDIR      	= $(CURDIR)/obj/$(EXT)
RESDIR      	= $(CURDIR)/res/$(EXT)
SPRITEDIR   	= $(RESDIR)/sprites
TILEDIR     	= $(RESDIR)/tiles
BINDIR      	= $(CURDIR)/bin/$(EXT)
MKDIRS      	= $(GENDIR) $(OBJDIR) $(BINDIR)

# Build Definitions
BINS	    	= $(OBJDIR)/$(PROJECTNAME).$(EXT)
ASSETSOURCES 	= $(foreach dir,$(GENDIR),$(notdir $(wildcard $(dir)/*.c))) 
CSOURCES    	= $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) 
ASMSOURCES  	= $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS       		= $(ASSETSOURCES:%.c=$(OBJDIR)/%.o) $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

LCCFLAGS += -Wl-j -Wm-yoA -Wm-ya4 -Wb-ext=.rel $(LCCFLAGS_$(EXT)) # This adds the current platform specific LCC Flags


# Configure platform specific LCC flags here:
LCCFLAGS_gb      = -Wm-ys -Wl-yt0x1B -autobank # Set an MBC for banking (1B-ROM+MBC5+RAM+BATT)
LCCFLAGS_gbc     = -Wm-ys -Wl-yt0x1B -Wm-yC -autobank # Same as .gb with: -Wm-yc (gb & gbc) or Wm-yC (gbc exclusive)

all: $(TARGETS)

# Compile .c files in "temp/" to .o object files
$(OBJDIR)/%.o:	$(GENDIR)/sprites/%.c $(GENDIR)/tiles/%.c 
	$(LCC) $(LCCFLAGS) $(CFLAGS) -I$(GENDIR) -Ires -c -o $@ $@

# Compile .c files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c 
	$(LCC) $(LCCFLAGS) $(CFLAGS) -I$(SRCDIR) -Ires -c -o $@ $<

# Compile .s assembly files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.s
	$(LCC) $(LCCFLAGS) $(CFLAGS) -c -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS) 
	$(LCC) $(LCCFLAGS) $(CFLAGS) -I$(GENDIR) -o $(BINDIR)/$(PROJECTNAME).$(EXT) $(OBJS) $(GENSOURCES)

prepare:
	mkdir -p $(OBJDIR)
	mkdir -p $(DISTDIR)
	mkdir -p $(GENDIR)

clean-all:
	@echo Cleaning
	@for target in $(TARGETS); do \
		$(MAKE) $$target-clean; \
	done

# Include available build targets
include build/gbdk/Targets.mk


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
ifneq ($(strip $(EXT)),)           # Only make the directories if EXT has been set by a target
$(info $(shell mkdir -p $(MKDIRS)))
endif