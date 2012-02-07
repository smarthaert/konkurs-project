unit UnColor;   //¬вод цвета

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TChangColor = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image6: TImage;
    Image5: TImage;
    Image4: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Vybor_color;
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Image10Click(Sender: TObject);
  private
    { Private declarations }
  public
    Num_color: word;
  end;

var
  ChangColor: TChangColor;

implementation

{$R *.DFM}

procedure TChangColor.Vybor_color;
begin
  case Num_color of
     0:begin
       Label1.Left:=82;
       Label1.Top:=218;
     end;
     1:begin
       Label1.Left:=10;
       Label1.Top:=10;
     end;
     2:begin
       Label1.Left:=82;
       Label1.Top:=10;
     end;
     3:begin
       Label1.Left:=154;
       Label1.Top:=10;
     end;
     4:begin
       Label1.Left:=10;
       Label1.Top:=79;
     end;
     5:begin
       Label1.Left:=82;
       Label1.Top:=79;
     end;
     6:begin
       Label1.Left:=154;
       Label1.Top:=79;
     end;
     7:begin
       Label1.Left:=10;
       Label1.Top:=148;
     end;
     8:begin
       Label1.Left:=82;
       Label1.Top:=148;
     end;
     9:begin
       Label1.Left:=154;
       Label1.Top:=148;
     end;
  end;
end;

procedure TChangColor.Image1Click(Sender: TObject);
begin
  Num_color:=1;
  Vybor_color;
end;

procedure TChangColor.Image2Click(Sender: TObject);
begin
  Num_color:=2;
  Vybor_color;
end;

procedure TChangColor.Image3Click(Sender: TObject);
begin
  Num_color:=3;
  Vybor_color;
end;

procedure TChangColor.Image4Click(Sender: TObject);
begin
  Num_color:=4;
  Vybor_color;
end;

procedure TChangColor.Image5Click(Sender: TObject);
begin
  Num_color:=5;
  Vybor_color;
end;

procedure TChangColor.Image6Click(Sender: TObject);
begin
  Num_color:=6;
  Vybor_color;
end;

procedure TChangColor.Image7Click(Sender: TObject);
begin
  Num_color:=7;
  Vybor_color;
end;

procedure TChangColor.Image8Click(Sender: TObject);
begin
  Num_color:=8;
  Vybor_color;
end;

procedure TChangColor.Image9Click(Sender: TObject);
begin
  Num_color:=9;
  Vybor_color;
end;

procedure TChangColor.FormActivate(Sender: TObject);
begin
  Vybor_color;
end;

procedure TChangColor.Image10Click(Sender: TObject);
begin
  Num_color:=0;
  Vybor_color;
end;

end.
