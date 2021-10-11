function LicDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
var
  hCloseBtn : Integer;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM :
      case wParam of
        CTRL_BUTTON_LICACCEPT : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_LICDECLINE : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
     WM_INITDIALOG :
       begin
         hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
         SendMessage(hWnd, WM_SETICON, ICON_SMALL, hIcon);
         hCloseBtn := GetSystemMenu(hWnd, False);
         if (hCloseBtn <> 0) then DeleteMenu(hCloseBtn, SC_CLOSE, MF_BYCOMMAND);
         SendMessage(GetDlgItem(hWnd, CTRL_RICHEDIT_LICENSE), WM_SETTEXT, 0, Integer(@GetTextFromFile(GetCurDir + 'License.txt')[1]));
         SetEditWndProc(GetDlgItem(hWnd, CTRL_RICHEDIT_LICENSE), @EditWindowProc);
         SetFocus(GetDlgItem(hWnd, CTRL_BUTTON_LICACCEPT));
         LicenceTimer := SetTimer(hWnd, TIMER_DIALOG_LICENSE, 1000, nil);
         EnableWindow(GetDlgItem(hWnd, CTRL_BUTTON_LICACCEPT), False);
         HideTaskBarButton(hWnd);
       end;
     WM_COMMAND :
       case LoWord(wParam) of
         CTRL_BUTTON_LICDECLINE : EndDialog(hWnd, 0);
         CTRL_BUTTON_LICACCEPT :
           begin
             EndDialog(hWnd, 0);
             IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'License', '1');
             Sleep(1000);
             StartSplashScreen(RES_BITMAP_SPLASHWND, $0040FF40);
           end;
       end;
     WM_TIMER :
       begin
         Dec(SecLicTime);
       if SecLicTime = 0 then
         begin
           KillTimer(hWnd, TIMER_DIALOG_LICENSE);
           EnableWindow(GetDlgItem(hWnd, CTRL_BUTTON_LICACCEPT), True);
         end;
       end;
     WM_DESTROY, WM_CLOSE : PostQuitMessage(0);
 end;
end;
