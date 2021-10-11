procedure CreateSettingsFile;
  begin
  AssignFile(f, GetCurDir + 'Settings.ini');
  Rewrite(f);
  WriteLn(f, '[Options]');
  WriteLn(f, 'License=0');
  WriteLn(f, 'DataFreq=1');
  WriteLn(f, 'TimeOut=2');
  WriteLn(f, 'Percent=5');
  WriteLn(f, 'DirPath=');
  WriteLn(f, 'PositMain=0');
  WriteLn(f, 'PosXMain=0');
  WriteLn(f, 'PosYMain=0');
  WriteLn(f, 'Tooltips=1');
  WriteLn(f, 'OneCopy=1');
  WriteLn(f, 'PositSide=0');
  WriteLn(f, 'PosXSide=0');
  WriteLn(f, 'PosYSide=0');
  WriteLn(f, 'TrnspSide=150');
  WriteLn(f, 'SideOnTop=0');
  WriteLn(f, 'AudioVol=0');
  WriteLn(f, 'PositVol=0');
  WriteLn(f, 'PositMove=0');
  WriteLn(f, 'GridLines=0');
  WriteLn(f, 'AutoRun=0');
  WriteLn(f, 'EventSide=0');
  WriteLn(f, 'RemvStat=0');
  WriteLn(f, 'Bitrate=3');
  WriteLn(f, 'Quality=2');
  WriteLn(f, 'Priority=2');
  WriteLn(f, 'ConfBuf=2');
  WriteLn(f, EmptyStr);
  WriteLn(f, '[HotKeys]');
  WriteLn(f, 'KeyPlayStart=0');
  WriteLn(f, 'KeyPlayStop=0');
  WriteLn(f, 'KeyRecStart=0');
  WriteLn(f, 'KeyRecStop=0');
  WriteLn(f, 'KeyDirOpen=0');
  WriteLn(f, 'KeySideBar=0');
  CloseFile(f);
end;

procedure RestoreSettingsFile;
  begin
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'DataFreq', '1');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'TimeOut', '2');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Percent', '5');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'DirPath', EmptyStr);
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositMain', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosXMain', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosYMain', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Tooltips', '1');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'OneCopy', '1');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositSide', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosXSide', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PosYSide', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', '150');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'SideOnTop', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'AudioVol', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositVol', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositMove', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'GridLines', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'AutoRun', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'RemvStat', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'EventSide', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Bitrate', '3');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Quality', '2');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Priority', '2');
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'ConfBuf', '2');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStart', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStop', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStart', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStop', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeyDirOpen', '0');
  IniWriteString(GetCurDir + 'Settings.ini', 'HotKeys', 'KeySideBar', '0');
end;

procedure InitializeParameters;
begin
// �������������� ���������� ��� ���������� ������� �������������
  StrTxtFrq[0] := Format(LoadStr(STR_ARY_FREQUENCY), ['22000', '22']);
  StrTxtFrq[1] := Format(LoadStr(STR_ARY_FREQUENCY), ['44100', '44,1']);
  StrTxtFrq[2] := Format(LoadStr(STR_ARY_FREQUENCY), ['48000', '48']);
// �������������� ���������� ��� ���������� ������ �����������
  StrTxtNet[0] := Format(LoadStr(STR_ARY_BUFFERTIME), [''+'5'+'']);
  StrTxtNet[1] := Format(LoadStr(STR_ARY_BUFFERTIME), [''+'10'+'']);
  StrTxtNet[2] := Format(LoadStr(STR_ARY_BUFFERTIME), [''+'15'+'']);
  StrTxtNet[3] := Format(LoadStr(STR_ARY_BUFFERTIME), [''+'30'+'']);
  StrTxtNet[4] := Format(LoadStr(STR_ARY_BUFFERTIME), [''+'45'+'']);
// �������������� ���������� ��� ���������� ������� ������
  StrTxtBuf[0] := Format(LoadStr(STR_ARY_MILSEC), ['5000']);
  StrTxtBuf[1] := Format(LoadStr(STR_ARY_MILSEC), ['10000']);
  StrTxtBuf[2] := Format(LoadStr(STR_ARY_MILSEC), ['15000']);
// �������������� ���������� ��� ���������� �������� ������
  StrTxtBit[0] := Format(LoadStr(STR_ARY_BITRATE), ['56']);
  StrTxtBit[1] := Format(LoadStr(STR_ARY_BITRATE), ['96']);
  StrTxtBit[2] := Format(LoadStr(STR_ARY_BITRATE), ['112']);
  StrTxtBit[3] := Format(LoadStr(STR_ARY_BITRATE), ['128']);
  StrTxtBit[4] := Format(LoadStr(STR_ARY_BITRATE), ['160']);
  StrTxtBit[5] := Format(LoadStr(STR_ARY_BITRATE), ['192']);
  StrTxtBit[6] := Format(LoadStr(STR_ARY_BITRATE), ['224']);
  StrTxtBit[7] := Format(LoadStr(STR_ARY_BITRATE), ['256']);
  StrTxtBit[8] := Format(LoadStr(STR_ARY_BITRATE), ['320']);
// �������������� ���������� ��� ���������� �������� ������
  StrTxtQlt[0] := LoadStr(STR_ARY_MP3HIGHEST);
  StrTxtQlt[1] := LoadStr(STR_ARY_MP3RECOMMENDED);
  StrTxtQlt[2] := LoadStr(STR_ARY_MP3DEFAULT);
  StrTxtQlt[3] := LoadStr(STR_ARY_MP3FASTEST);
  StrTxtQlt[4] := LoadStr(STR_ARY_MP3POOREST);
// �������������� ���������� ��� ���������� ���������� �����������
  StrTxtPrt[0] := LoadStr(STR_ARY_PRTIDLE);
  StrTxtPrt[1] := LoadStr(STR_ARY_PRTLOW);
  StrTxtPrt[2] := LoadStr(STR_ARY_PRTNORMAL);
  StrTxtPrt[3] := LoadStr(STR_ARY_PRTHIGH);
  StrTxtPrt[4] := LoadStr(STR_ARY_PRTHIGHEST);
end;

procedure LoadDataSettings;
begin
// ������� ����������� ������� ������ �� �����
  HotKey_UnRegister(hApp, IDC_HOTKEY_PLAY_START);
  HotKey_UnRegister(hApp, IDC_HOTKEY_PLAY_STOP);
  HotKey_UnRegister(hApp, IDC_HOTKEY_REC_START);
  HotKey_UnRegister(hApp, IDC_HOTKEY_REC_STOP);
  HotKey_UnRegister(hApp, IDC_HOTKEY_DIR_OPEN);
  HotKey_UnRegister(hApp, IDC_HOTKEY_SIDEBAR);

// ������ ��������� ������� �������������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'DataFreq', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_FREQUENCY), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_FREQUENCY), CB_SETCURSEL, 1, 0);

// ������ ��������� �������� �����������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TimeOut', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETTIMEOUT), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETTIMEOUT), CB_SETCURSEL, 1, 0);

// ������ ��������� ��������� �����������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Percent', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETPERCENT), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETPERCENT), CB_SETCURSEL, 5, 0);

// ������ ���� � ���������� ���������� ������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'DirPath', EmptyStr);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), WM_SETTEXT, 0, Integer(GetCurDir + 'AudioRips'))
    else SendMessage(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), WM_SETTEXT, 0, Integer(CheckParam));

// ������ ��������� ������� ������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'ConfBuf', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETBUFFER), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETBUFFER), CB_SETCURSEL, 1, 0);

// ������ ��������� ������� �������� �������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositMain', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMAIN), BM_SETCHECK, 1, 0);
// ������ ��������� ����������� ���������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Tooltips', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_BALLONTIPS), BM_SETCHECK, 1, 0);
// ������ ��������� ������� ����� ���������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'OneCopy', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_NUMBERCOPY), BM_SETCHECK, 1, 0);
// ������ ��������� ������� ���������� �������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositSide', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITSIDE), BM_SETCHECK, 1, 0);
// ������ ��������� ������������ ���������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'GridLines', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_GRIDLINES), BM_SETCHECK, 1, 0);
// ������ ��������� ��������� � ����������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'AutoRun', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_AUTORUN), BM_SETCHECK, 1, 0);
// ������ ��������� ������������� ��������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'RemvStat', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_REMSTAT), BM_SETCHECK, 1, 0);
// ������ ��������� ������������ ���������� �������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_SETPOS, Integer(TRUE), StrToInt(CheckParam));
  SendMessage(GetDlgItem(hStg, CTRL_EDIT_TRANSPSIDE), WM_SETTEXT, 0, Integer(PChar(CheckParam)));
// ������ ��������� ����������� ������ ������ ������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'SideOnTop', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_ONTOPSIDE), BM_SETCHECK, 1, 0);
// ������ ��������� ��������� ������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositVol', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_BASSVOLUME), BM_SETCHECK, 1, 0);
// ������ ��������� ���������� ����
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'PositMove', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMOVE), BM_SETCHECK, 1, 0);
// ������ ��������� ����������� ��������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'EventSide', EmptyStr);
  if CheckParam = '1' then SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_TRANSPWIND), BM_SETCHECK, 1, 0);
// ������ ��������� ������� ������
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStart'));
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStop'));
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStart'));
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStop'));
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyDirOpen'));
  HotKey_Set(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), GetIniFileHotKey(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), GetCurDir + 'Settings.ini', 'HotKeys', 'KeySideBar'));

// ������ ��������� �������� ��������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Bitrate', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_BITRATE), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_BITRATE), CB_SETCURSEL, 3, 0);

// ������ ��������� �������� �����������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Quality', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_QUALITY), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_QUALITY), CB_SETCURSEL, 5, 0);

// ������ ��������� ���������� �����������
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Priority', EmptyStr);
  SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_PRIORITY), CB_SETCURSEL, StrToInt(CheckParam), 0);
  if CheckParam = EmptyStr then SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_PRIORITY), CB_SETCURSEL, 2, 0);

end;

procedure SaveDataSettings;
begin
  // ��������� ��������� ������� ������
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStart');
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_PLAY_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyPlayStop');
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_START), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStart');
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_REC_STOP), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyRecStop');
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_DIR_OPEN), GetCurDir + 'Settings.ini', 'HotKeys', 'KeyDirOpen');
  SetIniFileKey(GetDlgItem(hStg, CTRL_HOTKEY_SIDEBAR), GetCurDir + 'Settings.ini', 'HotKeys', 'KeySideBar');

  // ��������� ��������� ������� �������������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_FREQUENCY), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'DataFreq', CheckParam);
    end;

  // ��������� ��������� �������� �����������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETTIMEOUT), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'TimeOut', CheckParam);
    end;

  // ��������� ��������� ��������� �����������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETPERCENT), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Percent', CheckParam);
    end;

  // ��������� ��������� ������� ������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_NETBUFFER), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'ConfBuf', CheckParam);
    end;

  // ��������� ���� � ���������� ���������� ������
  SendMessage(GetDlgItem(hStg, CTRL_EDIT_DIRECTORYPATH), WM_GETTEXT, sizeof(buffer1), Integer(@buffer1));
  CheckParam := buffer1;
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'DirPath', CheckParam);
  // ��������� ��������� ������� �������� �������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMAIN), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositMain', CheckParam);
  // ��������� ��������� ����������� ���������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_BALLONTIPS), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Tooltips', CheckParam);
  if CheckParam = '1' then TipsHwnd := 1 else TipsHwnd := 0;
  // ��������� ��������� ������� ����� ���������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_NUMBERCOPY), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'OneCopy', CheckParam);
  // ��������� ��������� ������� ���������� �������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITSIDE), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositSide', CheckParam);
  // ��������� ��������� ������������ ���������� �������
  SideGetRes := SendMessage(GetDlgItem(hStg, CTRL_TRACKBAR_TRANSPSIDE), TBM_GETPOS, 0, 0);
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'TrnspSide', IntToStr(SideGetRes));
  // ��������� ��������� ����������� ������ ������ ������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_ONTOPSIDE), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'SideOnTop', CheckParam);
  // ��������� ��������� ��������� ������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_BASSVOLUME), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositVol', CheckParam);
  // ��������� ��������� ���������� ����
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_POSITMOVE), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'PositMove', CheckParam);
  if CheckParam = '1' then MoveHwnd := 1 else MoveHwnd := 0;
  // ��������� ��������� ������������ ���������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_GRIDLINES), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'GridLines', CheckParam);
  // ��������� ��������� ��������� � ����������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_AUTORUN), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'AutoRun', CheckParam);
  // ��������� ��������� ������������� ��������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_REMSTAT), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'RemvStat', CheckParam);
  // ��������� ��������� ����������� ��������
  if SendMessage(GetDlgItem(hStg, CTRL_CHECKBOX_TRANSPWIND), BM_GETCHECK, 0, 0) = BST_CHECKED then CheckParam := '1' else CheckParam := '0';
  IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'EventSide', CheckParam);

  // ��������� ��������� �������� ��������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_BITRATE), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Bitrate', CheckParam);
    end;
  // ��������� ��������� �������� �����������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_QUALITY), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Quality', CheckParam);
    end;
  // ��������� ��������� ���������� �����������
  IndxCmbx := SendMessage(GetDlgItem(hStg, CTRL_COMBOBOX_PRIORITY), CB_GETCURSEL, IndxCmbx, 0);
  if(IndxCmbx <> CB_ERR) then
    begin
      CheckParam := IntToStr(IndxCmbx);
      IniWriteString(GetCurDir + 'Settings.ini', 'Options', 'Priority', CheckParam);
    end;

end;
