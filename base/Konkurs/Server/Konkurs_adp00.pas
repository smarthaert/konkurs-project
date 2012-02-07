unit Konkurs_adp00;
(*
 {$D-}
 {$L-}
 {$Y-}
 {$I-}
 {$Q-}
*)
 interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles,ComCryptM;

Const
 Name_INI='Konkurs.INI';
 SizeOfOrgUprMatrix=15;
 SizeOfOrgIndMatrix=15;

 SizeOfRxPacket=0;//17;
 SizeOfTxPacket=33;

 SpeedSHD=254;//скорость отработки шагового двигателя ГПК (255-макс.скорость)

 TIP_ID=0;
 TIP_POT=1;
 TIP_MAB=2;

type
  TOU_Cor=record
   ID_OU,ID_BUF:byte;
   SMESH:integer;
   K:real;
   INV,MAB:Boolean;
   TIP:byte;
  end;
  TBytesArray=array[0..1023]of byte;

  TKonkurs_ADP  = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure GetFromBufIn(var BytesReaded:Dword;Const B);
    procedure SetBufOut(var BytesToWrite:Dword;Const B);
  private
    procedure TranslateFromAdapters;
    procedure TranslateToAdapters;
    procedure Correct_OU(N: integer);
    function CheckIntegityReceived(D: Byte): Byte;
    { Private declarations }
  public
    { Public declarations }
    OU_COR:array[0..11] of TOU_COR;
    Procedure SetCorrectionEnabled;
    Procedure SetCorrectionDisabled;
    Function  ADaptersGetLastError:integer;         //код ошибки обмена (=0-нет ошибок)
    Function  ADaptersGetKeyNumber:LongWord;        //номер комплекта прошитых ключей
    Function  CheckBuffers(VAR IND_,OU_):integer;
    Procedure LOADINITABLES;
    Procedure WRITEINITABLES;
    Procedure SetArraysOU(VAR IND_,OU_);
  end;


var
  Konkurs_ADP: TKonkurs_ADP;
  ComC:TComCryptM;
  MKontrT:array[0..10,0..10]of byte;
  ComPort:integer;
  Br:TBaudRate;
  Corr_Disable:Boolean;
  OutPointer,InPointer:^TBytesArray;
  OLD_MABVN:word=0;Tek_VN:word=0;
  Ar_SBOI:array[0..3,0..48]of byte;
  N_ADP:Byte=0;
  SP_ADAPTERS: ARRAY[1..30] OF Byte = (
       $10,$07,
       $05,$02,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,
       $10,$04,
       $05,$03,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF);

implementation

{$R *.DFM}


Procedure TKonkurs_ADP.SetCorrectionEnabled;
begin
 Corr_Disable:=False;
end;

Procedure TKonkurs_ADP.SetCorrectionDisabled;
begin
 Corr_Disable:=True;
end;

//запоминание адресов массивов обмена
Procedure TKonkurs_ADP.SetArraysOU(VAR IND_,OU_);
begin
 OutPointer:=@IND_;
 InPointer:=@OU_;
end;

Function TKonkurs_ADP.CheckBuffers(VAR IND_,OU_):integer;
begin
 Move(COMC.BuferIN,OU_,50);
 Move(COMC.BuferOUT,IND_,50);
 Result:=0;
end;


Function  TKonkurs_ADP.ADaptersGetLastError:integer;
begin
 IF ComPort<0 then Result:=ComPort
 else begin
  IF GettickCount-Comc.LastTimeReceived<300
  then result:=0
  else result:=255;
 end;
end;

procedure TKonkurs_ADP.SetBufOut(var BytesToWrite:Dword;Const B);
begin
 IF OutPointer<>NIL then Move(OutPointer^,Comc.Org_IND,SizeOfOrgIndMatrix);
 TranslateToAdapters;
end;

procedure TKonkurs_ADP.GetFromBufIn(var BytesReaded:Dword;Const B);
begin
 TranslateFromAdapters;
 IF InPointer<>NIL then Move(Comc.Org_UPR,INPointer^,SizeOfOrgUprMatrix);
end;

procedure TKonkurs_ADP.DataModuleCreate(Sender: TObject);
begin
 OutPointer:=NIL;
 InPointer:=NIL;

 Corr_Disable:=false;
 LoadINITables;
 IF ComPort<0 then exit;
 Comc:=TComCryptM.Create(self);
 Comc.OnSetBufOut:=SetBufOut;
 Comc.OnDataAvail:=GetFromBufIn;
 Comc.ComNumber:=ComPort;
// FPort.ByteSize:= bs8;
// FPort.StopBits:= sb1BITS;
// FPort.Parity:=   ptNONE;
 ComC.BaudRate:= br;
 ComC.TimeOut:=  18;
 ComC.NumOfBytesRXPaket:=SizeOfRxPacket;
 ComC.NumOfBytesTXPaket:=SizeOfTxPacket;
 ComC.Open;
 IF NOT ComC.Connected then ComPort:=-(abs(Comport));
end;

procedure TKonkurs_ADP.DataModuleDestroy(Sender: TObject);
begin
 Comc.Close;
 ComC.free;
end;


Function  TKonkurs_ADP.ADaptersGetKeyNumber:LongWord;
BEGIN
 Result:=Comc.KeyNumberCode;
END;

Procedure TKonkurs_ADP.TranslateToAdapters;
VAR N:byte;
begin
 with ComC do begin
  For N:=0 to 31 do BuferOut[N+1]:=Org_IND[N];
  BuferOut[00]:=$A0;
  BuferOut[01]:=Org_IND[5];
  BuferOut[02]:=Org_IND[6];
  BuferOut[03]:=Org_IND[0];
  BuferOut[04]:=Org_IND[1];
  BuferOut[05]:=Org_IND[2];
  BuferOut[06]:=Org_IND[3];
 end;
end;

procedure TKonkurs_ADP.TranslateFromAdapters;
const MaxM=128;
var I,K:integer; W,V:^WORD;N:word;
begin
  K:=High(High(OU_Cor));
//  For I:=0 to K do Correct_OU(I);
  ComC.Org_UPR[0]:= ComC.BuferIn[03];//порт В
  ComC.Org_UPR[5]:= ComC.BuferIn[04];//порт Е
  ComC.Org_UPR[1]:= ComC.BuferIn[06];
  ComC.Org_UPR[2]:= ComC.BuferIn[05];
  W:=@ComC.Org_UPR[1];
  W^:=(W^ SHR 6)AND $03FF;//МАВ ГН
  ComC.Org_UPR[7]:= ComC.BuferIn[08];
  ComC.Org_UPR[8]:= ComC.BuferIn[07];
  W:=@ComC.Org_UPR[7];
  W^:=(W^ SHR 6)AND $03FF;//МАВ ВН
  N:=(W^SHR 2)AND $FF;
  ComC.Org_UPR[6]:= ComC.BuferIn[09];//потенциометр ВН
  I:=N-OLD_MABVN;
  OLD_MABVN:=N;
  IF (I>MaxM)AND(N>MaxM) then DEC(TEK_VN,2*MaxM);
  IF (I<-MaxM)AND(N<MaxM) then INC(TEK_VN,2*MaxM);
  V:=@ComC.Org_UPR[3];
  V^:=TEK_VN+N;
end;

Function TKonkurs_ADP.CheckIntegityReceived(D:Byte):Byte;
 begin
   IF ((D and $30)=$20)AND((D and $06)<>$06) then result:=0
                                             else result:=$FF;
end;
Procedure TKonkurs_ADP.Correct_OU(N:integer);
 var  IW:integer;B:byte;
 begin
  With OU_COR[N] do begin
   Case tip of
    TIP_ID:begin
            B:=COMC.BuferIn[ID_BUF];
            IF INV THEN b:=NOT B;
            ComC.ORG_UPR[ID_OU]:=B;
            exit;
           end;
    TIP_POT:begin
           end;
    TIP_MAB:begin
             IF CheckIntegityReceived(COMC.BuferIn[ID_BUF+1])<>0 then exit;
           end;
   end;
   B:=COMC.BuferIn[ID_BUF];
   IF INV THEN b:=NOT B;
   IF  NOT(Corr_Disable) Then begin
    IW:=Trunc(B*ABS(K));
    IW:=IW+SMESH;
    While IW>255 do DEC(IW,256);
    While IW<0 DO INC(IW,256);
    ComC.ORG_UPR[ID_OU]:=IW;
   end;
  end;
end;

procedure TKonkurs_ADP.LoadINITables;
Var  MemIni:TIniFile;
     IniFileName:string;
     I:integer;
     S:string;
begin
 IniFileName:=(GetCurrentDir+'\'+Name_INI);
 MemIni:=TIniFile.Create(IniFileName);
 with MemIni do begin
  I:=ReadInteger('MAIN','BAUDRATE',0);
  Case I of
   9600:Br:=br9600;
   19200:Br:=br19200;
   38400:Br:=br38400;
   else br:=br19200;
  end;
  ComPort:=ReadInteger('MAIN','COMPORT',1);
  For I:=0 to High(OU_COR) do begin
   OU_COR[I].smesh:=ReadInteger('ID_'+Inttostr(I),'SMESH',0);
   OU_COR[I].K:=ReadFloat('ID_'+Inttostr(I),'Kpered',1);
   OU_COR[I].ID_OU:=ReadInteger('ID_'+Inttostr(I),'ID_OU',0);
   OU_COR[I].ID_BUF:=ReadInteger('ID_'+Inttostr(I),'ID_BUF',0);
   OU_COR[I].INV:=OU_COR[I].K<0;
   S:=ReadString('ID_'+Inttostr(I),'TIP','');
   IF S='POT' then OU_COR[I].TIP:=TIP_POT
              else IF S='MAB' then OU_COR[I].TIP:=TIP_MAB
                              else OU_COR[I].TIP:=TIP_ID;
  end;
 end;
 MemIni.free;
end;

procedure TKonkurs_ADP.WriteINITables;
Var  MemIni:TIniFile;
     IniFileName:string;
     I:integer;
begin
 IniFileName:=(GetCurrentDir+'\'+Name_INI);
 MemIni:=TIniFile.Create(IniFileName);
 with MemIni do begin
  For I:=0 to High(OU_COR) do begin
   WriteInteger('ID_'+Inttostr(I),'SMESH',OU_COR[I].smesh);
   WriteFloat('ID_'+Inttostr(I),'Kpered',OU_COR[I].K);
  end;
 end;
 MemIni.free;
end;

end.
