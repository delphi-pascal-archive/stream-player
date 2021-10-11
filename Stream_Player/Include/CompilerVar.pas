type
  TMenuItem = record
    text : PChar;
    bmp : hIcon;
  end;

var
  MenuItems : array [1..19] of TMenuItem =
             (
             (text : PChar('Данные о программе'); bmp : 0),
             (text : PChar('Обсудить на форуме'); bmp : 0),
             (text : PChar('Отправить сообщение'); bmp : 0),
             (text : PChar('Проверить обновление'); bmp : 0),
             (text : 'Свернуть / Развернуть'; bmp : 0),
             (text : 'Информация о потоке'; bmp :0),
             (text : 'Настройки программы'; bmp : 0),
             (text : 'Добавить запись [Ins]'; bmp : 0),
             (text : 'Изменить запись [F2]'; bmp : 0),
             (text : 'Удалить запись [Del]'; bmp : 0),
             (text : 'Обновить плейлист [F5]'; bmp : 0),
             (text : 'Список радиостанций'; bmp : 0),
             (text : 'Открыть URL адрес'; bmp : 0),
             (text : 'Проиграть станцию'; bmp : 0),
             (text : 'Остановить станцию'; bmp : 0),
             (text : 'Записать станцию'; bmp : 0),
             (text : 'Остановить запись'; bmp : 0),
             (text : 'Открыть директорию'; bmp : 0),
             (text : 'Выход из программы'; bmp : 0)
             );

  size : TSize;
  DC, OldBmp, SplDC, MemDC : hDC;
  lpmis : ^TMeasureItemStruct;
  lpdis : ^TDrawItemStruct;
  item : ^TMenuItem;
  lvi : TLVItem;
  lvc : TLVColumn;
  WindowPos : PWindowPos;
  tvinsert : TTVInsertStruct;
  Version, GetCurDir, CheckParam, IndexItem, SelectTree, FolderRip, PositX, PositY, s : String;
  ListStat : PChar;
  Rect, r1, r2 : Trect;
  hApp, hBar, hStg, hLst, hAbt, hInf, hIcon, hBmp, hFont, IndxList, IndxCmbx, VolGetRes, SideGetRes, hImgList, i, ScreenHeight, ScreenWidth, WindowLeft, WindowTop, SenseX, SenseY, LeftBASS, RightBASS : Integer;
  LstTextDC, buffer1, buffer2, buffer3, TimeDataBuf : array [0..255] of Char;
  LicenceTimer, SplashTimer, CurrProgr, BuffProgr, Lenght, hParent, TickDifPlay, TickDifRec, TickStartPlay, TickStartRec : DWORD;
  SecLicTime : Integer = 5;
  LoadSetTime : Integer = 0;
  ThreadId, TreadIdInfo, hPopupMenu : Cardinal;
  PanelWidth : array [0..2] of Integer;
  CurThread : DWORD = 0;
  Stream : HSTREAM = 0;
  Encoder : HENCODE = 0;
  MoveHwnd : Integer = 0;
  TipsHwnd : Integer = 0;
  StickWindow : Word = 10;
  f : TextFile;
  pt : TPoint;
  Docked : Boolean;
  Menu, SubMenu : hMenu;
  GetSysTime : TSystemTime;
  tbButtons : array [0..7] of TTBButton =
  (
    (iBitmap : 0; idCommand : IDC_TOOLBAR_ABOUTINFO; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_DROPDOWN;),
    (iBitmap : 1; idCommand : IDC_TOOLBAR_SETTINGS; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 2; idCommand : IDC_TOOLBAR_EQUALIZER; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 3; idCommand : IDC_TOOLBAR_OPENURL; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 4; idCommand : IDC_TOOLBAR_PLAYSTART; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 5; idCommand : IDC_TOOLBAR_PLAYSTOP; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 6; idCommand : IDC_TOOLBAR_RECORDSTART; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;),
    (iBitmap : 7; idCommand : IDC_TOOLBAR_RECORDSTOP; fsState : TBSTATE_ENABLED; fsStyle : TBSTYLE_BUTTON;)
    );
  WindowWidth : Integer = 240;
  WindowHeight : Integer = 150;
  SplashWC : TWndClassEx = (cbSize : SizeOf(TWndClassEx); style : CS_HREDRAW or CS_VREDRAW; cbClsExtra : 0; cbWndExtra : 0; hIcon : 0; lpszMenuName : nil; lpszClassName : SplClassName; hIconSm : 0);
  PaintDC : TPaintStruct;
  ColorText : COLORREF;

  IntTxtFrq : array [0..2] of Integer = (22000, 44100, 48000);
  StrTxtFrq : array [0..2] of String;
  IntTxtNet : array [0..4] of Integer = (5000, 10000, 15000, 30000, 45000);
  StrTxtNet : array [0..4] of String;
  IntTxtPrc : array [0..9] of Integer = (50, 55, 60, 65, 70, 75, 80, 85, 90, 95);
  StrTxtPrc : array [0..9] of PChar = ('50 %', '55 %', '60 %', '65 %', '70 %', '75 %', '80 %', '85 %', '90 %', '95 %');

  IntTxtBuf : array [0..2] of Integer = (5000, 10000, 15000);
  StrTxtBuf : array [0..2] of String;

  IntTxtBit : array [0..8] of Integer = (56, 96, 112, 128, 160, 192, 224, 256, 320);
  StrTxtBit : array [0..8] of String;
  IntTxtQlt : array [0..4] of Integer = (0, 1, 2, 3, 4);
  StrTxtQlt : array [0..4] of String;
  IntTxtPrt : array [0..4] of Integer = (0, 1, 2, 3, 4);
  StrTxtPrt : array [0..4] of String;

  ThreadInfo : THandle;
  hRegion : hRgn;

  graybrush : HBRUSH = 0;
  GrayLB : TLogBrush = (lbStyle: BS_SOLID; lbColor: $EBE6E5; lbHatch: 0);
  lightbrush : HBRUSH = 0;
  LightLB : TLogBrush = (lbStyle: BS_SOLID; lbColor: $EFEBEB; lbHatch: 0);

