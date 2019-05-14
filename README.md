# Autosess.vim
An automatic vim sessions manager.

<p align="center">
  <img src="https://user-images.githubusercontent.com/10437171/57729653-022aa800-7697-11e9-82d6-eb4435cbb6d3.gif"></img>
</p>

## Introduction

Autosess is a wrapper around vim sessions (`:h session-file`). It automatically
saves and restores sessions by workspace.

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
