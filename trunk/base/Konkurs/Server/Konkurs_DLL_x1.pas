unit Konkurs_DLL_x1;
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
 maxOtsch=30;   //число усредняемых отсчетов по ВН грубого отсчета
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

  TKonkurs_DLL  = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure GetFromBufIn(var BytesReaded:Dword;Const B);
    procedure SetBufOut(var BytesToWrite:Dword;Const B);
  private
    procedure TranslateFromAdapters;
    procedure TranslateToAdapters;
    procedure Correct_OU(N: integer);
    function CheckIntegityReceived(D: Byte): Byte;
    procedure PrivjazkaUM;
    { Private declarations }
  public
    { Public declarations }
    Procedure LOADINITABLES;
    Procedure WRITEINITABLES;
    procedure ConnectToComPort;
  end;


var
  Konkurs_DLL: TKonkurs_DLL;
  ComC:TComCryptM;
  OU_COR:array[0..11] of TOU_COR;
  MKontrT:array[0..10,0..10]of byte;
  BufVN:array[0..maxOtsch] of byte;//word;
  Tabl:array [0..10]of byte;
  Count_UM:integer=0;
  NOT_PRV:boolean=True;
  ComPort:integer;
  Br:TBaudRate;
  Corr_Disable:Boolean;
  Obmen_Disable:Boolean=false;
  OutPointer,InPointer:^TBytesArray;
  OLD_MABVN:word=0;Tek_VN:word=0;
  Ar_SBOI:array[0..3,0..48]of byte;
  N_ADP:Byte=0;
  SP_ADAPTERS: ARRAY[1..30] OF Byte = (
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF,$00,
       $FF);

implementation

{$R *.DFM}


procedure TKonkurs_DLL.SetBufOut(var BytesToWrite:Dword;Const B);
begin
 IF OutPointer<>NIL then Move(OutPointer^,Comc.Org_IND,SizeOfOrgIndMatrix);
 TranslateToAdapters;
end;

procedure TKonkurs_DLL.GetFromBufIn(var BytesReaded:Dword;Const B);
begin
 TranslateFromAdapters;
 IF InPointer<>NIL then Move(Comc.Org_UPR,INPointer^,SizeOfOrgUprMatrix);
end;

procedure TKonkurs_DLL.DataModuleCreate(Sender: TObject);
var I:word;
begin
 For I:=0 to maxOtsch do BufVN[I]:=0;

 OutPointer:=NIL;
 InPointer:=NIL;

 Corr_Disable:=false;
 LoadINITables;
 ConnectToComPort;
end;

procedure TKonkurs_DLL.ConnectToComPort;
begin
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


procedure TKonkurs_DLL.DataModuleDestroy(Sender: TObject);
begin
 Comc.Close;
 ComC.free;
end;


Procedure TKonkurs_DLL.TranslateToAdapters;
VAR N:byte;
begin
 with ComC do begin
  For N:=0 to 31 do BuferOut[N+1]:=Org_IND[N];
  BuferOut[00]:=$A0;
  BuferOut[00]:=$90;
  BuferOut[01]:=Org_IND[5];
  BuferOut[02]:=Org_IND[6];
  BuferOut[03]:=Org_IND[0];
  BuferOut[04]:=Org_IND[1];
  BuferOut[05]:=Org_IND[2];
  BuferOut[06]:=Org_IND[3];
 end;
end;

procedure TKonkurs_DLL.TranslateFromAdapters;
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
  I:=N-OLD_MABVN;
  OLD_MABVN:=N;
  IF (I>MaxM)AND(N>MaxM) then DEC(Count_UM);
  IF (I<-MaxM)AND(N<MaxM) then INC(Count_UM);

  V:=@ComC.Org_UPR[3];
 //**** V^:=Count_UM*512+(W^ div 2);
  V^:=25724+Count_UM*128+(W^ div 8);

//  Move(BufVN[1],BufVN[0],sizeof(BufVN[0])*maxOtsch);
  Move(BufVN[1],BufVN[0],maxOtsch);
  BufVN[maxOtsch]:=ComC.BuferIn[09];

  N:=ComC.BuferIn[11]*4;
  IF (ComC.BuferIn[15]and $80)<>0 then N:=N+2;
  IF (ComC.BuferIn[15]and $40)<>0 then N:=N+1;
  IF N>110 then N:=N-110 else N:=0;
  BufVN[maxOtsch]:=N;

  N:=0;For I:=0 to maxOtsch do INC(N,BufVN[I]);
  ComC.Org_UPR[6]:= N div ((maxOtsch+1));//потенциометр ВН

  IF NOT_PRV then begin
    For I:=0 to maxOtsch do IF BufVN[I]=0 then exit;
    PrivjazkaUM;
    NOT_PRV:=false;
  end;
end;

procedure TKonkurs_DLL.PrivjazkaUM;
var N,I:integer;R:real;
begin
  N:=0;
  For I:=10 to maxOtsch do INC(N,BufVN[I]);
  N:=N div (maxOtsch-9);//потенциометр ВН
  I:=0;
  While (I<=high(Tabl))AND(N>Tabl[I]) do INC(I);
//  IF I>High(Tabl) then exit;
  R:=Tabl[I]-Tabl[I-1];
  R:=(R/10);
  R:=(I-1)*10+(N-Tabl[I-1])/R;
  Count_UM:=Round(R)+5;
end;


Function TKonkurs_DLL.CheckIntegityReceived(D:Byte):Byte;
begin
  IF ((D and $30)=$20)AND((D and $06)<>$06) then result:=0
                                            else result:=$FF;
end;

Procedure TKonkurs_DLL.Correct_OU(N:integer);
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

procedure TKonkurs_DLL.LoadINITables;
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
  For I:=0 to 10 do  Tabl[I]:=ReadInteger('TABLE',Inttostr(I),0);
 end;
 MemIni.free;
end;

procedure TKonkurs_DLL.WriteINITables;
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
