// Получаем информацию о битрейте потока
function BASSGetBitRate(handle : Cardinal) : DWORD;
var
  Lenght1, Lenght2, Lenght3 : Integer;
begin
  Lenght1 := BASS_StreamGetFilePosition(handle, BASS_FILEPOS_END);
  Lenght2 := Round(BASS_ChannelBytes2Seconds(handle, Lenght1));
  Lenght3 := Round(BASS_StreamGetFilePosition(handle, BASS_FILEPOS_END) * 8 / Lenght2 / 10000);
  Result := Lenght3 * 2;
end;

// Получаем информацию о режиме потока
function BASSGetMode(handle : Cardinal) : String;
var
  buf : array[0..255] of Char;
  flags : DWORD;
begin
  flags := BASS_ChannelGetData(handle, @buf, BASS_MUSIC_MONO);
  if (flags and BASS_SAMPLE_MONO) > 0 then
    Result := 'Mono'
  else
    Result := 'Stereo';
end;

// Получаем информацию о частоте потока
function BASSGetFreq(handle : Cardinal) : DWORD;
var
  freq, volume : Cardinal;
  pan : Integer;
begin
  BASS_ChannelGetAttributes(handle, freq, volume, pan);
  Result := freq;
end;
