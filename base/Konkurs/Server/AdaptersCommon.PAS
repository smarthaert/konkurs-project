//Общая часть библиотек адаптеров ,используемая для компиляции
//всех DLL связи с адаптерами

Procedure SetCorrectionEnabled;
begin
 Corr_Disable:=False;
end;

Procedure SetCorrectionDisabled;stdcall;export;
begin
 Corr_Disable:=True;
end;

Procedure SetObmenDisabled;stdcall;export;
begin
 Obmen_Disable:=True;
end;
Procedure SetObmenEnabled;stdcall;export;
begin
 Obmen_Disable:=False;
end;

Function CheckBuffers(VAR IND_,OU_):integer;stdcall;export;
begin
 Move(COMC.BuferIN,OU_,50);
 Move(COMC.BuferOUT,IND_,50);
 Result:=0;
end;

//запоминание адресов массивов обмена
Procedure SetArraysOU(VAR IND_,OU_);stdcall;export;
begin
 OutPointer:=@IND_;
 InPointer:=@OU_;
end;

//запоминание адресов массивов матрицы
Procedure GetArraysOU(VAR IND_,OU_:pointer);stdcall;export;
begin
 OU_:=@Comc.Org_UPR;
 IND_:=@Comc.Org_IND;
end;
//запоминание адресов массивов обмена
Procedure GetArrays_Corr(VAR IND_,OU_:pointer);stdcall;export;
begin
 OU_:=@OU_COR;
 IND_:=@MKontrT;
end;

//запоминание адресов массивов обмена
Procedure GetArrays_Buffer(VAR IND_,OU_:pointer);stdcall;export;
begin
 OU_:=@COMC.BuferIN;
 IND_:=@COMC.BuferOUT
end;

Function  ADaptersGetLastError:integer;stdcall;export;
begin
 IF ComPort<0 then Result:=ComPort
 else begin
  IF GettickCount-Comc.LastTimeReceived<300
  then result:=0
  else result:=255;
 end;
end;


Function CheckDataFromAdapter(VAR IND_,OU_):integer;stdcall;export;
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

Function  ADaptersGetKeyNumber:LongWord;StdCall;Export;
BEGIN
 Result:=Comc.KeyNumberCode;
END;

Function CheckLastReceivedTime:DWORD;STDCALL;Export;
BEGIN
 Result:=Comc.LastTimeReceived;
END;
Function CheckLastTransmitTime:DWORD;STDCALL;Export;
BEGIN
 Result:=Comc.LastTimeTransmitted;
END;

//переоткрытие СОМ-порта
Function Reconnect(NPort:Integer):integer;stdcall;export;
begin
 IF Nport>0 then ComPort:=Nport;
 ComC.Close;
 ComC.free;
 Tperep.ConnectToComPort;
 Result:=ComPort;
end;

//перезапись таблиц коррекции данных
Procedure WriteIniTable;stdcall;export;
begin
 Tperep.WriteINITables;
end;


