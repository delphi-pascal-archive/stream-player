unit HotKey;

interface

uses
  Windows, Messages, MSysIni, MSysUtils;

//Сохранение и получение HotKey из INI-файла
function GetIniFileHotKey(hHotKey: HWND; FileName, Section, Value: String): Word;
procedure SetIniFileKey(hHotKey: HWND; FileName, Section, Value: String);

//Установка сочетания горячих клавиш в элемент "msctls_hotkey32"
procedure HotKey_Set(hHotKey: HWND; wHotKey: Word);
//Получение сочетания горячих клавиш с элемента "msctls_hotkey32"
function HotKey_Get(hHotKey: HWND): Word;

//Регистрация горячей клавишы
function HotKey_Register(hWindow: HWND; HotKeyId: Integer; wHotKey: Word): Boolean;
//Снятие регистрации горячей клавишы
function HotKey_UnRegister(hWindow: HWND; HotKeyId: Integer): Boolean;

function GetModifiers(wHotKey: Word): Cardinal;

const
  HOTKEYF_SHIFT           = $01;
  HOTKEYF_CONTROL         = $02;
  HOTKEYF_ALT             = $04;
  HOTKEYF_EXT             = $08;

  HKCOMB_NONE             = $0001;
  HKCOMB_S                = $0002;
  HKCOMB_C                = $0004;
  HKCOMB_A                = $0008;
  HKCOMB_SC               = $0010;
  HKCOMB_SA               = $0020;
  HKCOMB_CA               = $0040;
  HKCOMB_SCA              = $0080;

const
  HKM_SETHOTKEY = WM_USER + 1;
  HKM_GETHOTKEY = WM_USER + 2;
  HKM_SETRULES  = WM_USER + 3;

type
 WordRec = packed record
  Lo, Hi: Byte;
end;

const
  scShift = $2000;
  scCtrl = $4000;
  scAlt = $8000;
  scNone = 0;

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

type
 TShortCut = Low(Word)..High(Word);

implementation

function GetIniFileHotKey(hHotKey: HWND; FileName, Section, Value: String): Word;
begin
 Result := StrToInt(IniReadString(FileName, Section, Value, #0));
 HotKey_Set(hHotKey, Result);
end;

procedure SetIniFileKey(hHotKey: HWND; FileName, Section, Value: String);
var
 wHotKey: Word;
begin
 wHotKey := HotKey_Get(hHotKey);
 IniWriteString(FileName, Section, Value, IntToStr(wHotKey));
end;

//Установка сочетания горячих клавиш в элемент "msctls_hotkey32"
procedure HotKey_Set(hHotKey: HWND; wHotKey: Word);
begin
 SendMessage(hHotKey, HKM_SETHOTKEY, wHotKey, 0);
end;

//Получение сочетания горячих клавиш с элемента "msctls_hotkey32"
function HotKey_Get(hHotKey: HWND): Word;
begin
 Result := SendMessage(hHotKey, HKM_GETHOTKEY, 0, 0);
end;

type
  TMenuKeyCap = (mkcBkSp, mkcTab, mkcEsc, mkcEnter, mkcSpace, mkcPgUp,
    mkcPgDn, mkcEnd, mkcHome, mkcLeft, mkcUp, mkcRight, mkcDown, mkcIns,
    mkcDel, mkcShift, mkcCtrl, mkcAlt);

var
  MenuKeyCaps: array[TMenuKeyCap] of string = (
    SmkcBkSp, SmkcTab, SmkcEsc, SmkcEnter, SmkcSpace, SmkcPgUp,
    SmkcPgDn, SmkcEnd, SmkcHome, SmkcLeft, SmkcUp, SmkcRight,
    SmkcDown, SmkcIns, SmkcDel, SmkcShift, SmkcCtrl, SmkcAlt);

function GetSpecialName(ShortCut: TShortCut): string;
var
  ScanCode: Integer;
  KeyName: array[0..255] of Char;
begin
  Result := #0;
  ScanCode := MapVirtualKey(WordRec(ShortCut).Lo, 0) shl 16;
  if ScanCode <> 0 then
  begin
    GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
    if (KeyName[1] = #0) and (KeyName[0] <> #0) then
      GetSpecialName := KeyName;
  end;
end;

function InStr(I : Integer) : string;
var
 S : String;
begin
 Str(I, S);
 InStr := S;
end;

function GetModifiers(wHotKey: Word): Cardinal;
begin
 Result := 0;
 if (WordRec(wHotKey).Hi and HOTKEYF_ALT) <> 0 then Result := Result or MOD_ALT;
 if (WordRec(wHotKey).Hi and HOTKEYF_SHIFT) <> 0 then Result := Result or MOD_SHIFT;
 if (WordRec(wHotKey).Hi and HOTKEYF_CONTROL) <> 0 then Result := Result or MOD_CONTROL;
end;

//Регистрация горячей клавишы
function HotKey_Register(hWindow: HWND; HotKeyId: Integer; wHotKey: Word): Boolean;
begin
 Result := RegisterHotKey(hWindow, HotKeyId, GetModifiers(wHotKey), WordRec(wHotKey).Lo);
end;

//Снятие регистрации горячей клавишы
function HotKey_UnRegister(hWindow: HWND; HotKeyId: Integer): Boolean;
begin
 Result := UnRegisterHotKey(hWindow, HotKeyId);
end;

end.