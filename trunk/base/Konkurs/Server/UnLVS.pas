unit UnLVS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, UnOther,
  NMUDP, UnBuildServer, UnSound;

const
  TIME_LINE=7;               // сек может отсутствовать связь
  IP_ADRESS_RUK='192.168.1.100';
  IP_ADRESS_NAV='192.168.1.100';
  CIRCULAR_PORT=6680;
  RUKOVOD_PORT=6681;
  SERVER_PORT=6682;
  VIEWER_PORT=6683;

type
  TLVS = class(TForm)

    procedure FormCreate(Sender: TObject);

    procedure NMUDP1DataReceived(Sender: TComponent; NumberBytes: Integer;
      FromIP: String; Port: Integer);
    procedure NMUDP2DataReceived(Sender: TComponent; NumberBytes: Integer;
      FromIP: String; Port: Integer);
      
  private
    NMUDP1: TNMUDP;
    NMUDP2: TNMUDP;
  public
    procedure Init_IPX;
    procedure Trans_Kom;
    procedure Obrabotka_Komand;
    procedure Send_IPX(mode_tr,n:word);
    procedure Receiv_IPX(i:integer);
    procedure Receiv_organ(n: integer);
    procedure Trans_Model;
    procedure ReCountTypModel;

  end;

var
  LVS: TLVS;
  Line_Kom: word;
  IP_addres_svoj: string;
  IP_Opredelen: boolean;
  Preparation:word;
  Trans_pre:boolean;
  BuffTr: Array [0..64,1..2000] of Char;
  BuffRc: Array [1..2000] of Char;
  KommandR: array[1..2] of byte;
  KommandTr: array[1..2] of byte;
  numKvit: byte;

implementation

uses Main, UnOrgan;

{$R *.DFM}

procedure TLVS.FormCreate(Sender: TObject);
begin
  Init_IPX;
end;

procedure TLVS.Init_IPX;
begin
  NMUDP1 := TNMUDP.Create(self);
  NMUDP1.OnDataReceived := NMUDP1DataReceived;
  NMUDP1.ReportLevel:=Status_Basic;
  NMUDP1.LocalPort:=SERVER_PORT;
  NMUDP1.RemotePort:=VIEWER_PORT;
  NMUDP1.RemoteHost:=IP_ADRESS_NAV;

  NMUDP2 := TNMUDP.Create(self);
  NMUDP2.OnDataReceived := NMUDP2DataReceived;
  NMUDP2.ReportLevel:=Status_Basic;
  NMUDP2.LocalPort:=CIRCULAR_PORT;
  NMUDP2.RemotePort:=RUKOVOD_PORT;
  NMUDP2.RemoteHost:=IP_ADRESS_NAV;
end;

procedure TLVS.Trans_Kom;
begin
  MoveMemory(@BuffTr[endO],@KommandTr,LVS_KOMAND);
  Potok[endO,1]:=1;  Potok[endO,2]:=2;
  inc(endO); endO:=endO and $3f; //Передача информации на РМИ
end;

procedure TLVS.NMUDP1DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stop_prog then exit;
  NMUDP1.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
  Preparation:=3;
  Trans_pre:=true;
end;

procedure TLVS.Receiv_IPX(i:integer);
begin
  //Сообщение от  руководителя
  case i of
    LVS_KOMAND: begin   // Команды
      MoveMemory(@KommandR,@BuffRc,LVS_KOMAND);
      Potok[endO,1]:=2; Potok[endO,2]:=1;inc(endO); endO:=endO and $3f;
    end;
    LVS_ISX_DAN: begin
      MoveMemory(@Task,@BuffRc,LVS_ISX_DAN);
      if numKvit<>Task.numKvit then begin
        numKvit:=Task.numKvit;
        Potok[endO,1]:=5; inc(endO); endO:=endO and $3f;
      end;
    end;
    LVS_TARGET: begin  // мишени
      MoveMemory(@Targets,@BuffRc,LVS_TARGET);
    end;
    LVS_MODEL: begin  // мишени
      MoveMemory(@Model,@BuffRc,LVS_MODEL);
      ReCountTypModel;
    end;
  end;
end;

procedure TLVS.Obrabotka_Komand;
begin
  case KommandR[1] of
    // Команды, относяшиеся к задаче
    ZADACHA: case KommandR[2] of
      ZAD_SIGNAL:begin
        // Восстановление боекомплекта
        Vostan_BK;
        NewRec.Play[1]:=true;
      end;
      ZAD_END_UPR: begin
        Form1.isx_pol;
        Vostan_BK;
//        NewRec.Play[2]:=true;
      end;
      ZAD_ISX_POL: begin
        Form1.Isx_pol;
        NewRec.Play[2]:=true;
      end;
    end;
    PORAJ_PTUR: begin
      Poraj[Num_BMP,KommandR[2]]:=true;
    end;
    // Команды, относяшиеся к выключению
    POWER_PK: case KommandR[2] of
      POWER_CLOSE:begin Mode_off:=0; Form1.close; end;
      POWER_OFF:begin Mode_off:=1; Form1.close; end;
      POWER_REBOOT:begin Mode_off:=2; Form1.close; end;
    end;
    ISPRAVN2_1: begin
        if KommandR[2]and $1=$0 then BMP[num_BMP].Ispravn_PTUR_Fill:=true else BMP[num_BMP].Ispravn_PTUR_Fill:=false;
        if KommandR[2]and $2=$0 then BMP[num_BMP].Ispravn_PTUR_Optik:=true else BMP[num_BMP].Ispravn_PTUR_Optik:=false;
        if KommandR[2]and $4=$0 then BMP[num_BMP].Ispravn_PTUR_Pomexa:=true else BMP[num_BMP].Ispravn_PTUR_Pomexa:=false;
        if KommandR[2]and $8=$0 then BMP[num_BMP].Ispravn_PTUR_Start:=true else BMP[num_BMP].Ispravn_PTUR_Start:=false;
        if KommandR[2]and $20=$0 then BMP[num_BMP].Ispravn_PTUR_Marsh:=true else BMP[num_BMP].Ispravn_PTUR_Marsh:=false;
    end;

  end;
end;

procedure TLVS.Send_IPX(mode_tr, n: word);
begin
  case mode_tr of
    1: begin
        NMUDP1.SendBuffer(BuffTr[n],LVS_SERVER_PTUR);
    end;
    2: begin
        MoveMemory(@BuffTr[endO],@KommandTr,LVS_KOMAND);
        NMUDP2.SendBuffer(BuffTr[endO],LVS_KOMAND);
    end;
  end;
end;

procedure TLVS.Receiv_organ(n: integer);
begin
  Otrabotka_LVS(n);
end;

procedure TLVS.Trans_Model;
begin
  if (Task.m_index>5000)and(Task.m_index<6000) then begin
    MoveMemory(@BuffTr[endO],@Model,LVS_MODEL);
    Potok[endO,1]:=1; Potok[endO,2]:=1;  Potok[endO,3]:=13;
    inc(endO); endO:=endO and $3f;
  end;
end;

procedure TLVS.NMUDP2DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stop_prog then exit;
  NMUDP2.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
  Preparation:=3;
  Trans_pre:=true;
end;

procedure TLVS.ReCountTypModel;
var
a: word;
begin
  for a:=1 to COL_TEXNIKA_MODEL do begin
    case Model[a].Typ of
      1..30: Model[a].Typ:=1;
      31..40: Model[a].Typ:=3;
      41..50: Model[a].Typ:=3;
    end;
  end;

end;

end.
