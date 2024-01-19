# Increase verbosity, from 0 to 5
VERBOSE_LEVEL := 0

# Folders in the current path
PACKAGES := $(wildcard */)

all: clean install 

# stow doesn't allow to override an existing file, so we need to adopt them
# which will change the git project and then restore it to the previous state
# it's a bit hacky but it works. Don't use unless it's necessary.
bootstrap:
	@stow --adopt --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)
	@git restore .

install:
	@stow --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)

clean: 
	@stow --delete --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)

clean-nvim:
	@stow --delete --target=${HOME} --verbose=$(VERBOSE_LEVEL) nvim

.PHONY: all bootstrap install clean clean-nvim

