# You can set the name of the .gb ROM file here
PROJECTNAME :=	game
TARGETS 	:=	gb gbc

# Include GBDK build targets
include build/gbdk/GBDK.mk

all: $(TARGETS)

gb:
	$(MAKE) build-gb

gbc:
	$(MAKE) build-gbc

clean:
	$(MAKE) clean-target