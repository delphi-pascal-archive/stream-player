unit MSysIni;

interface

uses
  Windows, MSysUtils;

function IniReadString(const FFileName, Section, Ident, Default: string): string;
function IniWriteString(const FFileName, Section, Ident, Value: string): Boolean;

implementation

function IniReadString(const FFileName, Section, Ident, Default: string): string;
var
 Buffer: array[0..1023] of Char;
begin
 SetString(Result, Buffer, GetPrivateProfileString(PChar(Section),
  PChar(Ident), PChar(Default), Buffer, SizeOf(Buffer), PChar(FFileName)));
end;

function IniWriteString(const FFileName, Section, Ident, Value: string): Boolean;
begin
 Result := WritePrivateProfileString(PChar(Section), PChar(Ident), PChar(Value), PChar(FFileName));
end;

end.
