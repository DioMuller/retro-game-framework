# Platform specific flags for compiling (only populate if they're both present)
ifneq ($(strip $(PORT)),)
ifneq ($(strip $(PLAT)),)
CFLAGS += -m$(PORT):$(PLAT)
endif
endif

# Called by the individual targets below to build a ROM
build-target: $(BINS)	

clean-target:
	rm -rf $(OBJDIR)
	rm -rf $(DISTDIR)
	rm -rf $(GENDIR)

build-gb-clean:
	${MAKE} clean-target EXT=gb
build-gb:
	$(CURDIR)/scripts/sdk/gbdk/create_assets.sh gb
	${MAKE} build-target PORT=sm83 PLAT=gb EXT=gb SPRITES=gb


build-gbc-clean:
	${MAKE} clean-target EXT=gbc
build-gbc:
	$(CURDIR)/scripts/sdk/gbdk/create_assets.sh gbc
	${MAKE} build-target PORT=sm83 PLAT=gb EXT=gbc SPRITES=gbc
