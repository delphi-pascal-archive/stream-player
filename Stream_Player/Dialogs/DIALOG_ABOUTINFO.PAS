function AboutDlgFunc(hWnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : Bool; stdcall;
begin
  Result := False;
  case uMsg of
    WM_CTLCOLORSTATIC:
      begin
        case GetDlgCtrlId(lParam) of
          CTRL_STATIC_ABOUTBANNER, CTRL_STATIC_ABOUTICON, CTRL_STATIC_ABOUTNAME, CTRL_STATIC_ABOUTVERSION : Result := BOOL(GetStockObject(WHITE_BRUSH));
        end;
      end;
    WM_INITDIALOG :
      begin
        hAbt := hWnd;
        hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS);
        SendMessage(hAbt, WM_SETICON, ICON_SMALL, hIcon);
        hIcon := LoadImage(hInstance, PChar(RES_ICON_GENERAL), IMAGE_ICON, 32, 32, LR_DEFAULTSIZE);
        if hIcon <> 0 then SendMessage(GetDlgItem(hAbt, CTRL_STATIC_ABOUTICON), STM_SETIMAGE, IMAGE_ICON, hIcon);
        hIcon := LoadImage(hInstance, PChar(RES_ICON_MENUFORUM), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE);
        if hIcon <> 0 then SendMessage(GetDlgItem(hAbt, CTRL_STATIC_FORUMICON), STM_SETIMAGE, IMAGE_ICON, hIcon);
        hIcon := LoadImage(hInstance, PChar(RES_ICON_MENUMESSAGE), IMAGE_ICON, 16, 16, LR_DEFAULTSIZE);
        if hIcon <> 0 then SendMessage(GetDlgItem(hAbt, CTRL_STATIC_MESSAGEICON), STM_SETIMAGE, IMAGE_ICON, hIcon);
        SendMessage(GetDlgItem(hAbt, CTRL_STATIC_ABOUTVERSION), WM_SETTEXT, 0, Integer(PChar( Format(LoadStr(IDC_STR_VER_INFO), [Version, PChar(AlphaVersion)]) )));
        SendMessage(GetDlgItem(hAbt, CTRL_STATIC_COPYRIGHTS), WM_SETTEXT, 0, Integer(PChar(Format(LoadStr(STR_APP_SPLASHSCR), [PChar('Maksim V.')])) ));
        hFont := CreateFont(16, 0, 0, 0, 800, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, 'Tahoma');
        if hFont <> 0 then SendMessage(GetDlgItem(hAbt, CTRL_STATIC_ABOUTNAME), WM_SETFONT, hFont, 0);
        SetFocus(GetDlgItem(hAbt, CTRL_BUTTON_ABOUTCLOSE));
     end;
    WM_COMMAND :
      begin
        case LoWord(wParam) of
          CTRL_BUTTON_ABOUTCLOSE : SendMessage(hAbt, WM_CLOSE, Integer(True), 0);
        end;
      end;
    WM_CLOSE, WM_DESTROY :
      begin
        DeleteObject(hIcon);
        DeleteObject(hFont);
        EndDialog(hAbt, 0);
      end;
  end;
end;