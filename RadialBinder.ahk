; RUS Help: Удерживать СРЕДНЮЮ кнопку мыши - показать меню (для выбора элемента меню - просто навести курсор на нужный элемент). 
; RUS Help: Удерживать End 3 сек - выключить биндер.
; RUS Help: Удерживать End 2 сек - перезапуск биндера.
;
; ENG Help: Hold Middle Mouse Button to display the menu, mouse over to select an item.
; ENG Help: Hold End for 3 sec to shutdown the binder.
; ENG Help: Hold End for 2 sec to reload the binder.
;
; Ricardo Richi aka Sungrey @ RichiSoft https://linktr.ee/richisoft

#SingleInstance, force
SetKeyDelay,-1, -1
SetControlDelay, -1
SetMouseDelay, -1
SendMode Input
SetBatchLines,-1
ListLines, Off
Menu, Tray, NoStandard 
Menu, Tray, Add, Перезагрузка, ReloadSub
Menu, Tray, Add, Выход, ExitSub
SetWorkingDir %A_ScriptDir%


;==ADMIN=RIGHTS=OVERRIDER==================================================
full_command_line := DllCall("GetCommandLine", "str")

If Not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
   Try
   {
      If A_IsCompiled
         Run *RunAs "%A_ScriptFullPath%" /restart
      Else
         Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
   }
   ExitApp
}


;==INIT====================================================================
AppName := "Radial Binder v1.1.221123"
Global ShortAppName := "Radial Binder"

Menu, Tray, Tip, %AppName%

;IrfanView https://www.irfanview.com
IfNotExist, %A_Temp%\ahk\irfanview\i_view32.exe
{
  FileCreateDir, %A_Temp%\ahk\irfanview\zip
  ToolTipShow_Func("Загрузка дополнительных файлов...")
  URLDownloadToFile, https://domainunion.de/irfanview/iview462g.zip, %A_Temp%\ahk\irfanview\zip\iview462g.zip
  Run, tar -xvzf %Temp%\ahk\irfanview\zip\iview462g.zip -C %Temp%\ahk\irfanview\zip,,Hide
  Sleep, 2000
  FileMove, %A_Temp%\ahk\irfanview\zip\i_view32.exe, %A_Temp%\ahk\irfanview\i_view32.exe
  Sleep, 210
  FileRemoveDir, %A_Temp%\ahk\irfanview\zip, 1
  ToolTipShow_Func("Загрузка завершена")
}


;==NAMING==================================================================
Global CellSize = 90 ;rus Размер ячейки
Global CellResizer = 2.2 ;rus Значение на удаления ячеек от центра
Global RelativeCenter = 1.02 ;rus Относительный центр, чтобы было красиво
;rus Ячейки без сглаживания, потому что ванильный AHK не умеет в сглаживание, аминь

Loop, 8
{
   ;rus Названия ячеек. `n - перенос строки
   Cell1 := "Скриншот"
   Cell2 := "     ПМП`n (на тело)"
   Cell3 := "  Кодеин`n (на тело)"
   Cell4 := "    Карта`n  пожаров"
   Cell5 := "  УК Штата"
   Cell6 := "        -"
   Cell7 := "        -"
   Cell8 := "  Коорд.`n  мышки"

   ;rus Настройки текста
   FontSize = 9 ;rus Размер текста
   FontColor = White ;rus Цвет текста, можно указать и типа FFFFFF и White, кому как нравится
   FontType = Arial Black ;rus Шрифт, работает только со стандартными шрифтами

   TextPaddingLeft = 10 ;rus Отступ текста слева
   TextPaddingTop = 31 ;rus Отступ текста сверху
   TextBoxHight := CellSize - 24 ;rus Размер текстбокса по высоте
   TextBoxWidth := CellSize - 18 ;rus Размер текстбокса по ширине

   CurrentCell := Cell%A_Index%
   CellBG := CellSize + 20 ;To hide scrollbars
   TextOptions = x%TextPaddingLeft% y%TextPaddingTop% w%TextBoxWidth% h%TextBoxHight% c%FontColor% +BackgroundTrans

   Gui CellBox%A_Index%: Font, s%FontSize%, %FontType%
   Gui CellBox%A_Index%: Add, Text, %TextOptions%, %CurrentCell%
   Gui CellBox%A_Index%: Add, ActiveX, x0 y0 w%CellBG% h%CellBG% vBG, HtmlFile ;Use the same colors as DF005F to create the fake transparency effect
   BG.Write( "<body style=background-color:DF005F;/>" ) ;rus Цвет Маджестика DF005F, тут можно поменять, чтобы настроить отступы текста и вернуть цвет обратно
   Gui CellBox%A_Index%: Color, DF005F ;rus Цвет Маджестика
   Gui CellBox%A_Index%: +Disabled +ToolWindow +AlwaysOnTop -Caption +LastFound
}


;==BINDER==================================================================
;https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
Got_Cell:
MouseGetPos, , , WinID
WinGetTitle, Cell, ahk_id %WinID%
If Cell contains Cell
{
   CoordMode, mouse, Screen
   MouseMove, %mx1%, %my1%
   If Cell = Cell1
   {
      NoGui_Func()
      ScreenShot_Func("Скриншот")
      Return
   }
   Else If Cell = Cell2
   {
      NoGui_Func()
      Say_Func("/me осмотрел пострадавшего")
      Say_Func("/do Пострадавший без сознания")
      Say_Func("/me проверил пульс пострадавшего на сонной артерии")
      Say_Func("/me проверил дыхание пострадавшего")
      G_Func(750)
      Click_Func(1100, 440)
      Say_Func("/me достал шприц с эпинефрином и дифибриллятор")
      Say_Func("/me вколол шприц с эпинефрином и дал разряд с дифибриллятора")
      Say_Func("/do Пострадавший пришел в сознание")
      Sleep, 6550
      ScreenShot_Func("Реанимация")
      Return
   }
   Else If Cell = Cell3
   {
      NoGui_Func()
      Say_Func("/do На плече висит сумка с лекарствами")
      Say_Func("/me открыл сумку с лекарствами")
      G_Func(750)
      ;Click_Func(1100, 440) ;rus Нужна позиция в G - Продать таблетку, иначе работать не будет. Настраивается так же как в ПМП
      Sleep, 3550
      ScreenShot_Func("Таблетки")
      Return
   }
   Else If Cell = Cell4
   {
      WebOverlay_Func("https://i.imgur.com/0JYqdcL.gif", 1720, 1016) ;rus Карта пожаров EMT EMS
      Return
   }
   Else If Cell = Cell5
   {
      WebOverlay_Func("https://i.imgur.com/IGC5xKT.gif", 1549, 1013) ;rus Уголовный кодекс Majestic - FIB (08.11.2023)
      Return
   }
   Else If Cell = Cell6
   {

   }
   Else If Cell = Cell7
   {

   }
   Else If Cell = Cell8
   {
      NoGui_Func()
      SetTimer, GetCursor, 100

      GetCursor:
         MouseGetPos, xPos, yPos
         ToolTip, X: %xPos%`nY: %yPos%`n`nEsc - Закрыть
         Return
   }
   SoundBeep, 600, 80 ;If no func set
   SoundBeep, 600, 80 ;rus Если функция пустая (выше), то будет двойной бип
}
Return


;==RADIAL=MENU=BUTTON======================================================
MButton::
PressedTime = 0
CoordMode, mouse, Screen
MouseGetPos, mx1, my1
SetTimer, FadeOut_FX, 35
RadialBinderBuilder()
SetTimer, Got_Cell, 15
Return

;==FUNCS===================================================================
ToolTipShow_Func(ttName) {
   ToolTip, %ttName%
   Sleep, 2500
   ToolTip
   Return
}

ScreenShot_Func(ssName) {
   SoundBeep, 150, 120
   SoundBeep, 350, 100
   Run, "%A_Temp%\ahk\irfanview\i_view32.exe" /capture=3 /convert=%A_WorkingDir%\%ShortAppName%\%ssName%\$U(`%Y-`%m-`%d_`%H`%M`%S).png,,Hide
}

WebOverlay_Func(ImgUrl, wImg, hImg) {
   NoGui_Func()
   Gui Overlay: +Disabled +ToolWindow +AlwaysOnTop -Caption +LastFound
   Gui Overlay: Add, ActiveX, w%wImg% h%hImg%, % "mshtml:<img src='" ImgUrl "' />" 
   Gui Overlay: Color, FFFFFF
   WinSet, TransColor, FFFFFF 220
   Gui Overlay: Show, AutoSize Center NoActivate, Overlay
   Gui Overlay: +E0x80020 ;ignores mouse-over
   ToolTipShow_Func("Esc/End - Закрыть")
}

Say_Func(text) {
   Clipboard = 
   Clipboard = %text%
   SendMessage, 0x50,, 0x4190419,, A
   SendInput, {vk54} ;t
   Sleep, 750
   SendInput, ^{vk56} ;ctrl-v
   SendInput, {vk0d} ; enter
   Sleep, 750
}

Click_Func(mouse_x, mouse_y) {
   MouseMove, %mouse_x%, %mouse_y%
   Sleep, 1050
   Click, %mouse_x%, %mouse_y%
   Sleep, 750
}

G_Func(sleepAfter) {
   SendInput, {vk47}
   Sleep, %sleepAfter%
}

Cancel_Func() {
   Gui Overlay: Destroy
   Gui CellBox%A_Index%: Destroy
   SetTimer, GetCursor, Off
   ToolTip
}

NoGui_Func() {
   Gui Overlay: Destroy
   Gui CellBox%A_Index%: Destroy
   Sleep, 500
}

;Based on the original code of 'Radial menu v2' by Boris Mudrinic (boris-mudrinic@net.hr)
RadialBinderBuilder() {
   CoordMode, mouse, Screen
   MouseGetPos, mxf, myf
   Loop, 8
   {
      If A_index = 1
      {
         CellX := mxf - (25 * CellResizer) ;Central cross - upper cell
         CellY := myf - (100 * CellResizer)
      }
      Else If A_index = 2
      {
         CellX := mxf + (30 * CellResizer)
         CellY := myf - (80 * CellResizer)
      }
      Else If A_index = 3
      {
         CellX := mxf + (50 * CellResizer)
         CellY := myf - (25 * CellResizer) ;Central cross - right cell
      }
      Else If A_index = 4
      {
         CellX := mxf + (30 * CellResizer)
         CellY := myf + (30 * CellResizer)
      }
      Else If A_index = 5
      {
         CellX := mxf - (25 * CellResizer) ;Central cross - bottom cell
         CellY := myf + (50 * CellResizer)
      }
      Else If A_index = 6
      {
         CellX := mxf - (80 * CellResizer)
         CellY := myf + (30 * CellResizer)
      }
      Else If A_index = 7
      {
         CellX := mxf - (100 * CellResizer)
         CellY := myf - (25 * CellResizer) ;Central cross - left cell
      }
      Else If A_index = 8
      {
         CellX := mxf - (80 * CellResizer)
         CellY := myf - (80 * CellResizer)
      }

      ResizedCellX := Ceil(CellX * RelativeCenter)
      ResizedCellY := Ceil(CellY * RelativeCenter)
      Gui CellBox%A_Index%: +AlwaysOnTop +ToolWindow -Caption +LastFound
      WinSet, Region, 0-0 E W%CellSize% H%CellSize% ;Elipse cell (rounded cell)

      Gui CellBox%A_Index%: Show, x%ResizedCellX% y%ResizedCellY% w%CellSize% h%CellSize% , Cell%A_Index%   
      WinSet, Transparent, 180, Cell%A_Index%
      
      Sleep, 32
      If Not (GetKeyState("MButton","p"))
      Return
   }
}

FadeOut_FX:
PressedTime++
If Not (GetKeyState("MButton","p"))
{
   If (PressedTime < 7)
   SendInput, {MButton}
   
   SetTimer, Got_Cell, off
   SetTimer, FadeOut_FX, off

	; FadeOut FX
   InitialAlpha = 180 
	Loop, 17
	{
		Loop, 8
		WinSet, Transparent, %InitialAlpha%, Cell%A_Index%
		InitialAlpha -= 15 ;AlphaStep
		Sleep, 25 ;Frame per decay
	}
	Loop, 8
	Gui CellBox%A_Index%: Hide
	Return
}
Return
;==Hotkey=section=starts=here==============================================


;==SYSTEM==================================================================
*~$Escape::
Cancel_Func()
Return

*~$End::
Cancel_Func()
KeyWait, End, T0.8
If ErrorLevel
{
  KeyWait, End, T2.8
  If ErrorLevel
  {
    GoSub, ExitSub
  }
  GoSub, ReloadSub
}
Return

ReloadSub:
   SoundBeep, 500, 80
   Reload 

ExitSub:
   SoundBeep, 600, 80
   SoundBeep, 400, 80
   ExitApp
