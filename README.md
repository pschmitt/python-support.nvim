
# python-support.nvim

use `:PythonSupportInitPython3` to initialize python support for neovim.

If you like setup python for neovim manually, you may refer to [this
wiki](https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim)

## Requirements

- You need `python3` in your `$PATH`

## Usage

Execute `:PythonSupportInitPython3` after you
have installed this plugin.

## Installing additional python packages

If you need some specific python package in your venv, let's say you need
flake8, put this into your vimrc file. this plugin will check the
requirements automatically, if requirements are not satisfied, a warning
message will be fired by this plugin. It should be fixed after you execute
`PythonSupportInitPython`.

```vim
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
```

This plugin sets virtualenv for neovim by default. If you want to use current
environment's python2 and python3, for example, the jedi library won't
complete for non-venv project if the plugin is running on venv. Use the
following option to disable this feature:

```vim
let g:python_support_python3_venv = 0
```

## Notice

I'm working on linux. I haven't test it on other systems. Feel free to send a
PR for other systems support.
