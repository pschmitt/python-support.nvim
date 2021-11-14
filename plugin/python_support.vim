if !has('nvim')
  finish
endif

" command PythonSupport
let g:python_support_python3_venv = get(g:,'python_support_python3_venv', 'venv')
let g:python_support_python3_venv_system_site_pkgs = get(g:,'python_support_python3_venv_system_site_pkgs', 0)
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'pynvim')

com! PythonSupportInitPython3 call s:python_support_init(3)

func! s:python_support_init(v)
  let l:cmd = [split(globpath(&rtp,'python3_support.sh'),'\n')[0]] +
    \ ['--python', g:python3_host_prog] +
    \ [g:python_support_python3_venv_system_site_pkgs == 1 ? "--system-site-packages" : ""] +
    \ ["--venv-name", g:python_support_python3_venv] +
    \ g:python_support_python3_requirements

  exec '! ' . join(l:cmd, ' ')
  call s:init()
endfunc

func! s:init()
  let l:python3 = ""
  if g:python_support_python3_venv
    silent! let l:python3 = split(globpath(&rtp, g:python_support_python3_venv . '/bin/python'),'\n')[0]
    if l:python3 != ''
      let g:python3_host_prog = l:python3
    else
      echom 'python-support.nvim: venv not initialized. Please run PythonSupportInitPython3'
    endif
  elseif executable('python3') && get(g:, 'python3_host_prog', '') == ''
    let g:python3_host_prog = 'python3'
  elseif get(g:, 'python3_host_prog', '') == ''
    echom 'python-support.nvim: python3 executable not found'
  endif

  if get(g:, 'python3_host_prog', '') != ''
    " spawn python process to check requirements 1 second later
    call timer_start(1000, function('s:py3requirements'))
    " TODO Should we run UpdateRemotePlugins here?
    " UpdateRemotePlugins
  endif
endfunc

func! s:py3requirements(timer)
  if empty(g:python_support_python3_requirements)
    " no requirements
    return
  endif

  let l:python = g:python3_host_prog
  if l:python == ''
    let l:python = 'python3'
  endif

  let l:cmd = [l:python, split(globpath(&rtp,'python3_check.py'),'\n')[0]] + g:python_support_python3_requirements
  call jobstart(l:cmd,{'on_stdout':function('s:on_stdout'), 'on_stderr':function('s:on_stdout')})
endfunc

func! s:on_stdout(job_id, data, event)
  echom join(a:data,"\n")
endfunc

call s:init()

" vim: set ft=vim et ts=2 sw=2 :
