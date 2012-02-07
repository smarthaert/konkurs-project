unit UnLVS;

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls,
  Forms, Dialogs,
  UnOther, NMUDP,
  UnBuild, UnDraw,
  UnAction;

const
  TIME_LINE=7;               // сек может отсутствовать связь
  IP_ADRESS_CIRK='192.168.1.100';

  CIRCULAR_PORT=6680;        // Порт цыркулярного обмена
  RUKOVOD_PORT=6681;         // Порт руководитель
  SERVER_PORT=6682;          // Порт сервер
  VIEWER_PORT=6683;          // Порт вьюер

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
    procedure Send_IPX(mode_tr:word);
    procedure Receiv_IPX(i:integer);
    procedure Receiv_organ(n: integer);
    procedure Trans_Model;
    procedure Obrabotka_Komand;
  end;

var
  LVS: TLVS;
  Line_Kom: word;
  IP_addres_svoj: string;
  IP_Opredelen: boolean;
  Preparation:word;
  Trans_pre:boolean;
  // Сетевые переменные
   BuffTr: Array [1..2000] of Char;
   BuffRc: Array [1..2000] of Char;
   KommandR: array[1..2] of byte;
   KommandTr: array[1..2] of byte;
   numKvit: byte;

implementation

uses Main;

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
  NMUDP1.LocalPort:=VIEWER_PORT;
  NMUDP1.RemotePort:=RUKOVOD_PORT;
  NMUDP1.RemoteHost:=IP_ADRESS_CIRK;

  NMUDP2 := TNMUDP.Create(self);
  NMUDP2.OnDataReceived := NMUDP2DataReceived;
  NMUDP2.ReportLevel:=Status_Basic;
  NMUDP2.LocalPort:=CIRCULAR_PORT;
  NMUDP2.RemotePort:=CIRCULAR_PORT;
  NMUDP2.RemoteHost:=IP_ADRESS_CIRK;
end;

procedure TLVS.Trans_Kom;
begin
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
      MoveMemory(@BMP[Num_BMP],@BuffRc,LVS_SERVER_PTUR);
      ChangeServer(Num_BMP);
    end;
    LVS_ISX_DAN: begin
      MoveMemory(@Task,@BuffRc,LVS_ISX_DAN);
      if numKvit<>Task.numKvit then begin
        numKvit:=Task.numKvit;
        stopProg:=true;
        Potok[endO,1]:=5; inc(endO); endO:=endO and $3f;
      end;
    end;
    LVS_TARGET: begin  // мишени
      MoveMemory(@Targets,@BuffRc,LVS_TARGET);
    end;
    LVS_MODEL: begin
      MoveMemory(@Model, @BuffRc,LVS_MODEL);
    end;
  end;
end;

procedure TLVS.Obrabotka_Komand;
var a,b,c: integer;
n: longint;
Sender: TObject;
begin
  case KommandR[1] of
    // Команды, относяшиеся к задаче
    ZADACHA: case KommandR[2] of
      ZAD_SIGNAL:begin
        // Восстановление боекомплекта
      end;
      ZAD_BEGIN_UPR: begin
      end;
      ZAD_END_UPR: begin
        Form1.isxPol;
      end;
      ZAD_ISX_POL: begin
        Form1.isxPol;
      end;
    end;
    // Команды, относяшиеся к выключению
    POWER_PK: case KommandR[2] of
      POWER_CLOSE:  begin Mode_off:=0; Form1.close; end;
      POWER_OFF:    begin Mode_off:=1; Form1.close; end;
      POWER_REBOOT: begin Mode_off:=2; Form1.close; end;
    end;
    VIEWER_MODE: begin
      if  real_RM=RM_RUKOVOD then begin
        if KommandR[2]<VIEWER_RIGHRT then begin
          otobr_RM:=KommandR[2];
          Form1.FormResize(nil);
        end
        else begin
          case KommandR[2] of
            VIEWER_RIGHRT:begin
              anglH:=anglH+1;
              if anglH>=360 then anglH:=anglH-360;
            end;
            VIEWER_LEFT:begin
              anglH:=anglH-1;
              if anglH<0 then anglH:=anglH+360;
            end;
            VIEWER_UP:begin
              anglX:=anglX-1;
            end;
            VIEWER_DOUN:begin
              anglX:=anglX+1;
            end;
            VIEWER_SCALE_PLUS: if kratn<5 then kratn:=kratn+0.5;
            VIEWER_SCALE_MINUS:if kratn>1 then kratn:=kratn-0.5;
          end;
        end;
      end;
    end;
  end;
end;

procedure TLVS.Send_IPX(mode_tr: word);
begin
  case mode_tr of
    2: begin
      MoveMemory(@BuffTr,@KommandTr,LVS_KOMAND);
      NMUDP1.SendBuffer(BuffTr,LVS_KOMAND);
    end;
  end;
end;

procedure TLVS.Receiv_organ(n: integer);
begin
//  Form1.Otrabotka(n);
end;

procedure TLVS.Trans_Model;
begin
  if (Task.m_index>5000)and(Task.m_index<6000) then begin
    MoveMemory(@BuffTr[endO],@Model,LVS_MODEL);
    Potok[endO,1]:=1; Potok[endO,2]:=1;  Potok[endO,3]:=13;
    inc(endO); endO:=endO and $3f;
  end;
end;

procedure TLVS.NMUDP1DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stopProg then exit;
  NMUDP1.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
  Preparation:=3;
  Trans_pre:=true;
end;

procedure TLVS.NMUDP2DataReceived(Sender: TComponent; NumberBytes: Integer;
  FromIP: String; Port: Integer);
var I: integer;
begin
  if stopProg then exit;
  NMUDP2.ReadBuffer(BuffRc,I);
  if i=-1 then exit;
  Receiv_IPX(i);
  Preparation:=3;
  Trans_pre:=true;
end;

end.
