call delete("Foo.hs")
e Foo.hs
normal! imodule Foo where
normal! oa = a
write
FixHaskellFilename
echo "File is " . fnamemodify(expand("%"), ":t")
call vimtest#SaveOut()
call delete("Foo.hs")
call vimtest#Quit()
