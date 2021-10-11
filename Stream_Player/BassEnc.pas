{
  BASSenc 2.3 Delphi API, copyright (c) 2003-2007 Ian Luck.
  Requires BASS - available from www.un4seen.com

  See the BASSENC.CHM file for more complete documentation
}

Unit BASSenc;

interface

uses Windows, Bass;

const
  // Additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_ACM_CANCEL         = 2000; // ACM codec selection cancelled
  BASS_ERROR_CAST_DENIED        = 2100; // access denied (invalid password)

  // Additional config options
  BASS_CONFIG_ENCODE_PRIORITY   = $10300; // encoder DSP priority
  BASS_CONFIG_ENCODE_CAST_TIMEOUT = $10310; // cast timeout

  // BASS_Encode_Start flags
  BASS_ENCODE_NOHEAD            = 1;	// do NOT send a WAV header to the encoder
  BASS_ENCODE_FP_8BIT           = 2;	// convert floating-point sample data to 8-bit integer
  BASS_ENCODE_FP_16BIT          = 4;	// convert floating-point sample data to 16-bit integer
  BASS_ENCODE_FP_24BIT          = 6;	// convert floating-point sample data to 24-bit integer
  BASS_ENCODE_BIGEND            = 16;	// big-endian sample data
  BASS_ENCODE_PAUSE             = 32;	// start encording paused
  BASS_ENCODE_PCM               = 64;	// write PCM sample data (no encoder)
  BASS_ENCODE_AUTOFREE          = $40000; // free the encoder when the channel is freed

  // BASS_Encode_GetACMFormat flags
  BASS_ACM_DEFAULT              = 1; // use the format as default selection
  BASS_ACM_RATE                 = 2; // only list formats with same sample rate as the source channel
  BASS_ACM_CHANS                = 4; // only list formats with same number of channels (eg. mono/stereo)
  BASS_ACM_SUGGEST              = 8; // suggest a format (HIWORD=format tag)

  // BASS_Encode_CastInit content MIME types
  BASS_ENCODE_TYPE_MP3          = 'audio/mpeg';
  BASS_ENCODE_TYPE_OGG          = 'application/ogg';
  BASS_ENCODE_TYPE_AAC          = 'audio/aacp';

  // Encoder notifications
  BASS_ENCODE_NOTIFY_ENCODER    = 1; // encoder died
  BASS_ENCODE_NOTIFY_CAST       = 2; // cast server connection died
  BASS_ENCODE_NOTIFY_CAST_TIMEOUT = 3; // cast timeout

  // BASS_Encode_CastGetStats types
  BASS_ENCODE_STATS_SHOUT       = 0; // Shoutcast stats
  BASS_ENCODE_STATS_ICE         = 1; // Icecast mount-point stats
  BASS_ENCODE_STATS_ICESERV     = 2; // Icecast server stats


type
  HENCODE = DWORD;   // encoder handle

  ENCODEPROC = procedure(handle:DWORD; channel:DWORD; buffer:Pointer; length:DWORD; user:DWORD); stdcall;
  {
    Encoding callback function.
    handle : The encoder
    channel: The channel handle
    buffer : Buffer containing the encoded data
    length : Number of bytes
    user   : The 'user' parameter value given when calling BASS_EncodeStart
  }

  ENCODENOTIFYPROC = procedure(handle:HENCODE; status,user:DWORD); stdcall;
  {
    Encoder death notification callback function.
    handle : The encoder
    status : Notification (BASS_ENCODE_NOTIFY_xxx)
    user   : The 'user' parameter value given when calling BASS_Encode_SetNotify
  }


const
  bassencdll = 'bassenc.dll';

function BASS_Encode_Start(handle:DWORD; cmdline:PChar; flags:DWORD; proc:ENCODEPROC; user:DWORD): HENCODE; stdcall; external bassencdll;
function BASS_Encode_IsActive(handle:DWORD): DWORD; stdcall; external bassencdll;
function BASS_Encode_Stop(handle:DWORD): BOOL; stdcall; external bassencdll;
function BASS_Encode_SetPaused(handle:DWORD; paused:BOOL): BOOL; stdcall; external bassencdll;
function BASS_Encode_Write(handle:DWORD; buffer:Pointer; length:DWORD): BOOL; stdcall; external bassencdll;
function BASS_Encode_SetNotify(handle:DWORD; proc:ENCODENOTIFYPROC; user:DWORD): BOOL; stdcall; external bassencdll;
function BASS_Encode_SetChannel(handle:DWORD; channel:DWORD): BOOL; stdcall; external bassencdll;
function BASS_Encode_GetChannel(handle:HENCODE): DWORD; stdcall; external bassencdll;

function BASS_Encode_GetACMFormat(handle:DWORD; form:Pointer; formlen:DWORD; title:PChar; flags:DWORD): DWORD; stdcall; external bassencdll;
function BASS_Encode_StartACM(handle:DWORD; form:Pointer; flags:DWORD; proc:ENCODEPROC; user:DWORD): HENCODE; stdcall; external bassencdll;
function BASS_Encode_StartACMFile(handle:DWORD; form:Pointer; flags:DWORD; filename:PChar): HENCODE; stdcall; external bassencdll;

function BASS_Encode_CastInit(handle:HENCODE; server,pass,content,name,url,genre,desc,headers:PChar; bitrate:DWORD; pub:BOOL): BOOL; stdcall; external bassencdll;
function BASS_Encode_CastSetTitle(handle:HENCODE; title:PChar): BOOL; stdcall; external bassencdll;
function BASS_Encode_CastGetStats(handle:HENCODE; stype:DWORD; pass:PChar): PChar; stdcall; external bassencdll;

implementation

end.
