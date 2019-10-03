" window maximization toggle

function! LiteralizeCommand(string)
    " get already properly escaped sequences out of the way, so we don't double-escape them
    let s = eval('"'. a:string .'"')
    " escape remaining special key sequences
    let s = escape(s, '<')
    let s = eval('"'.   s      .'"')
    return s
endfunction

function! ToggleWindowSize()
  if !exists("w:is_window_maximized")
    let w:is_window_maximized = 0
  end
  if !exists("t:last_maxing_window_id")
    let t:last_maxing_window_id = 0
  end
  if !exists('t:is_window_maximized')
    let t:is_window_maximized = 0
  end
  if t:last_maxing_window_id != win_getid()
    if t:is_window_maximized != w:is_window_maximized
      let w:is_window_maximized = 0
    endif
    " getwinvar(t:last_maxing_window_id, 'is_window_maximized') == w:is_window_maximized
    " setwinvar(t:last_maxing_window_id, 'is_window_maximized', !w:is_window_maximized)
  endif
  if w:is_window_maximized == 1
    execute LiteralizeCommand('normal <C-w>=')
    let w:is_window_maximized = 0
  else
    execute LiteralizeCommand('normal <C-w><Bar>z999<CR>')
    let w:is_window_maximized = 1
  endif
  let t:last_maxing_window_id = win_getid()
  let t:is_window_maximized = w:is_window_maximized
endfunction
