unit UnOtkaz;     // Задание таблицы отказов комплекса

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UnLVS, UnOther;

type
  TOtkaz = class(TForm)
    Panel16: TPanel;
    Label16: TLabel;
    CheckBox16: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox22: TCheckBox;
    procedure CheckBox16Click(Sender: TObject);
  private                                
    { Private declarations }
  public
    num: word;
    { Public declarations }
  end;

var
  Otkaz       : TOtkaz;
  ispravnInf1 : byte;
  ispravnInf2 :byte;
  ispravnInf3 :byte;

implementation
uses
  Main;
{$R *.DFM}

procedure TOtkaz.CheckBox16Click(Sender: TObject);
begin
  ispravnInf2:=0;
  if CheckBox16.Checked then ispravnInf2:=ispravnInf2+$1;
  if CheckBox18.Checked then ispravnInf2:=ispravnInf2+$2;
  if CheckBox19.Checked then ispravnInf2:=ispravnInf2+$4;
  if CheckBox20.Checked then ispravnInf2:=ispravnInf2+$8;
  if CheckBox22.Checked then ispravnInf2:=ispravnInf2+$20; //"Неисправность маршевого двигателя"
  KommandTr[1]:=ISPRAVN2_1;
  KommandTr[2]:=ispravnInf2;
  LVS.Trans_Kom;
end;

end.



