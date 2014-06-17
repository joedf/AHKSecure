#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>

Global $Lbl1, $Lbl2, $Lbl3, $Lbl4, $BtL, $BtLS, $BtLB, $BtLBS, $BtE, $BtES, $BtAdmin, $Annuler
Global $Arg, $Res, $SandBox, $ahk, $Scite, $ResDir, $Dll, $nMsg
Global $Gui1, $GUI2, $Option, $Installer, $Desinstaller, $Grp1, $Rd1, $Rd2, $Ok

	Global $Dirahk = RegRead("HKLM\SOFTWARE\AutoHotkey\", "InstallDir")
	Global $Dirahkbeta = RegRead("HKLM\SOFTWARE\AutoHotkey\", "InstallDir")&"\v2-alpha\"
	Global $Versionahk = RegRead("HKLM\SOFTWARE\AutoHotkey\", "Version")
	Global $Versionahkbeta = FileGetVersion(RegRead("HKLM\SOFTWARE\AutoHotkey\", "InstallDir")&"\v2-alpha\x86\AutoHotkey.exe")
	Global $Beta = RegRead("HKLM\SOFTWARE\AutoHotkey\", "InstallDir")&"\v2-alpha\x86\AutoHotkey.exe"
	Global $HKey_AUShell = "HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell"

; Verification ligne de commande (/? ou /src ou autre)
$Arg = _IsCmdLine()

; Controle que le script soit bien compile
If Not @Compiled Then
	_error("Thou shouldst not lay-to this script with nay compilation ")
EndIf

; Controle si ahk est installe
If $Dirahk = "" Then _error("AHK is not installed ! ")

; Récupère le chemin de l'exécutable SandBox.
$Res = StringSplit(RegRead("HKEY_CLASSES_ROOT\*\shell\sandbox\command", ""), " /", 1)
$SandBox = $Res[1]

; Récupère le chemin de l'exécutable ahk et Scite.
If FileExists($Dirahk & "\AutoHotkey.exe") Then
	$ahk = $Dirahk & "\AutoHotkey.exe"
	$beta = $Beta
	$Scite = $Dirahk & "\SciTE\SciTE.exe"
Else
	_error("AHK is not installed ! ")
EndIf

$Dll = DllOpen("user32.dll")

#Region ########################################### START Function section ###########################################
Func _GUI()
	#Region ########################################### START GUI section ###########################################
	$Gui1 = GUICreate($AppName, 250, 280, -1, -1, BitOR($WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_BORDER, $WS_CLIPSIBLINGS))
	GUISetFont(8, 800, 0, "MS Sans Serif")

	$Lbl1 = GUICtrlCreateLabel("AutoHotkey", 10, 5, 110, 15, $SS_CENTER)
	$Lbl2 = GUICtrlCreateLabel($Versionahk, 10, 20, 110, 17, $SS_CENTER)
	$Lbl3 = GUICtrlCreateLabel("AHK Beta", 130, 5, 110, 17, $SS_CENTER)
	If Not $Beta Then GUICtrlSetState(-1, $GUI_DISABLE)
	$Lbl4 = GUICtrlCreateLabel($Versionahkbeta, 130, 20, 110, 17, $SS_CENTER)
	If Not $Beta Then GUICtrlSetState(-1, $GUI_DISABLE)

	$BtL = GUICtrlCreateButton("Execute", 10, 40, 110, 30, $BS_FLAT)
	GUICtrlSetBkColor(-1, 0xFF0000)
	GUICtrlSetTip(-1, "Execute the script")

	$BtLS = GUICtrlCreateButton("Execute (sandbox)", 10, 80, 110, 30, $BS_FLAT)
	GUICtrlSetBkColor(-1, 0x00FF00)
	GUICtrlSetTip(-1, "Execute the script in the sandbox ")

	$BtLB = GUICtrlCreateButton("Execute", 130, 40, 110, 30, $BS_FLAT)
	If $Beta Then
		GUICtrlSetBkColor(-1, 0xFF0000)
	Else
		GUICtrlSetState(-1, $GUI_DISABLE)
	EndIf
	GUICtrlSetTip(-1, "Execute with AHK Beta" & $Versionahkbeta)

	$BtLBS = GUICtrlCreateButton("Execute (sandbox)", 130, 80, 110, 30, $BS_FLAT)
	If $Beta Then
		GUICtrlSetBkColor(-1, 0xFF0000)
	Else
		GUICtrlSetState(-1, $GUI_DISABLE)
	EndIf
	GUICtrlSetTip(-1, "Execute the script with AHK Beta in the sandbox " & $Versionahkbeta)

	$BtE = GUICtrlCreateButton("Open in Scite", 10, 120, 233, 30, $BS_FLAT)
	GUICtrlSetBkColor(-1, 0xFF0000)
	GUICtrlSetTip(-1, "Edit the script using Scite")

	$BtES = GUICtrlCreateButton("Edit the script in Sandboxie", 10, 160, 233, 30, $BS_FLAT)
	GUICtrlSetBkColor(-1, 0x00FF00)
	GUICtrlSetTip(-1, "Edit the script in a sandboxed Scite")

	$Annuler = GUICtrlCreateButton("Abort", 10, 200, 233, 30, $BS_FLAT)
	GUICtrlSetBkColor(-1, 0x00FF00)
	GUICtrlSetTip(-1, "Quit without doing anything")

	; Si SandBoxie n'est pas installé :
	If $SandBox = "" Then
		GUICtrlSetBkColor($BtLS, 0xF4F4F0)
		GUICtrlSetBkColor($BtLBS, 0xF4F4F0)
		GUICtrlSetBkColor($BtES, 0xF4F4F0)
		GUICtrlSetState($BtLS, $GUI_DISABLE)
		GUICtrlSetState($BtLBS, $GUI_DISABLE)
		GUICtrlSetState($BtES, $GUI_DISABLE)
	EndIf

	GUICtrlSetState($BtLS, $GUI_FOCUS)
	GUISetState(@SW_SHOW)
	#EndRegion ########################################### START GUI section ###########################################

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $Annuler
				_Sortie()

			Case $BtL
				_Lance()

			Case $BtLS
				_LanceSandBoxe()

			Case $BtLB
				_LanceBeta()

			Case $BtLBS
				_LanceSandBoxeBeta()

			Case $BtE
				_Edit()

			Case $BtES
				_EditSandBoxe()

			Case Else
				If _IsPressed("4E", $Dll) Then _Lance() ; N
				If _IsPressed("53", $Dll) Then _LanceSandBoxe() ; S
				If _IsPressed("45", $Dll) Then _Edit() ; E
				If _IsPressed("42", $Dll) Then _EditSandBoxe() ; B
				If _IsPressed("41", $Dll) Or _IsPressed("1B", $Dll) Then _Sortie() ; A ou ESC

		EndSwitch
	WEnd
EndFunc   ;==>_GUI

Func _error($Msg)
	MsgBox(16, $AppName & " Error", $Msg)
	Exit (0)
EndFunc   ;==>_error

Func _Lance()
	ShellExecute($ahk, '"' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_Lance

Func _LanceSandBoxe()
	ShellExecute($SandBox, ' /box:__ask__ ' & $ahk & ' "' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_LanceSandBoxe

Func _LanceBeta()
	ShellExecute($beta, '"' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_Lance

Func _LanceSandBoxeBeta()
	ShellExecute($SandBox, ' /box:__ask__ ' & $beta & ' "' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_LanceSandBoxe

Func _Edit()
	ShellExecute($Scite, ' "' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_Edit

Func _EditSandBoxe()
	ShellExecute($SandBox, ' /box:__ask__ ' & $Scite & ' "' & $Arg & '"')
	_Sortie()
EndFunc   ;==>_EditSandBoxe

Func _Sortie()
	DllClose($Dll)
	Exit (1)
EndFunc   ;==>_Sortie

Func _chooseinstall()

	$GUI2 = GUICreate($AppName, 380, 110, -1, -1)
	$Option = GUICtrlCreateLabel("Choose your install option ", 45, 20, 350, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
	$Installer = GUICtrlCreateButton("Activate", 50, 60, 130, 30, $BS_FLAT)
	$Desinstaller = GUICtrlCreateButton("Deactivate", 200, 60, 130, 30, $BS_FLAT)
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit

			Case $Installer
				_ahkSecureInstall()

			Case $Desinstaller
				GUICtrlDelete($GUI2)
				_ChoixClic()

		EndSwitch
	WEnd
EndFunc   ;==>_chooseinstall

Func _IsCmdLine()
	If $CmdLine[0] > 0 Then
		If StringInStr($cmdlineraw, "/inst") Then
			_ahkSecureInstall()
		EndIf
		Return $CmdLine[1]
	Else
		_chooseinstall()
	EndIf
EndFunc   ;==>_IsCmdLine

Func _ChoixClic()
	$GUI2 = GUICreate("AHKSecure", 162, 161, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_GROUP, $WS_BORDER, $WS_CLIPSIBLINGS), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
	$Grp1 = GUICtrlCreateGroup("Opening action :", 16, 16, 129, 97)
	$Rd1 = GUICtrlCreateRadio("Execute", 31, 41, 80, 20)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$Rd2 = GUICtrlCreateRadio("Edit", 31, 71, 80, 20)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	$Ok = GUICtrlCreateButton("OK", 40, 128, 80, 25, $BS_FLAT)
	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $Ok
				If BitAND(GUICtrlRead($Rd1), $GUI_CHECKED) = $GUI_CHECKED Then
					If RegRead($HKey_AUShell, "") Then
						RegWrite($HKey_AUShell&"\Open\Command", "", "REG_SZ", '"C:\Program Files\AutoHotkey\AutoHotkey.exe" "%1" %*')
						RegWrite($HKey_AUShell, "", "REG_SZ", "Open")
					EndIf
				Else
					If RegRead($HKey_AUShell, "") Then
						RegWrite($HKey_AUShell&"\Edit\Command", "", "REG_SZ", '"C:\Program Files\AutoHotkey\SciTE\SciTE.exe" "%1"')
						RegWrite($HKey_AUShell, "", "REG_SZ", "Edit")
					EndIf
				EndIf
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>_ChoixClic

Func _ahkSecureInstall()
	Local $DirInstall = @ScriptDir
	Local $RegLaunch = '"' & $DirInstall & "\" & @ScriptName & '" "%1" %*'
	If FileExists($DirInstall & "\" & @ScriptName) Then
		If RegRead($HKey_AUShell, "") Then
			RegWrite($HKey_AUShell & "\AHKSecure\Command", "", "REG_SZ", $RegLaunch)
			RegWrite($HKey_AUShell, "", "REG_SZ", "AHKSecure")
		EndIf
	Else
		_error("Couldn't install AHKSecure ")
	EndIf
	Exit
EndFunc   ;==>_ahkSecureInstall
#EndRegion ########################################### START Function section ###########################################
