procedure ShowSettingsControls(
Checkbox_PositMain, Checkbox_BallonTips, Checkbox_NumberCopy, Checkbox_BassVolume, Checkbox_PositMove,
Checkbox_GridLines, Checkbox_AutoRun, Checkbox_RemvStat, Static_Frequency, Combobox_Frequency,
Static_NetTimeOut, Combobox_NetTimeOut, Static_NetPercent, Combobox_NetPercent, Static_NetBuffer,
Combobox_NetBuffer, Edit_DirectoryPath, Button_DirectoryPath, Static_DirectoryPath, Checkbox_PositSide,
Static_TranspSide, Edit_TranspSide, Trackbar_TranspSide, Checkbox_OnTopSide, Checkbox_TranspWindow,
Static_PlayStart, Hotkey_PlayStart, Static_PlayStop, Hotkey_PlayStop, Static_RecStart, Hotkey_RecStart,
Static_RecStop, Hotkey_RecStop, Static_DirOpen, Hotkey_DirOpen, Static_SideBar, Hotkey_SideBar,
Static_Bitrate, Combobox_Bitrate, Static_Quality, Combobox_Quality, Static_Priority, Combobox_Priority
: Integer);
begin
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMAIN), Checkbox_PositMain);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_BALLONTIPS), Checkbox_BallonTips);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_NUMBERCOPY), Checkbox_NumberCopy);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_BASSVOLUME), Checkbox_BassVolume);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMOVE), Checkbox_PositMove);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_GRIDLINES), Checkbox_GridLines);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_AUTORUN), Checkbox_AutoRun);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_REMSTAT), Checkbox_RemvStat);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_FREQUENCY), Static_Frequency);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_FREQUENCY), Combobox_Frequency);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_NETTIMEOUT), Static_NetTimeOut);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_NETTIMEOUT), Combobox_NetTimeOut);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_NETPERCENT), Static_NetPercent);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_NETPERCENT), Combobox_NetPercent);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_NETBUFFER), Static_NetBuffer);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_NETBUFFER), Combobox_NetBuffer);
  ShowWindow(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), Edit_DirectoryPath);
  ShowWindow(GetDlgItem(hStg, CTRL_BUTTON_DIRECTORYPATH), Button_DirectoryPath);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_DIRECTORYPATH), Static_DirectoryPath);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_POSITSIDE), Checkbox_PositSide);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_TRANSPSIDE), Static_TranspSide);
  ShowWindow(GetDlgItem(hStg, CTRL_EDIT_TRANSPSIDE), Edit_TranspSide);
  ShowWindow(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), Trackbar_TranspSide);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_ONTOPSIDE), Checkbox_OnTopSide);
  ShowWindow(GetDlgItem(hStg, CTRL_CHECKBOX_TRANSPWIND), Checkbox_TranspWindow);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_PLAY_START), Static_PlayStart);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), Hotkey_PlayStart);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_PLAY_STOP), Static_PlayStop);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), Hotkey_PlayStop);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_REC_START), Static_RecStart);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), Hotkey_RecStart);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_REC_STOP), Static_RecStop);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), Hotkey_RecStop);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_DIR_OPEN), Static_DirOpen);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), Hotkey_DirOpen);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_SIDEBAR), Static_SideBar);
  ShowWindow(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), Hotkey_SideBar);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_BITRATE), Static_Bitrate);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_BITRATE), Combobox_Bitrate);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_QUALITY), Static_Quality);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_QUALITY), Combobox_Quality);
  ShowWindow(GetDlgItem(hStg, CTRL_STATIC_PRIORITY), Static_Priority);
  ShowWindow(GetDlgItem(hStg, CTRL_COMBOBOX_PRIORITY), Combobox_Priority);
end;

function SetDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
var
  i : Integer;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM :
      case wParam of
        CTRL_STATIC_SETNGSINFO : DrawColorButton(lParam, RES_ICON_MENUSETTINGS, 16, GetSysColor(COLOR_INACTIVECAPTION), GetSysColor(COLOR_BTNTEXT), GetSysColor(COLOR_HIGHLIGHTTEXT), 1);
        CTRL_BUTTON_DIRECTORYPATH : DrawColorButton(lParam, RES_ICON_MENUDIRECTORY, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_SETNGSSAVE : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16,  GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_SETNGSREST : DrawColorButton(lParam, RES_ICON_BUTTONREST, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_SETNGSCNSL : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
     WM_INITDIALOG :
       begin
         hStg := hWnd;
         hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
         SendMessage(hStg, WM_SETICON, ICON_SMALL, hIcon);
         hImgList := ImageList_Create(16, 16, ILC_COLOR32, 6, 1);
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETGEN), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETBASS), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETSAVE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETSIDE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETHKEY), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_DLGSETFMP3), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
         SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_SETIMAGELIST, 0, hImgList);
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_GNRL));
         tvinsert.item.iImage := 0;
         tvinsert.item.iSelectedImage := 0;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_BASS));
         tvinsert.item.iImage := 1;
         tvinsert.item.iSelectedImage := 1;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_SAVE));
         tvinsert.item.iImage := 2;
         tvinsert.item.iSelectedImage := 2;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_SIDE));
         tvinsert.item.iImage := 3;
         tvinsert.item.iSelectedImage := 3;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_KEYS));
         tvinsert.item.iImage := 4;
         tvinsert.item.iSelectedImage := 4;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         tvinsert.hParent := nil;
         tvinsert.hInsertAfter := TVI_ROOT;
         tvinsert.item.mask := TVIF_TEXT or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
         tvinsert.item.pszText := PChar(LoadStr(IDC_STR_TW_FMP3));
         tvinsert.item.iImage := 5;
         tvinsert.item.iSelectedImage := 5;
         hParent := SendMessage(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVM_INSERTITEM, 0, Integer(@tvinsert));
         SetTreeViewStyle(GetDlgItem(hStg, CTRL_TREEVIEW_SETTINGS), TVS_SHOWSELALWAYS or TVS_FULLROWSELECT or TVS_DISABLEDRAGDROP or TVS_TRACKSELECT or TVS_SINGLEEXPAND);
         hFont := CreateFont(13, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
         if hFont <> 0 then
           begin
             SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_EDIT_TRANSPSIDE), WM_SETFONT, hFont, 0);
           end;
         hFont := CreateFont(11, 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
         if hFont <> 0 then
           begin
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), WM_SETFONT, hFont, 0);
             SendMessage(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), WM_SETFONT, hFont, 0);
           end;
         for i := low(StrTxtFrq) to high(StrTxtFrq) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_FREQUENCY), CB_ADDSTRING, 0, Integer(StrTxtFrq[i]));
         for i := low(StrTxtNet) to high(StrTxtNet) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETTIMEOUT), CB_ADDSTRING, 0, Integer(StrTxtNet[i]));
         for i := low(StrTxtPrc) to high(StrTxtPrc) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETPERCENT), CB_ADDSTRING, 0, Integer(StrTxtPrc[i]));
         for i := low(StrTxtBuf) to high(StrTxtBuf) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETBUFFER), CB_ADDSTRING, 0, Integer(StrTxtBuf[i]));
         for i := low(StrTxtBit) to high(StrTxtBit) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_BITRATE), CB_ADDSTRING, 0, Integer(StrTxtBit[i]));
         for i := low(StrTxtQlt) to high(StrTxtQlt) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_QUALITY), CB_ADDSTRING, 0, Integer(StrTxtQlt[i]));
         for i := low(StrTxtPrt) to high(StrTxtPrt) do SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_PRIORITY), CB_ADDSTRING, 0, Integer(StrTxtPrt[i]));
         SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_SETRANGE, Integer(TRUE), MAKELONG(0, 255));
         SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_SETTICFREQ, 5, 0);
         SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_SETLINESIZE, 0, 1);
         SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_SETPAGESIZE, 0, 1);
         LoadDataSettings;
         SetEditWndProc(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), @EditWindowProc);
         SetEditWndProc(GetDlgItem(hStg, CTRL_EDIT_TRANSPSIDE), @EditWindowProc);
         SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_GNRL))));
         ShowSettingsControls(SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE,
         SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
         SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
         SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
         SW_HIDE);
       end;
    WM_HSCROLL :
      begin
        case LoWord(wParam) of
          TB_BOTTOM, TB_ENDTRACK, TB_LINEDOWN, TB_LINEUP, TB_PAGEDOWN, TB_PAGEUP, TB_THUMBPOSITION, TB_THUMBTRACK, TB_TOP :
            begin
              SideGetRes := SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_GETPOS, 0, 0);
              SendMessage(GetDlgItem(hStg, CTRL_EDIT_TRANSPSIDE), WM_SETTEXT, 0, Integer(PChar(IntToStr(SideGetRes))));
            end;
        end;
      end;
    WM_NOTIFY :
      case PNMTreeView(lParam)^.hdr.code of
        TVN_SELCHANGING:
          begin
            PNMTreeView(lParam)^.itemNew.mask := TVIF_TEXT;
            PNMTreeView(lParam)^.itemNew.pszText := buffer3;
            PNMTreeView(lParam)^.itemNew.cchTextMax := sizeof(buffer3);
            if (TreeView_GetItem(PNMTreeView(lParam)^.hdr.hwndFrom, PNMTreeView(lParam)^.itemNew)) then SelectTree := PChar(PNMTreeView(lParam)^.itemNew.pszText);
            if SelectTree = PChar(LoadStr(IDC_STR_TW_GNRL)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_GNRL))));
                ShowSettingsControls(SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE);
              end;
            if SelectTree = PChar(LoadStr(IDC_STR_TW_BASS)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_BASS))));
                ShowSettingsControls(SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_SHOW,
                SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE);
              end;
            if SelectTree = PChar(LoadStr(IDC_STR_TW_SAVE)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_SAVE))));
                ShowSettingsControls(SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE);
              end;
            if SelectTree = PChar(LoadStr(IDC_STR_TW_SIDE)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_SIDE))));
                ShowSettingsControls(SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_SHOW,
                SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE);
              end;
            if SelectTree = PChar(LoadStr(IDC_STR_TW_KEYS)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_KEYS))));
                ShowSettingsControls(SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW,
                SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE);
              end;
            if SelectTree = PChar(LoadStr(IDC_STR_TW_FMP3)) then
              begin
                SendMessage(GetDlgItem(hStg, CTRL_STATIC_SETNGSINFO), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_TW_FMP3))));
                ShowSettingsControls(SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE,
                SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_HIDE, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW, SW_SHOW,
                SW_SHOW);
              end;
          end;
    end;
    WM_COMMAND :
      begin
        case LoWord(wParam) of
          CTRL_BUTTON_DIRECTORYPATH :
            begin
              FolderRip := GetFolder(hStg, 0, PChar(LoadStr(STR_DIR_PATHFILE)));
              if FolderRip <> #0 then SendMessage(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), WM_SETTEXT, 0, Integer(@FolderRip[1]));
            end;
          CTRL_BUTTON_SETNGSSAVE :
            begin
              SaveDataSettings;
              SendMessage(hStg, WM_CLOSE, Integer(True), 0);
            end;
          CTRL_BUTTON_SETNGSREST :
            begin
              SendMessage(hStg, WM_CLOSE, Integer(True), 0);
              RestoreSettingsFile;
            end;
          CTRL_BUTTON_SETNGSCNSL : SendMessage(hStg, WM_CLOSE, Integer(True), 0);
      end;
    end;
    WM_DESTROY, WM_CLOSE :
      begin

        // регистрируем горячие клавиши
        HotKey_Register(hApp, IDC_HOTKEY_PLAY_START, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStart'));
        HotKey_Register(hApp, IDC_HOTKEY_PLAY_STOP, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStop'));
        HotKey_Register(hApp, IDC_HOTKEY_REC_START, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStart'));
        HotKey_Register(hApp, IDC_HOTKEY_REC_STOP, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStop'));
        HotKey_Register(hApp, IDC_HOTKEY_DIR_OPEN, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyDirOpen'));
        HotKey_Register(hApp, IDC_HOTKEY_SIDEBAR, GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), GetCurDir + 'Settings.ini', 'HotKeys', 'KeySideBar'));

        DeleteObject(hIcon);
        DeleteObject(hFont);
        ImageList_Destroy(hImgList);
        EndDialog(hStg, 0);

        // читаем настройку уведомлений сайдбара
        CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'EventSide', EmptyStr);
        if CheckParam = '1' then SetWindowLong(hBar, GWL_EXSTYLE, GetWindowLong(hBar, GWL_EXSTYLE) or WS_EX_LAYERED or WS_EX_TRANSPARENT)
          else
            begin
              SetWindowLong(hBar, GWL_EXSTYLE, GetWindowLong(hBar, GWL_STYLE) and not WS_CAPTION);
              SetWindowLong(hBar, GWL_EXSTYLE, GetWindowLong(hBar, GWL_EXSTYLE) or WS_EX_LAYERED);
              SetBlendWindow(hBar, StrToInt(IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', EmptyStr)));
            end;

        // читаем настройку отображения разделителей
        CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'GridLines', EmptyStr);
        if CheckParam = '1' then SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_LABELTIP or LVS_EX_GRIDLINES)
        else SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT or LVS_EX_LABELTIP);

        // читаем настройку помещения в автозапуск
        CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'AutoRun', EmptyStr);
        if CheckParam = '1' then SetAutoRun(TRUE, 'Stream Player') else SetAutoRun(FALSE, 'Stream Player');

        // читаем настройку отображения плавающей панели поверх остальных окон
        CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'SideOnTop', EmptyStr);
        if  CheckParam = '1' then
          begin
            if (not(IsTopMost(hBar))) then
              SetWindowPos(hBar, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
          end
          else
          begin
            if IsTopMost(hBar) then
              SetWindowPos(hBar, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
          end;

      end;
  end;
end;
