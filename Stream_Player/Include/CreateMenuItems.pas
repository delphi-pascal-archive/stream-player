procedure CreateMenuContextDialog;
var
  i : Integer;
begin
  Menu := CreatePopupMenu;
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_ABOUTINFO, @MenuItems[1]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_TRAYADDDEL, @MenuItems[5]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_EQUALIZER, @MenuItems[6]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_CREATESTAT, @MenuItems[8]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_RENAMESTAT, @MenuItems[9]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_REMOVESTAT, @MenuItems[10]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_RELOADLIST, @MenuItems[11]);
  AppendMenu(Menu, MF_SEPARATOR, 0,nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_SETTINGS, @MenuItems[7]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_URLLINK, @MenuItems[13]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STARTPLAY, @MenuItems[14]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STOPPLAY, @MenuItems[15]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STARTRECORD, @MenuItems[16]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STOPRECORD, @MenuItems[17]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_DIRECTORY, @MenuItems[18]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_EXITAPP, @MenuItems[19]);
  SetForegroundWindow(hApp);
  GetCursorPos(pt);
  TrackPopupMenu(Menu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.x, pt.y, 0, hApp, nil);
  PostMessage(hApp, WM_NULL, 0, 0);
  DestroyMenu(Menu);
  for i := 1 to 19 do if MenuItems[i].bmp <> 0 then DeleteObject(MenuItems[i].bmp);
end;

procedure CreateMenuContextListview;
var
  i : Integer;
begin
  Menu := CreatePopupMenu;
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_CREATESTAT, @MenuItems[8]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_RENAMESTAT, @MenuItems[9]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_REMOVESTAT, @MenuItems[10]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_RELOADLIST, @MenuItems[11]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_URLLINK, @MenuItems[13]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STARTPLAY, @MenuItems[14]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STOPPLAY, @MenuItems[15]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STARTRECORD, @MenuItems[16]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_STOPRECORD, @MenuItems[17]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_DIRECTORY, @MenuItems[18]);
  SetForegroundWindow(hApp);
  GetCursorPos(pt);
  TrackPopupMenu(Menu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.x, pt.y, 0, hApp, nil);
  PostMessage(hApp, WM_NULL, 0, 0);
  DestroyMenu(Menu);
  for i := 1 to 19 do if MenuItems[i].bmp <> 0 then DeleteObject(MenuItems[i].bmp);
end;

procedure CreateMenuToolbar;
var
  i : Integer;
begin
  Menu := CreatePopupMenu;
  GetWindowRect(GetDlgItem(hApp, CTRL_TOOLBAR_GENERAL), Rect);
  pt.x := Rect.Left;
  pt.y := Rect.Bottom;
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_ABOUTINFO, @MenuItems[1]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_FORUM, @MenuItems[2]);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_MESSAGE, @MenuItems[3]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_UPDATE, @MenuItems[4]);
  SetForegroundWindow(hApp);
  TrackPopupMenu(Menu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.x, pt.y, 0, hApp, nil);
  PostMessage(hApp, WM_NULL, 0, 0);
  DestroyMenu(Menu);
  for i := 1 to 19 do if MenuItems[i].bmp <> 0 then DeleteObject(MenuItems[i].bmp);
end;

procedure CreateMenuTrayIcon;
var
  i : Integer;
begin
  Menu := CreatePopupMenu;
  if IsWindowEnabled(hAbt) or
    IsWindowEnabled(hStg) or
      IsWindowEnabled(hLst) or
        IsWindowEnabled(hInf) or
          IsWindowEnabled(FindWindow(nil, PChar(LoadStr(IDC_STR_MSG_ERR)))) or
            IsWindowEnabled(FindWindow(nil, PChar(LoadStr(STR_TIP_ICONTRAY))))
              then Exit;
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_ABOUTINFO, @MenuItems[1]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_TRAYADDDEL, @MenuItems[5]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  SubMenu := CreatePopUpMenu();
  if GetPrivateProfileString(PChar('Stations'), nil, nil, buffer3, SizeOf(buffer3), PChar(GetCurDir + 'Stations.dat')) <> 0 then
    begin
      ListStat := buffer3;
      while ListStat^ <> EmptyStr do
        begin
          AppendMenu(SubMenu, MF_STRING, CTRL_MENU_PLAYSTAT, ListStat);
          inc(ListStat, lstrlen(ListStat) + 1);
        end;
    end;
  AppendMenu(Menu, MF_OWNERDRAW or MF_POPUP, SubMenu, @MenuItems[12]);
  DestroyMenu(SubMenu);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_SETTINGS, @MenuItems[7]);
  AppendMenu(Menu, MF_SEPARATOR, 0, nil);
  AppendMenu(Menu, MF_OWNERDRAW, CTRL_MENU_EXITAPP, @MenuItems[19]);
  SetForegroundWindow(hApp);
  GetCursorPos(pt);
  TrackPopupMenu(Menu, TPM_LEFTALIGN or TPM_LEFTBUTTON, pt.x, pt.y, 0, hApp, nil);
  PostMessage(hApp, WM_NULL, 0, 0);
  DestroyMenu(Menu);
  for i := 1 to 19 do if MenuItems[i].bmp <> 0 then DeleteObject(MenuItems[i].bmp);
end;

procedure CreateMenuItemsIcons;
begin
  MenuItems[1].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUABOUT), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[2].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUFORUM), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[3].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUMESSAGE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[4].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUUPDATE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[5].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUTRAYICON), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[6].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUEQUALIZER), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[7].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUSETTINGS), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[8].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUSTATADD), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[9].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUSTATREN), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[10].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUSTATDEL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[11].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUSTATREL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[12].bmp := LoadImage(hInstance, PChar(RES_ICON_STATIONS), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[13].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUPLAYURL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[14].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUPLAYSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[15].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUPLAYSTOP), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[16].bmp := LoadImage(hInstance, PChar(RES_ICON_MENURECSTART), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[17].bmp := LoadImage(hInstance, PChar(RES_ICON_MENURECSTOP), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[18].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUDIRECTORY), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
  MenuItems[19].bmp := LoadImage(hInstance, PChar(RES_ICON_MENUEXITAPP), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
end;
