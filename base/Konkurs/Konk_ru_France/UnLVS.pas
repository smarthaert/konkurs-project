unit UnLVS;

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls,
  Forms, Dialogs,
  UnOther, NMUDP,
  UnBuildSetka, UnOcenka;

const
  TIME_LINE = 7;               // сек может отсутствовать связь
  IP_ADRESS_CIRK='192.168.1.100';
  COL_ABONENT = 10;

  CIRCULAR_PORT = 6680;
  RUKOVOD_PORT  = 6681;
  SERVER_PORT   = 6682;
  VIEWER_PORT   = 6683;

type
  TLVS = class(TForm)

    procedure FormCreate(Sender: TObject);

    procedure NMUDP1DataReceived(Sender: TComponent; NumberBytes: Integer;
      FromIP: String; Port: Integer);
    procedure NMUDP2DataReceived(Sender: TComponent; NumberBytes: Integer;
      FromIP: String; Port: Integer);
  private
    NMUDP1, NMUDP2 : TNMUDP;
  public
    procedure Init_IPX;
    procedure Trans_Kom;
    procedure Obrabotka_Komand;
    procedure Send_IPX(mode_tr,n:word);
    procedure Receiv_IPX(i:integer);
    procedure Receiv_organ;
    procedure Trans_Model;
    procedure Trans_Isx_pol;
  end;

var
  LVS             : TLVS;
  Line_Kom        : word;
  IP_addres_svoj  : string;
  IP_Opredelen    : boolean;
  Preparation     : array [0..COL_ABONENT-1] of word;
  numKvit         : array [0..COL_ABONENT-1] of byte;
  BuffTr          : Array [0..64,1..2000] of Char;
  BuffRc          : Array [1..2000] of Char;
  KommandR        : array[1..2] of byte;
  KommandTr       : array[1..2] of byte;

implementation

uses Main, UnModel;

{$R *.DFM}

procedure TLVS.FormCreate(Sender: TObject);
begin
  Init_IPX;
end;

procedure TLVS.Init_IPX;
begin

  NMUDP1                :=  TNMUDP.Create(self);
  NMUDP1.OnDataReceived :=  NMUDP1DataReceived;
  NMUDP1.ReportLevel    :=  Status_Basic;
  NMUDP1.LocalPort      :=  RUKOVOD_PORT;
  NMUDP1.RemotePort     :=  CIRCULAR_PORT;
  NMUDP1.RemoteHost     :=  IP_ADRESS_CIRK;

  NMUDP2                :=  TNMUDP.Create(self);
  NMUDP2.OnDataReceived :=  NMUDP2DataReceived;
  NMUDP2.ReportLevel    :=  Status_Basic;
  NMUDP2.LocalPort      :=  VIEWER_PORT;
  NMUDP2.RemotePort     :=  CIRCULAR_PORT;
  NMUDP2.RemoteHost     :=  IP_ADRESS_CIRK;
end;

procedure TLVS.Trans_Kom;
begin
  MoveMemory(@BuffTr[endO],@KommandTr,LVS_KOMAND);
//  Send_IPX(1, endO);
  Potok[endO,1]:=1;  Potok[endO,3]:=2;
  inc(endO); endO:=endO and $3f; //Передача информации на РМИ
end;

procedure TLVS.Receiv_IPX(i:integer);
begin
  //Сообщение от  руководителя
  case i of
    LVS_KOMAND: begin   // Команды
      MoveMemory(@KommandR,@BuffRc,LVS_KOMAND);
      Obrabotka_Komand;
    end;
    LVS_SERVER_PTUR: begin
      if otobr_RM=RM_RUKOVOD then begin
        MoveMemory(@BMP[Num_BMP],@BuffRc,LVS_SERVER_PTUR);
        Receiv_organ;
      end;
    end;
  end;
end;

procedure TLVS.Obrabotka_Komand;
var
  a: word;
begin
  case KommandR[1] of
    PORAJ_PTUR: begin
      DeMont_Target[Num_BMP,KommandR[2]]:=true;
      Poraj[Num_BMP,KommandR[2]]:=true;
    end;
    // Команды, относяшиеся к выключению
    POWER_PK: case KommandR[2] of
      POWER_CLOSE:begin Mode_off:=0; Form1.close; end;
      POWER_OFF:begin Mode_off:=1; Form1.close; end;
      POWER_REBOOT:begin Mode_off:=2; Form1.close; end;
    end;
    SINCHRO..SINCHRO+20: begin
      a:=KommandR[1]-SINCHRO;
      Preparation[a]:=3;
      numKvit[a]:=KommandR[2];
    end;
  end;
end;

procedure TLVS.Send_IPX(mode_tr, n: word);
begin
  case mode_tr of
    2: begin
        NMUDP1.SendBuffer(BuffTr[n],LVS_KOMAND);
    end;
    10: begin
        NMUDP1.SendBuffer(BuffTr[n],LVS_ISX_DAN);
    end;
    13: begin
        NMUDP1.SendBuffer(BuffTr[n],LVS_MODEL);
    end;
    14: begin
        NMUDP1.SendBuffer(BuffTr[n],LVS_TARGET);
    end;
  end;
end;

procedure TLVS.Receiv_organ;
begin
  if Missile_Start_old<>BMP[Num_BMP].Start_PTUR then begin
    Missile_Start_old:=BMP[Num_BMP].Start_PTUR;
    if not BMP[Num_BMP].Start_PTUR then begin
      case BMP[Num_BMP].Mode of
        6: begin
          DeMont_Target[Num_BMP,BMP[Num_BMP].Num_destroy]:=true;
          Poraj[Num_BMP,BMP[Num_BMP].Num_destroy]:=true;
          num_BMP_temp:=Num_BMP;
          Ris_target(BMP[Num_BMP].Num_destroy,Koord_poraj_X[Num_BMP][1],Koord_poraj_Y[Num_BMP][1],20,1);
          if Koord_poraj_X[Num_BMP][1]<70 then Koord_poraj_X[Num_BMP][1]:=Koord_poraj_X[Num_BMP][1]+15;
          inc(Ocenka[Num_BMP].Col_PTUR);
          Ocenka[Num_BMP].num_PTUR[Ocenka[Num_BMP].Col_PTUR]:=BMP[Num_BMP].Num_destroy;
        end;
        7: begin
          Poraj_TAK_TEX[BMP[Num_BMP].Num_destroy]:=1;
        end;
      end;
    end
    else begin
      if Ocenka[Num_BMP].FirstShot=0 then Ocenka[Num_BMP].FirstShot:=Time_Upr;
    end;
  end;
  if BMP[Num_BMP].Col_Upr<>Boek[Num_BMP].Col_Upr then begin
    Boek[Num_BMP].Col_Upr:=BMP[Num_BMP].Col_Upr;
    Form1.OtobrPanel(2);
  end;
end;

procedure TLVS.Trans_Isx_pol;
begin
  MoveMemory(@BuffTr[endO],@Task,LVS_ISX_DAN);
  Potok[endO,1]:=1;  Potok[endO,2]:=1; Potok[endO,3]:=10;
  inc(endO); endO:=endO and $3f;
end;

procedure TLVS.Trans_Model;
begin
  if (Task.m_index<5000) then begin
    MoveMemory(@BuffTr[endO],@Targets,LVS_TARGET);
    Potok[endO,1]:=1; Potok[endO,2]:=1;  Potok[endO,3]:=14;
    inc(endO); endO:=endO and $3f;
  end;
  if (Task.m_index>5000)and(Task.m_index<6000) then begin
    MoveMemory(@BuffTr[endO],@Model,LVS_MODEL);
//  MoveMemory(@BuffTr[endO,1200],@targetsTaktika,LVS_TARG_TAK);
    Potok[endO,1]:=1; Potok[endO,2]:=1;  Potok[endO,3]:=13;
    inc(endO); endO:=endO and $3f;
  end;
end;

procedure TLVS.NMUDP1DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stop_prog then exit;
  NMUDP1.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
end;

procedure TLVS.NMUDP2DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stop_prog then exit;
  NMUDP2.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
end;

end.
