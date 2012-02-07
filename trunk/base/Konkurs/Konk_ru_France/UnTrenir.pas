unit UnTrenir;

interface

uses Windows, Dialogs, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Shellapi,UnOther;

type
  TTrenir = class(TForm)
    CancelBtn: TButton;
    Bevel1: TBevel;
    Button1: TButton;
    RadioGroup2: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    TreeView2: TTreeView;
    StaticText1: TStaticText;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TreeView1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  CurPath = 'Text\';


var
  Trenir: TTrenir;
  num_selected: integer;         // Номер выбранной операции
  change: boolean;
  num: word;

implementation
Uses Main, UnLine;
{$R *.DFM}

procedure TTrenir.FormCreate(Sender: TObject);
begin
  num_selected:=0;
  num:=0;
  change:=false;
end;

procedure TTrenir.Button1Click(Sender: TObject);
var a: word;
begin
  if not change then exit;// не было выбора
  num_selected:=TreeView2.Selected.SelectedIndex;
  // выбран не работающий пункт
  if (num_selected<1)or(num_selected>99)  then begin
    MessageDlg('Действие не выбрано', mtInformation,[mbOk], 0);
    StaticText1.Caption:='Действие не выбрано';
    Caption:='Действия при вооружении';
    Button2.Enabled:=false;
    Button3.Enabled:=false;
    exit;
  end;
  Caption:=TreeView2.Selected.Text;
  StaticText1.Caption:=TreeView2.Selected.Text;
  Kommand[1]:=OPERATION;
  if (num_selected>=20) and (num_selected<30) then begin /// Проверка функционирования
    Kommand[2]:=OPER_CTRL_FUNCTION;
    Button2.Enabled:=false;
    Button3.Enabled:=true;
    Button4.Enabled:=true;
    Button5.Enabled:=true;
    RadioGroup2.Enabled:=false;
  end
  else begin
    if (num_selected<20) then begin
      Button2.Enabled:=true;
      Button3.Enabled:=true;
      Button4.Enabled:=false;
      Button5.Enabled:=false;
      RadioGroup2.Enabled:=true;
      Kommand[2]:=num_selected;
      Num_Prog:=num_selected;
    end;
  end;
  Form1.Trans_kom($ff);
end;

procedure TTrenir.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  exit;
  if Num_Prog=0 then exit;
{  if key in [VK_F1,VK_F2,VK_F3] then begin
    mesto:='n';
    Oper_Ruk.Isx_Pol;
    Oper_Ruk.Enabled:=true;
    Oper_Ruk.Visible:=true;
    Oper_Ruk.Show;
  end;
   case key of
    VK_ESCAPE:begin
      Oper_Ruk.Visible:=false;
      Oper_Ruk.Enabled:=false;
    end;
    VK_F1: Num_BMP:=1;
    VK_F2: Num_BMP:=2;
    VK_F3: Num_BMP:=3;
//    VK_F5: begin
//      Application.CreateForm(TFormLine, FormLine);
//      FormLine.ShowModal;
//    end;
  end;}
end;

procedure TTrenir.TreeView1Click(Sender: TObject);
begin
  change:=true;// Был выбор
end;

procedure TTrenir.Button2Click(Sender: TObject);
var a:word;
begin
  if (num_selected=0)  then exit;
  TreeView2.Enabled:=false;
  Button1.Enabled:=false;
  Kommand[1]:=OPERATION;
  case  Trenir.RadioGroup2.ItemIndex of
    0: Kommand[2]:=OPER_SAMOOB_BEGIN;
    1: Kommand[2]:=OPER_TRENIR_BEGIN;
    2: Kommand[2]:=OPER_KONTRL_BEGIN;
  end;
  Form1.Trans_kom($ff);
  for a:=1 to COL_EKIP do begin
    Num_Oper_Error[1,a]:=false;
    Num_Oper_Error[2,a]:=false;
//    Num_Oper[1,a]:=1;
//    Num_Oper[2,a]:=1;
  end;
end;

procedure TTrenir.Button3Click(Sender: TObject);
begin
  TreeView2.Enabled:=true;
  Button1.Enabled:=true;
  Kommand[1]:=OPERATION;
  Kommand[2]:=OPER_END;
  Form1.Trans_kom($ff);
end;

procedure TTrenir.Button4Click(Sender: TObject);
begin
  Kommand[1]:=OPERATION;
  Kommand[2]:=OPER_RASSOGL_VYVER;
  Form1.Trans_kom(0);// Только наводчикам
end;

procedure TTrenir.Button5Click(Sender: TObject);
begin
  Kommand[1]:=OPERATION;
  Kommand[2]:=OPER_SOGL_VYVER;
  Form1.Trans_kom(0);// Только наводчикам
end;

procedure TTrenir.FormDestroy(Sender: TObject);
begin
  Kommand[1]:=OPERATION;;
  Kommand[2]:=OPER_END;
  Form1.Trans_kom($ff);
end;

end.



