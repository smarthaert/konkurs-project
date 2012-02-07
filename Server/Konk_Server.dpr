program Konk_Server;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  UnOrgan in 'UnOrgan.pas',
  UnGeom in '..\Common\UnGeom.pas',
  ComCryptM in 'ComCryptM.pas',
  AdapterComm in 'AdapterComm.pas',
  UnMatrix in 'UnMatrix.pas',
  UnPanel in 'UnPanel.pas' {Form3},
  UnBuildServer in '..\Common\Build\UnBuildServer.pas',
  UnBuildSetka in '..\Common\Build\UnBuildSetka.pas',
  UnLVS in 'UnLVS.pas' {LVS},
  UnMissile in '..\Common\UnMissile.pas',
  UnBuildKoordObject in '..\Common\Build\UnBuildKoordObject.pas',
  UnReadIni in 'UnReadIni.pas',
  UnOther in '..\Common\Konkurs\UnOther.pas',
  Unsound in 'Unsound.pas' {Sound_Form};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TLVS, LVS);
  Application.CreateForm(TSound_Form, Sound_Form);
  Application.Run;
end.
