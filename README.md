# dotfiles

My personal config files.

Feel free to lurk and grab whatever you find interesting. I encourage you not
to clone and run; that sounds like a bad idea.

As you can see, I don't have a lot of things going on. After many years, my
dotfiles were full of things I didn't use anymore, so I decided to clean them
up a little bit. I use Fedora Workstation everywhere and I barely change
anything. A normal day for me is one terminal with tmux and Firefox. That's
pretty much all I need in a desktop, so the less I configure, the better.

This project uses [GNU Stow](https://www.gnu.org/software/stow/) and [GNU
Make](https://www.gnu.org/software/make/), so you need to install them. I don't
handle the installation of programs in this repository. I have found that
installation scripts tend to go stale in these kinds of personal projects.

In Fedora:

```bash
sudo dnf install -y stow make
```

Then, run `make`. If a file already exists (usually Bash files on new
installations), you need to adopt it or remove the target.

## About the structure

Each program has its own folder. Inside, you will find files and directories
that start with `dot-`. Stow will replace that part with a `.`, making them
hidden. Years ago, when I started using Stow, I was using hidden files
directly, but that turned out to be a pain in the butt to handle.

## Legal stuff

This repository is licensed under the GNU General Public License v3.0 or later.
See [LICENSE](LICENSE) for details.

Third-party files, if any are added in the future, retain their original
copyright and license.
