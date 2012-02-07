unit UnPoint;    //Формирование информации о перемещении стрелка

interface

uses
  Windows, SysUtils,
  Classes, Graphics,
  Forms, Controls,
  StdCtrls, Buttons,
  ExtCtrls, Spin;

type
  TOKBottomDlg7 = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    CheckBox1: TCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpinEdit4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg7  : TOKBottomDlg7;

implementation

{$R *.DFM}

procedure TOKBottomDlg7.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TOKBottomDlg7.SpinEdit4Change(Sender: TObject);
begin
  Label6.Caption:=inttostr(SpinEdit4.Value div 60)+' min'+inttostr(SpinEdit4.Value mod 60)+' sec';
end;

end.
