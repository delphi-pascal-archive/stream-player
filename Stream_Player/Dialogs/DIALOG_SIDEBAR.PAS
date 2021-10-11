function SideDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
var
  tme : TTRACKMOUSEEVENT;
  FuncMouseEvent : function(var EventTrack: TTrackMouseEvent): BOOL; stdcall;
begin
  Result := False;
    case uMsg of
      WM_DRAWITEM :
        case wParam of
          CTRL_STATIC_SIDEICOLOGO : DrawColorButton(lParam, RES_ICON_GENERAL, 32, GetSysColor(COLOR_INACTIVECAPTION), GetSysColor(COLOR_BTNTEXT), GetSysColor(COLOR_HIGHLIGHTTEXT), 1);
        end;
      WM_CTLCOLORDLG : Result := BOOL(GetStockObject(WHITE_BRUSH));
      WM_CTLCOLORSTATIC :
        begin
          case GetDlgCtrlId(lParam) of
            CTRL_STATIC_SIDETXTFIELD, CTRL_STATIC_SIDESTATION, CTRL_STATIC_SIDEICOPLAY, CTRL_STATIC_SIDEPLAYING,
            CTRL_STATIC_SIDEICOREC, CTRL_STATIC_SIDERECORDING, CTRL_STATIC_SIDEICOVOLUME, CTRL_STATIC_SIDEVOLUMING,
            CTRL_STATIC_SIDEICOTIME, CTRL_STATIC_SIDECURTIME :
              begin
                SetBkMode(wParam, TRANSPARENT);
                Result := BOOL(GetStockObject(WHITE_BRUSH));
              end;
          end;
        end;
      WM_CONTEXTMENU : if wParam = hBar then CreateMenuTrayIcon;
      WM_MOUSEHOVER : SetBlendWindow(hBar, 255);
      WM_MOUSELEAVE : SetBlendWindow(hBar, StrToInt(IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', EmptyStr)));
      WM_MOUSEMOVE :
        begin
          tme.cbSize := sizeof(TTRACKMOUSEEVENT);
          tme.dwFlags := TME_HOVER or TME_LEAVE;
          tme.dwHoverTime := 10;
          tme.hwndTrack := hBar;
          @FuncMouseEvent := @TrackMouseEvent;
          FuncMouseEvent(tme);
        end;
    WM_WINDOWPOSCHANGING :
      begin
        if MoveHwnd = 1 then
          begin
            SystemParametersInfo(SPI_GETWORKAREA, 0, @R1, 0);
            WindowPos := Pointer(lParam);
            if WindowPos.x <= R1.Left + StickWindow then
              begin
                WindowPos.x := R1.Left;
                Docked := TRUE;
              end;
            if WindowPos.x + WindowPos.cx >= R1.Right - StickWindow then
              begin
                WindowPos.x := R1.Right - WindowPos.cx;
                Docked := TRUE;
              end;
            if WindowPos.y <= R1.Top + StickWindow Then
              begin
                WindowPos.y := R1.Top;
                Docked := TRUE;
              end;
            if WindowPos.y + WindowPos.cy >= R1.Bottom - StickWindow Then
              begin
               WindowPos.y := R1.Bottom - WindowPos.cy;
                Docked := TRUE;
              end;
            if Docked then
              with R1 do
                begin
                  if WindowPos.x < Left then WindowPos.x := Left;
                  if WindowPos.x + WindowPos.cx > Right then WindowPos.x := Right - WindowPos.cx;
                  if WindowPos.y < Top then WindowPos.y := Top;
                  if WindowPos.y + WindowPos.cy > Bottom then WindowPos.y := Bottom - WindowPos.cy;
                end;
          end;
      end;
       WM_INITDIALOG :
         begin
           hBar := hWnd;
           SetTimer(hBar, TIMER_DIALOG_CLOCK, 50, nil);
           CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositSide', EmptyStr);
           if CheckParam = '1' then
             begin
               PositX := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PosXSide', EmptyStr);
               PositY := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PosYSide', EmptyStr);
               SetWindowPos(hBar, HWND_NOTOPMOST, StrToInt(PositX), StrToInt(PositY), 0, 0, SWP_NOSIZE);
             end
           else
             begin
               GetWindowRect(FindWindow('Shell_TrayWnd', nil), r1);
               GetWindowRect(hBar, r2);
               SetWindowPos(hBar, HWND_NOTOPMOST, (r1.Left + r1.Right) - (r2.Right - r2.Left) - 7, r1.Top - (r2.Bottom - r2.Top) - 7, 0, 0, SWP_NOSIZE);
             end;

           CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'SideOnTop', EmptyStr);
           if CheckParam = '1' then SetWindowPos(hBar, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);


  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositVol', EmptyStr);
  if CheckParam = '1' then
    begin
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'AudioVol', EmptyStr);
  SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETPOS, Integer(TRUE), StrToInt(CheckParam));
  BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, StrToInt(CheckParam));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 2, Integer(PChar(CheckParam)+'%'));
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEVOLUMING), WM_SETTEXT, 0, Integer(PChar(CheckParam)+'%'));
    end
    else
    begin
SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETPOS, Integer(TRUE), 100);
VolGetRes := Sendmessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_GETPOS, 0, 0);
BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, Byte(PChar(VolGetRes)));
SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 2, Integer(PChar(IntToStr(VolGetRes))+'%'));
SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEVOLUMING), WM_SETTEXT, 0, Integer(PChar(IntToStr(VolGetRes))+'%'));
    end;

           hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 32, 32, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEICOLOGO), STM_SETIMAGE, IMAGE_ICON, hIcon);
           hIcon := LoadImage(hInstance, PChar(RES_ICON_PLAYSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEICOPLAY), STM_SETIMAGE, IMAGE_ICON, hIcon);
           hIcon := LoadImage(hInstance, PChar(RES_ICON_RECORDSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEICOREC), STM_SETIMAGE, IMAGE_ICON, hIcon);
           hIcon := LoadImage(hInstance, PChar(RES_ICON_VOLUMEING), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEICOVOLUME), STM_SETIMAGE, IMAGE_ICON, hIcon);
           hIcon := LoadImage(hInstance, PChar(RES_ICON_CURRENTTIME), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEICOTIME), STM_SETIMAGE, IMAGE_ICON, hIcon);

           HideTaskBarButton(hBar);
           SetWindowLong(hBar, GWL_EXSTYLE, GetWindowLong(hBar, GWL_EXSTYLE) or WS_EX_LAYERED);
           SetBlendWindow(hBar, StrToInt(IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', EmptyStr)));
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar( Format(LoadStr(IDC_STR_APP_INFO), [Version]) )));

           CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'EventSide', EmptyStr);
           if CheckParam = '1' then SetWindowLong(hBar, GWL_EXSTYLE, GetWindowLong(hBar, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_TRANSPARENT);

           hFont := CreateFont(11, 0, 0, 0, 600, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
           if hFont <> 0 then
             begin
               SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEPLAYING), WM_SETFONT, hFont, 0);
               SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDERECORDING), WM_SETFONT, hFont, 0);
               SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEVOLUMING), WM_SETFONT, hFont, 0);
               SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDECURTIME), WM_SETFONT, hFont, 0);
             end;

           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEPLAYING), WM_SETTEXT, 0, Integer(PChar(FormatTime(0))));
           SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDERECORDING), WM_SETTEXT, 0, Integer(PChar(FormatTime(0))));

           hFont := CreateFont(13, 0, 0, 0, 600, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
           if hFont <> 0 then SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETFONT, hFont, 0);
         end;
     WM_TIMER :
       case wParam of
         TIMER_DIALOG_CLOCK :
           begin
             GetLocalTime(GetSysTime);
             GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, @GetSysTime, nil, TimeDataBuf, SizeOf(TimeDataBuf));
             lstrcpy(TimeDataBuf, PChar(Format('%.2d:%.2d:%.2d', [GetSysTime.wHour, GetSysTime.wMinute, GetSysTime.wSecond])));
             SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDECURTIME), WM_SETTEXT, 0, Integer(@TimeDataBuf));
           end;
       end;
      WM_LBUTTONDOWN : SendMessage(hBar, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
      WM_DESTROY, WM_CLOSE :
        begin
          EndDialog(hBar, 0);
          KillTimer(hBar, TIMER_DIALOG_CLOCK);
        end;
  end;
end;
