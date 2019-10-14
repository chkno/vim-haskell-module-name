call delete("Foo.hs")
call delete("Bar.hs")
e Foo.hs
normal! imodule Bar where
normal! oa = a
write
FixHaskellFilename
" Note: If you get "Not an editor command: Move" here, you need Eunuch
echo "File is " . fnamemodify(expand("%"), ":t")
call vimtest#SaveOut()
call delete("Foo.hs")
call delete("Bar.hs")
call vimtest#Quit()
