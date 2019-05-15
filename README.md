# Autosess.vim
An automatic vim sessions and views manager.

<p align="center">
  <img src="https://user-images.githubusercontent.com/10437171/57759027-4e0e3900-76f9-11e9-8c55-8b68d72c913b.gif"></img>
</p>

## Introduction

Autosess is a wrapper around vim sessions (`:h mksession`) and vim views (`:h
mkview`). It automatically saves and restores sessions by workspace, and views
by file.

## Installation

```vim
Plug 'soywod/autosess.vim'
```

## Configuration

### Sessions folder

By default, sessions are stored in `<plugin-root>/sessions`. You can customize
the directory:

```vim
let g:autosess_folder = '/my/custom/folder'
```
