unit DrawCtrl;

interface

uses 
 Windows, Messages;

function SetColorBrightness(SCBColor : COLORREF; SCBVal : Integer) : COLORREF;
procedure DrawColorButton(dblParam : LPARAM; BtnIco, IcoSize : Integer; BtnColor : COLORREF; BtnTextColor : COLORREF; BtnGradientColor : COLORREF = 0; Round : Byte = 0);
procedure DrawGradient(shdc : HDC; srect : TRect; clStart, clEnd : COLORREF);

implementation

function SetColorBrightness(SCBColor : COLORREF; SCBVal : Integer) : COLORREF;
var
  SC_B, SC_G, SC_R, SC_A : Integer;
  function CalcCVal(CVal : Integer) : Integer;
    begin
      result := (CVal * SCBVal) div 100;
      If (result > $FF) then
        result := $FF
      else
      If (result < $00) then
        result := $00;
    end;
begin
  SC_R := (SCBColor) and $FF;
  SC_G := (SCBColor shr  8) and $FF;
  SC_B := (SCBColor shr 16) and $FF;
  SC_A := (SCBColor shr 24) and $FF;
  SC_B := CalcCVal(SC_B);
  SC_G := CalcCVal(SC_G);
  SC_R := CalcCVal(SC_R);
  result := (SC_A shl 24) + (SC_B shl 16) + (SC_G shl 8) + (SC_R);
end;

procedure DrawColorButton(dblParam : LPARAM; BtnIco, IcoSize : Integer; BtnColor : COLORREF; BtnTextColor : COLORREF; BtnGradientColor : COLORREF = 0; Round : Byte = 0);
var
  hButtonIcon, hIconSize, BtnRoundCount : Integer;
  hButtonDC : HDC;
  ButtonRect, ButtonOldRect : TRect;
  hButtonWnd : HWND;
  BtnBrushTemplate, BtnRoundBrushTemplate, BtnHiBrushTemplate, BtnLoBrushTemplate, BtnVeryLoBrushTemplate : TLogBrush;
  BtnBrush, BtnRoundBrush, BtnHiBrush, BtnLoBrush, BtnVeryLoBrush : HBRUSH;
  BtnRoundPen : HPEN;
  BtnPC : array [0..$400] of Char;
  BtnBkColor : COLORREF;
Label
  NoEdge;
begin
  with BtnBrushTemplate do
    begin
      lbStyle := BS_SOLID;
      lbColor := BtnColor;
      lbHatch := 0;
    end;
  BtnBrush := CreateBrushIndirect(BtnBrushTemplate);
  with BtnHiBrushTemplate do
    begin
      lbStyle := BS_SOLID;
      lbColor := SetColorBrightness(BtnBrushTemplate.lbColor, 120);
      lbHatch := 0;
    end;
  BtnHiBrush := CreateBrushIndirect(BtnHiBrushTemplate);
  with BtnLoBrushTemplate do
    begin
      lbStyle := BS_SOLID;
      lbColor := SetColorBrightness(BtnBrushTemplate.lbColor, 60);
      lbHatch := 0;
    end;
  BtnLoBrush := CreateBrushIndirect(BtnLoBrushTemplate);
  with BtnVeryLoBrushTemplate do
    begin
      lbStyle := BS_SOLID;
      lbColor := SetColorBrightness(BtnBrushTemplate.lbColor, 30);
      lbHatch := 0;
    end;
  BtnVeryLoBrush := CreateBrushIndirect(BtnVeryLoBrushTemplate);
  hButtonWnd := PDRAWITEMSTRUCT(dblParam).hwndItem;
  hButtonDC := PDRAWITEMSTRUCT(dblParam).hDC;
  ButtonRect := PDRAWITEMSTRUCT(dblParam).rcItem;
  BtnBkColor := GetBkColor(hButtonDC);
  If (getprop(hButtonWnd, 'MouseOver') = 1) then
    BtnGradientColor := SetColorBrightness(BtnGradientColor, 120);
  SetBkColor(hButtonDC, BtnBrushTemplate.lbColor);
  SetTextColor(hButtonDC, BtnTextColor);
  If (BtnGradientColor > 0) then
    begin
      If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_SELECTED) <> 0) then
        BtnGradientColor := SetColorBrightness(BtnGradientColor, 80);
      DrawGradient(hButtonDC, ButtonRect, BtnColor, BtnGradientColor);
    end
  else
    FillRect(hButtonDC, ButtonRect, BtnBrush);
  If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_FOCUS) <> 0) then
    begin
      ButtonRect.Left := ButtonRect.Left;
      ButtonRect.Right := ButtonRect.Right;
      ButtonRect.Top := ButtonRect.Top;
      ButtonRect.Bottom := ButtonRect.Bottom;
    end;
  ButtonOldRect := ButtonRect;
  If (Round > 0) then
    goto NoEdge;
  If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_SELECTED) <> 0) then
    FillRect(hButtonDC, ButtonRect, BtnLoBrush)
  else
    FillRect(hButtonDC, ButtonRect, BtnVeryLoBrush);
  NoEdge:
  ButtonRect := ButtonOldRect;
  If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_SELECTED) <> 0) then
    begin
      ButtonRect.Left := ButtonRect.Left + 2;
      ButtonRect.Top := ButtonRect.Top;
    end;
  SendMessage(hButtonWnd, WM_GETTEXT, $400, LongInt(@BtnPC[0]));
  If (BtnGradientColor > 0) then
    SetBkMode(hButtonDC, TRANSPARENT);
  hIconSize := IcoSize;
  hButtonIcon := LoadImage(hInstance, MAKEINTRESOURCE(BtnIco), IMAGE_ICON, hIconSize, hIconSize, 0);
    If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_DISABLED) <> 0) then
    begin
      SetTextColor(hButtonDC, BtnTextColor);
      ButtonRect.Left := ButtonRect.Left + hIconSize + 5;
      ButtonRect.Top := ButtonRect.Top;
      DrawText(hButtonDC, @BtnPC[0], - 1, ButtonRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

      // требуется для значка в плавающей панели (не нужно)
      if BtnPC = '' then
        begin
          ButtonRect.Left := ButtonRect.Left + 6;
          ButtonRect.Top := ButtonRect.Top + 6;
        end;

      DrawIconEx(hButtonDC, ButtonRect.Left - hIconSize, ButtonRect.Top + 5, hButtonIcon, hIconSize, hIconSize, 0, 0, DI_NORMAL);
      ButtonRect.Left := ButtonRect.Left;
      ButtonRect.Top := ButtonRect.Top;
      SetBkMode(hButtonDC, TRANSPARENT);
      SetTextColor(hButtonDC, BtnTextColor);
    end
  else
  If (BtnGradientColor > 0) then
    begin
      SetTextColor(hButtonDC, BtnTextColor);
      ButtonRect.Left := ButtonRect.Left + hIconSize + 5;
      ButtonRect.Top := ButtonRect.Top;
      if hIconSize = 0 then
        begin
          ButtonRect.Left := ButtonRect.Left - 3;
          ButtonRect.Top := ButtonRect.Top - 2;
        end;
      DrawText(hButtonDC, @BtnPC[0], - 1, ButtonRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
      DrawIconEx(hButtonDC, ButtonRect.Left - hIconSize, ButtonRect.Top + 5, hButtonIcon, hIconSize, hIconSize, 0, 0, DI_NORMAL);
      ButtonRect.Left := ButtonRect.Left;
      ButtonRect.Top := ButtonRect.Top;
      SetBkMode(hButtonDC, TRANSPARENT);
      SetTextColor(hButtonDC, BtnTextColor);
    end;
  DrawText(hButtonDC, @BtnPC[0], - 1, ButtonRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
  If (Round > 0) then
    begin
      with BtnRoundBrushTemplate do
        begin
          lbStyle := BS_HOLLOW;
          lbColor := 0;
          lbHatch := 0;
        end;
      BtnRoundBrush := CreateBrushIndirect(BtnRoundBrushTemplate);
      SelectObject(hButtonDC, BtnRoundBrush);
      ButtonRect := PDRAWITEMSTRUCT(dblParam).rcItem;
      BtnRoundPen := CreatePen(PS_SOLID, 1, SetColorBrightness(BtnBkColor, 110));
      SelectObject(hButtonDC, BtnRoundPen);
      RoundRect(hButtonDC, ButtonRect.Left, ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom, Round, Round);
      DeleteObject(BtnRoundPen);
      ButtonRect.Left := ButtonRect.Left + 1;
      ButtonRect.Right := ButtonRect.Right - 1;
      ButtonRect.Top := ButtonRect.Top + 1;
      ButtonRect.Bottom := ButtonRect.Bottom - 1;
      If ((PDRAWITEMSTRUCT(dblParam).itemState and ODS_SELECTED) <> 0) then
        BtnRoundPen := CreatePen(PS_SOLID, 1, BtnVeryLoBrushTemplate.lbColor)
      else
        BtnRoundPen := CreatePen(PS_SOLID, 1, BtnLoBrushTemplate.lbColor);
      SelectObject(hButtonDC, BtnRoundPen);
      RoundRect(hButtonDC, ButtonRect.Left, ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom, Round , Round);
      DeleteObject(BtnRoundPen);
      ButtonRect := PDRAWITEMSTRUCT(dblParam).rcItem;
      BtnRoundPen := CreatePen(PS_SOLID, 1, BtnBkColor);
      SelectObject(hButtonDC, BtnRoundPen);
      for BtnRoundCount := 2 to Round do
        begin
          ButtonRect.Left := ButtonRect.Left;
          ButtonRect.Right := ButtonRect.Right;
          ButtonRect.Top := ButtonRect.Top;
          ButtonRect.Bottom := ButtonRect.Bottom;
          RoundRect(hButtonDC, ButtonRect.Left, ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom, Round, Round);
          RoundRect(hButtonDC, ButtonRect.Left, ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom, Round, Round);
        end;
      DeleteObject(BtnRoundPen);
      SelectObject(hButtonDC, BtnBrush);
      DeleteObject(BtnRoundBrush);
    end;
  SetBkColor(hButtonDC, BtnBkColor);
  DeleteObject(BtnBrush);
  DeleteObject(BtnHiBrush);
  DeleteObject(BtnLoBrush);
  DeleteObject(BtnVeryLoBrush);
  ReleaseDC(hButtonWnd, hButtonDC);
end;

procedure DrawGradient(shdc : HDC; srect : TRect; clStart, clEnd : COLORREF);
type
  ExtByte = Real;
const
  sPenPoint : TPoint = (X : 1; Y : 1);
var
  TempRect : TRect;
  sBrushTemplate : TLogBrush;
  sPenTemplate : TLogPen;
  sBrush : HBRUSH;
  sPen : HPEN;
  dRed, dGreen, dBlue : Integer;
  CBlue, CGreen, CRed, CLine : ExtByte;
  CLinesX, CLinesY : Word;
  clStartR, clStartG, clStartB, clEndR, clEndG, clEndB : Byte;
begin
  clStartR := (clStart) and $FF;
  clStartG := (clStart shr 8) and $FF;
  clStartB := (clStart shr 16) and $FF;
  clEndR := (clEnd) and $FF;
  clEndG := (clEnd shr  8) and $FF;
  clEndB := (clEnd shr 16) and $FF;
  CLinesX := srect.Right  - srect.Left + 1;
  CLinesY := srect.Bottom - srect.Top + 1;
  with sBrushTemplate do
    begin
      lbStyle := BS_SOLID;
      lbColor := GetBkColor(shdc);
      lbHatch := 0;
    end;
  sBrush := CreateBrushIndirect(sBrushTemplate);
  TempRect := sRect;
  FillRect(shdc, TempRect, sBrush);
  dBlue  := (clEndB - clStartB);
  dGreen := (clEndG - clStartG);
  dRed := (clEndR - clStartR);
  CLine := srect.Top;
  while (CLine  < (CLinesY + srect.Top - 1)) do
    begin
      CBlue := (dBlue * (CLine - srect.Top + 1)) / CLinesY;
      CGreen := (dGreen * (CLine - srect.Top + 1)) / CLinesY;
      CRed := (dRed * (CLine - srect.Top + 1)) / CLinesY;
      CBlue := (clStartB + CBlue);
      CGreen := (clStartG + CGreen);
      CRed  := (clStartR + CRed);
      with sPenTemplate do
        begin
          lopnStyle := PS_SOLID;
          lopnWidth := sPenPoint;
          lopnColor := ((Round(CBlue) and $FF) shl 16) + ((Round(CGreen) and $FF) shl 8) + ((Round(CRed) and $FF));
        end;
      sPen := CreatePenIndirect(sPenTemplate);
      SelectObject(shdc, sPen);
      MoveToEx(shdc, srect.Left, Round(CLine), nil);
      LineTo(shdc, srect.Left + CLinesX - 1, Round(CLine));
      CLine := CLine + 1;
      DeleteObject(sPen);
    end;
  DeleteObject(sBrush);
end;

end.
