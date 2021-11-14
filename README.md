# python-support.nvim

To setup python for neovim manually, please refer to [this wiki](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)

## Requirements

You obviously need `python3` in your `$PATH`

## Installation

Tell your package manager to fetch `pschmitt:python-support.nvim`.

Example with vim-plug:

```vim
Plug 'pschmitt/python-support.nvim', { 'do': ':PythonSupportInitPython3'}
```

## Usage

Execute `:PythonSupportInitPython3` after you have installed this plugin.

## Configuration options

### Installing additional python packages

If you need some specific python package in your venv, let's say you need
flake8, put this into your vimrc file. this plugin will check the
requirements automatically, if requirements are not satisfied, a warning
message will be fired by this plugin. It should be fixed after you execute
`PythonSupportInitPython3`.

```vim
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
```

### Use system packages

This plugin creates a virtual environemnt for neovim by default. 
If you want to use system packages (`python -m venv --system-packages`), 
to use python-dbus for example, you can set:

```vim
let g:python_support_python3_venv_system_site_pkgs = 1
```

### Set venv name

If for some reason you want to rename the venv that `python-support.nvim`
creates you do so via:

```vim
let g:python_support_python3_venv = 'my-venv-name' " Default: 'venv'
```
