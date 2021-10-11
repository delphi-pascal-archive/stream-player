unit TaskBar;

interface

uses 
 Windows;

//Добавление значка в Tray
//TaskBarAddIcon(Handle, 123, LoadIcon(hInstance, 'MAINICON'), 22, 'Текст подсказки');
function TaskBarAddIcon(
  hWindow: HWND;             // окно, создавшее значок
  ID: Cardinal;              // идентификатор значка
  ICON: hIcon;               // иконка
  CallbackMessage: Cardinal; // сообщение, которое будет посылаться окну
  Tip: PChar                 // ToolTip
): Boolean;

//Изменение значка в Tray
function TaskBarModifyIcon(hWindow: HWND; ID: Cardinal; Flags: Cardinal; ICON: hIcon; Tip: PChar): Boolean;
//Удаление значка из Tray
function TaskBarDeleteIcon(hWindow: HWND; ID: Integer): Boolean;

type
  PNotifyIconDataA = ^TNotifyIconDataA;
  PNotifyIconDataW = ^TNotifyIconDataW;
  PNotifyIconData = PNotifyIconDataA;
  TNotifyIconDataA = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..63] of AnsiChar;
  end;
  TNotifyIconDataW = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..63] of WideChar;
  end;
  TNotifyIconData = TNotifyIconDataA;

const
  NIM_ADD         = $00000000;
  NIM_MODIFY      = $00000001;
  NIM_DELETE      = $00000002;

  NIF_MESSAGE     = $00000001;
  NIF_ICON        = $00000002;
  NIF_TIP         = $00000004;

function Shell_NotifyIconA(dwMessage: DWORD; lpData: PNotifyIconDataA): BOOL; stdcall;
function Shell_NotifyIconW(dwMessage: DWORD; lpData: PNotifyIconDataW): BOOL; stdcall;
function Shell_NotifyIcon(dwMessage: DWORD; lpData: PNotifyIconData): BOOL; stdcall;

implementation

function Shell_NotifyIconA; external 'shell32.dll' name 'Shell_NotifyIconA';
function Shell_NotifyIconW; external 'shell32.dll' name 'Shell_NotifyIconW';
function Shell_NotifyIcon; external 'shell32.dll' name 'Shell_NotifyIconA';

function TaskBarAddIcon(hWindow: HWND; ID: Cardinal; ICON: hIcon;
 CallbackMessage: Cardinal; Tip: PChar): Boolean;
var
  NID: TNotifyIconData;
begin
  FillChar(NID, SizeOf(TNotifyIconData), 0);
  with NID do begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd   := hWindow;
    uID    := ID;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    uCallbackMessage := CallbackMessage;
    hIcon  := Icon;
    lstrcpyn(szTip, Tip, SizeOf(szTip));
  end;
  Result := Shell_NotifyIcon(NIM_ADD, @NID);
end;

function TaskBarModifyIcon(hWindow: HWND; ID: Cardinal; Flags: Cardinal;
 ICON: hIcon; Tip: PChar): Boolean;
var
  NID: TNotifyIconData;
begin
  FillChar(NID, SizeOf(TNotifyIconData), 0);
  with NID do begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd    := hWindow;
    uID    := ID;
    uFlags := Flags;
    hIcon  := Icon;
    lstrcpyn(szTip, Tip, SizeOf(szTip));
  end;
  Result := Shell_NotifyIcon(NIM_MODIFY, @NID);
end;

function TaskBarDeleteIcon(hWindow: HWND; ID: Integer): Boolean;
var
  NID: TNotifyIconData;
begin
  FillChar(NID, SizeOf(TNotifyIconData), 0);
  with NID do begin
    cbSize := SizeOf(TNotifyIconData);
    Wnd    := hWindow;
    uID    := ID;
  end;
  Result := Shell_NotifyIcon(NIM_DELETE, @NID);
end;

end.
