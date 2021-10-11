const
  WM_TRAYICON                  = WM_APP + 1;
  CTRL_USER_TRAYICON           = 60;
  WM_PLAY_START                = WM_USER + 101;
  WM_PLAY_STOP                 = WM_USER + 102;
  WM_REC_START                 = WM_USER + 103;
  WM_REC_STOP                  = WM_USER + 104;
  WM_OPEN_DIR                  = WM_USER + 105;
  WM_SHOW_SIDE                 = WM_USER + 106;

{������� ���������}

  TIMER_DIALOG_LICENSE         = 61;
  TIMER_DIALOG_SPLASH          = 62;
  TIMER_DIALOG_PLAY            = 63;
  TIMER_DIALOG_RECORD          = 64;
  TIMER_DIALOG_CLOCK           = 65;
  TIMER_DIALOG_SNDMETER        = 66;

{������� ��������}
  RES_DIALOG_GENERAL           = 101;
  RES_DIALOG_LICENSE           = 102;
  RES_DIALOG_PLAYURL           = 103;
  RES_DIALOG_ADDSTAT           = 104;
  RES_DIALOG_RENSTAT           = 105;
  RES_DIALOG_DELSTAT           = 106;
  RES_DIALOG_SIDEBAR           = 107;
  RES_DIALOG_ABOUT             = 108;
  RES_DIALOG_SETTINGS          = 109;
  RES_DIALOG_STREAM            = 110;

{������� ������}
  RES_ICON_GENERAL             = 101;
  RES_ICON_STATIONS            = 102;
  RES_ICON_PLAYSTART           = 103;
  RES_ICON_RECORDSTART         = 104;
  RES_ICON_PLAYRECSTOP         = 105;
  RES_ICON_VOLUMEING           = 106;
  RES_ICON_DLGSTATADD          = 107;
  RES_ICON_DLGSTATREN          = 108;
  RES_ICON_DLGSTATDEL          = 109;
  RES_ICON_DLGSTATURL          = 110;
  RES_ICON_MENUABOUT           = 111;
  RES_ICON_MENUFORUM           = 112;
  RES_ICON_MENUMESSAGE         = 113;
  RES_ICON_MENUUPDATE          = 114;
  RES_ICON_MENUTRAYICON        = 115;
  RES_ICON_MENUEQUALIZER       = 116;
  RES_ICON_MENUSETTINGS        = 117;
  RES_ICON_MENUSTATADD         = RES_ICON_DLGSTATADD;
  RES_ICON_MENUSTATREN         = RES_ICON_DLGSTATREN;
  RES_ICON_MENUSTATDEL         = RES_ICON_DLGSTATDEL;
  RES_ICON_MENUSTATREL         = 118;
  RES_ICON_MENUPLAYURL         = RES_ICON_DLGSTATURL;
  RES_ICON_MENUPLAYSTART       = RES_ICON_PLAYSTART;
  RES_ICON_MENUPLAYSTOP        = RES_ICON_PLAYRECSTOP;
  RES_ICON_MENURECSTART        = RES_ICON_RECORDSTART;
  RES_ICON_MENURECSTOP         = RES_ICON_PLAYRECSTOP;
  RES_ICON_MENUDIRECTORY       = 119;
  RES_ICON_MENUEXITAPP         = 120;
  RES_ICON_CURRENTTIME         = 121;
  RES_ICON_DLGSETGEN           = 122;
  RES_ICON_DLGSETBASS          = 123;
  RES_ICON_DLGSETSAVE          = 124;
  RES_ICON_DLGSETSIDE          = 125;
  RES_ICON_DLGSETHKEY          = 126;
  RES_ICON_DLGSETFMP3          = 127;
  RES_ICON_BUTTONYES           = 128;
  RES_ICON_BUTTONNOT           = 129;
  RES_ICON_BUTTONREST          = 130;

{������� ��������}
  RES_CURSOR_GENERAL           = 101;

{������� �����������}
  RES_BITMAP_SPLASHWND         = 101;

  CTRL_MENU_ABOUTINFO          = 1;
  CTRL_MENU_FORUM              = 2;
  CTRL_MENU_MESSAGE            = 3;
  CTRL_MENU_UPDATE             = 4;
  CTRL_MENU_TRAYADDDEL         = 5;
  CTRL_MENU_EQUALIZER          = 6;
  CTRL_MENU_SETTINGS           = 7;
  CTRL_MENU_CREATESTAT         = 8;
  CTRL_MENU_RENAMESTAT         = 9;
  CTRL_MENU_REMOVESTAT         = 10;
  CTRL_MENU_RELOADLIST         = 11;
  CTRL_MENU_URLLINK            = 12;
  CTRL_MENU_STARTPLAY          = 13;
  CTRL_MENU_STOPPLAY           = 14;
  CTRL_MENU_STARTRECORD        = 15;
  CTRL_MENU_STOPRECORD         = 16;
  CTRL_MENU_DIRECTORY          = 17;
  CTRL_MENU_EXITAPP            = 18;
  CTRL_MENU_PLAYSTAT           = 19;

{Yeaiaiou aeaaiiai aeaeiaa}
  CTRL_GENERAL_REGION          = 1001;
  CTRL_GENERAL_BANNER          = 1002;
  CTRL_GENERAL_BTNMENU         = 1003;
  CTRL_GENERAL_BTNONTOP        = 1004;
  CTRL_GENERAL_BTNMINZE        = 1005;
  CTRL_GENERAL_BTNCLOSE        = 1006;
  CTRL_TOOLBAR_GENERAL         = 1012;
  CTRL_TRACKBAR_VOLUME         = 1014;
  CTRL_LISTVIEW_PLAYLIST       = 1021;
  CTRL_PROGRESS_LEFT           = 1022;
  CTRL_PROGRESS_RIGHT          = 1023;
  CTRL_STATUSBAR_PANEL         = 1031;
  IDC_TOOLBAR_ABOUTINFO        = 1051;
  IDC_TOOLBAR_SETTINGS         = 1052;
  IDC_TOOLBAR_EQUALIZER        = 1053;
  IDC_TOOLBAR_OPENURL          = 1054;
  IDC_TOOLBAR_PLAYSTART        = 1055;
  IDC_TOOLBAR_PLAYSTOP         = 1056;
  IDC_TOOLBAR_RECORDSTART      = 1057;
  IDC_TOOLBAR_RECORDSTOP       = 1058;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_RICHEDIT_LICENSE        = 2011;
  CTRL_BUTTON_LICACCEPT        = 2021;
  CTRL_BUTTON_LICDECLINE       = 2022;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_ADDTITLE        = 4001;
  CTRL_EDIT_STATNAMEADD       = 4011;
  CTRL_EDIT_STATLINKADD       = 4012;
  CTRL_BUTTON_APPLYADD        = 4021;
  CTRL_BUTTON_CANCELADD       = 4022;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_RENTITLE        = 5001;
  CTRL_EDIT_STATNAMEREN       = 5011;
  CTRL_EDIT_STATLINKREN       = 5012;
  CTRL_BUTTON_APPLYREN        = 5021;
  CTRL_BUTTON_CANCELREN       = 5022;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_REMTITLE        = 6001;
  CTRL_EDIT_STATNAMEREM       = 6011;
  CTRL_BUTTON_APPLYREM        = 6021;
  CTRL_BUTTON_CANCELREM       = 6022;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_SIDEICOLOGO     = 7001;
  CTRL_STATIC_SIDETXTFIELD    = 7002;
  CTRL_STATIC_SIDESTATION     = 7012;
  CTRL_STATIC_SIDEICOPLAY     = 7021;
  CTRL_STATIC_SIDEPLAYING     = 7022;
  CTRL_STATIC_SIDEICOREC      = 7023;
  CTRL_STATIC_SIDERECORDING   = 7024;
  CTRL_STATIC_SIDEICOVOLUME   = 7025;
  CTRL_STATIC_SIDEVOLUMING    = 7026;
  CTRL_STATIC_SIDEICOTIME     = 7027;
  CTRL_STATIC_SIDECURTIME     = 7028;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_ABOUTBANNER     = 8001;
  CTRL_STATIC_ABOUTICON       = 8002;
  CTRL_STATIC_ABOUTNAME       = 8003;
  CTRL_STATIC_ABOUTVERSION    = 8004;
  CTRL_STATIC_FORUMICON       = 8021;
  CTRL_STATIC_LINKFORUM       = 8022;
  CTRL_STATIC_MESSAGEICON     = 8023;
  CTRL_STATIC_LINKMESSAGE     = 8024;
  CTRL_STATIC_COPYRIGHTS      = 8031;
  CTRL_BUTTON_ABOUTCLOSE      = 8032;

  CTRL_TREEVIEW_SETTINGS      = 9001;
  CTRL_STATIC_SETNGSINFO      = 9002;
  CTRL_CHECKBOX_POSITMAIN     = 9011;
  CTRL_CHECKBOX_BALLONTIPS    = 9012;
  CTRL_CHECKBOX_NUMBERCOPY    = 9013;
  CTRL_CHECKBOX_BASSVOLUME    = 9014;
  CTRL_CHECKBOX_POSITMOVE     = 9015;
  CTRL_CHECKBOX_GRIDLINES     = 9016;
  CTRL_CHECKBOX_AUTORUN       = 9017;
  CTRL_CHECKBOX_REMSTAT       = 9018;
  CTRL_STATIC_FREQUENCY       = 9021;
  CTRL_COMBOBOX_FREQUENCY     = 9022;
  CTRL_STATIC_NETTIMEOUT      = 9023;
  CTRL_COMBOBOX_NETTIMEOUT    = 9024;
  CTRL_STATIC_NETPERCENT      = 9025;
  CTRL_COMBOBOX_NETPERCENT    = 9026;
  CTRL_STATIC_NETBUFFER       = 9027;
  CTRL_COMBOBOX_NETBUFFER     = 9028;
  CTRL_EDIT_DIRECTORYPATH     = 9031;
  CTRL_BUTTON_DIRECTORYPATH   = 9032;
  CTRL_STATIC_DIRECTORYPATH   = 9033;
  CTRL_CHECKBOX_POSITSIDE     = 9041;
  CTRL_STATIC_TRANSPSIDE      = 9042;
  CTRL_TRACKBAR_TRANSPSIDE    = 9043;
  CTRL_EDIT_TRANSPSIDE        = 9044;
  CTRL_CHECKBOX_ONTOPSIDE     = 9045;
  CTRL_CHECKBOX_TRANSPWIND    = 9046;
  IDC_HOTKEY_PLAY_START       = 71;
  IDC_HOTKEY_PLAY_STOP        = 72;
  IDC_HOTKEY_REC_START        = 73;
  IDC_HOTKEY_REC_STOP         = 74;
  IDC_HOTKEY_DIR_OPEN         = 75;
  IDC_HOTKEY_SIDEBAR          = 76;
  CTRL_STATIC_PLAY_START      = 9051;
  CTRL_HOTKEY_PLAY_START      = 9052;
  CTRL_STATIC_PLAY_STOP       = 9053;
  CTRL_HOTKEY_PLAY_STOP       = 9054;
  CTRL_STATIC_REC_START       = 9055;
  CTRL_HOTKEY_REC_START       = 9056;
  CTRL_STATIC_REC_STOP        = 9057;
  CTRL_HOTKEY_REC_STOP        = 9058;
  CTRL_STATIC_DIR_OPEN        = 9059;
  CTRL_HOTKEY_DIR_OPEN        = 9060;
  CTRL_STATIC_SIDEBAR         = 9061;
  CTRL_HOTKEY_SIDEBAR         = 9062;
  CTRL_STATIC_BITRATE         = 9071;
  CTRL_COMBOBOX_BITRATE       = 9072;
  CTRL_STATIC_QUALITY         = 9073;
  CTRL_COMBOBOX_QUALITY       = 9074;
  CTRL_STATIC_PRIORITY        = 9075;
  CTRL_COMBOBOX_PRIORITY      = 9076;
  CTRL_BUTTON_SETNGSSAVE      = 9081;
  CTRL_BUTTON_SETNGSREST      = 9082;
  CTRL_BUTTON_SETNGSCNSL      = 9083;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_URLTITLE        = 10001;
  CTRL_EDIT_STATLINKURL       = 10011;
  CTRL_BUTTON_APPLYURL        = 10021;
  CTRL_BUTTON_CANCELURL       = 10022;

{Yeaiaou aeaeiaa n eeoaiceae}
  CTRL_STATIC_STATINFO        = 11001;
  CTRL_STATIC_BITINFO         = 11002;
  CTRL_STATIC_MODEINFO        = 11003;
  CTRL_STATIC_FREQINFO        = 11004;
  CTRL_BUTTON_FREQCLOSE       = 11005;


{Oaaoa nienea aini?iecaaaaiey}
  COLOR_BLUE                   = $00FAFA46;
  COLOR_RED                    = $4300DE;
  COLOR_ORANGE                 = $23C4FF;
  COLOR_WHITE                  = $00FFFFFF;

  LVS_EX_LABELTIP              = $00004000;

  CHECKPOSHTTP                 = 'http://';

  mylink = 'http://forums.avtograd.ru/index.php?showtopic=11588';
  mymail = 'http://forums.avtograd.ru/index.php?act=Msg&CODE=4&MID=5059';

  IDC_STR_VER_INFO = 1600;
  IDC_STR_APP_INFO = 1601;
  IDC_STR_TW_GNRL = 1602;
  IDC_STR_TW_BASS = 1603;
  IDC_STR_TW_SAVE = 1604;
  IDC_STR_TW_SIDE = 1605;
  IDC_STR_TW_KEYS = 1606;
  IDC_STR_TW_FMP3 = 1607;
  IDC_STR_MSG_FUT = 1608;
  IDC_STR_MSG_ERR = 1609;
  IDC_STR_MSG_INF = 1610;
  IDC_STR_MSG_ADD = 1611;
  IDC_STR_MSG_REN = 1612;
  IDC_STR_MSG_ITM = 1613;
  IDC_STR_MSG_URL = 1614;
  IDC_STR_MSG_STM = 1615;
  STR_LST_NEWSTATION = 1616;
  STR_TIP_ABOUTINFO = 1617;
  STR_TIP_SETTINGS = 1618;
  STR_TIP_ICONTRAY = 1619;
  STR_TIP_OPENLINK = 1620;
  STR_TIP_PLAYSTART = 1621;
  STR_TIP_PLAYSTOP = 1622;
  STR_TIP_RECSTART = 1623;
  STR_TIP_RECSTOP = 1624;
  STR_DIR_PATHFILE = 1625;
  STR_LIB_VERSION = 1626;
  STR_LIB_INITIALIZE = 1627;
  STR_INI_INITIALIZE = 1628;
  STR_URL_CONNECTING = 1629;
  STR_URL_BUFFERING = 1630;
  STR_URL_PLAYING = 1631;
  STR_APP_SPLASHSCR = 1632;
  STR_ARY_FREQUENCY = 1633;
  STR_ARY_BUFFERTIME = 1634;
  STR_ARY_BITRATE = 1635;
  STR_ARY_MP3HIGHEST = 1636;
  STR_ARY_MP3RECOMMENDED = 1637;
  STR_ARY_MP3DEFAULT = 1638;
  STR_ARY_MP3FASTEST = 1639;
  STR_ARY_MP3POOREST = 1640;
  STR_ARY_PRTIDLE = 1641;
  STR_ARY_PRTLOW = 1642;
  STR_ARY_PRTNORMAL = 1643;
  STR_ARY_PRTHIGH = 1644;
  STR_ARY_PRTHIGHEST = 1645;
  STR_ARY_MILSEC = 1646;

  EmptyStr = '';

  SplBmpWidth      = 240;
  SplBmpHeight     = 150;
  SplClassName     = 'SplashWndClass';

  AlphaVersion     = 'Alpha 12';
  SoftwareName     = 'Stream Player';