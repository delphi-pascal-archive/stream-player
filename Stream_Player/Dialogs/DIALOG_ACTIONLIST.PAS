function AddDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM:
      Case wParam Of
        CTRL_BUTTON_APPLYADD : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_CANCELADD : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_STATIC_ADDTITLE : DrawColorButton(lParam, RES_ICON_DLGSTATADD, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
    WM_INITDIALOG :
      begin
        hLst := hWnd;
        hFont := CreateFont(13, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then
          begin
            SendMessage(GetDlgItem(hLst, CTRL_STATIC_ADDTITLE), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEADD), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_BUTTON_APPLYADD), WM_SETFONT, hFont, 0);
          end;
        SetFocus(GetDlgItem(hLst, CTRL_BUTTON_APPLYADD));
        SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEADD), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_LST_NEWSTATION))));
        SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKADD), WM_SETTEXT, 0, Integer(PChar(CHECKPOSHTTP)));
      end;
    WM_COMMAND :
      case LoWord(wParam) of
        CTRL_BUTTON_APPLYADD :
          begin
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEADD), WM_GETTEXT, 255, Integer(@buffer2));
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKADD), WM_GETTEXT, 255, Integer(@buffer3));
            if (buffer2 = EmptyStr) or (buffer3 = EmptyStr) or (pos(CHECKPOSHTTP, buffer3) = 0) then
              begin
                MessageBox(hLst, PChar(LoadStr(IDC_STR_MSG_ADD)), PChar(LoadStr(IDC_STR_MSG_INF)), MB_ICONWARNING);
                Exit;
              end;
            if FileExists(GetCurDir + 'Stations.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'Stations.tmp'));
            AssignFile(f, GetCurDir + 'Stations.tmp');
            Rewrite(f);
            WriteLn(f, '[Stations]');
            for i := 0 to SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETITEMCOUNT, 0, 0) - 1 do
            begin
              ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), i, 0, buffer1, SizeOf(buffer1));
              if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
              s := StrPas(buffer1);
              WriteLn(f, PChar(s + '=' + IndexItem));
            end;
            WriteLn(f, PChar(string(buffer2) + '=' + string(buffer3)));
            CloseFile(f);
            DeleteFile(PChar(GetCurDir + 'Stations.dat'));
            RenameFile(PChar(GetCurDir + 'Stations.tmp'), PChar(GetCurDir + 'Stations.dat'));
            Sleep(100);
            SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEALLITEMS, Integer(True), 0);
            LoadFileStations;
            SendMessage(hLst, WM_CLOSE, Integer(True), 0);
          end;
        CTRL_BUTTON_CANCELADD : SendMessage(hLst, WM_CLOSE, Integer(True), 0);
      end;
     WM_LBUTTONDOWN : SendMessage(hLst, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
     WM_DESTROY, WM_CLOSE :
       begin
         DeleteObject(hFont);
         EndDialog(hLst, 0);
       end;
    end;
end;

function RenDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM:
      Case wParam Of
        CTRL_BUTTON_APPLYREN : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_CANCELREN : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_STATIC_RENTITLE : DrawColorButton(lParam, RES_ICON_DLGSTATREN, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
     WM_INITDIALOG :
       begin
        hLst := hWnd;
        hFont := CreateFont(13, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then
          begin
            SendMessage(GetDlgItem(hLst, CTRL_STATIC_RENTITLE), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREN), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_BUTTON_APPLYREN), WM_SETFONT, hFont, 0);
          end;
        SetFocus(GetDlgItem(hLst, CTRL_BUTTON_APPLYREN));
        IndxList := SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
        if IndxList = -1 then
          begin
            Messagebox(hLst, PChar(LoadStr(IDC_STR_MSG_ITM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
            EndDialog(hLst, 0);
            Exit;
          end
          else
          if (IndxList > -1) then
          begin
            ZeroMemory(@buffer1, SizeOf(buffer1));
            ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), IndxList, 0, buffer1, SizeOf(buffer1));
            if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
          end;
          SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREN), WM_SETTEXT, 0, Integer(PChar(@buffer1)));
          SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKREN), WM_SETTEXT, 0, Integer(PChar(IndexItem)));
       end;
    WM_COMMAND :
      case LoWord(wParam) of
        CTRL_BUTTON_APPLYREN :
          begin
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREN), WM_GETTEXT, 255, Integer(@buffer2));
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKREN), WM_GETTEXT, 255, Integer(@buffer3));
            if (buffer2 = EmptyStr) or (buffer3 = EmptyStr) or (pos(CHECKPOSHTTP, buffer3) = 0) then
              begin
                Messagebox(hLst, PChar(LoadStr(IDC_STR_MSG_REN)), PChar(LoadStr(IDC_STR_MSG_INF)), MB_ICONWARNING);
                Exit;
              end;
            SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEITEM, IndxList, 0);
            if FileExists(GetCurDir + 'Stations.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'Stations.tmp'));
            AssignFile(f, GetCurDir + 'Stations.tmp');
            Rewrite(f);
            WriteLn(f, '[Stations]');
            for i := 0 to SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETITEMCOUNT, 0, 0) - 1 do
            begin
              ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), i, 0, buffer1, SizeOf(buffer1));
              if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
              s := StrPas(buffer1);
              WriteLn(f, PChar(s + '=' + IndexItem));
            end;
            WriteLn(f, PChar(string(buffer2) + '=' + string(buffer3)));
            CloseFile(f);
            DeleteFile(PChar(GetCurDir + 'Stations.dat'));
            RenameFile(PChar(GetCurDir + 'Stations.tmp'), PChar(GetCurDir + 'Stations.dat'));
            Sleep(100);
            SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEALLITEMS, Integer(True), 0);
            LoadFileStations;
            SendMessage(hLst, WM_CLOSE, Integer(True), 0);
          end;
        CTRL_BUTTON_CANCELREN : SendMessage(hLst, WM_CLOSE, Integer(True), 0);
      end;
     WM_LBUTTONDOWN : SendMessage(hLst, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
     WM_DESTROY, WM_CLOSE :
       begin
         DeleteObject(hFont);
         EndDialog(hLst, 0);
       end;
    end;
end;

function DelDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM:
      Case wParam Of
        CTRL_BUTTON_APPLYREM : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_CANCELREM : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_STATIC_REMTITLE : DrawColorButton(lParam, RES_ICON_DLGSTATDEL, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
     WM_INITDIALOG :
       begin
        hLst := hWnd;
        hFont := CreateFont(13, 0, 0, 0, 600, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then
          begin
            SendMessage(GetDlgItem(hLst, CTRL_STATIC_REMTITLE), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREM), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_BUTTON_APPLYREM), WM_SETFONT, hFont, 0);
          end;
        SetFocus(GetDlgItem(hLst, CTRL_BUTTON_APPLYREM));
        IndxList := SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
        if IndxList = -1 then
          begin
            Messagebox(hLst, PChar(LoadStr(IDC_STR_MSG_ITM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
            EndDialog(hLst, 0);
            Exit;
          end
          else
          MessageBeep(MB_ICONQUESTION);
          if (IndxList > -1) then
          begin
            ZeroMemory(@buffer1, SizeOf(buffer1));
            ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), IndxList, 0, buffer1, SizeOf(buffer1));
            if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
          end;
          CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'RemvStat', EmptyStr);
          if CheckParam = '1' then
            begin
              SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEITEM, IndxList, 0);
              if FileExists(GetCurDir + 'Stations.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'Stations.tmp'));
              AssignFile(f, GetCurDir + 'Stations.tmp');
              Rewrite(f);
              WriteLn(f, '[Stations]');
              for i := 0 to SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETITEMCOUNT, 0, 0) - 1 do
                begin
                  ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), i, 0, buffer1, SizeOf(buffer1));
                  if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
                  s := StrPas(buffer1);
                  WriteLn(f, PChar(s + '=' + IndexItem));
                end;
              CloseFile(f);
              DeleteFile(PChar(GetCurDir + 'Stations.dat'));
              RenameFile(PChar(GetCurDir + 'Stations.tmp'), PChar(GetCurDir + 'Stations.dat'));
              Sleep(100);
              SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEALLITEMS, Integer(True), 0);
              LoadFileStations;
              EndDialog(hLst, 0);
            end;
          SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREM), WM_SETTEXT, 0, Integer(PChar(@buffer1)));
          SetEditWndProc(GetDlgItem(hLst, CTRL_EDIT_STATNAMEREM), @EditWindowProc);
       end;
    WM_COMMAND :
      case LoWord(wParam) of
        CTRL_BUTTON_APPLYREM :
          begin
            IndxList := SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
                if (IndxList > -1) then
                  begin
                    ZeroMemory(@buffer1, SizeOf(buffer1));
                    ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), IndxList, 0, buffer1, SizeOf(buffer1));
                    if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
                  end;
                SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEITEM, IndxList, 0);
                if FileExists(GetCurDir + 'Stations.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'Stations.tmp'));
                AssignFile(f, GetCurDir + 'Stations.tmp');
                Rewrite(f);
                WriteLn(f, '[Stations]');
                for i := 0 to SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETITEMCOUNT, 0, 0) - 1 do
                begin
                  ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), i, 0, buffer1, SizeOf(buffer1));
                  if(buffer1[0] <> EmptyStr) then IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', buffer1, EmptyStr);
                  s := StrPas(buffer1);
                  WriteLn(f, PChar(s + '=' + IndexItem));
                end;
              CloseFile(f);
              DeleteFile(PChar(GetCurDir + 'Stations.dat'));
              RenameFile(PChar(GetCurDir + 'Stations.tmp'), PChar(GetCurDir + 'Stations.dat'));
              Sleep(100);
              SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEALLITEMS, Integer(True), 0);
              LoadFileStations;
              SendMessage(hLst, WM_CLOSE, Integer(True), 0);
          end;
        CTRL_BUTTON_CANCELREM : SendMessage(hLst, WM_CLOSE, Integer(True), 0);
      end;
     WM_LBUTTONDOWN : SendMessage(hLst, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
     WM_DESTROY, WM_CLOSE :
       begin
         DeleteObject(hFont);
         EndDialog(hLst, 0);
       end;
    end;
end;

function UrlDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : bool; stdcall;
begin
  Result := False;
    case uMsg of
    WM_DRAWITEM:
      Case wParam Of
        CTRL_BUTTON_APPLYURL : DrawColorButton(lParam, RES_ICON_BUTTONYES, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_BUTTON_CANCELURL : DrawColorButton(lParam, RES_ICON_BUTTONNOT, 16,  GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
        CTRL_STATIC_URLTITLE : DrawColorButton(lParam, RES_ICON_DLGSTATURL, 16, GetSysColor(COLOR_BTNHILIGHT), GetSysColor(COLOR_MENUTEXT), GetSysColor(COLOR_INACTIVECAPTION), 1);
      end;
     WM_INITDIALOG :
       begin
        hLst := hWnd;
        hFont := CreateFont(13, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then
          begin
            SendMessage(GetDlgItem(hLst, CTRL_STATIC_URLTITLE), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), WM_SETFONT, hFont, 0);
            SendMessage(GetDlgItem(hLst, CTRL_BUTTON_APPLYURL), WM_SETFONT, hFont, 0);
          end;
        LoadLinksStations;
        SetFocus(GetDlgItem(hLst, CTRL_BUTTON_APPLYURL));
       end;
    WM_COMMAND :
      case LoWord(wParam) of
        CTRL_BUTTON_APPLYURL :
          begin
            SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), WM_GETTEXT, 255, Integer(@buffer3));
            if (buffer3 = EmptyStr) or (pos(CHECKPOSHTTP, buffer3) = 0) then
              begin
                Messagebox(hLst, PChar(LoadStr(IDC_STR_MSG_URL)), PChar(LoadStr(IDC_STR_MSG_INF)), MB_ICONWARNING);
                Exit;
              end;

            IndexItem := buffer3;
            if (CurThread <> 0) then
              begin
                MessageBeep(0);
                CloseHandle(BeginThread(nil, 0, @OpenURL, PChar(IndexItem), 0, ThreadId));
              end
              else
                begin
                  SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), CB_ADDSTRING, 0, Integer(@buffer3));
                  CurThread := BeginThread(nil, 0, @OpenURL, PChar(IndexItem), 0, ThreadId);
                end;
            SendMessage(hLst, WM_CLOSE, Integer(True), 0);
          end;
        CTRL_BUTTON_CANCELURL : SendMessage(hLst, WM_CLOSE, Integer(True), 0);
      end;
     WM_LBUTTONDOWN : SendMessage(hLst, WM_NCLBUTTONDOWN, HTCAPTION, lParam);
     WM_DESTROY, WM_CLOSE :
       begin
         SaveLinksStations;
         DeleteObject(hFont);
         EndDialog(hLst, 0);
       end;
    end;
end;
