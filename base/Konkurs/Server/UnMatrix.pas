unit UnMatrix;

interface
uses
  Windows, UnOther,SysUtils, main;
{$I KONKURS_Constants.INC}
{$I DLL_ADAPTERS_DEFINE.INC}

procedure Read_Discret_Card;
procedure Isx_Pol_Matrix;
procedure Isx_Pol_Azimut;
function Count16Bit(numLine: integer): smallint;

var
  Org_upr:    array [0..14]of byte;
  Org_ind:    array [0..14]of byte;
  Org_upr_old:array [0..14]of byte;

implementation
uses
  UnOrgan;


procedure Isx_Pol_Azimut;
begin
  BMP[Num_BMP].AzPricel:=Count16Bit(11)*0.001437;;
  if BMP[Num_BMP].AzPricel<0 then BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel+360;
  BMP[Num_BMP].AzPricelMemo:=0;
end;

procedure Isx_Pol_Matrix;
var
  a: word;
begin
  // ��������� ������� ���������� � ������� ��������� (���)
  Org_upr[0]:=$ff;
  Org_upr[1]:=0;
  Org_upr[2]:=8;
  Org_upr_old[0]:=$ff;
  for a:=0 to 8 do Org_ind[a]:=$00;
  SetArraysOU(ORG_IND,ORG_UPR);
end;

procedure Read_Discret_Card;
var
  n: word;
  SI:^SmallInt;
begin
  //3,4  ���� �����
  SI:=@Org_UPR[3];     //����� �� ��
  BMP[Num_BMP].UmPricel:=SI^*0.00265;

  n:=5;
  if Org_upr_old[n]<>Org_upr[n] then begin
    if Org_upr[n] and $01 =0 then BMP[Num_BMP].Filtr:=true else BMP[Num_BMP].Filtr:=false;
    Org_upr_old[n]:=Org_upr[n];
  end;
  //11,12 ������
  SI:=@Org_UPR[11];     //����� �� ��
  // ���� �������� ��������
  if BMP[Num_BMP].azimutSpeed then BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricelMemo+SI^*0.00274
                              else BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricelMemo+SI^*0.00137;

  if BMP[Num_BMP].AzPricel<0 then BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel+360;
  if BMP[Num_BMP].AzPricel<0 then BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel+360;
  if BMP[Num_BMP].AzPricel>=360 then BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel-360;
  Form1.label2.Caption:=floattostr(BMP[Num_BMP].AzPricel);

  n:=0;
  if Org_upr_old[n]<>Org_upr[n] then begin
    if Org_upr[n] and $01 =0 then begin
      if not BMP[Num_BMP].Kn_Ptur then begin
        PuskPTUR;
        BMP[Num_BMP].Kn_Ptur:=true;
      end;
    end
    else begin
      BMP[Num_BMP].Kn_Ptur:=false;
    end;
    // ��������
    if Org_upr[n] and $04 =0 then begin
      BMP[Num_BMP].azimutSpeed:=true;
      BMP[Num_BMP].AzPricelMemo:=BMP[Num_BMP].AzPricel-SI^*0.00274;
    end
    else begin
      BMP[Num_BMP].azimutSpeed:=false;
      BMP[Num_BMP].AzPricelMemo:=BMP[Num_BMP].AzPricel-SI^*0.00137;
    end;
    if Org_upr[n] and $08 =0 then BMP[Num_BMP].NalichiePTUR:=true
                             else BMP[Num_BMP].NalichiePTUR:=false;
    BMP[Num_BMP].Lumen_PTR:=0;
    if Org_upr[n] and $20 =0 then BMP[Num_BMP].Lumen_PTR:=255;
    if Org_upr[n] and $40 =0 then BMP[Num_BMP].Lumen_PTR:=180;
    if Org_upr[n] and $80 =0 then BMP[Num_BMP].Lumen_PTR:=100;
    Org_upr_old[n]:=Org_upr[n];
  end;

end;

function Count16Bit(numLine: integer): smallint;
begin
  Count16Bit:=Org_upr[numLine]+(Org_upr[numLine+1]  shl 8);
end;
end.
