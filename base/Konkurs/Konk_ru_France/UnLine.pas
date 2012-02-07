unit UnLine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UnOther, Main, UnLVS;

type
  TFormLine = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Shape2: TShape;
    StaticText3: TStaticText;
    Shape3: TShape;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Panel2: TPanel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    Shape15: TShape;
    Timer1: TTimer;
    Panel3: TPanel;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText20: TStaticText;
    StaticText22: TStaticText;
    Panel4: TPanel;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    StaticText18: TStaticText;
    StaticText21: TStaticText;
    StaticText23: TStaticText;
    StaticText24: TStaticText;
    StaticText25: TStaticText;
    StaticText26: TStaticText;
    Panel5: TPanel;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    StaticText27: TStaticText;
    StaticText28: TStaticText;
    StaticText29: TStaticText;
    StaticText30: TStaticText;
    StaticText31: TStaticText;
    StaticText32: TStaticText;
    StaticText33: TStaticText;
    StaticText34: TStaticText;
    Shape35: TShape;
    StaticText35: TStaticText;
    Shape36: TShape;
    StaticText36: TStaticText;
    Panel8: TPanel;
    Shape47: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Shape53: TShape;
    Shape54: TShape;
    Shape55: TShape;
    StaticText41: TStaticText;
    StaticText45: TStaticText;
    StaticText49: TStaticText;
    StaticText50: TStaticText;
    StaticText52: TStaticText;
    StaticText53: TStaticText;
    StaticText54: TStaticText;
    Shape58: TShape;
    StaticText57: TStaticText;
    Panel9: TPanel;
    Shape57: TShape;
    Shape59: TShape;
    Shape60: TShape;
    Shape61: TShape;
    Shape62: TShape;
    Shape63: TShape;
    Shape64: TShape;
    Shape66: TShape;
    StaticText56: TStaticText;
    StaticText59: TStaticText;
    StaticText61: TStaticText;
    StaticText62: TStaticText;
    StaticText63: TStaticText;
    StaticText64: TStaticText;
    StaticText65: TStaticText;
    StaticText66: TStaticText;
    StaticText67: TStaticText;
    StaticText68: TStaticText;
    Shape67: TShape;
    Shape68: TShape;
    Panel11: TPanel;
    Shape70: TShape;
    Shape71: TShape;
    StaticText70: TStaticText;
    StaticText71: TStaticText;
    Shape72: TShape;
    Shape73: TShape;
    StaticText72: TStaticText;
    StaticText73: TStaticText;
    Panel13: TPanel;
    Shape83: TShape;
    StaticText84: TStaticText;
    Edit1: TEdit;
    Shape84: TShape;
    StaticText85: TStaticText;
    Shape37: TShape;
    StaticText37: TStaticText;
    Shape42: TShape;
    StaticText39: TStaticText;
    Shape43: TShape;
    StaticText40: TStaticText;
    Shape20: TShape;
    StaticText19: TStaticText;
    Shape44: TShape;
    StaticText42: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure RePaint_Form;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Perecl(n: word);
    { Public declarations }
  end;

var
  FormLine: TFormLine;
  Num: word;

implementation

{$R *.DFM}

procedure TFormLine.FormCreate(Sender: TObject);
begin
  if Num_BMP>0 then Num:=Num_BMP else Num:=1;
  StaticText84.Caption:='������ � '+inttostr(Num);
  Kommand[1]:=ZADACHA;
  Kommand[2]:=ZAD_PROSMOTR_ORG_UPR+num;
  Trans_kom(Num);
  RePaint_Form;
end;

procedure TFormLine.RePaint_Form;
var a,b,c,d: boolean;
begin
if Trans_pre[num] then begin
  Shape83.Brush.Color:=clLime;
  a:=false;   // �� ����� ��
  b:=false;   // �� ����� �� (����������)
  c:=false;   // �� ����� ���
  d:=false;   // �� ����� �����

  if Org_Upr_Rm[Num].nav_imp[5] and $01=0 then begin //�. ������
    Shape1.Brush.Color:=clLime;
    Shape8.Brush.Color:=clLime;
  end
  else begin
    Shape1.Brush.Color:=clRed;
    Shape8.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[46] and $80=0 then begin //  ���������������
    Shape37.Brush.Color:=clLime;
    Shape14.Brush.Color:=clLime;
    Shape17.Brush.Color:=clLime;
  end
  else begin
    Shape37.Brush.Color:=clRed;
    Shape14.Brush.Color:=clRed;
    Shape17.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[48] and $10=0 then begin //  ������������ �����
    Shape2.Brush.Color:=clLime;
  end
  else begin
    Shape2.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[6] and $20=0 then begin  // A��-��� ��-��
    Shape4.Brush.Color:=clLime;
    Shape11.Brush.Color:=clLime;
    Shape28.Brush.Color:=clLime;
    Shape68.Brush.Color:=clLime;
  end
  else begin
    Shape4.Brush.Color:=clRed;
    Shape11.Brush.Color:=clRed;
    Shape28.Brush.Color:=clRed;
    Shape68.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
    d:=true;   // �� ����� �����
  end;
  if (Org_Upr_Rm[Num].kom_imp[7] and $04=$0) then begin    // A��-��� ��-��
    Shape5.Brush.Color:=clLime;
    Shape12.Brush.Color:=clLime;
    Shape30.Brush.Color:=clLime;
    Shape67.Brush.Color:=clLime;
  end
  else begin
    Shape5.Brush.Color:=clRed;
    Shape12.Brush.Color:=clRed;
    Shape30.Brush.Color:=clRed;
    Shape67.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
    d:=true;   // �� ����� �����
  end;
  if Org_Upr_Rm[Num].nav_imp[46] and $20=0 then begin  //  ��� ���� ���
    Shape6.Brush.Color:=clLime;
  end
  else begin
    Shape6.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[46] and $40=0 then begin  //  ��� �� ��
    Shape7.Brush.Color:=clLime;
  end
  else begin
    Shape7.Brush.Color:=clRed;
  end;
  if BMP[Num].vod_imp[0] and $04=0 then begin  // ��� ��
    Shape42.Brush.Color:=clLime;
  end
  else begin
    Shape42.Brush.Color:=clRed;
  end;
  if BMP[Num].Ispravn_Priv_Gor    then begin  //  ����������� ��
    Shape43.Brush.Color:=clLime;
  end
  else begin
    Shape43.Brush.Color:=clRed;
  end;
  if BMP[Num].Priv_gor            then begin
    Shape3.Brush.Color:=clLime;
  end
  else begin
    Shape3.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[48] and $04=0 then begin //  ��������� ����
    Shape9.Brush.Color:=clLime;
    Shape21.Brush.Color:=clLime;
  end
  else begin
    Shape9.Brush.Color:=clRed;
    Shape21.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[47] and $01=0 then begin  //  ��� �� ��
    Shape13.Brush.Color:=clLime;
  end
  else begin
    Shape13.Brush.Color:=clRed;
  end;
  if BMP[Num].Ispravn_Priv_Ver    then begin //  �����������
    Shape15.Brush.Color:=clLime;
  end
  else begin
    Shape15.Brush.Color:=clRed;
  end;
  if BMP[Num].Priv_Ver            then begin
    Shape10.Brush.Color:=clLime;
  end
  else begin
    Shape10.Brush.Color:=clRed;
  end;
  if BMP[Num].Gotov_Dalnom then begin //  ���������
    Shape18.Brush.Color:=clLime;
  end
  else begin
    Shape18.Brush.Color:=clRed;
  end;
  if Org_Upr_Rm[Num].nav_imp[5]and $08=0 then begin // �. ���������
    Shape16.Brush.Color:=clLime;
  end
  else begin
    Shape16.Brush.Color:=clRed;
  end;
  if BMP[Num].Ispravn_Daln then begin // ����������� ����������
    Shape19.Brush.Color:=clLime;
  end
  else begin
    Shape19.Brush.Color:=clRed;
  end;
  if not Upravl then begin // ��� ���������� �� ���
    Shape58.Brush.Color:=clLime;
    Shape49.Brush.Color:=clLime;
    Shape59.Brush.Color:=clLime;
  end
  else begin
    Shape58.Brush.Color:=clRed;
    Shape49.Brush.Color:=clRed;
    Shape59.Brush.Color:=clRed;
    c:=true;   // �� ����� ���
    d:=true;   // �� ����� �����
  end;
  if Org_Upr_Rm[Num].nav_imp[5] and $04=0 then begin // ���-��� ����������
    Shape20.Brush.Color:=clLime;
  end
  else begin
    Shape20.Brush.Color:=clRed;
  end;

  if (Org_Upr_Rm[Num].nav_imp[48] and $01=0) then begin //������� �������
    Shape23.Brush.Color:=clLime;
  end
  else begin
    Shape23.Brush.Color:=clRed;
  end;

  if (Org_Upr_Rm[Num].nav_imp[5] and $02=0) then begin // �. ������������
    Shape24.Brush.Color:=clLime;
  end
  else begin
    Shape24.Brush.Color:=clRed;
  end;

  if BMP[Num].Ispravn_Stabil then begin // ����������� �������������
    Shape26.Brush.Color:=clLime;
  end
  else begin
    Shape26.Brush.Color:=clRed;
  end;
  if (Org_Upr_Rm[Num].nav_imp[5] and $02=0) and
      (BMP[Num].Time_Giro=0) then begin //� ������������ + ����
    Shape25.Brush.Color:=clLime;
    edit1.Text:=' ';
  end
  else begin
    if (Org_Upr_Rm[Num].nav_imp[5] and $02=0) then edit1.Text:=inttostr(BMP[Num].Time_Giro)
                                                else edit1.Text:=' ';
    Shape25.Brush.Color:=clRed;
  end;
  if BMP[Num].Privod then begin    // ������ �������
    Shape44.Brush.Color:=clLime;
  end
  else begin
    Shape44.Brush.Color:=clRed;
  end;
  if BMP[Num].Stab_Push then begin // ������������
    Shape22.Brush.Color:=clLime;
  end
  else begin
    Shape22.Brush.Color:=clRed;
  end;
  if (not BMP[Num].Gotov_Pushka)then begin /// ����� �� ��������
    Shape27.Brush.Color:=clLime;
    Shape61.Brush.Color:=clRed;
    d:=true;   // �� ����� �����
  end
  else begin
    Shape27.Brush.Color:=clRed;
    Shape61.Brush.Color:=clLime;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].kom_imp[8] and $08=0)then begin      //  ��� �� ��
    Shape32.Brush.Color:=clLime;
  end
  else begin
    Shape32.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].kom_imp[8] and $04=0)then begin      //  ��� �� ��
    Shape31.Brush.Color:=clLime;
  end
  else begin
    Shape31.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].kom_imp[8] and $02=0)then begin      //  ��� ���
    Shape34.Brush.Color:=clLime;
  end
  else begin
    Shape34.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].kom_imp[8] and $01=0)then begin      //  ��� �� ���
    Shape35.Brush.Color:=clLime;
  end
  else begin
    Shape35.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].kom_imp[9] and $02=0) then begin      //  ���  �� ���
    Shape33.Brush.Color:=clLime;
  end
  else begin
    Shape33.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if(Org_Upr_Rm[Num].nav_imp[6] and $10=$10) then begin      //   ������. '�, �, �, �'
    Shape36.Brush.Color:=clLime;
  end
  else begin
    Shape36.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  if BMP[Num].Klin_otkr  then begin // ���� ������
    Shape72.Brush.Color:=clLime;
  end
  else begin
    Shape72.Brush.Color:=clRed;
    a:=false;   // �� ����� ��
  end;
  case BMP[Num].Vybor_Bal of                 // "���� ���"
    BRONE_SNAR:if Boek[Num].Col_BR>0 then b:=true;
    KUMUL_SNAR:if Boek[Num].Col_Kum>0 then  b:=true;
    OSKOL_SNAR:if Boek[Num].Col_OF>0  then  b:=true;
    UPRAV_SNAR:if Boek[Num].Col_Upr>0 then  b:=true;
  end;
  if b then begin   // "���� ���"
    Shape73.Brush.Color:=clLime;
  end
  else begin
    Shape73.Brush.Color:=clRed;
  end;
  if (not a) and b then begin   // ����� ��
    Shape29.Brush.Color:=clLime;
  end
  else begin
    Shape29.Brush.Color:=clRed;
  end;
  if (Org_Upr_Rm[Num].nav_imp[0] and $01=$01)then begin    // �� �����
    Shape47.Brush.Color:=clLime;
  end
  else begin
    Shape47.Brush.Color:=clRed;
    c:=true;   // �� ����� ���
  end;
  if(Boek[Num].Col_PKT>0) then begin              // ���� �������
    Shape51.Brush.Color:=clLime;
  end
  else begin
    Shape51.Brush.Color:=clRed;
    c:=true;   // ��� ����� ���
  end;
  if(Org_Upr_Rm[Num].kom_imp[8] and $10=0) then begin     // �� ����� �� ���
    Shape53.Brush.Color:=clLime;
    Shape63.Brush.Color:=clLime;
  end
  else begin
    Shape53.Brush.Color:=clRed;
    Shape63.Brush.Color:=clRed;
    a:=true;
    c:=true;   // �� ����� ���
    d:=true;   // �� ����� �����
  end;
  if(Org_Upr_Rm[Num].nav_imp[46] and $02=0) then begin      // �� ����� �� ���
    Shape54.Brush.Color:=clLime;
    Shape64.Brush.Color:=clLime;
  end
  else begin
    Shape54.Brush.Color:=clRed;
    Shape64.Brush.Color:=clRed;
    a:=true;
    c:=true;   // �� ����� ���
    d:=true;   // �� ����� �����
  end;
  if(BMP[Num].ballist>-2) then begin      //  ����� ��������� ����������
    Shape55.Brush.Color:=clLime;
  end
  else begin
    Shape55.Brush.Color:=clRed;
    c:=true;   // �� ����� ���
  end;
  if not c then begin   // ����� ���
    Shape50.Brush.Color:=clLime;
  end
  else begin
    Shape50.Brush.Color:=clRed;
  end;
  if (Org_Upr_Rm[Num].nav_imp[47] and $08=0)then begin        // �����������-�� �����
    Shape62.Brush.Color:=clLime;
  end
  else begin
    Shape62.Brush.Color:=clRed;
    d:=true;   // �� ����� �����
  end;
  if (Org_Upr_Rm[Num].nav_imp[47] and $04=0)then begin        // �����������
    Shape66.Brush.Color:=clLime;
  end
  else begin
    Shape66.Brush.Color:=clRed;
    d:=true;   // �� ����� �����
  end;
  if (BMP[Num].vod_imp[1] and $80=0) then begin      //����������� � ��
    Shape84.Brush.Color:=clLime;
  end
  else begin
    Shape84.Brush.Color:=clRed;
    d:=true;   // �� ����� �����
  end;
  if (Org_Upr_Rm[Num].nav_imp[0] and $02=$02) then begin   // �� ���
    Shape57.Brush.Color:=clLime;
  end
  else begin
    Shape57.Brush.Color:=clRed;
    d:=true;   // �� ����� �����
  end;
  if not d then begin   // ����� �����
    Shape60.Brush.Color:=clLime;
  end
  else begin
    Shape60.Brush.Color:=clRed;
  end;

end
else begin
  Shape83.Brush.Color:=clRed;
  Shape1.Brush.Color:=clRed;
  Shape2.Brush.Color:=clRed;
  Shape3.Brush.Color:=clRed;
  Shape4.Brush.Color:=clRed;
  Shape5.Brush.Color:=clRed;
  Shape6.Brush.Color:=clRed;
  Shape7.Brush.Color:=clRed;
  Shape8.Brush.Color:=clRed;
  Shape9.Brush.Color:=clRed;
  Shape10.Brush.Color:=clRed;
  Shape11.Brush.Color:=clRed;
  Shape12.Brush.Color:=clRed;
  Shape13.Brush.Color:=clRed;
  Shape14.Brush.Color:=clRed;
  Shape15.Brush.Color:=clRed;
  Shape16.Brush.Color:=clRed;
  Shape17.Brush.Color:=clRed;
  Shape18.Brush.Color:=clRed;
  Shape19.Brush.Color:=clRed;
  Shape20.Brush.Color:=clRed;
  Shape21.Brush.Color:=clRed;
  Shape22.Brush.Color:=clRed;
  Shape23.Brush.Color:=clRed;
  Shape24.Brush.Color:=clRed;
  Shape25.Brush.Color:=clRed;
  Shape26.Brush.Color:=clRed;
  Shape27.Brush.Color:=clRed;
  Shape28.Brush.Color:=clRed;
  Shape29.Brush.Color:=clRed;
  Shape30.Brush.Color:=clRed;
  Shape30.Brush.Color:=clRed;
  Shape31.Brush.Color:=clRed;
  Shape32.Brush.Color:=clRed;
  Shape33.Brush.Color:=clRed;
  Shape34.Brush.Color:=clRed;
  Shape35.Brush.Color:=clRed;
  Shape36.Brush.Color:=clRed;
  Shape37.Brush.Color:=clRed;
  Shape42.Brush.Color:=clRed;
  Shape43.Brush.Color:=clRed;
  Shape44.Brush.Color:=clRed;
  Shape47.Brush.Color:=clRed;
  Shape49.Brush.Color:=clRed;
  Shape50.Brush.Color:=clRed;
  Shape51.Brush.Color:=clRed;
  Shape53.Brush.Color:=clRed;
  Shape54.Brush.Color:=clRed;
  Shape55.Brush.Color:=clRed;
  Shape57.Brush.Color:=clRed;
  Shape58.Brush.Color:=clRed;
  Shape59.Brush.Color:=clRed;
  Shape60.Brush.Color:=clRed;
  Shape61.Brush.Color:=clRed;
  Shape62.Brush.Color:=clRed;
  Shape63.Brush.Color:=clRed;
  Shape64.Brush.Color:=clRed;
  Shape66.Brush.Color:=clRed;
  Shape67.Brush.Color:=clRed;
  Shape68.Brush.Color:=clRed;
  Shape72.Brush.Color:=clRed;
  Shape73.Brush.Color:=clRed;
end;

end;

procedure TFormLine.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE,VK_F5:begin
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR_OTKL;
      Trans_kom(Num);
      Form1.Perekl_RM(Num);
      close;
    end;
    VK_F1: Perecl(1);
    VK_F2: Perecl(2);
    VK_F3: Perecl(3);
  end;
  StaticText84.Caption:='������ � '+inttostr(Num);
end;

procedure TFormLine.Timer1Timer(Sender: TObject);
begin
  RePaint_Form;
end;

procedure TFormLine.Perecl(n: word);
begin
  Kommand[1]:=ZADACHA;
  Kommand[2]:=ZAD_PROSMOTR_ORG_UPR_OTKL;
  Trans_kom(Num);
  Num:=n;
  Kommand[1]:=ZADACHA;
  Kommand[2]:=ZAD_PROSMOTR_ORG_UPR+num;
  Trans_kom(Num);
end;

end.

