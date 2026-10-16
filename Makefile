# You can set the name of the .gb ROM file here

ifeq ($(strip $(PROJECT_NAME)),)
PROJECT_NAME :=	test_game
endif

ifeq ($(strip $(TARGETS)),)
TARGETS 	:=	gb gbc
endif

# Include GBDK build targets
include build/gbdk/GBDK.mk

all: $(TARGETS)

gb:
	$(MAKE) build-gb

gbc:
	$(MAKE) build-gbc

clean:
	$(MAKE) clean-target