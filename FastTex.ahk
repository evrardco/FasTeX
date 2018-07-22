;This script is intended for easy and fast math writing using LaTeX
;Author: Colin Evrard
;Date: 17/1/2017
;TO DO: vectors, limits, functions, compatibility issues, matrices, partial derivatives, 
;		greek alphabet, physical constants, multiple integrals 
equation=0
derivative=0
integral=0
fraction=0
vector=0
up=0
down=0
text=0
parenthesis=0
cwd = C:\Users\Colin\Dropbox\Cours\SINF12BA\Macro1\
Stack := Array(-1)
^e::					;Enter Equation mode
		equation:=1						
		SendRaw \[  
return
;tests
^t::
	Stack.push(1)
	Stack.push(2)
	Stack.push(3)
	Stack.push(4)

!p::
	WinGet, winid ,, A
	WinMinimize, ahk_id %winid%
	FormatTime, filename,, dd-MM-yyyy@HH-mm-ss
	Run, C:\windows\system32\SnippingTool.exe
	WinWait ahk_class Microsoft-Windows-SnipperToolbar

	WinActivate, ahk_class Microsoft-Windows-SnipperToolbar
	;click on the new screenshot button, the window is constant sized so it's ok
	MouseMove, 49, 50
	Send {Enter}
	WinWait ahk_class Microsoft-Windows-SnipperEditor
	WinActivate ahk_class Microsoft-Windows-SnipperEditor
	Send {CtrlDown}{s}{CtrlUp} ;opening the save as dialog
	WinWait ahk_class #32770 ;random number corresponding to the save as dialog class
	;entering filename and closing
	Clipboard = %filename%.jpg
	Send {CtrlDown}{v}{CtrlUp}
	Send {F4}{Escape}
	SendRaw %cwd%
	Send {Enter 4}
	WinWaitActive, ahk_class Microsoft-Windows-SnipperEditor
	WinClose, ahk_class Microsoft-Windows-SnipperEditor
	WinWaitClose, ahk_class Microsoft-Windows-SnipperEditor
	WinActivate, ahk_id %winid%
	WinWaitActive, ahk_id %winid%
	;entering latex code
	Clipboard = `\begin{figure}`n	`\includegraphics[width=`\linewidth]{%filename%}`n`\end{figure}`n
	Send {CtrlDown}{v}{CtrlUp}
		

return

^i::
		equation:=1
		SendRaw $
return


#If (equation=1)
	^e::
		Send {Space}{Raw} \] ; Comment this line if your editor automatically places the end of the
							 ; inline equation
		equation:=0
	return

	^i::
			equation:=0
			SendRaw $
	return

	!d::
			derivative:=1
			SendRaw \frac{ \mathrm{d} }{ \mathrm{d}  }
			Send {Left 2}
	return

	!i::
			SendRaw \int_{  }^{  }
			Send {Left 7}
			integral:=1
	return

	!v::
			SendRaw \vec{  }
			Send {Left 2}
			vector:=1
	return

	!f::
			SendRaw	\frac{  }{  }
			Send {Left 6}
			fraction:=1
	return

	Up::
			SendRaw ^{  }
			Send {Left 2}
			up:=1
	return

	Down::
			SendRaw _{  }
			Send {Left 2}
			down:=1
	return
	
	!Up::
			SendRaw \uparrow
			Send {Space}
	return
	
	!Down:: 
			SendRaw \downarrow
			Send {Space}
	return
	
	!Right::
			SendRaw \rightarrow
			Send {Space}
	return

	!Left::
			SendRaw \lefttarrow
			Send {Space}
	return
	
	!t::
			SendRaw \textrm{  }
			Send {Left 2}
			text:=1
	return
	(::              ;)
		Send {Raw}(  )
		Send {Left 2}
		parenthesis:=1
	return
	

	
	;Greek Alphabet
	
	^!t::
		KeyWait, h, D
		Send {Backspace}
		SendRaw \theta
	return
		
	Tab::
			if(derivative=1){
				Send {Right 2}
				derivative:=0
			}
			if(integral=2){
				Send {Right 2}
				integral:=0
			}
			if(integral=1){
				Send {Right 5}
				integral:=2
			}
			if(fraction=2){
				Send {Right 2}
				fraction:=0
			}
			if(fraction=1){
				Send {Right 4}
				fraction:=2
			}
			if(vector=1){
				Send {Right 2}
				vector:=0
			}
			if(up=1){
				Send {Right 2}
				up:=0
			}
			if(down=1){
				Send {Right 2}
				down:=0
			}
			if(text=1){
				Send {Right 2}
				text:=0
			}
			if( parenthesis=1 ){
				Send {Right 2}
				parenthesis:=0
			}
	return
#If