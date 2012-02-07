(*******************************************************************************
  Модуль для ведения лога
*******************************************************************************)
unit Logging;

interface

uses
  SysUtils, Classes, windows;
//  System; /////////////
const
MaxLogSize = 500000;    //размер файла в байтах при котором следует очистить лог

var
  LogFile : TextFile;
  isLogInit : Boolean = False;
  prevPackTick : Cardinal;

procedure LogInit(fname: String);
procedure LogMsg(msg : String);
procedure CleanLog(f_fullname: String; maxsize:integer);
procedure LogPackedge(var Buff: array of AnsiChar; var length: integer);


implementation

procedure LogInit(fname: String);
var
  f_fullname : string;
begin
  // ParamStr(0) - возвращает полное имя ехе-шника
  f_fullname := ExtractFilePath(ParamStr(0)) + fname;
  AssignFile(LogFile, f_fullname);
  {$I-}  // Отключение автоконтроля для вызова функции IOResult
  if FileExists(f_fullname) then
  begin  
    CleanLog(f_fullname, MaxLogSize);
    Append(LogFile)       // Запись в конец существующего
  end
  else
    Rewrite(LogFile);      // Создание нового
  Writeln(LogFile,'***** Старт: ' + DateTimeToStr(Now) + ' *****');
  CloseFile(LogFile);
  {$I+}
  if IOResult =  0 then
    isLogInit := True;
end;

procedure LogMsg(msg : String);
begin
  if isLogInit then
  begin
    Append(LogFile);
    Writeln(LogFile,msg);
    CloseFile(LogFile);
  end;
end;


procedure CleanLog(f_fullname: String; maxsize: integer);
var
     stm: TFileStream;
begin
   stm := TFileStream.Create(f_fullname, fmOpenRead or fmShareDenyWrite);
   if (stm.Size > maxsize) then
    begin
      FreeAndNil(stm);
         AssignFile(LogFile, f_fullname);
         if FileExists(f_fullname) then
         Rewrite(LogFile);
         CloseFile(LogFile);
      end;
   FreeAndNil(stm);

end;

//запись в лог буффера байт
procedure LogPackedge(var Buff: array of AnsiChar; var length: integer);
var
i : integer;
s : string;
begin

  LogMsg('----Buff size : '+IntToStr(length) +' -----');
  LogMsg('----Buff time : '+IntToStr(GetTickCount) +'; prev: '+
                IntToStr(GetTickCount-prevPackTick)+'ms; -----');
  prevPackTick := GetTickCount;
  for I := 0 to length-1 do
   begin
    s:=IntToStr(byte(Buff[i]));
    LogMsg('Byte '+IntToStr(i)+' : '+s);
   end;


end;

initialization
  LogInit(ChangeFileExt(ExtractFileName(ParamStr(0)), '.LOG'));
end.

