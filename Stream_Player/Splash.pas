unit Splash;

interface

uses
 Windows;

procedure StartSplashScreen(Image : Integer; TextColor : COLORREF);

const
  SplashVersion    = 'Версия : 2.0.0.0';
  SplashCopyright  = 'Авторские права (c) 2007-2008 Explorer';
  ClassName        = 'SplashWndClass';
  WindowWidth      : integer = 240;
  WindowHeight     : integer = 150;
  SplBmpWidth      = 240;
  SplBmpHeight     = 150;
  IDC_SPLASH_TIMER = 101;
  FontName         = 'Tahoma';

var
  WindRect : TRect;
  BMP, ScreenHeight, ScreenWidth, WindowLeft, WindowTop, SplashTimer : Integer;
  SplashWC : TWndClassEx = (cbSize : SizeOf(TWndClassEx); style : CS_HREDRAW or CS_VREDRAW; cbClsExtra : 0; cbWndExtra : 0; hIcon : 0; lpszMenuName : nil; lpszClassName : ClassName; hIconSm : 0);
  OldBmp, SplDC, MemDC : HDC;
  PaintDC : TPaintStruct;
  TextFont : hFont;
  ColorText : COLORREF;

implementation

function SplashDlgProc(hSph : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : LRESULT; stdcall;
begin
  Result := 0;
    case uMsg of
      WM_SYSCOMMAND, WM_COMMAND : Result := 0;
      WM_CLOSE, WM_DESTROY : PostQuitMessage(GetLastError);
      WM_CREATE :
        begin
          SplashTimer := SetTimer(hSph, IDC_SPLASH_TIMER, 1500, nil);
          SetBlendWindow(hSph, 225);
        end;
      WM_TIMER :
        begin
          KillTimer(hSph, SplashTimer);
          DestroyWindow(hSph);
        end;
      WM_PAINT :
        begin
          SplDC := Beginpaint(hSph, PaintDC);
          TextFont := CreateFont(12, 0, 0, 0, 400, 0, 0, 0, RUSSIAN_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, FontName);
          MemDC := CreateCompatibleDC(SplDC);
          OldBmp := SelectObject(MemDC, BMP);
          StretchBlt(SplDC, 0, 0, SplBmpWidth, SplBmpHeight, MemDC, 0, 0, SplBmpWidth, SplBmpHeight, SRCCOPY);
          SelectObject(MemDC, OldBmp);
          SetBkMode(SplDC, TRANSPARENT);
          GetClientRect(hSph, WindRect);
          WindRect.Left := WindRect.Left + 10;
          WindRect.Right := WindRect.Right - 10;
          SelectObject(SplDC, TextFont);
          SetTextColor(SplDC, ColorText);
          WindRect.Top := WindRect.Top + 10;
          DrawText(SplDC, PChar(SplashVersion), - 1, WindRect, DT_SINGLELINE or DT_RIGHT);
          SetTextColor(SplDC, ColorText);
          WindRect.Top := WindRect.Bottom - WindRect.Top - 10;
          DrawText(SplDC, PChar(SplashCopyright), - 1, WindRect, DT_SINGLELINE or DT_CENTER);
          DeleteDC(MemDC);
          EndPaint(hSph, PaintDC);
        end;
    else
      Result := DefWindowProc(hSph, uMsg, wParam, lParam);
  end;
end;

procedure StartSplashScreen(Image : Integer; TextColor : COLORREF);
var
  Msg : TMsg;
  Wnd : DWORD;
begin
  SplashWC.lpfnWndProc := @SplashDlgProc;
  SplashWC.hInstance := hInstance;
  SplashWC.hbrBackground := GetStockobject(BLACK_BRUSH);
  SplashWC.hCursor := LoadCursor(hInstance, IDC_ARROW);
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WindRect, 0);
  ScreenWidth := WindRect.Right - WindRect.Left;
  ScreenHeight := WindRect.Bottom - WindRect.Top;
  WindowLeft := (ScreenWidth div 2) - (WindowWidth div 2);
  WindowTop := (ScreenHeight div 2) - (WindowHeight div 2);
  RegisterClassEx(SplashWC);
  ColorText := TextColor;
  BMP := LoadBitmap(hInstance, MAKEINTRESOURCE(Image));
  Wnd := CreateWindowEx(WS_EX_APPWINDOW or WS_EX_TOPMOST, ClassName, nil, WS_POPUP, WindowLeft, WindowTop, WindowWidth, WindowHeight, 0, 0, hInstance, nil);
  Showwindow(Wnd, SW_SHOW);
  while True do
  begin
    if not GetMessage(msg, 0, 0, 0) then Break;
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;
  DeleteObject(BMP);
  BMP := 0;
end;

end.
