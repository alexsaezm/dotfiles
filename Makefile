# Increase verbosity, from 0 to 5
VERBOSE_LEVEL := 0

# Folders in the current path
PACKAGES := $(wildcard */)

all: clean install 

install:
	@stow --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)

clean: 
	@stow --delete --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)

.PHONY: all install clean

