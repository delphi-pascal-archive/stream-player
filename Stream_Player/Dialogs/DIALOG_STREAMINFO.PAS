function GetInfoStat : Integer;
begin
  SetThreadPriority(ThreadInfo, THREAD_PRIORITY_BELOW_NORMAL);
  while TRUE do
    begin
      if BASS_ChannelIsActive(Stream) = BASS_ACTIVE_PLAYING then
        begin
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_STATINFO), WM_SETTEXT, 0, Integer(PChar( GetItemText(hBar, CTRL_STATIC_SIDESTATION) )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_BITINFO), WM_SETTEXT, 0, Integer(PChar( IntToStr(BASSGetBitRate(Stream)) )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_MODEINFO), WM_SETTEXT, 0, Integer(PChar( BASSGetMode(Stream) )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_FREQINFO), WM_SETTEXT, 0, Integer(PChar( IntToStr(BASSGetFreq(Stream)) )));
          Sleep(250);
        end
      else
        begin
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_STATINFO), WM_SETTEXT, 0, Integer(PChar( EmptyStr )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_BITINFO), WM_SETTEXT, 0, Integer(PChar( EmptyStr )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_MODEINFO), WM_SETTEXT, 0, Integer(PChar( EmptyStr )));
          SendMessage(GetDlgItem(hInf, CTRL_STATIC_FREQINFO), WM_SETTEXT, 0, Integer(PChar( EmptyStr )));
          Sleep(250);
        end;
    end;
end;

function InfoDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : Bool; stdcall;
begin
  Result := False;
  case uMsg of
    WM_DRAWITEM :
      case wParam of
        CTRL_BUTTON_FREQCLOSE : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
    WM_INITDIALOG :
      begin
        hInf := hWnd;
        hIcon := LoadImage(hInstance, PChar(RES_ICON_MENUEQUALIZER), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        SendMessage(hInf, WM_SETICON, ICON_SMALL, hIcon);
        SetFocus(GetDlgItem(hInf, CTRL_BUTTON_FREQCLOSE));
        ThreadInfo := CreateThread(nil, 0, @GetInfoStat, nil, 0, TreadIdInfo);
     end;
    WM_COMMAND :
      begin
        case LoWord(wParam) of
          CTRL_BUTTON_FREQCLOSE : SendMessage(hInf, WM_CLOSE, Integer(True), 0);
        end;
      end;
    WM_CLOSE, WM_DESTROY :
      begin
        DeleteObject(hIcon);
        TerminateThread(ThreadInfo, 0);
        CloseHandle(ThreadInfo);
        EndDialog(hInf, 0);
      end;
  end;
end;