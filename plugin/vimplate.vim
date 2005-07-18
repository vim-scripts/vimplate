"""""""""""""""""""""""""""""""""""""""""""""
" vimplate - Template-Toolkit support for Vim
"""""""""""""""""""""""""""""""""""""""""""""
"
" If you find vimplate useful,
" or have suggestions for improvements, please let me know.
"
" If you write a new template, and will place it in the vimplate package,
" please send it to: stotz@gmx.ch
"
" Usage:
"   :Vimplate <template>
"     choice <template> whit <TAB> command line completion is supportet.
" 
" Subroutines:
"   locale()                  for locale please: man locale
"   [% loc=locale() %]        get the current locale and write it to the variable loc
"   [% locale('C') %]         set global the current locale to C
"   [% locale('de_DE') %]     set global the current locale to de_DE
"   date()                    for date please see: man date
"   [% date('%c') %]          print the current date with the current locale setting
"   [% date('de_DE', '%c') %] print the current date with the locale de_DE
"   input()
"   [% var=input() %]         reade input from user and write it to the variable var
"   choice()
"   [% day=choice('day:', 'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa') %]
"                             let the user choice between different values
"                             and write it to the variable day
"
"   please see: try :Vimplate Test
"               and read the documentation to Template-Toolkit.
"
" Requirements:
"   Perl
"     http://www.perl.org
"     or http://activestate.com/Products/ActivePerl
"     or http://cygwin.com/
"   Template-Toolkit
"     http://search.cpan.org/~abw/Template-Toolkit-2.14
" 
" Installation:
"   1. change to your ~/.vim directory
"   2. untar vimplate.tar.gz: gzip -dc vimplate.tar.gz |tar xpvf -
"   3. move vimplate it the directory that you prefore
"      for expample in ~/bin or /usr/local/bin
"   4. move the directory Template with the example templates 
"      to the place that you prefore
"   5. edit your ~/.vimrc and set the variable Vimplate to
"      to the place where vimplate is locatet
"      for expample let Vimplate = "$HOME/bin/vimplate"
"   6. run vimplate to create your configuration file ~/.vimplaterc
"      for example $HOME/bin/vimplate -createconfig
"   7. edit your ~/.vimplaterc
"   8. happy vimplating
"
" Documentation:
"   - http://www.template-toolkit.org/docs.html
"   - man perl
"  
" Todo:
"   - bether exception handling
"   - write a vim documentation
"   - write a bether documentation
"   - write more templates
"
" License:
"   This program is free software; you can redistribute it and/or modify it
"   under the terms of the GNU General Public License, version 2, as published
"   by the Free Software Foundation.
"
"   This program is distributed in the hope that it will be useful, but
"   WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
"   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
"   for more details.
"
"   A copy of the GNU GPL is available as /usr/share/common-licenses/GPL-2
"   on Debian systems, or on the World Wide Web at
"   http://www.gnu.org/copyleft/gpl.html
"   You can also obtain it by writing to the Free Software Foundation, Inc.,
"   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
"
" Copyright:
"   Copyright (c) 2005, Urs Stotz <stotz@gmx.ch>
"
" Version:
"   vimplate 0.2.2
"
" Changelog:
"   2005-07-18 version 0.2.2 vimplate should be running on Windows
"              when there Template-Toolkit is installed.
"              Better templates for C++.
"   2005-07-09 version 0.2.1 name of subroutine changed
"              write a better .vimplaterc
"   2005-07-09 version 0.2.0 uploaded
"   2005-07-01 init version
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" allow user to avoid loading this plugin and prevent loading twice
if exists ("loaded_vimplate")
    finish
endif
let loaded_vimplate = 1

let s:vimplate = Vimplate

function s:RunVimplate(template)
  let l:tmpfile = tempname()
  let l:cmd =  s:vimplate. " -out=" . l:tmpfile . " -template=" . a:template
  let l:line = line(".")
  execute "!" . l:cmd
  silent execute "read " . l:tmpfile
  execute delete(l:tmpfile)
  execute "normal " . l:line . "G"
  if getline(".") =~ "^$"
    execute "normal dd"
  endif
endfunction

function ListTemplates(...)
  return system(s:vimplate . " -listtemplates")
endfun

command! -complete=custom,ListTemplates -nargs=1 Vimplate call s:RunVimplate(<f-args>)
