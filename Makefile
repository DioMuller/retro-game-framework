# Include GBDK build targets
include build/gbdk/GBDK.mk

all:
	$(MAKE) all-targets

gb:
	$(MAKE) build-gb

gbc:
	$(MAKE) build-gbc

clean:
	$(MAKE) clean-target