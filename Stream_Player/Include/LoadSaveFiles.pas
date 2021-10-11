procedure LoadFileStations;
var
  buflist : array [0..4096] of Char;
begin
  SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_DELETEALLITEMS, Integer(True), 0);
  SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), WM_SETREDRAW, Integer(False), 0);
  hImgList := ImageList_Create(16, 16, ILC_COLOR32, 1, 1);
  ImageList_AddIcon(hImgList, LoadImage(hInstance, PChar(RES_ICON_STATIONS), IMAGE_ICON, 32, 32, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS));
  if GetPrivateProfileString(PChar('Stations'), nil, nil, buflist, SizeOf(buflist), PChar(GetCurDir + 'Stations.dat')) <> 0 then
  begin
    ListStat := buflist;
    while ListStat^ <> EmptyStr do
      begin
        lvi.pszText := ListStat;
        lvi.iSubItem := 0;
        SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_INSERTITEM, Integer(True), Integer(@lvi));
        SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_SETIMAGELIST, LVSIL_SMALL, hImgList);
        inc(ListStat, lstrlen(ListStat) + 1);
      end;
  end;
  SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), WM_SETREDRAW, Integer(True), 0);
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 3, Integer(PChar( IntToStr(ListView_GetItemCount(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST))) )));
end;

procedure SaveFileStations;
var
  i : Integer;
begin
  if FileExists(GetCurDir + 'Stations.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'Stations.tmp'));
  AssignFile(f, GetCurDir + 'Stations.tmp');
  Rewrite(f);
  WriteLn(f, '[Stations]');
  for i := 0 to SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETITEMCOUNT, 0, 0) - 1 do
  begin
    ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), i, 0, buffer1, SizeOf(buffer1));
    if(buffer1[0] <> EmptyStr) then
      begin
        IndexItem := buffer1;
        IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', IndexItem, EmptyStr);
      end;
    s := StrPas(buffer1);
    WriteLn(f, PChar(s + '=' + IndexItem));
  end;
  CloseFile(f);
  DeleteFile(PChar(GetCurDir + 'Stations.dat'));
  RenameFile(PChar(GetCurDir + 'Stations.tmp'), PChar(GetCurDir + 'Stations.dat'));
end;

procedure LoadLinksStations;
begin
  if FileExists(GetCurDir + 'LinkURL.dat') = TRUE then
  begin
    AssignFile(f, GetCurDir + 'LinkURL.dat');
    Reset(f);
    while not EOF(f) do
    begin
      ReadLn(f, s);
      SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), CB_ADDSTRING, 0, Integer(@s[1]));
    end;
    CloseFile(f);
  end;
  SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), CB_DELETESTRING, 0, 0)
end;

procedure SaveLinksStations;
var
  i : Integer;
begin
  if FileExists(GetCurDir + 'LinkURL.tmp') = TRUE then DeleteFile(PChar(GetCurDir + 'LinkURL.tmp'));
  AssignFile(f, GetCurDir + 'LinkURL.tmp');
  Rewrite(f);
  WriteLn(f, '[Stations]');
  for i := 0 to SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), CB_GETCOUNT, 0, 0) - 1 do
  begin
    SendMessage(GetDlgItem(hLst, CTRL_EDIT_STATLINKURL), CB_GETLBTEXT, i, Integer(@buffer1));
    s := StrPas(buffer1);
    WriteLn(f, s);
  end;
  CloseFile(f);
  DeleteFile(PChar(GetCurDir + 'LinkURL.dat'));
  RenameFile(PChar(GetCurDir + 'LinkURL.tmp'), PChar(GetCurDir + 'LinkURL.dat'));
end;
