#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include <GuiConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <GuiSlider.au3>
#include <ColorConstants.au3>
#include <ScreenCapture.au3>
#include <Color.au3>
#include <GuiAVI.au3>
#include <WindowsConstants.au3>



WinActivate("Mozilla")
sleep(100)

Global $loop = 0
Global $sleep = 1
Global $cTarget = $COLOR_WHITE
Global $cCheck = 0
Global $hCheck = 0
Global $MainPixel = 0
Opt("SendkeyDownDelay", Random(5, 50, 1))
Opt("GUIOnEventMode",1)
SoundSetWaveVolume(10)
Opt("MouseClickDelay", 0)

;Main window

Local $hGUI = GUICreate("PixelClicker", 300, 300)
GUISetOnEvent($GUI_EVENT_CLOSE, "Quit")
FileInstall("smile.jpg",@TempDir & "\smile.jpg")
Local $Pic1 = GUICtrlCreatePic(@TempDir & "\smile.jpg", 0, 0, 300, 300)
FileDelete(@TempDir & "\smile.jpg")

#comments-start

Slider para o delay entre as repetições
GUICtrlSetState(-1,$GUI_DISABLE)
Local $hSlider = GUICtrlCreateSlider(0, 0, 300, 30, BitOR($TBS_TOOLTIPS, $TBS_AUTOTICKS, $TBS_ENABLESELRANGE))
GUICtrlSetLimit($hSlider, 10000, 2000)

#comments-end

GUISetState()

;icon
FileInstall("icon.ico",@TempDir & "\icon.ico")

;HELP

GUISetFont (9, 700)
Local $help = GUICtrlCreateLabel("F11-Start F10-Pause F9-Exit F8-Target F7-HP", 0, 275, 300, 50, $SS_CENTER)
GUICtrlSetBkColor($help, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($help, $COLOR_WHITE)
Local $help = GUICtrlCreateLabel("By Krix", 0, 285, 300, 50, $SS_CENTER)
GUICtrlSetBkColor($help, $GUI_BKCOLOR_TRANSPARENT)

;inputs

#comments-start

Texto em baixo do slider do delay
Local $Delay = GUICtrlCreateLabel( "Delay entre repetições", 100, 30)
GUICtrlSetBkColor($Delay, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($Delay, $COLOR_WHITE)

#comments-end

;att
Local $lAtt = GUICtrlCreateLabel("Att", 10, 32)
GUICtrlSetBkColor($lAtt, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($lAtt, $COLOR_WHITE)
Local $nAtt = GUICtrlCreateInput("1", 40, 30, 20, 20, $ES_CENTER)

;drop
Local $lDrops = GUICtrlCreateLabel("Drops", 2, 50)
GUICtrlSetBkColor($lDrops, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($lDrops, $COLOR_WHITE)
Local $nDrops = GUICtrlCreateInput("4", 40, 50, 20, 20, $ES_CENTER)

;hp
Local $lHP = GUICtrlCreateLabel("HP", 2, 90)
GUICtrlSetBkColor($lHP, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($lHP, $COLOR_WHITE)
Local $kHP = GUICtrlCreateInput("7", 40, 90, 20, 20, $ES_CENTER)
Local $tHP = GUICtrlCreateButton("", 65, 90, 20, 20, $BS_ICON)
GUICtrlSetImage($tHP, "icon.ico")
GUICtrlSetOnEvent($tHP, "CHP")

;target
Local $target = GUICtrlCreateLabel("Target", 0, 70)
GUICtrlSetBkColor($target, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor($target, $COLOR_WHITE)
Local $ttarget = GUICtrlCreateButton("", 65, 70, 20, 20, $BS_ICON)
GUICtrlSetImage($ttarget, "icon.ico")
GUICtrlSetOnEvent($ttarget, "CTarget")

#comments-start
$vx = 100
$vy = 100
$vwidth = 1100
$vheight = 600
Global $oIE = _GUICtrl_CreateWMPlayer( (@ScriptDir & "/video.avi"), $vx, $vy, $vwidth, $vheight )
_GUICtrlAVI_Play($player)



Loval $htarget = GUICtrlCreateLabel("HPTarget", 0 , 90)
GUICtrlSetBkColor($htarget, $GUI_BKCOLOR_TRANSPAREN)
GUICtrlSetColor($htarget, $COLOR_WHITE)
#comments-end

FileDelete(@TempDir & "\icon.ico")

;indicador
;$hWndTT = _GUICtrlSlider_GetToolTips($hSlider) controlo do slider em cima para variável
;_GUICtrlSlider_SetToolTips($hSlider, $hWndTT)

Func CLOSEButton()
   MsgBox($MB_OK, "Bye", "Bye")
   Exit
EndFunc

HotKeySet("{f11}","Start")
HotKeySet("{f9}", "Quit")
HotKeySet("{f10}","Stop")
HotKeySet("{f8}", "Coordenadas")
HotKeySet("{f7}", "HPCoordenadas")

While 1
   If $sleep = 1 then
	  Sleep(10)
   EndIf
   If $loop = 1 then
	  $sleep2 = Random(150, 250, 1)
	  ;Send("PC1")
	  Do
		 $aimbot = PixelSearch(453, 202, 1513, 670, $MainPixel)
	  Until (Not @error)
	  Call(PixelCheck)
	  ;Send(@CRLF & "hPixelCheck")
	  if $hCheck = 1 Then
		 MouseClick($MOUSE_CLICK_LEFT, $aimbot[0], $aimbot[1], 1, 0)
		 $hCheck = 0
	  EndIf
	  ;Send(@CRLF & "EndIf")
   EndIf
WEnd

Func Coordenadas()
   $MousePos = MouseGetPos()
   Global $x = $MousePos[0]
   Global $y = $MousePos[1]
   $MainPixel = PixelGetColor($x, $y)
   ;Send($x & @CRLF & $y & @CRLF & $MainPixel & @CRLF)
   $MainPixel_Hex = Hex ($MainPixel, 6)
   $cor = "0x" & $MainPixel_Hex
   Global $pCor = GUICtrlCreateLabel ("", 90, 70, 20, 20)
   GUICtrlSetBKColor($pCor, $cor)
EndFunc

Func CTarget()
   Local $hDLL = DllOpen("user32.dll")
   Local $clique = _IsPressed("01", $hDLL)
   While Not $clique
	  Call("Coordenadas")
	  $clique = _IsPressed("01", $hDLL)
   WEnd
   DllClose($hDLL)
EndFunc

Func CHP()
   Local $hDLL = DllOpen("user32.dll")
   Local $clique = _IsPressed("01", $hDLL)
   While Not $clique
	  Call("HPCoordenadas")
	  $clique = _IsPressed("01", $hDLL)
   WEnd
   DllClose($hDLL)
EndFunc

Func PixelCheck()
   ;Send(@CRLF & "FuncPC")
   Global $nPixel = PixelGetColor($aimbot[0], $aimbot[1])
   ;Send(@CRLF & "Got Color" & @CRLF & $nPixel & @CRLF & $MainPixel)
   If $nPixel == $MainPixel Then
	  ;Send(@CRLF & "cCheck = 1" )
	  $hCheck = 1
   Else
	  $hCheck = 0
	  ;Send(@CRLF & "cCheck = 0" )
   EndIf
EndFunc

Func HPCoordenadas()
   $hMousePos = MouseGetPos()
   Global $hx = $hMousePos[0]
   Global $hy = $hMousePos[1]
   Global $hMainPixel = PixelGetColor($hx, $hy)
   ;Send($hx & @CRLF & $hy & @CRLF & $hMainPixel & @CRLF)
   $hMainPixel_Hex = Hex ($hMainPixel, 6)
   $hcor = "0x" & $hMainPixel_Hex
   Global $hpCor = GUICtrlCreateLabel ("", 90, 90, 20, 20)
   GUICtrlSetBKColor($hpCor, $hcor)
EndFunc

Func hPixelCheck()
   ;Send(@CRLF & "FuncPC")
   Global $hPixel = PixelGetColor($aimbot[0], $aimbot[1])
   ;Send(@CRLF & "Got Color" & @CRLF & $hPixel & @CRLF & $hMainPixel)
   If $hPixel == $hMainPixel Then
	  ;Send(@CRLF & "hCheck = 0" )
	  $hCheck = 1 ; se for igual nao precisa de mandar input
   Else
	  $hCheck = 0
	  ;Send(@CRLF & "hCheck = 1" )
   EndIf
EndFunc

Func Stop()
   SoundPlay("")
   $loop = 0
   $sleep = 1
   ToolTip("Paused", 0, 0, "", 0)
EndFunc

Func Start()
   ;SoundPlay ("video.mp3")
   $loop = 1
   $sleep = 0
   ToolTip("Playing", 0, 0, "", 0)
EndFunc

Func Quit()
   Exit
EndFunc
