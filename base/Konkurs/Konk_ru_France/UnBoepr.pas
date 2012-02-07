unit UnBoepr; //ввод количества боеприпасов, выстрелов

interface

uses
  Windows, SysUtils,
  Classes, Graphics,
  Forms, Controls,
  StdCtrls, Buttons,
  ExtCtrls, Spin,
  ComCtrls, CheckLst;

type
  TOKBottomDlg5 = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel4: TPanel;
    Label4: TLabel;
    SpinEdit4: TSpinEdit;
    Button1: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg5: TOKBottomDlg5;

implementation

{$R *.DFM}

procedure TOKBottomDlg5.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TOKBottomDlg5.Button1Click(Sender: TObject);
begin
  SpinEdit4.Value :=  0;
end;

end.
