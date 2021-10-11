{*******************************************************************************
 Project   : Stream Player - Reload Edition
 Filename  : Not available
 Date      : 18-04-2008
 Version   : 2.0
 Author    : Maksim V
 URL       : http://www.stream-player.narod.ru
 Copyright : Copyright (c) 2007-2008 Maksim V
*******************************************************************************}

program Player;

uses
  Windows, Messages, CommCtrl, ShellApi, ShlObj, HotKey,
  Bass, BassEnc, TaskBar, MSysUtils, DrawCtrl, MSysIni;

{$I Include\Constants.pas}
{$I Include\CompilerVar.pas}

{$R Resources\Bitmap.res}
{$R Resources\Dialog.res}
{$R Resources\Icon.res}
{$R Resources\Manifest.res}
{$R Resources\String.res}
{$R Resources\Version.res}

{$I Include\LoadSaveFiles.pas}
{$I Include\AppSettings.pas}
{$I Include\PlayRecStream.pas}
{$I Include\CreateMenuItems.pas}
{$I Include\GetStreamInfo.pas}

{$I Dialogs\DIALOG_ACTIONLIST.PAS}
{$I Dialogs\DIALOG_SETTINGS.PAS}
{$I Dialogs\DIALOG_SIDEBAR.PAS}
{$I Dialogs\DIALOG_ABOUTINFO.PAS}
{$I Dialogs\DIALOG_STREAMINFO.PAS}

procedure BassLibraryInit;
begin
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'DataFreq', EmptyStr);
  if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
    begin
      MessageBox(hApp, PChar(LoadStr(STR_LIB_VERSION)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end;
  if (not BASS_Init(-1, IntTxtFrq[StrToInt(CheckParam)], 0, hApp, nil)) then
    begin
      MessageBox(hApp, PChar(LoadStr(STR_LIB_INITIALIZE)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      PostQuitMessage(0);
    end;
  BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1);
  BASS_SetConfig(BASS_CONFIG_NET_PREBUF, 0);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TimeOut', EmptyStr);
  BASS_SetConfig(BASS_CONFIG_NET_TIMEOUT, IntTxtNet[StrToInt(CheckParam)]);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'ConfBuf', EmptyStr);
  BASS_SetConfig(BASS_CONFIG_BUFFER, IntTxtBuf[StrToInt(CheckParam)]);
end;

function MainDlgFunc(hWnd : hWnd; uMsg : DWORD; wParam : wParam; lParam : lParam) : bool; stdcall;
begin
  Result := True;
  case uMsg of
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
    WM_COMMAND :
      begin
        case LoWord(wParam) of
          CTRL_GENERAL_BTNMENU : CreateMenuContextDialog;
          CTRL_GENERAL_BTNONTOP :
            begin
              if (not(IsTopMost(hApp))) then
                begin
                  SetWindowPos(hApp, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW)
                end
              else
                begin
                  SetWindowPos(hApp, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
                end;
            end;
          CTRL_GENERAL_BTNMINZE :
            begin
              if IsWindowVisible(hApp) then
                begin
                  ShowWindow(hApp, SW_MINIMIZE);
                  ShowWindow(hApp, SW_HIDE);
                end
                else
                begin
                  ShowWindow(hApp, SW_SHOW);
                  ShowWindow(hApp, SW_RESTORE);
                  SetForegroundWindow(hApp);
                end;
            end;

          CTRL_GENERAL_BTNCLOSE : SendMessage(hApp, WM_CLOSE, Integer(TRUE), 0);


          IDC_TOOLBAR_ABOUTINFO : DialogBox(hInstance, PChar(RES_DIALOG_ABOUT), hApp, @AboutDlgFunc);
          IDC_TOOLBAR_SETTINGS : DialogBox(hInstance, PChar(RES_DIALOG_SETTINGS), hApp, @SetDlgFunc);
          IDC_TOOLBAR_EQUALIZER : DialogBox(hInstance, PChar(RES_DIALOG_STREAM), hApp, @InfoDlgFunc);
          IDC_TOOLBAR_OPENURL : DialogBox(hInstance, PChar(RES_DIALOG_PLAYURL), hApp, @UrlDlgFunc);
          IDC_TOOLBAR_PLAYSTART : StartPlaySreamRadio;
          IDC_TOOLBAR_PLAYSTOP : StopPlayStreamRadio;
          IDC_TOOLBAR_RECORDSTART : StartRecordStreamRadio;
          IDC_TOOLBAR_RECORDSTOP : StopRecordStreamRadio;
          CTRL_MENU_ABOUTINFO : DialogBox(hInstance, PChar(RES_DIALOG_ABOUT), hApp, @AboutDlgFunc);
          CTRL_MENU_FORUM : ShellExecute(hApp, 'open', 'http://forums.avtograd.ru/index.php?showtopic=11588', nil, nil, SW_SHOWNORMAL);
          CTRL_MENU_MESSAGE : ShellExecute(hApp, 'open', 'http://forums.avtograd.ru/index.php?act=Msg&CODE=4&MID=5059', nil, nil, SW_SHOWNORMAL);
          CTRL_MENU_UPDATE : ShellExecute(hApp, 'open', PChar(GetCurDir + 'updater.exe'), nil, nil, SW_SHOWNORMAL);
          CTRL_MENU_TRAYADDDEL :
            begin
              if IsWindowVisible(hApp) then
                begin
                  ShowWindow(hApp, SW_MINIMIZE);
                  ShowWindow(hApp, SW_HIDE);
                end
                else
                begin
                  ShowWindow(hApp, SW_SHOW);
                  ShowWindow(hApp, SW_RESTORE);
                  SetForegroundWindow(hApp);
                end;
            end;
          CTRL_MENU_EQUALIZER : DialogBox(hInstance, PChar(RES_DIALOG_STREAM), hApp, @InfoDlgFunc);
          CTRL_MENU_SETTINGS : DialogBox(hInstance, PChar(RES_DIALOG_SETTINGS), hApp, @SetDlgFunc);

          CTRL_MENU_CREATESTAT : DialogBox(hInstance, PChar(RES_DIALOG_ADDSTAT), hApp, @AddDlgFunc);
          CTRL_MENU_RENAMESTAT : DialogBox(hInstance, PChar(RES_DIALOG_RENSTAT), hApp, @RenDlgFunc);
          CTRL_MENU_REMOVESTAT : DialogBox(hInstance, PChar(RES_DIALOG_DELSTAT), hApp, @DelDlgFunc);
          CTRL_MENU_RELOADLIST : LoadFileStations;
          CTRL_MENU_URLLINK : DialogBox(hInstance, PChar(RES_DIALOG_PLAYURL), hApp, @UrlDlgFunc);
          CTRL_MENU_STARTPLAY : StartPlaySreamRadio;
          CTRL_MENU_STOPPLAY : StopPlayStreamRadio;
          CTRL_MENU_STARTRECORD : StartRecordStreamRadio;
          CTRL_MENU_STOPRECORD : StopRecordStreamRadio;
          CTRL_MENU_DIRECTORY : StartOpenRecordDirectory;
          CTRL_MENU_EXITAPP : SendMessage(hApp, WM_CLOSE, Integer(True), 0);
          CTRL_MENU_PLAYSTAT :
            begin
              GetMenuString(Menu, CTRL_MENU_PLAYSTAT, buffer1, SizeOf(buffer1), MF_BYCOMMAND);
              MessageBox(hApp,PChar(LoadStr(IDC_STR_MSG_FUT)),PChar(LoadStr(IDC_STR_MSG_INF)),MB_ICONINFORMATION);
            end;
       end;
     end;
    WM_HSCROLL :
      begin
        case LoWord(wParam) of
          TB_BOTTOM, TB_ENDTRACK, TB_LINEDOWN, TB_LINEUP, TB_PAGEDOWN, TB_PAGEUP, TB_THUMBPOSITION, TB_THUMBTRACK, TB_TOP :
            begin
              VolGetRes := Sendmessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_GETPOS, 0, 0);
              BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, Byte(PChar(VolGetRes)));
              SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 2, Integer(PChar(IntToStr(VolGetRes))+'%'));
              SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEVOLUMING), WM_SETTEXT, 0, Integer(PChar(IntToStr(VolGetRes))+'%'));
            end;
        end;
      end;
    WM_CONTEXTMENU :
      begin
        if wParam = hApp then CreateMenuContextDialog;
        if wParam = GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST) then CreateMenuContextListview;
      end;

    {Инициализация всплывающих меню}
    WM_INITMENUPOPUP :
      begin
        // Проверяем некоторые данные для управления активности меню
        IndxList := SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
        if IndxList = -1 then
          begin
            EnableMenuItem(Menu, CTRL_MENU_RENAMESTAT, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
            EnableMenuItem(Menu, CTRL_MENU_REMOVESTAT, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
            EnableMenuItem(Menu, CTRL_MENU_STARTPLAY, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
            end;
        if not(BASS_ChannelIsActive(Stream) = BASS_ACTIVE_PLAYING) then
          begin
            EnableMenuItem(Menu, CTRL_MENU_STOPPLAY, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
            EnableMenuItem(Menu, CTRL_MENU_STARTRECORD, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
            EnableMenuItem(Menu, CTRL_MENU_STOPRECORD, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
          end
          else
          begin
            EnableMenuItem(Menu, CTRL_MENU_STOPPLAY, MF_BYCOMMAND or MF_ENABLED);
            EnableMenuItem(Menu, CTRL_MENU_STARTRECORD, MF_BYCOMMAND or MF_ENABLED);
            EnableMenuItem(Menu, CTRL_MENU_STOPRECORD, MF_BYCOMMAND or MF_ENABLED);
          end;
        if Encoder = 0 then EnableMenuItem(Menu, CTRL_MENU_STOPRECORD, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED);
      end;

    WM_NOTIFY :
      begin
         with PNMHdr(lParam)^ do
           if(code = TTN_NEEDTEXT) then
           begin
             if TipsHwnd = 1 then
               begin
                 case PToolTipText(lParam)^.hdr.idFrom of
                   IDC_TOOLBAR_ABOUTINFO : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_ABOUTINFO));
                   IDC_TOOLBAR_SETTINGS : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_SETTINGS));
                   IDC_TOOLBAR_EQUALIZER : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_ICONTRAY));
                   IDC_TOOLBAR_OPENURL : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_OPENLINK));
                   IDC_TOOLBAR_PLAYSTART : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_PLAYSTART));
                   IDC_TOOLBAR_PLAYSTOP : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_PLAYSTOP));
                   IDC_TOOLBAR_RECORDSTART : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_RECSTART));
                   IDC_TOOLBAR_RECORDSTOP : PToolTipText(lParam)^.lpszText := PChar(LoadStr(STR_TIP_RECSTOP));
                 end;
               end;
             end;
        case PNMToolBar(lParam)^.hdr.code of
          TBN_DROPDOWN : CreateMenuToolbar;
        end;
         if (PNMHdr(lParam).idFrom = CTRL_STATUSBAR_PANEL) then
           begin
             case PNMHdr(lParam)^.code of
               NM_DBLCLK : DialogBox(hInstance, PChar(RES_DIALOG_STREAM), hApp, @InfoDlgFunc);
           end;
           end;
         if (PNMHdr(lParam).idFrom = CTRL_LISTVIEW_PLAYLIST) then
          begin
            case PNMHdr(lParam)^.code of
              LVN_KEYDOWN :
                case PLVKeyDown(lParam)^.wvKey of
                  VK_INSERT : DialogBox(hInstance, PChar(RES_DIALOG_ADDSTAT), hApp, @AddDlgFunc);
                  VK_F2 : DialogBox(hInstance, PChar(RES_DIALOG_RENSTAT), hApp, @RenDlgFunc);
                  VK_F5 : LoadFileStations;
                  VK_DELETE : DialogBox(hInstance, PChar(RES_DIALOG_DELSTAT), hApp, @DelDlgFunc);
                end;
              NM_DBLCLK : StartPlaySreamRadio;
              NM_CUSTOMDRAW :
                begin
                  with PNMLVCUSTOMDRAW(lParam)^ do
                  begin
                    case nmcd.dwDrawStage of
                      CDDS_PREPAINT : SetWindowLong(hApp, DWL_MSGRESULT, CDRF_NOTIFYITEMDRAW);
                      CDDS_ITEMPREPAINT :
                        begin
                          if (nmcd.uItemState and CDIS_FOCUS <> 0) then
                          begin
                            clrText := GetSysColor(COLOR_BTNHILIGHT);
                            clrTextBk := GetSysColor(COLOR_HIGHLIGHT);
                            lvi.stateMask := LVIS_SELECTED;
                            lvi.state := 0;
                            SendMessageW(PNMHdr(lParam).hwndFrom, LVM_SETITEMSTATE, nmcd.dwItemSpec, longint(@lvi));
                            SetWindowLong(hApp, DWL_MSGRESULT, CDRF_NOTIFYPOSTPAINT);
                          end
                          else
                            SetWindowLong(hApp, DWL_MSGRESULT, CDRF_DODEFAULT);
                        end;
                      CDDS_ITEMPOSTPAINT :
                        begin
                          if (nmcd.uItemState and CDIS_FOCUS <> 0) then
                          begin
                            lvi.stateMask := LVIS_SELECTED;
                            lvi.state := $FF;
                            SendMessageW(PNMHdr(lParam).hwndFrom, LVM_SETITEMSTATE, nmcd.dwItemSpec, longint(@lvi));
                            Rect.Left := LVIR_ICON;
                            Rect.Right := LVIR_BOUNDS;
                            if (SendMessageW(PNMHdr(lParam).hwndFrom, LVM_GETITEMRECT, nmcd.dwItemSpec, longint(@Rect)) <> 0)
                              then
                              with Rect do
                              begin
                                inc(left, 1);
                                inc(right, -1);
                                PatBlt(nmcd.hdc, left, top, 1, bottom - top - 1, DSTINVERT);
                                PatBlt(nmcd.hdc, right - 1, top, 1, bottom - top - 1, DSTINVERT);
                                PatBlt(nmcd.hdc, left, top, right - left, 1, DSTINVERT);
                                PatBlt(nmcd.hdc, left, bottom - 2, right - left, 1, DSTINVERT);
                              end;
                            Rect.Left := LVIR_LABEL;
                            if (SendMessageW(PNMHdr(lParam).hwndFrom, LVM_GETITEMRECT, nmcd.dwItemSpec, longint(@Rect)) <> 0)
                              then
                              with Rect do
                              begin
                                DrawGradient(nmcd.hdc, Rect, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_INACTIVECAPTION));
                                SetTextColor(nmcd.hdc, GetSysColor(COLOR_BTNTEXT));
                                PatBlt(nmcd.hdc, left, top, 1, bottom - top - 2, BLACKNESS);
                                PatBlt(nmcd.hdc, right - 1, top, 1, bottom - top - 2, BLACKNESS);
                                PatBlt(nmcd.hdc, left, top, right - left, 1, BLACKNESS);
                                PatBlt(nmcd.hdc, left, bottom - 2, right - left, 1, BLACKNESS);
                                IndxList := SendMessage(PNMHdr(lParam).hwndFrom, LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
                                ListView_GetItemText(PNMHdr(lParam).hwndFrom, IndxList, 0, LstTextDC, sizeof(LstTextDC));
                                Rect.Left := left + 4;
                                Rect.Top := top + 1;
                                Rect.Right := right - 4;
                                DrawText(nmcd.hdc, @LstTextDC[0], - 1, Rect, DT_LEFT or DT_VCENTER);
                              end;
                          end;
                        end;
                    else
                      SetWindowLong(hApp, DWL_MSGRESULT, CDRF_DODEFAULT);
                    end;
                  end;
                end;
            end;
          end;
      end;


    WM_INITDIALOG :
      begin
        hApp := hWnd;
        BassLibraryInit;
        InitializeParameters;
        if not DirectoryExists(GetCurDir + '\' + 'AudioRips') then CreateDir(GetCurDir + '\' + 'AudioRips');

  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositMain', EmptyStr);
  if CheckParam = '1' then
    begin
  PositX := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PosXMain', EmptyStr);
  PositY := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PosYMain', EmptyStr);
  SetWindowPos(hApp, 0, StrToInt(PositX), StrToInt(PositY), 0, 0, SWP_NOSIZE);
  if (PositX = '-32000') or (PositY = '-32000') then
    begin
      GetWindowRect(FindWindow('Shell_TrayWnd', nil), r1);
      GetWindowRect(hApp, r2);
      SetWindowPos(hApp, HWND_NOTOPMOST, (r1.Left + r1.Right) - (r2.Right - r2.Left) - 7, r1.Top - (r2.Bottom - r2.Top) - 7, 0, 0, SWP_NOSIZE);
    end;
    end;


        hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        SendMessage(hApp, WM_SETICON, ICON_SMALL, hIcon);

SendMessage(hApp, WM_SETTEXT, 0, Integer(PChar( SoftwareName )));
SendMessage(GetDlgItem(hApp, CTRL_GENERAL_BANNER), WM_SETTEXT, 0, Integer(PChar( SoftwareName )));


  lvc.mask := LVIF_TEXT or LVIF_IMAGE;
  lvc.pszText := EmptyStr;
  lvc.cx := 157;
  SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_INSERTCOLUMN, 0, Integer(@lvc));
  lvi.mask := LVIF_TEXT;

  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'GridLines', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_LABELTIP or LVS_EX_GRIDLINES)
    else
      SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_LABELTIP);

        SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETRANGE, Integer(TRUE), MAKELONG(0, 100));
        SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETTICFREQ, 5, 0);
        SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETLINESIZE, 0, 5);
        SendMessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_SETPAGESIZE, 0, 5);


  GetClientRect(hApp, Rect);
  PanelWidth[0] := 75;
  PanelWidth[1] := 150;
  PanelWidth[2] := 225;
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETPARTS, 3, Integer(@PanelWidth));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 0, Integer(PChar(FormatTime(0))));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 1, Integer(PChar(FormatTime(0))));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 2, Integer(PChar(IntToStr(VolGetRes))+'%'));
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEVOLUMING), WM_SETTEXT, 0, Integer(PChar(IntToStr(VolGetRes))+'%'));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETICON, 0, LoadImage(hInstance, PChar(RES_ICON_PLAYSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETICON, 1, LoadImage(hInstance, PChar(RES_ICON_RECORDSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT));
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETICON, 2, LoadImage(hInstance, PChar(RES_ICON_VOLUMEING), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT));
GetWindowRect(hApp, Rect);
hRegion := CreateRoundRectRgn(0, 0, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, 6, 6);
        SetWindowRgn(hApp, hRegion, TRUE);
        hFont := CreateFont(11, 0, 0, 0, 600, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), WM_SETFONT, hFont, 0);
LoadFileStations;
        SetFocus(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST));

          HotKey_Register(hApp, IDC_HOTKEY_PLAY_START, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStart'));
          HotKey_Register(hApp, IDC_HOTKEY_PLAY_STOP, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStop'));
          HotKey_Register(hApp, IDC_HOTKEY_REC_START, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStart'));
          HotKey_Register(hApp, IDC_HOTKEY_REC_STOP, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStop'));
          HotKey_Register(hApp, IDC_HOTKEY_DIR_OPEN, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyDirOpen'));
          HotKey_Register(hApp, IDC_HOTKEY_SIDEBAR, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), GetCurDir + 'Settings.ini', 'HotKeys', 'KeySideBar'));

  hImgList := ImageList_Create(16, 16, ILC_COLOR32, 8, 1);
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUABOUT), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUSETTINGS), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUEQUALIZER), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUPLAYURL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUPLAYSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENUPLAYSTOP), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENURECSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_MENURECSTOP), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  tbButtons[0].iBitmap := 0;
  tbButtons[1].iBitmap := 1;
  tbButtons[2].iBitmap := 2;
  tbButtons[3].iBitmap := 3;
  tbButtons[4].iBitmap := 4;
  tbButtons[5].iBitmap := 5;
  tbButtons[6].iBitmap := 6;
  tbButtons[7].iBitmap := 7;
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_BUTTONSTRUCTSIZE, sizeof(TTBBUTTON), 0);
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_BUTTONCOUNT, 0, 0);
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_ADDBUTTONS, 8, Integer(@tbButtons));
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_SETIMAGELIST, 0, hImgList);
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_AUTOSIZE, 0, 0);
  SendMessage(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), TB_SETEXTENDEDSTYLE, 0, TBSTYLE_EX_DRAWDDARROWS or TBSTYLE_EX_MIXEDBUTTONS or BTNS_AUTOSIZE);


  CreateDialog(hInstance, PChar(RES_DIALOG_SIDEBAR), 0, @SideDlgFunc);
  CreateMenuItemsIcons;
  TaskBarAddIcon(hApp, CTRL_USER_TRAYICON, LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS), WM_TRAYICON, PChar( Format(LoadStr(IDC_STR_APP_INFO), [Version]) ));

  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositMove', EmptyStr);
  if CheckParam = '1' then MoveHwnd := 1;

  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Tooltips', EmptyStr);
  if CheckParam = '1' then TipsHwnd := 1;

SetWindowLong(GetDlgItem(hApp, CTRL_PROGRESS_LEFT), GWL_STYLE, GetWindowLong(GetDlgItem(hApp, CTRL_PROGRESS_LEFT), GWL_STYLE));
SetWindowLong(GetDlgItem(hApp, CTRL_PROGRESS_RIGHT), GWL_STYLE, GetWindowLong(GetDlgItem(hApp, CTRL_PROGRESS_RIGHT), GWL_STYLE));
SendMessage(GetDlgItem(hApp, CTRL_PROGRESS_LEFT), PBM_SETRANGE, 0, MakeLong(0, 16384));
SendMessage(GetDlgItem(hApp, CTRL_PROGRESS_RIGHT), PBM_SETRANGE, 0, MakeLong(0, 16384));

        // читаем настройку помещения в автозапуск
        CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'AutoRun', EmptyStr);
        if CheckParam = '1' then SetAutoRun(TRUE, 'Stream Player') else SetAutoRun(FALSE, 'Stream Player');

  SetTimer(hApp, TIMER_DIALOG_SNDMETER, 10, nil);
      end;
    WM_LBUTTONDOWN : SendMessage(hApp, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
    WM_CLOSE, WM_DESTROY :
      begin
        ShowWindow(hBar, SW_HIDE);

        // сохраняем настройку громкости движка
        VolGetRes := Sendmessage(GetDlgItem(hApp, CTRL_TRACKBAR_VOLUME), TBM_GETPOS, 0, 0);
        IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'AudioVol', IntToStr(VolGetRes));

        // сохраняем настройку координат главного окна
        GetWindowRect(hApp, r1);
        GetWindowRect(hBar, r2);
        IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosXMain', IntToStr(r1.Left));
        IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosYMain', IntToStr(r1.Top));
        IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosXSide', IntToStr(r2.Left));
        IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosYSide', IntToStr(r2.Top));

          HotKey_UnRegister(hApp, IDC_HOTKEY_PLAY_START);
          HotKey_UnRegister(hApp, IDC_HOTKEY_PLAY_STOP);
          HotKey_UnRegister(hApp, IDC_HOTKEY_REC_START);
          HotKey_UnRegister(hApp, IDC_HOTKEY_REC_STOP);
          HotKey_UnRegister(hApp, IDC_HOTKEY_DIR_OPEN);
          HotKey_UnRegister(hApp, IDC_HOTKEY_SIDEBAR);
        BASS_Free;

        TaskBarDeleteIcon(hApp, CTRL_USER_TRAYICON);
        KillTimer(hApp, TIMER_DIALOG_SNDMETER);
        PostQuitMessage(0);
      end;

   WM_TRAYICON:
    case wParam of
     CTRL_USER_TRAYICON :
      case lParam of
          WM_LBUTTONDBLCLK :
            begin
              if IsWindowVisible(hApp) then
                begin
                  ShowWindow(hApp, SW_MINIMIZE);
                  ShowWindow(hApp, SW_HIDE);
                end
                else
                begin
                  ShowWindow(hApp, SW_SHOW);
                  ShowWindow(hApp, SW_RESTORE);
                  SetForegroundWindow(hApp);
                end;
            end;
          WM_RBUTTONDOWN : CreateMenuTrayIcon;
      end;
    end;
    WM_MEASUREITEM :
      case PDRAWITEMSTRUCT(lParam).CtlType of
        ODT_MENU :
          begin
            DC := GetDC(hApp);
            lpmis := Pointer(lParam);
            item := Pointer(lpmis.ItemData);
            GetTextExtentPoint32(DC, item.text, StrLen(item.text), size);
            lpmis.itemWidth := size.cx - 18;
            lpmis.itemHeight := 20;
            ReleaseDC(hApp, DC);
          end;
      end;
    WM_DRAWITEM: 
      begin
        case wParam of
        CTRL_GENERAL_REGION : DrawColorButton(lParam, 0, 0, $F3F0F0, 0, $CFC4BE, 8);
        CTRL_GENERAL_BANNER, CTRL_GENERAL_BTNMENU, CTRL_GENERAL_BTNONTOP, CTRL_GENERAL_BTNMINZE, CTRL_GENERAL_BTNCLOSE : DrawColorButton(lParam, 0, 0, $F6F3F3, 0, $DBD3D0, 3);
        end;
        case PDRAWITEMSTRUCT(lParam).CtlType of
          ODT_MENU :
            begin
              lpdis := Pointer(LParam);
              item := Pointer(lpdis.ItemData);
              if (lpdis.itemState and ODS_SELECTED = ODS_SELECTED) then
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_HIGHLIGHT));
                DrawGradient(lpdis.hdc, lpdis.rcItem, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_INACTIVECAPTION));
                PatBlt(lpdis.hDC, lpdis.rcItem.left, lpdis.rcItem.top, 1, lpdis.rcItem.bottom - lpdis.rcItem.top - 1, DSTINVERT);
                PatBlt(lpdis.hDC, lpdis.rcItem.right - 1, lpdis.rcItem.top, 1, lpdis.rcItem.bottom - lpdis.rcItem.top - 1, DSTINVERT);
                PatBlt(lpdis.hDC, lpdis.rcItem.left, lpdis.rcItem.top, lpdis.rcItem.right - lpdis.rcItem.left, 1, DSTINVERT);
                PatBlt(lpdis.hDC, lpdis.rcItem.left, lpdis.rcItem.bottom - 1, lpdis.rcItem.right - lpdis.rcItem.left, 1, DSTINVERT);
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_MENUTEXT));
                DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 4, ((lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2) + 1, item.bmp, 0, 0, 0, 0, DI_NORMAL);
                DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 3, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.bmp, 0, 0, 0, 0, DI_NORMAL);
              end
              else
              begin
                FillRect(lpdis.hDC, lpdis.rcItem, GetSysColorBrush(COLOR_MENU));
                SetTextColor(lpdis.hDC, GetSysColor(COLOR_MENUTEXT));
              end;
              if (lpdis.itemState and ODS_GRAYED) <> 0 then
                begin
                  SetBkMode(lpdis.hDC, TRANSPARENT);
                  SetTextColor(lpdis.hDC, GetSysColor(COLOR_GRAYTEXT));
                end;
              DrawIconEx(lpdis.hDC, lpdis.rcItem.Left + 3, (lpdis.rcItem.Top + lpdis.rcItem.Bottom - 16) div 2, item.bmp, 0, 0, 0, 0, DI_NORMAL);
              lpdis.rcItem.left := lpdis.rcItem.left + 25;
              SetBkMode(lpdis.hDC, TRANSPARENT);
              DrawText(lpdis.hDC, @item.text[0], - 1, lpdis.rcItem, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
            end;
        end;
      end;


    WM_CTLCOLORDLG :
      begin
        lightbrush := CreateBrushIndirect(LightLB);
        SetBkColor(wParam, LightLB.lbColor);
        result := bool(lightbrush);
      end;

    WM_CTLCOLORSTATIC :
    case GetDlgCtrlID(lParam) of
      CTRL_TRACKBAR_VOLUME :
      begin
        graybrush := CreateBrushIndirect(GrayLB);
        SetBkColor(wParam, GrayLB.lbColor);
        result := bool(graybrush);
      end;
    end;


     WM_TIMER :
       case wParam of
         TIMER_DIALOG_SNDMETER :
           begin
             Get_VULevel(LeftBASS, RightBASS);
             SendMessage(GetDlgItem(hApp, CTRL_PROGRESS_LEFT), PBM_SETPOS, LeftBASS, 0);
             SendMessage(GetDlgItem(hApp, CTRL_PROGRESS_RIGHT), PBM_SETPOS, RightBASS, 0);
           end;
       end;

      WM_PLAY_START : StartPlaySreamRadio;
      WM_PLAY_STOP : StopPlayStreamRadio;
      WM_REC_START : StartRecordStreamRadio;
      WM_REC_STOP : StopRecordStreamRadio;
      WM_OPEN_DIR : StartOpenRecordDirectory;
      WM_SHOW_SIDE :
        begin
          if IsWindowVisible(hBar) then
            ShowWindow(hBar, SW_HIDE)
          else
          begin
            ShowWindow(hBar, SW_SHOW);
            SetForegroundWindow(hBar);
          end;
        end;

      WM_HOTKEY :
        case LOWORD(wParam) of
          IDC_HOTKEY_PLAY_START : StartPlaySreamRadio;
          IDC_HOTKEY_PLAY_STOP : StopPlayStreamRadio;
          IDC_HOTKEY_REC_START : StartRecordStreamRadio;
          IDC_HOTKEY_REC_STOP : StopRecordStreamRadio;
          IDC_HOTKEY_DIR_OPEN : StartOpenRecordDirectory;
          IDC_HOTKEY_SIDEBAR :
            begin
              if IsWindowVisible(hBar) then
                ShowWindow(hBar, SW_HIDE)
                else
                begin
                  ShowWindow(hBar, SW_SHOW);
                  SetForegroundWindow(hBar);
                end;
            end;
        end;
  else
    Result := False;
  end;
end;

function SplashDlgProc(hSph : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : LRESULT; stdcall;
begin
  Result := 0;
    case uMsg of
      WM_SYSCOMMAND, WM_COMMAND : Result := 0;
      WM_CLOSE, WM_DESTROY :
        begin
          EndDialog(hSph, 0);
          DialogBox(hInstance, PChar(RES_DIALOG_GENERAL), 0, @MainDlgFunc);
        end;
      WM_CREATE :
        begin
          SplashTimer := SetTimer(hSph, TIMER_DIALOG_SPLASH, 2500, nil);
          SetBlendWindow(hSph, 225);
        end;
      WM_TIMER :
        begin
          KillTimer(hSph, SplashTimer);
          DestroyWindow(hSph);
        end;
      WM_PAINT :
        begin
          SplDC := Beginpaint(hSph, PaintDC);
          hFont := CreateFont(12, 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, 'Tahoma');
          MemDC := CreateCompatibleDC(SplDC);
          OldBmp := SelectObject(MemDC, hBmp);
          StretchBlt(SplDC, 0, 0, SplBmpWidth, SplBmpHeight, MemDC, 0, 0, SplBmpWidth, SplBmpHeight, SRCCOPY);
          SelectObject(MemDC, OldBmp);
          SetBkMode(SplDC, TRANSPARENT);
          GetClientRect(hSph, Rect);
          Rect.Left := Rect.Left + 10;
          Rect.Right := Rect.Right - 10;
          SelectObject(SplDC, hFont);
          SetTextColor(SplDC, ColorText);
          Rect.Top := Rect.Top + 7;
          DrawText(SplDC, PChar(Format(LoadStr(IDC_STR_VER_INFO), [Version, PChar(AlphaVersion)])), - 1, Rect, DT_CENTER);
          SetTextColor(SplDC, ColorText);
          Rect.Top := Rect.Bottom - Rect.Top - 25;
          DrawText(SplDC, PChar(Format(LoadStr(STR_APP_SPLASHSCR), [PChar('Maksim V.')])), - 1, Rect, DT_CENTER);
          DeleteDC(MemDC);
          EndPaint(hSph, PaintDC);
        end;
    else
      Result := DefWindowProc(hSph, uMsg, wParam, lParam);
  end;
end;

procedure StartSplashScreen(Image : Integer; TextColor : COLORREF);
var
  Msg : TMsg;
  Wnd : DWORD;
begin
  SplashWC.lpfnWndProc := @SplashDlgProc;
  SplashWC.hInstance := hInstance;
  SplashWC.hbrBackground := GetStockobject(BLACK_BRUSH);
  SplashWC.hCursor := LoadCursor(hInstance, IDC_ARROW);
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rect, 0);
  ScreenWidth := Rect.Right - Rect.Left;
  ScreenHeight := Rect.Bottom - Rect.Top;
  WindowLeft := (ScreenWidth div 2) - (WindowWidth div 2);
  WindowTop := (ScreenHeight div 2) - (WindowHeight div 2);
  RegisterClassEx(SplashWC);
  ColorText := TextColor;
  hBmp := LoadImage(hInstance, MAKEINTRESOURCE(Image), IMAGE_BITMAP, 0, 0, LR_DEFAULTSIZE);
  Wnd := CreateWindowEx(WS_EX_APPWINDOW or WS_EX_TOPMOST, SplClassName, nil, WS_POPUP, WindowLeft, WindowTop, WindowWidth, WindowHeight, 0, 0, hInstance, nil);
  ShowWindow(Wnd, SW_SHOW);
  HideTaskBarButton(Wnd);
  while True do
  begin
    if not GetMessage(msg, 0, 0, 0) then Break;
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;
  DeleteObject(hBmp);
  hBmp := 0;
end;

{$I Dialogs\DIALOG_LICENSE.PAS}

begin
  InitCommonControls;
  GetCurDir := CutFileName(ParamStr(0));
  if FileExists(GetCurDir + 'License.txt') = FALSE then Exit;
  if FileExists(GetCurDir + 'Settings.ini') = FALSE then CreateSettingsFile;
  if FileExists(GetCurDir + 'Settings.ini') = FALSE then
    begin
      MessageBox(hApp, PChar(LoadStr(STR_INI_INITIALIZE)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end;
  GetVersionInfo(Version);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'OneCopy', EmptyStr);
  if CheckParam = '1' then
    begin
      CreateSemaphore(nil, 0, 1, 'STREAM_PLAYER');
      if (GetLastError = ERROR_ALREADY_EXISTS) then Exit;
    end;
      CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'License', EmptyStr);
        if CheckParam = '1' then
          StartSplashScreen(RES_BITMAP_SPLASHWND, $0040FF40)
          else
          DialogBox(hInstance, PChar(RES_DIALOG_LICENSE), 0, @LicDlgFunc);
  ExitProcess(hInstance);
end.
