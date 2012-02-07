unit AdapterComm;

interface

uses
  Windows,Konkurs_DLL_x1,ComCryptM;

Procedure SetCorrectionEnabled;
Procedure SetCorrectionDisabled;
Procedure SetObmenDisabled;
Procedure SetObmenEnabled;
Function CheckBuffers(VAR IND_,OU_):integer;
Procedure GetArrays_Buffer(VAR IND_,OU_:pointer);
Function  ADaptersGetLastError:integer;
Function CheckLastReceivedTime:DWORD;
Procedure GetArraysOU(VAR IND_,OU_:pointer);
Procedure SetArraysOU(VAR IND_,OU_);
//Function Reconnect(NPort:Integer):integer;
//Procedure WriteIniTable;

implementation
Procedure SetCorrectionEnabled;
begin
 Corr_Disable:=False;
end;

Procedure SetCorrectionDisabled;
begin
 Corr_Disable:=True;
end;

Procedure SetObmenDisabled;
begin
 Obmen_Disable:=True;
end;
Procedure SetObmenEnabled;
begin
 Obmen_Disable:=False;
end;

Function CheckBuffers(VAR IND_,OU_):integer;
begin
 Move(COMC.BuferIN,OU_,50);
 Move(COMC.BuferOUT,IND_,50);
 Result:=0;
end;

//запоминание адресов массивов обмена
Procedure SetArraysOU(VAR IND_,OU_);
begin
 OutPointer:=@IND_;
 InPointer:=@OU_;
end;

//запоминание адресов массивов матрицы
Procedure GetArraysOU(VAR IND_,OU_:pointer);
begin
 OU_:=@Comc.Org_UPR;
 IND_:=@Comc.Org_IND;
end;
//запоминание адресов массивов обмена
Procedure GetArrays_Corr(VAR IND_,OU_:pointer);
begin
 OU_:=@OU_COR;
 IND_:=@MKontrT;
end;

//запоминание адресов массивов обмена
Procedure GetArrays_Buffer(VAR IND_,OU_:pointer);
begin
 OU_:=@COMC.BuferIN;
 IND_:=@COMC.BuferOUT
end;

Function  ADaptersGetLastError:integer;
begin
 IF ComPort<0 then Result:=ComPort
 else begin
  IF GettickCount-Comc.LastTimeReceived<300
  then result:=0
  else result:=255;
 end;
end;


Function CheckDataFromAdapter(VAR IND_,OU_):integer;
var B:^TBytesArray;
begin
 OutPointer:=@IND_;
 InPointer:=@OU_;
 Result:=Comc.NumOfLastReceived;
 B:=@IND_;
 Move(B[0],Comc.Org_IND,SizeOfOrgIndMatrix);
 B:=@OU_;
 Move(ComC.Org_UPR,B[0],SizeOfOrgUprMatrix);
end;

Function  ADaptersGetKeyNumber:LongWord;
BEGIN
 Result:=Comc.KeyNumberCode;
END;

Function CheckLastReceivedTime:DWORD;
BEGIN
 Result:=Comc.LastTimeReceived;
END;
Function CheckLastTransmitTime:DWORD;
BEGIN
 Result:=Comc.LastTimeTransmitted;
END;

//переоткрытие СОМ-порта
{Function Reconnect(NPort:Integer):integer;
begin
 IF Nport>0 then ComPort:=Nport;
 ComC.Close;
 ComC.free;
 ConnectToComPort;
 Result:=ComPort;
end;

//перезапись таблиц коррекции данных
Procedure WriteIniTable;
begin
 WriteINITables;
end;}


end.
