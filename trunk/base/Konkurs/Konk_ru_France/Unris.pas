unit UnRis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
var DeviceMode : TDevMode;
begin
 { DeviceMode.dmSize:=SizeOf(DeviceMode);
  DeviceMode.dmBitsPerPel:=32;
  DeviceMode.dmPelsWidth:=1024;
  DeviceMode.dmPelsHeight:=768;
  DeviceMode.dmFields:=DM_BITSPERPEL or DM_PELSWIDTH or DM_PELSHEIGHT;
  if ChangeDisplaySettings(DeviceMode,CDS_TEST or CDS_FULLSCREEN) <> DISP_CHANGE_SUCCESSFUL then Exit;
  ChangeDisplaySettings(DeviceMode,CDS_FULLSCREEN);}
end;

end.
