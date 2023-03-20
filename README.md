# dotfiles

My personal dotfiles. Documented. Feel free to use.

After years of random personal solutions, from not solution at all to Ansible scripts, I discovered [GNU Stow](https://www.gnu.org/software/stow). Simple, stable. It does the job.

> __Disclaimer__: Don't clone and use it directly if you are not me, read first, copy the idea. This project contains a lot of hard coded stuff that only make sense to me. The Makefile is the most important and relevant part honestly.

[Inspired by Bradon Invergo](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html). Alternative link: [Web Archive](https://web.archive.org/web/20230122011733/https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

## Before

You need GNU Stow. In Fedora:

```bash
sudo dnf install stow stow-doc -y
```

A lot of other programs might be needed. But the purpose of this repository is to configure the programs, not to install them.

## How to use this repository

By default, stow operates on the parent of the folder. I don't clone repositories in my home folder hence I need to specify the place where I want the dotfiles, my home folder.
As I'm not going to remember that, I did a Makefile :)

```
make # clean first, then install all
make install # just install!
make clean # clean everything!
```
