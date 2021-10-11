unit BallonHint;

interface

uses
  Windows, Messages, CommCtrl;

var
 hTooltip : HWND;
 ti : TToolInfo;

function CreateBaloonToolTips(hHint : HWND) : Boolean;
function AddBaloonToolTip(hHint : HWND; Text : PChar) : Boolean;
procedure DelBaloonToolTip(hHint : HWND);

implementation

function CreateBaloonToolTips(hHint : HWND) : Boolean;
begin
 hToolTip := CreateWindowEx(WS_EX_TOOLWINDOW or WS_EX_TOPMOST, 'Tooltips_Class32', nil, TTS_ALWAYSTIP, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, hHint, 0, hInstance, nil);
  if hToolTip <> 0 then
   begin
    Result := SetWindowPos(hToolTip, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
    ti.cbSize := SizeOf(TToolInfo);
    ti.uFlags := TTF_SUBCLASS;
    ti.hInst := hInstance;
   end else
  Result := False;
end;

function AddBaloonToolTip(hHint : HWND; Text : PChar) : Boolean;
var
 Rect : TRect;
begin
 Result := False;
  if (hHint <> 0) and (GetClientRect(hHint, Rect)) then
   begin
    ti.hwnd := hHint;
    ti.Rect := Rect;
    ti.lpszText := Text;
    Result := Boolean(SendMessage(hToolTip, TTM_ADDTOOL, 0, Integer(@ti)));
   end;
end;

procedure DelBaloonToolTip(hHint : HWND);
var
 Item : HWND;
 Rect : TRect;
begin
 Item := hHint;
 if (Item <> 0) and (GetClientRect(Item, Rect)) then
  begin
   ti.hwnd := hHint;
   SendMessage(hToolTip, TTM_DELTOOL, 0, Integer(@ti));
   DestroyWindow(hToolTip);
 end;
end;

end.