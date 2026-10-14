# Platform specific flags for compiling (only populate if they're both present)
ifneq ($(strip $(PORT)),)
ifneq ($(strip $(PLAT)),)
CFLAGS += -m$(PORT):$(PLAT)
endif
endif

# Called by the individual targets below to build a ROM
build-target: create-assets $(BINS)

clean-target:
	rm -rf $(OBJDIR)
	rm -rf $(DISTDIR)
	rm -rf $(GENDIR)

build-gb-clean:
	${MAKE} clean-target EXT=gb
build-gb:
	${MAKE} build-target PORT=sm83 PLAT=gb EXT=gb SPRITES=gbapduck


build-gbc-clean:
	${MAKE} clean-target EXT=gbc
build-gbc:
	${MAKE} build-target PORT=sm83 PLAT=gb EXT=gbc SPRITES=gbc


build-pocket-clean:
	${MAKE} clean-target EXT=pocket
build-pocket:
	${MAKE} build-target PORT=sm83 PLAT=ap EXT=pocket SPRITES=gbapduck


build-megaduck-clean:
	${MAKE} clean-target EXT=duck
build-megaduck:
	${MAKE} build-target PORT=sm83 PLAT=duck EXT=duck SPRITES=gbapduck


build-sms-clean:
	${MAKE} clean-target EXT=sms
build-sms:
	${MAKE} build-target PORT=z80 PLAT=sms EXT=sms SPRITES=ggsms


build-gg-clean:
	${MAKE} clean-target EXT=gg
build-gg:
	${MAKE} build-target PORT=z80 PLAT=gg EXT=gg SPRITES=ggsms


build-nes-clean:
	${MAKE} clean-target EXT=nes
build-nes:
	${MAKE} build-target PORT=mos6502 PLAT=nes EXT=nes SPRITES=nes
