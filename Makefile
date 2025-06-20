.PHONY: install
ifeq ($(OS),Windows_NT)
  EXE=.exe
endif

perl5-$(project_version)/perl$(EXE): perl5-$(project_version)/config.h
	$(MAKE) -C perl5-$(project_version)

install: perl5-$(project_version)/perl$(EXE)
	DESTDIR=$(prefix) $(MAKE) -C perl5-$(project_version) install
	rm -rf perl5-$(project_version)/config.h

perl5-$(project_version)/config.h: perl5-$(project_version)/Configure
	cd perl5-$(project_version) && ../$^ -des -Dusedevel -Dman1dir=/share/man/man1 -Dman1ext=1 -Dman3dir=/share/man/man3 -Dman3ext=3 -Dversiononly=no

perl5-$(project_version)/Configure: v$(project_version).tar.gz
	tar xzf $<

v$(project_version).tar.gz:
	curl -O https://github.com/Perl/perl5/archive/refs/tags/$@
