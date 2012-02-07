program Konk_ru;

uses
  Forms,
  Main in 'Main.pas' {Form1},                                     //������� ���� ���������� ����������
  UnModel in 'UnModel.pas',                                       //�������� �������
  UnVybor in 'UnVybor.pas'      {OKBottomDlg1},                   //����� ����������
  UnEdit in 'UnEdit.pas'        {OKBottomDlg4},                   //�������� �������� � ��������� ����������
  UnEd_Tak in 'UnEd_Tak.pas'    {Edit_Tak},                       //�������� � ���������� �������
  UnPoint in 'Unpoint.pas'      {OKBottomDlg7},                   //������������ ���������� � ����������� �������
  UnBoepr in 'Unboepr.pas'      {OKBottomDlg5},                   //���� ���������� �����������, ���������
  UnColor in 'UnColor.pas'      {ChangColor},                     //���� �����
  UnTarget in 'UnTarget.pas'    {OKBottomDlg6},                   //������������ ������� �������
  UnTarTak in 'UnTarTak.pas'    {Tar_Tak},                        //����������� ������
  UnEkip in 'Unekip.pas'        {OKBottomDlg3},                   //���� ������ �� ���������
  UnPogoda in 'Unpogoda.pas'    {OKBottomDlg2},                   //���� ������ � �������� ��������
  UnVedom in 'Unvedom.pas'      {Vedom},                          //��������� ����������
  UnVed_Ta in 'UnVed_Ta.pas'    {FVed_Ta},                        //���������
  UnClose in 'Unclose.pas'      {OKBottomDlg},                    //���������� ������
  UnLVS in 'UnLVS.pas'          {LVS},                            //����� �� ��������� �������������� ����
  UnBuildSetka in '..\Common\Build\UnBuildSetka.pas',             //
  UnBuildServer in '..\Common\Build\UnBuildServer.pas',           //
  UnBuildKoordObject in '..\Common\Build\UnBuildKoordObject.pas', //
  UnOther in '..\Common\Konkurs\UnOther.pas',                     //
  UnGeom in '..\Common\UnGeom.pas',                               //
  UnTask in 'UnTask.pas',                                         //
  UnOcenka in 'UnOcenka.pas',                                     //������������ ������ �� ����������� ��������
  UnReadIni in 'UnReadIni.pas',                                   //������ �� ��� ����� � ������������ �������� ��� ���������� ������
  UnOtkaz in 'UnOtkaz.pas' {Otkaz},                               //������� ������� ������� ���������
  UnLoadLang in 'UnLoadLang.pas';                                 //������������ �������� ���������

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TLVS, LVS);
  Application.CreateForm(TOtkaz, Otkaz);
  Application.Run;
end.
