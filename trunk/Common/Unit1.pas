unit Unit1;

interface

uses
  UnOther, UnBuildSetka;

 procedure InitModels;
 procedure InitModels1;


implementation

procedure InitModels;
var a: word;
begin
  for a:=1 to 5 do begin
    Model[a].Typ:=a;
    Model[a].Xtek:=30+a*2;
    Model[a].Ytek:=50;
    Model[a].Htek:=CountHeight(Model[a].Xtek, Model[a].Ytek)+0.5;
    Model[a].AzBase:=180;
    Model[a].Akt:=$10;
  end;
{  for a:=6 to 8 do begin
    Model[a].Typ:=a+54;
    Model[a].Xtek:=10+a*2;
    Model[a].Ytek:=20;
    Model[a].Htek:=CountHeight(Model[a].Xtek, Model[a].Ytek);
    Model[a].AzBase:=180;
  end;}
end;

procedure InitModels1;
var a: word;
begin
  for a:=1 to 3 do begin
    Model[a].Typ:=a;
  end;
  for a:=4 to 17 do begin
    Model[a].Typ:=a+26;
  end;
end;
end.
