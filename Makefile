# Increase verbosity, from 0 to 5
VERBOSE_LEVEL := 1

# If at some point I need to filter out folders, I can do something like:
# PACKAGES := $(filter-out folder_A/ folder_B/,$(wildcard */))
PACKAGES := $(wildcard */)

# The main target. Although it's a little bit destructive in already existing setups.
all: clean install

# Cleaning is important, in real life and here
clean:
	@stow --delete --target=${HOME} --verbose=$(VERBOSE_LEVEL) --dotfiles $(PACKAGES)

# The real deal, it will grab all the folders and generate the symlinks
install:
	@stow --target=${HOME} --verbose=$(VERBOSE_LEVEL) --dotfiles $(PACKAGES)

# GNU Stow doesn't allow to override an existing file, so we need to adopt them
# which will change the git project and then restore it to the previous state
# it's a bit hacky but it works. Don't use unless it's necessary.
adopt:
	@stow --adopt --target=${HOME} --verbose=$(VERBOSE_LEVEL) $(PACKAGES)
	@git restore .

# I never remember how to clean all the Neovim stuff in case, hence this step
clean-nvim:
	@stow --delete --target=${HOME} --verbose=$(VERBOSE_LEVEL) nvim
	@rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/

.PHONY: all adopt install clean clean-nvim
