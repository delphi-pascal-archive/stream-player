procedure ResultTimerPlay;
begin
  TickDifPlay := GetTickCount - TickStartPlay;
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 0, Integer(PChar(FormatTime(TickDifPlay))));
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDEPLAYING), WM_SETTEXT, 0, Integer(PChar(FormatTime(TickDifPlay))));
end;

procedure ResultTimerRecord;
begin
  TickDifRec := GetTickCount - TickStartRec;
  SendMessage(GetDlgItem(hApp, CTRL_STATUSBAR_PANEL), SB_SETTEXT, 1, Integer(PChar(FormatTime(TickDifRec))));
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDERECORDING), WM_SETTEXT, 0, Integer(PChar(FormatTime(TickDifRec))));
end;

procedure StatProc(buffer : Pointer; len, user : DWORD); stdcall;
begin
  if (buffer <> nil) and (len = 0) then SendMessage(hApp, WM_COMMAND, 99, DWORD(PChar(buffer)));
end;

function GetQualityRec(Get : Integer) : string;
begin
  case (Get) of
    0 : Result := '0';
    1 : Result := '2';
    2 : Result := '5';
    3 : Result := '7';
    4 : Result := '9';
    else
      Result := '5';
  end;
end;

procedure StartRecordStreamRadio;
var
  CommandLine, FileData, FileTime, Bitrate, Quality, Priority, FileName : String;
begin
  if Stream = 0 then
    begin
      MessageBox(hApp, PChar(LoadStr(IDC_STR_MSG_STM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end;
  if not DirectoryExists(GetCurDir + '\' + 'AudioRips') then CreateDir(GetCurDir + '\' + 'AudioRips');  TickStartRec := GetTickCount;
  ResultTimerRecord;
  SetTimer(hApp, TIMER_DIALOG_RECORD, 1000, @ResultTimerRecord);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'DirPath', EmptyStr);
  if (String(CheckParam) = EmptyStr) then CheckParam := PChar(GetCurDir + '\' + 'AudioRips') else CheckParam := PChar(CheckParam);
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_GETTEXT, 255, Integer(@buffer1));
  GetDateFormat(LOCALE_USER_DEFAULT, 0, nil, nil, TimeDataBuf, sizeof(TimeDataBuf));
  lstrcpy(TimeDataBuf, PChar(Format('%.2d.%.2d.%.2d', [GetSysTime.wDay, GetSysTime.wMonth, GetSysTime.wYear])));
  FileData := TimeDataBuf;
  GetLocalTime(GetSysTime);
  GetTimeFormat(LOCALE_USER_DEFAULT, TIME_FORCE24HOURFORMAT, @GetSysTime, nil, TimeDataBuf, sizeof(TimeDataBuf));
  lstrcpy(TimeDataBuf, PChar(Format('%.2d.%.2d.%.2d', [GetSysTime.wHour, GetSysTime.wMinute, GetSysTime.wSecond])));
  FileTime := TimeDataBuf;
  FileName := Format(PChar(CheckParam + '\' + 'AudioFile_%s_%s.mp3'), [FileData, FileTime]);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Quality', EmptyStr);
  Quality := GetQualityRec(IntTxtQlt[StrToInt(CheckParam)]);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Bitrate', EmptyStr);
  Bitrate := IntToStr(IntTxtBit[StrToInt(CheckParam)]);
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Priority', EmptyStr);
  Priority := IntToStr(IntTxtPrt[StrToInt(CheckParam)]);
  CommandLine := Format('Lame.exe -b %s -q%s --priority %s - "%s"', [Bitrate, Quality, Priority, FileName]);
  Encoder := BASS_Encode_Start(Stream, PChar(CommandLine), BASS_ENCODE_AUTOFREE, nil, 0);
end;

procedure StopRecordStreamRadio;
begin
  if (Stream = 0) or (Encoder = 0) then
    begin
      MessageBox(hApp, PChar(LoadStr(IDC_STR_MSG_STM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end;
  TickStartRec := GetTickCount;
  ResultTimerRecord;
  KillTimer(hApp, TIMER_DIALOG_RECORD);
  BASS_Encode_Stop(Stream);
  Encoder := 0;
end;

procedure StopPlayStreamRadio;
begin
  if Stream = 0 then
    begin
      MessageBox(hApp, PChar(LoadStr(IDC_STR_MSG_STM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end;
  BASS_StreamFree(Stream);
  TickStartPlay := GetTickCount;
  ResultTimerPlay;
  KillTimer(hApp, TIMER_DIALOG_PLAY);
  TickStartRec := GetTickCount;
  ResultTimerRecord;
  KillTimer(hApp, TIMER_DIALOG_RECORD);
  BASS_Encode_Stop(Stream);
  Encoder := 0;
  Stream := 0;
end;

procedure Get_VULevel(var L, R : Integer);
var
  VUCH : DWORD;
  L_VU, R_VU : Integer;
begin 
  VUCH := BASS_ChannelGetLevel(Stream);
  L_VU := LOWORD(VUCH);
  R_VU := HIWORD(VUCH);
  if (BASS_ChannelIsActive(Stream) = BASS_ACTIVE_PLAYING) then
   begin 
    L := L_VU;
    R := R_VU;
   end
   else
  begin 
    L := 0;
    R := 0;
  end; 
end;

function OpenURL(URL : PChar) : Integer;
begin
  Result := 0;
  if BASS_ChannelIsActive(Stream) = BASS_ACTIVE_PLAYING then
    begin
      BASS_StreamFree(Stream);
      TickStartPlay := GetTickCount;
      ResultTimerPlay;
      KillTimer(hApp, TIMER_DIALOG_PLAY);
      TickStartRec := GetTickCount;
      ResultTimerRecord;
      KillTimer(hApp, TIMER_DIALOG_RECORD);
      BASS_Encode_Stop(Stream);
      Encoder := 0;
      Stream := 0;
    end;
  BuffProgr := 0;
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Percent', EmptyStr);
  SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_URL_CONNECTING))));
  Stream := BASS_StreamCreateURL(url, 0, BASS_STREAM_STATUS or BASS_STREAM_AUTOFREE, @StatProc, 0);
  if (Stream = 0) then
    begin
      SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar(LoadStr(IDC_STR_MSG_ERR))));
      BASS_ChannelPlay(Stream, FALSE);
      Exit;
    end
    else
    begin
      CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'Percent', EmptyStr);
    repeat
      Lenght := BASS_StreamGetFilePosition(Stream, BASS_FILEPOS_END);
      if (Lenght = DW_Error) then Break;
      CurrProgr := (BASS_StreamGetFilePosition(Stream, BASS_FILEPOS_DOWNLOAD) - BASS_StreamGetFilePosition(Stream, BASS_FILEPOS_CURRENT)) * 100 div Lenght;
      if (CurrProgr <> BuffProgr) then
        begin
          BuffProgr := CurrProgr;
          SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar(Format(LoadStr(STR_URL_BUFFERING), [BuffProgr]))));
        end;
      until
      BuffProgr > IntTxtPrc[StrToInt(CheckParam)];
      BASS_ChannelPlay(Stream, FALSE);
      SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar(LoadStr(STR_URL_PLAYING))));
      SendMessage(GetDlgItem(hBar, CTRL_STATIC_SIDESTATION), WM_SETTEXT, 0, Integer(PChar(@buffer1)));
      TickStartPlay := GetTickCount;
      ResultTimerPlay;
      SetTimer(hApp, TIMER_DIALOG_PLAY, 1000, @ResultTimerPlay);
  end;
  CurThread := 0;
end;

procedure StartPlaySreamRadio;
begin
  IndxList := SendMessage(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), LVM_GETNEXTITEM, -1 , LVNI_FOCUSED);
  if IndxList = -1 then
    begin
      MessageBox(hApp, PChar(LoadStr(IDC_STR_MSG_STM)), PChar(LoadStr(IDC_STR_MSG_ERR)), MB_ICONSTOP);
      Exit;
    end
  else
  if(IndxList > -1) then
    begin
      ZeroMemory(@buffer1, SizeOf(buffer1));
      ListView_GetItemText(GetDlgItem(hApp, CTRL_LISTVIEW_PLAYLIST), IndxList, 0, buffer1, SizeOf(buffer1));
      if(buffer1[0] <> EmptyStr) then
      begin
        IndexItem := buffer1;
        IndexItem := IniReadString(GetCurDir + 'Stations.dat', 'Stations', IndexItem, EmptyStr);
        if (CurThread <> 0) then
          begin
            MessageBeep(0);
            CloseHandle(BeginThread(nil, 0, @OpenURL, PChar(IndexItem), 0, ThreadId));
          end
          else
            CurThread := BeginThread(nil, 0, @OpenURL, PChar(IndexItem), 0, ThreadId);
      end;
    end;
end;

procedure StartOpenRecordDirectory;
begin
  CheckParam := IniReadString(GetCurDir + 'Settings.ini', 'Options', 'DirPath', EmptyStr);
  if CheckParam = EmptyStr then
    ShellExecute(hApp, 'open', PChar(CheckParam + '\' + 'AudioRips'), nil, nil, SW_SHOWNORMAL)
    else
    ShellExecute(hApp, 'open', PChar(CheckParam), nil, nil, SW_SHOWNORMAL);
end;
