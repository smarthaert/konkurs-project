unit UnModel;     //�������� �������

interface
uses
  Windows,SysUtils, Main, UnOther, Math, UnBuildSetka, UnGeom, UnLVS;

type

TTarget_Model_Tek=record                       // �������� ������
    Num: byte;                         // ����� ������
    ColPoints: byte;                   // ���������� ������� �����
    Aktiv: byte;                       // ���������� ������
    Color_Mask: byte;                  // ���� ������
    Tst: word;                         // ����� ���������
    Tend: word;                        // ����� ��������
    Tzar: word;                        // ����� ����������� ��� ���������
    PointTek: word;

    UmBase,            // ������  ������� ������
    Tangage:          real;             // ���������� ������
    UmPushka:         real;             // ��������� �����
    AzBashn:          real;             // ������� �����
    Start:            boolean;          // ������ ��������
    Typ:              byte;             // ���������� � �����
    Akt:              byte;             // ���������� �����(>$0f- ������)
    Zar:              boolean;          // �������
    Svoboden:         boolean;          // �� ����� ��������� ����
    Gotov:            boolean;          // ����� � ��������
    Vystrel:          boolean;          // ������� ���������
    Time_Zar:         word;             // ����� ���������� �� ����� ���������
    Num_BMP:          word;             // ����� �����, �� �������� ��������

    AzBase:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Xtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;      // ���������� ������� �����
    Ytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Htek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Tstop:array[0..COL_MAX_POINTS_TAK_TEX] of word;        // ����� ��������� � �����
    Skor:array[0..COL_MAX_POINTS_TAK_TEX] of real;      // C������� �������� �� ��������
    Visible:array[0..COL_MAX_POINTS_TAK_TEX] of boolean;   // ��������� �� �������
    Time_stop:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;  //����� ��������� � �����
    Complited:array[0..COL_MAX_POINTS_TAK_TEX] of  boolean;   //true ���� ����� ��������
    Vxtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vhtek:array[0..COL_MAX_POINTS_TAK_TEX] of  real;         // ��� ��������� �����
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
    Mov: boolean;                        // ����������

    Delta       : real;     //������ ��������� ����������
    XNow        : Koord;    //���������� ������� �����
    XNext       : Koord;    //���������� ����� ����������
    Dir         : Koord;    //��� ����������� ��������
    Coners      : array [1..4] of Koord; //���� ���� ������� � ������ ��������� �� ����������� ��������
    obhod       : integer;  //����������� ������ 0-��� ������, -1-�������, 1-������
    NoForvard   : boolean;  //������ ���� ������
  end;
    TTarget_Model_Isx=record                       // �������� ������
    Num: byte;                         // ����� ������
    ColPoints: byte;                   // ���������� ������� �����
    Aktiv: byte;                       // ���������� ������
    Color_Mask: byte;                  // ���� ������
    Tst: word;                         // ����� ���������
    Tend: word;                        // ����� ��������
    PointTek: word;

    UmBase, AzBase:   real;             // ������  ������� ������
    Tangage:          real;             // ���������� ������
    UmPushka:         real;             // ��������� �����
    AzBashn:          real;             // ������� �����
    Start:            boolean;          // ������ ��������
    Typ:              byte;             // ���������� � �����
    Akt:              byte;             // ���������� �����

    Xtek:array[0..COL_MAX_POINTS_TAK_TEX] of word;      // ���������� ������� �����
    Ytek:array[0..COL_MAX_POINTS_TAK_TEX] of word;
    Htek:array[0..COL_MAX_POINTS_TAK_TEX] of word;
    Tstop:array[0..COL_MAX_POINTS_TAK_TEX] of word;        // ����� ��������� � �����
    Skor:array[0..COL_MAX_POINTS_TAK_TEX] of word;      // C������� �������� �� ��������
    Visible:array[0..COL_MAX_POINTS_TAK_TEX] of boolean;   // ��������� �� �������
    Time_stop:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;  //����� ��������� � �����
    Time_mov:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;   //����� �������� �� ��������� �����
    Vxtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vhtek:array[0..COL_MAX_POINTS_TAK_TEX] of  real;         // ��� ��������� �����
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
    Mov: boolean;                        // ����������
  end;



    procedure Count_Poraj_model(n:word);
    procedure CountParamModel_Tik;
    procedure CountParamModel_Sek;
    function StandColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {������ �������� ��� ������������ ��������}
    function DinColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {������ �������� ��� ������������ ��������}
    function Colligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {������ �������� ��� ������������ ��������}
    procedure GetWay(var Stepper : TTarget_Model_Tek);           //����� ����
    procedure GetDir(var Stepper :TTarget_Model_Tek);           //����� �����������
    procedure IsPointCompleted(var Stepper : TTarget_Model_Tek);   //�������� ������� � ����� ����������
    procedure Isx_Model;
    procedure Otvet_Model(num: word);

var
   Target_Model_Tek: array[1..COL_MAX_OBJEKT_TAK_TEX] of TTarget_Model_Tek;
   Target_Model_Isx: array[1..COL_MAX_OBJEKT_TAK_TEX] of TTarget_Model_Isx;
   Poraj_TAK_TEX: array[1..COL_MAX_OBJEKT_TAK_TEX] of word;////0-�� �������, 1-�����, 2-���
   d_um_gm : array[1..COL_MAX_OBJEKT_TAK_TEX] of real;       // �������� ������� �� ��
   d_kren_gm: array[1..COL_MAX_OBJEKT_TAK_TEX] of real;


implementation

const
EPS = 1;              //�������� ������� � ����� ���������� �������� ������

procedure CountParamModel_Sek;
var
a: word;
begin
  for a:=1 to Col_Model do begin
    if Poraj_TAK_TEX[a]>0 then begin // ������ ��������
      // ��������� ��� �����������
      Model[a].Akt:=Poraj_TAK_TEX[a] shl 4;// ��� � ��������� ��������� � ������� ���������
      Model[a].Start:=false;               // ��������� ������
      // ������������ ������ ��� ��������
      Target_Model_Tek[a].Gotov:=false;    // ���������� ����� ��������,
      Target_Model_Tek[a].Zar:=false;      // �������
      Target_Model_Tek[a].Svoboden:=false;// � �������� ��� ���������� ����������
    end
    else begin
      // ���� ��������=0 �� �������� �� ������������
      if Target_Model_Tek[a].Skor[0]>0 then Model[a].Start:=true else Model[a].Start:=false;
      Model[a].Skorost:=round(Target_Model_Tek[a].Skor[0]*1000);
      // ���� ����� �������� �� ��������� �� �������
      if not Target_Model_Tek[a].Complited[Target_Model_Tek[a].PointTek] then begin
        // �������� �������� �� ������� �������
        Target_Model_Tek[a].Vhtek[0]:=Target_Model_Tek[a].Vhtek[Target_Model_Tek[a].PointTek];
        Target_Model_Tek[a].Skor[0]:=Target_Model_Tek[a].Skor[Target_Model_Tek[a].PointTek];
        //������ �������� � �������� ���������� � ����� ����
        Target_Model_Tek[a].XNow.X:=Model[a].Xtek;
        Target_Model_Tek[a].XNow.Y:=Model[a].Ytek;
        Target_Model_Tek[a].XNext.X:=Target_Model_Tek[a].Xtek[Target_Model_Tek[a].PointTek];
        Target_Model_Tek[a].XNext.Y:=Target_Model_Tek[a].Ytek[Target_Model_Tek[a].PointTek];
        if Model[a].Typ<>3 then GetWay(Target_Model_Tek[a]);
        IsPointCompleted(Target_Model_Tek[a]);
        Target_Model_Tek[a].Vxtek[0]:=Target_Model_Tek[a].Skor[0]*Target_Model_Tek[a].Dir.X;
        Target_Model_Tek[a].Vytek[0]:=Target_Model_Tek[a].Skor[0]*Target_Model_Tek[a].Dir.Y;
          /// ������ ����������� ��������
        if not Target_Model_Tek[a].Complited[Target_Model_Tek[a].PointTek] then
        begin
         Target_Model_Tek[a].AzBase[0]:=90-ArcSin(Target_Model_Tek[a].Dir.Y)/Pi*180;
         if Target_Model_Tek[a].Dir.X<0 then Target_Model_Tek[a].AzBase[0]:=-Target_Model_Tek[a].AzBase[0];
        end;
      end
      else begin
        //���� �� ��������� ����� ����� ��������
        if Target_Model_Tek[a].Time_stop[Target_Model_Tek[a].PointTek]>0 then begin
          // ��������� �����
          dec(Target_Model_Tek[a].Time_stop[Target_Model_Tek[a].PointTek]);
          // �����
          Target_Model_Tek[a].Vxtek[0]:=0;
          Target_Model_Tek[a].Vytek[0]:=0;
          Target_Model_Tek[a].Vhtek[0]:=0;
          Target_Model_Tek[a].Skor[0]:=0;
        end
        else begin
          // ���� ����� �� ���������
          if Target_Model_Tek[a].PointTek<Target_Model_Isx[a].ColPoints then begin
            // ��������� � ��������� �����
            inc(Target_Model_Tek[a].PointTek);
            Target_Model_Tek[a].XNow.X:=Model[a].Xtek;
            Target_Model_Tek[a].XNow.Y:=Model[a].Ytek;
            Target_Model_Tek[a].XNext.X:=Target_Model_Tek[a].Xtek[Target_Model_Tek[a].PointTek];
            Target_Model_Tek[a].XNext.Y:=Target_Model_Tek[a].Ytek[Target_Model_Tek[a].PointTek];
            GetDir(Target_Model_Tek[a]);
          end
          else begin
            // ���� ����� ��������� �� ���� ��� ������
          end;
        end;
      end;
      // ���� �� �������
      if Target_Model_Tek[a].Time_Zar<TIME_ZAR_MODEL then begin
        // ����� ���������
        inc(Target_Model_Tek[a].Time_Zar);
        Target_Model_Tek[a].Zar:=false;
      end
      else begin
        Target_Model_Tek[a].Zar:=true;
        // ���� �������� � �������, �� �����
        if Target_Model_Tek[a].Svoboden and Target_Model_Tek[a].Zar then Target_Model_Tek[a].Gotov:=true;
      end;
      /// �������� �������
      if not Target_Model_Tek[a].Svoboden then begin // ����� �������� ���������
        if Model[a].AzBase=Target_Model_tek[a].AzBase[0]then begin /// ���� �����������  � ������ �����������
          if Target_Model_Tek[a].Vystrel then begin// ���� �� ���������� ��� ��� �������, ��
            Count_Poraj_model(a);                  // ���������� ���������
            Target_Model_Tek[a].Vystrel:=false;
            // ���� �� �������, �� �������� ���������
            if Povrejden[Num_BMP]=DESTR_COMPL then Target_Model_Tek[a].Svoboden:=true;
          end;
          // ���� ������� �� �������
          if Target_Model_Tek[a].Zar then begin
            // ��������� �������
//            Vystrel_model(a);
            KommandTr[1]:=STVOL_DYM_TAK;          // �������� ���� �������
            KommandTr[2]:=a;
            LVS.Trans_kom;
            Target_Model_Tek[a].Zar:=false;     // ��������� ����� �������� �� ���������
            Target_Model_Tek[a].Time_Zar:=0;
            Target_Model_Tek[a].Vystrel:=true;  // ��������� �������� �� ��������� ��������
          end;
        end;
      end;
    end;
    //����� �������
    //������� ����� ������
    if (Model[a].Typ=0)and (time_Upr>Target_Model_Isx[a].Tst) and (time_Upr<Target_Model_Isx[a].Tend)
                        { and (Target_Model_Isx[a].Visible[Target_Model_Isx[a].PointTek]) }then begin
      //���� ������ �� �������� � �� ��������, �� ��������
      Model[a].Typ:=Target_Model_Isx[a].Num;
    end;
  end;
end;

procedure CountParamModel_Tik;
var
a: word;
d: real;
asin,acos: real;
num_patch_h,index_X,index_Y: integer;
begin
  for a:=1 to Col_Model do begin
    if Model[a].Typ>0 then begin
      if Poraj_TAK_TEX[a]>0 then begin // ������ ��������
        // ������� ������ �� �����
        if Model[a].Typ=MODEL_APACH then if Model[a].Htek>CountHeight(Model[a].Xtek,Model[a].Ytek) then begin
          Model[a].Htek:=Model[a].Htek+Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek];
          Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek]:=Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek]-0.004;
          Model[a].Xtek:=Model[a].Xtek+Target_Model_Tek[a].Vxtek[0];
          Target_Model_Tek[a].Vxtek[0]:=Target_Model_Tek[a].Vxtek[0]/1.01;
          Model[a].Ytek:=Model[a].Ytek+Target_Model_Tek[a].Vytek[0];
          Target_Model_Tek[a].Vytek[0]:=Target_Model_Tek[a].Vytek[0]/1.01;
          // ��������� � �������
          Model[a].UmBase:=Model[a].UmBase+2;
        end;
      end
      else begin
        ///��������
        if (Model[a].Xtek>4) and (Model[a].Xtek<(lenghtSurfaceX-4)) /// ����������� ��������
             and(Model[a].Ytek>8) and (Model[a].Ytek<lenghtSurfaceY-4) then begin
          if Model[a].Typ=MODEL_APACH then Model[a].Htek:=Model[a].Htek+Target_Model_Tek[a].Vhtek[0]
          else Model[a].Htek:=Target_Model_Tek[a].Htek_const[Target_Model_Tek[a].PointTek]
                                             +CountHeightModel(Model[a].Xtek,Model[a].Ytek,num_patch_h,index_X,index_Y);
          // ������� � �������� ������
          if not Target_Model_tek[a].Complited[Target_Model_Tek[a].PointTek] then
          if abs(Model[a].AzBase-Target_Model_tek[a].AzBase[0])<1 then
          begin
           Model[a].Xtek:=Model[a].Xtek+Target_Model_Tek[a].Vxtek[0];
           Model[a].Ytek:=Model[a].Ytek+Target_Model_Tek[a].Vytek[0];
           Model[a].AzBase:=Target_Model_tek[a].AzBase[0];
          end
          else begin
            d:=Model[a].AzBase-Target_Model_tek[a].AzBase[0];
            if d>180 then d:=d-360;
            if d<-180 then d:=d+360;
           if d>0 then Model[a].AzBase:=Model[a].AzBase-1
                  else Model[a].AzBase:=Model[a].AzBase+1;
           if Model[a].AzBase>180 then Model[a].AzBase:=Model[a].AzBase-360;
           if Model[a].AzBase<-180 then Model[a].AzBase:=Model[a].AzBase+360;
          end;
          // ���������� ������ ������� �� ����� � �������
          asin:=sin(Model[a].AzBase/57.3);
          acos:=cos(Model[a].AzBase/57.3);
          /// ������
          d:=(Um_mestn[num_patch_h][index_X][index_Y]*acos+
            Kren_mestn[num_patch_h][index_X][index_Y]*asin)-Model[a].UmBase;
          d_um_gm[a]:=d_um_gm[a]+d/9 - d_um_gm[a]/12;// d_um_gm- ������������� �������� ��� ������������� � �����
          Model[a].UmBase:=Model[a].UmBase + d_um_gm[a];
          // ����
          d:=Um_mestn[num_patch_h][index_X][index_Y]*asin+
             Kren_mestn[num_patch_h][index_X][index_Y]*acos-Model[a].Kren;
          d_kren_gm[a]:=d_kren_gm[a]+d/9 - d_kren_gm[a]/12;
          Model[a].Kren:=Model[a].Kren + d_kren_gm[a];
        end
        else begin
          // �� ������� ����������������
          Target_Model_Tek[a].Vxtek[0]:=0;
          Target_Model_Tek[a].Vytek[0]:=0;
          Target_Model_Tek[a].Skor[0]:=0;
        end;
      end;
    end;
  end;
end;


// ������ ���������
procedure Count_Poraj_model(n:word);
begin
  KommandTr[2]:=0;
  case Aktivnost of
    0,1: begin
      Target_Model_Tek[n].Svoboden:=true;
      exit;
    end;
    2:if random(100)>50 then begin
      KommandTr[1]:=DESTROY_TANK;
      if Povrejden[Num_BMP]>0 then begin  // ���� ���� �����������, ��
        KommandTr[2]:=DESTR_COMPL;           // ��������� ������
      end
      else begin
        case random(6) of
          0: KommandTr[2]:=DESTR_COMPL;           // ��������� ������
          1: KommandTr[2]:=DESTR_NAVOD;           // ��������� (���������,������������, ������, ������ �)
          2: KommandTr[2]:=DESTR_PRIVOD;          // ������
          3: KommandTr[2]:=DESTR_DVIG;           // ���������
          4: KommandTr[2]:=DESTR_POVOROT_LEV;    // ��������
          5: KommandTr[2]:=DESTR_POVOROT_PRAV;
        end;
      end;
    end;
    3:if random(100)>25 then begin
      KommandTr[1]:=DESTROY_TANK;
      if Povrejden[Num_BMP]>0 then begin  // ���� ���� �����������, ��
        KommandTr[2]:=DESTR_COMPL;           // ��������� ������
      end
      else begin
        case random(7) of
          0: KommandTr[2]:=DESTR_COMPL;           // ��������� ������
          1: KommandTr[2]:=DESTR_NAVOD;           // ��������� (���������,������������, ������, ������ �)
          2: KommandTr[2]:=DESTR_PRIVOD;          // ������
          3: KommandTr[2]:=DESTR_DALN;          // ���������
          4: KommandTr[2]:=DESTR_DVIG;            // ���������
          5: KommandTr[2]:=DESTR_POVOROT_LEV;     // ��������
          6: KommandTr[2]:=DESTR_POVOROT_PRAV;
        end;
      end;
    end;
    4:begin
      KommandTr[1]:=DESTROY_TANK;
      if Povrejden[Num_BMP]>0 then begin  // ���� ���� �����������, ��
        KommandTr[2]:=DESTR_COMPL;           // ��������� ������
      end
      else begin
        case random(3) of
          0: KommandTr[2]:=DESTR_COMPL;           // ��������� ������
          1: KommandTr[2]:=DESTR_NAVOD;           // ��������� (���������,������������, ������, ������ �)
          2: KommandTr[2]:=DESTR_DVIG;            // ���������
        end;
      end;
    end;
  end;
  if  KommandTr[2]=DESTR_COMPL then begin  // ����
    LVS.Trans_kom;
  end
  else if  KommandTr[2]<DESTR_DVIG then LVS.Trans_kom;// ���������
  n:=Target_Model_Tek[n].Num_BMP;
  Povrejden[Num_BMP]:=KommandTr[2];
{  case Kommand[2] of
    DESTR_COMPL: Form1.Memo1.Lines.add('��������� ������ ����� '+ inttostr(n));
    DESTR_NAVOD: Form1.Memo1.Lines.add('������� �� ����� 1�40 ����� '+ inttostr(n));
    DESTR_DALN: Form1.Memo1.Lines.add('������� �� ����� ��������� ����� '+ inttostr(n));
    DESTR_PRIVOD: Form1.Memo1.Lines.add('������� �� ����� ������ ����� '+ inttostr(n));
    DESTR_PRIVOD_VER: Form1.Memo1.Lines.add('������� �� ����� ����.������ ����� '+ inttostr(n));
    DESTR_PRIVOD_GOR: Form1.Memo1.Lines.add('������� �� ����� ���.������ ����� '+ inttostr(n));
    DESTR_STABIL: Form1.Memo1.Lines.add('������� �� ����� ������������ ����� '+ inttostr(n));
    DESTR_AZ: Form1.Memo1.Lines.add('������� �� ����� ������� ��������� ����� '+ inttostr(n));
    DESTR_PNV: Form1.Memo1.Lines.add('������� �� ����� ������ ������ ����� '+ inttostr(n));
    DESTR_UPR_RAK: Form1.Memo1.Lines.add('������� �� ����� 1�13 ����� '+ inttostr(n));
    DESTR_VOD: Form1.Memo1.Lines.add('�������� �� ����� ������� ������ ����� '+ inttostr(n));
    DESTR_DVIG: Form1.Memo1.Lines.add('������� �� ����� ��������� ����� '+ inttostr(n));
    DESTR_POVOROT_LEV: Form1.Memo1.Lines.add('������� �� ����� ���. �������� ����� '+ inttostr(n));
    DESTR_POVOROT_PRAV: Form1.Memo1.Lines.add('������� �� ����� ����. �������� ����� '+ inttostr(n));
    DESTR_STARTER: Form1.Memo1.Lines.add('������� �� ����� ������� ����� '+ inttostr(n));
    DESTR_SCEPLENIE: Form1.Memo1.Lines.add('�������� �� ����� ��������� ����� '+ inttostr(n));
    else Form1.Memo1.Lines.add('������ �� ������ ����� '+ inttostr(n));
  end;}
end;

 function DinColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {������ �������� ��� ������������ ��������}
 var a : integer;
 begin
  DinColligion:=false;
  for a:=1 to Col_Model do
  if ((abs(Model[a].Xtek-Stepper.XNow.X)>Stepper.Delta/10) and (abs(Model[a].Ytek-Stepper.XNow.Y)>Stepper.Delta/10)) then
  if ((abs(Model[a].Xtek-NextStep.XNow.X)<Stepper.Delta+Target_Model_Tek[a].Delta) and
      (abs(Model[a].Ytek-NextStep.XNow.Y)<Stepper.Delta+Target_Model_Tek[a].Delta)) then
  DinColligion:=true;
 end;

 function StandColligion(Stepper,NextStep :TTarget_Model_Tek) : boolean; {������ �������� ��� ������������ ��������}
 var i,j,ii,jj,k : integer;
     p : PMestnik;
     pp : pcoord;
     Patch : integer;
 begin
      StandColligion:=false;
      Patch:=CountPatch(NextStep.XNow.X,NextStep.XNow.Y);
      for i:=-1 to 1 do
      for j:=-1 to 1 do
      begin
       k:=Patch+i*colPatchX+j;
       ii:=Patch div colPatchX;
       jj:=k div colPatchX;
       if ((abs(ii-jj)<2) and (k>0) and (k<=colPatchSurface)) then
       if Mestniks[k]<>nil then
       for ii:=0 to Mestniks[k].Count-1 do
       begin
        p:=Mestniks[k].Items[ii];
        pp:=p^.Curver.Items[0];
        case p^.Type_Objekt of
{�����}        1: if ((Abs(NextStep.XNow.X-pp^.X)<Stepper.Delta) and (Abs(NextStep.XNow.Y-pp^.Y)<Stepper.Delta)) then StandColligion:=true;
{����������}   2: if PointInCircl(NextStep.XNow.X,NextStep.XNow.Y,p^.Curver) then StandColligion:=true;
{�������������}3: if (PointInRect(NextStep.Coners[1].X,NextStep.Coners[1].Y,p^.Curver) or
                      CrossPolygon(NextStep.Coners[1],NextStep.Coners[2],p^.Curver)) then StandColligion:=true;
{�������}      4: if CrossLine(Stepper.XNow.X,Stepper.XNow.Y,NextStep.XNow.X,NextStep.XNow.Y,p^.Curver) then StandColligion:=true;
        end;
       end;
      end;
 end;

 function Colligion(Stepper,NextStep :TTarget_Model_Tek) : boolean; {������ ��������}
 begin
  Colligion:=StandColligion(Stepper,NextStep) or DinColligion(Stepper,NextStep);
 end;

procedure GetWay(var Stepper :TTarget_Model_Tek);
var tempx,tempy,sqrt2 : real;
    red : boolean;
    i,j : integer;
    PrdStep,NxtStep :TTarget_Model_Tek;
procedure CalcNextCoord(d : koord);
begin
 NxtStep.XNow.X:=PrdStep.XNow.X+(Stepper.Delta+Stepper.Skor[0])*d.X;
 NxtStep.XNow.Y:=PrdStep.XNow.Y+(Stepper.Delta+Stepper.Skor[0])*d.Y;
 NxtStep.Coners[1].X:=NxtStep.XNow.X+Stepper.Delta/3*d.Y;
 NxtStep.Coners[1].Y:=NxtStep.XNow.Y-Stepper.Delta/3*d.X;
 NxtStep.Coners[2].X:=NxtStep.XNow.X-Stepper.Delta/3*d.Y;
 NxtStep.Coners[2].Y:=NxtStep.XNow.Y+Stepper.Delta/3*d.X;
end;
begin
 sqrt2:=Sqrt(2);
 PrdStep:=Stepper;
 NxtStep:=Stepper;
 if (Stepper.obhod<>0) then
 begin
   Stepper.Dir.X:=Stepper.XNext.X-Stepper.XNow.X;
   Stepper.Dir.Y:=Stepper.XNext.Y-Stepper.XNow.Y;
   tempx:=sqrt(Stepper.Dir.X*Stepper.Dir.X+Stepper.Dir.Y*Stepper.Dir.Y);
   NxtStep.Dir.X:=Stepper.Dir.X/tempx;
   NxtStep.Dir.Y:=Stepper.Dir.Y/tempx;
   Stepper.Dir.X:=NxtStep.Dir.X;
   Stepper.Dir.Y:=NxtStep.Dir.Y;
 end;
 CalcNextCoord(Stepper.Dir);
 if (not Colligion(Stepper,NxtStep) and not Stepper.NoForvard
     and ((Stepper.Dir.X*PrdStep.Dir.X+Stepper.Dir.Y*PrdStep.Dir.Y)>=0)) then Stepper.obhod:=0
 else
 if PrdStep.obhod=0 then
 begin
  red:=true;
  j:=0;
  repeat
   Inc(j);
   tempy:=(Stepper.Dir.X+Stepper.Dir.Y)/sqrt2;
   tempx:=(Stepper.Dir.X-Stepper.Dir.Y)/sqrt2;
   Stepper.Dir.X:=tempx;
   Stepper.Dir.Y:=tempy;
   CalcNextCoord(Stepper.Dir);
   if not Colligion(Stepper,NxtStep) then
   begin
    Stepper.obhod:=1;
    red:=false;
   end
   else
   begin
    tempy:=(NxtStep.Dir.Y-NxtStep.Dir.X)/sqrt2;
    tempx:=(NxtStep.Dir.X+NxtStep.Dir.Y)/sqrt2;
    NxtStep.Dir.X:=tempx;
    NxtStep.Dir.Y:=tempy;
    CalcNextCoord(NxtStep.Dir);
    if not Colligion(Stepper,NxtStep) then
    begin
     Stepper.obhod:=-1;
     Stepper.Dir.X:=NxtStep.Dir.X;
     Stepper.Dir.Y:=NxtStep.Dir.Y;
     red:=false;
    end;
   end;
   if (red and (j=3)) then
   begin
    Stepper.Dir.X:=0;
    Stepper.Dir.Y:=0;
    red:=false;
   end;
  until not red;
 end
 else
 begin
  red:=true;
  j:=0;
  repeat
   Inc(j);
   tempy:=(Stepper.obhod*Stepper.Dir.X+Stepper.Dir.Y)/sqrt2;
   tempx:=(Stepper.Dir.X-Stepper.obhod*Stepper.Dir.Y)/sqrt2;
   Stepper.Dir.X:=tempx;
   Stepper.Dir.Y:=tempy;
   CalcNextCoord(Stepper.Dir);
   if not Colligion(Stepper,NxtStep) then
   if Stepper.NoForvard then Stepper.NoForvard:=false else red:=false;
   if (red and (j=3)) then
   begin
    Stepper.Dir.X:=0;
    Stepper.Dir.Y:=0;
    red:=false;
   end;
  until not red;
 end;
 if ((Abs(Stepper.Dir.X+PrdStep.Dir.X)<0.001) and (Abs(Stepper.Dir.Y+PrdStep.Dir.Y)<0.001))
 then Stepper.NoForvard:=true else Stepper.NoForvard:=false;
end;

procedure GetDir(var Stepper :TTarget_Model_Tek);
var tempx : real;
begin
   Stepper.Dir.X:=Stepper.XNext.X-Stepper.XNow.X;
   Stepper.Dir.Y:=Stepper.XNext.Y-Stepper.XNow.Y;
   tempx:=sqrt(Stepper.Dir.X*Stepper.Dir.X+Stepper.Dir.Y*Stepper.Dir.Y);
   Stepper.Dir.X:=Stepper.Dir.X/tempx;
   Stepper.Dir.Y:=Stepper.Dir.Y/tempx;
end;

procedure IsPointCompleted(var Stepper :TTarget_Model_Tek);   //�������� ������� � ����� ����������
begin
 if (abs(Stepper.XNext.X-Stepper.XNow.X)<=Eps) and (abs(Stepper.XNext.Y-Stepper.XNow.y)<=Eps) then
 begin
  Stepper.Complited[Stepper.PointTek]:=true;
  Stepper.Dir.X:=0;
  Stepper.Dir.Y:=0;
 end;
end;

procedure Isx_Model;
var a: word;
begin
  for a:=1 to COL_MAX_OBJEKT_TAK_TEX do begin
    Model[a].Typ:=0;
    Model[a].Akt:=0;
    Target_Model_Tek[a].Svoboden:=true;
    Target_Model_Tek[a].Zar:=false;
    Poraj_TAK_TEX[a]:=0;
  end;
end;

procedure Otvet_Model(num: word);
var
a,b,p: word;
r,d: real;
begin
exit;
  if (Task.m_index>5000)and(Task.m_index<6000)then begin
//    if Form1.ComboBox1.ItemIndex=0 then exit;  // ����� �� ����
    r:=R_REAK_MODEL;
    b:=0;
    for a:=1 to Col_Model do begin // ������� ����������, ��������� ���� �� ������
      if (Target_Model_Tek[a].Gotov){and(Model[a].Typ<>2)} then begin
        d:=sqr(BMP[num].X_PTUR-Model[a].Xtek)+sqr(BMP[num].Y_PTUR+Model[a].Ytek);
        if d<r then begin
          r:=d;
          b:=a;
        end;
      end;
    end;
    if b=0 then begin // ���� ��� �����������, �� ���� �� ���������
      for a:=1 to Col_Model do begin
        if Target_Model_Tek[a].Svoboden and not Target_Model_Tek[a].Gotov
           and(Target_Model_Isx[a].Num<>14)then begin
          d:=sqr(BMP[num].X_PTUR-Model[a].Xtek)+sqr(BMP[num].Y_PTUR+Model[a].Ytek);
          if d<r then begin
            r:=d;
            b:=a;
          end;
        end;
      end;
    end;
    if b>0 then begin
      Target_Model_Tek[b].Svoboden:=false;/// ��������� ���� ���������� �������
      Target_Model_Tek[b].Num_BMP:=num;   //  ����� ������ �����, �� �������� ����� ������� �����
      // ����� ����������� ��������
      r:=(BMP[num].Ytek-Model[b].Ytek);
      if r=0 then r:=0.00001;
      p:=Target_Model_Tek[b].PointTek;// ����� ������ ���� ������(����� ������� �����)
      Target_Model_Tek[b].AzBase[p]:= ArcTan((BMP[num].Xtek-Model[b].Xtek)/r)*57.3;
      if r<0 then Target_Model_Tek[b].AzBase[p]:=Target_Model_Tek[b].AzBase[p]+180
             else if (BMP[num].Xtek-Model[b].Xtek)<0 then Target_Model_Tek[b].AzBase[p]:=Target_Model_Tek[b].AzBase[p]+360;
      Target_Model_Tek[b].Vytek[p]:=Target_Model_Tek[b].Skor[p]*cos(Target_Model_Tek[b].AzBase[p]/57.3);
      Target_Model_Tek[b].Vxtek[p]:=Target_Model_Tek[b].Skor[p]*sin(Target_Model_Tek[b].AzBase[p]/57.3);
    end;
  end;
end;

end.
