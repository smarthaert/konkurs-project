unit UnDrawModel;

interface
uses
  UnBuild, dglOpenGL, UnBuildModel, UnOther;

  procedure Draw_Model;
  procedure Draw_BMP1(n: integer);
  procedure Draw_Apach(n: integer);
  procedure Draw_M113(n: integer);
  procedure Draw_M2(n: integer);
  procedure Draw_Leo(n: integer);
  procedure Draw_T80(n: integer);
  procedure Draw_Arjun(n: integer);
  procedure Draw_Bunker(n: integer);
  procedure Draw_Kamaz(n: integer);
  procedure Draw_M1A1(n: integer);
  procedure Draw_M48(n: integer);
  procedure Draw_T84(n: integer);
  procedure Draw_Vijayanta(n: integer);
  procedure Draw_Sapsan(n: integer);
  procedure Draw_UAZ(n: integer);
  procedure Draw_T72(n: integer);
  procedure Draw_T55(n: integer);
  procedure Draw_T59(n: integer);
  procedure Draw_T69(n: integer);
  procedure Draw_T90(n: integer);
  procedure  Draw_BMP2(n: integer);
  procedure  Draw_BTR80(n: integer);
  procedure Draw_Scorpion(n: integer);
  procedure Draw_BMD3(n: integer);
  procedure Draw_Cobra(n: integer);
  procedure Draw_A_10A(n: integer);
  procedure Draw_F_16(n: integer);
  procedure Draw_SU_25(n: integer);
  procedure Draw_ALKM(n: integer);
  procedure Draw_F_15(n: integer);
  procedure Draw_ZSU(n: integer);

  procedure  Draw_MI24(n: integer);
  procedure  Draw_BTR_RD(n: integer);
  procedure  Draw_Bredly(n: integer);
  procedure  Draw_2C9(n: integer);
  procedure  Draw_D30(n: integer);

implementation
uses
  UnDraw;
const
  POL_BTR_H=1;            //��������� ������� ��� �� � � ������� ��������
  X_KOLESO_P=0.0718;
  X_KOLESO_L=0.0016;
  H_KOLESO=0.009;
  Y1_KOLESO=0.18265;
  Y2_KOLESO=0.14165;
  Y3_KOLESO=0.08095;
  Y4_KOLESO=0.039;
  X_BASHN=0.036;
  H_BASHN=0.033;
  Y_BASHN=0.143;
  X_STVOL=0;
  H_STVOL=0.0055;
  Y_STVOL=0.015;

var
  baz_rot: array[1..COL_TEXNIKA_MODEL]of boolean;
  rot_vint: array[1..COL_TEXNIKA_MODEL] of real;
  rot_koleso: array[1..COL_TEXNIKA_MODEL] of real;


procedure Draw_Model;
var n:word;
begin
  for n:=1 to COL_TEXNIKA_MODEL do begin
    if Model[n].Typ>0 then begin
      case Model[n].Typ of
        MODEL_T55:  Draw_T55(n);
        MODEL_T72: Draw_T72(n);
        MODEL_T80: Draw_T80(n);
        MODEL_T90: Draw_T90(n);
        MODEL_T59: Draw_T59(n);
        MODEL_T69: Draw_T69(n);
        MODEL_T84: Draw_T84(n);
        MODEL_ARJUN: Draw_Arjun(n);
        MODEL_VJAYANTA: Draw_Vijayanta(n);
        MODEL_LEOPARD: Draw_Leo(n);
        MODEL_M1A1: Draw_M1A1(n);
        MODEL_M48: Draw_M48(n);

        MODEL_BMP1: Draw_BMP1(n);
        MODEL_BMP2: Draw_BMP2(n);
        MODEL_BMD3: Draw_BMD3(n);
        MODEL_BTR80: Draw_BTR80(n);
        MODEL_M113: Draw_M113(n);
        MODEL_M2: Draw_M2(n);
        MODEL_SCORPION: Draw_Scorpion(n);
        MODEL_BTR_RD: Draw_BTR_RD(n);
        MODEL_BREDLY: Draw_Bredly(n);

        MODEL_APACH: Draw_Apach(n);
        MODEL_COBRA: Draw_Cobra(n);
        MODEL_MI24: Draw_MI24(n);

        MODEL_A10A: Draw_A_10A(n);
        MODEL_F15: Draw_F_15(n);
        MODEL_F16: Draw_F_16(n);
        MODEL_SU25: Draw_SU_25(n);

        MODEL_ALKM: Draw_ALKM(n);
        MODEL_SAPSAN: Draw_Sapsan(n);

        MODEL_KAMAZ: Draw_Kamaz(n);
        MODEL_UAZ469: Draw_Uaz(n);
        MODEL_2C9: Draw_2C9(n);
        MODEL_D30: Draw_D30(n);
        MODEL_BUNKER: Draw_Bunker(n);
      end;
    end;
  end;
end;

//===================== �������===========================

procedure Draw_ARJUN(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(ARJUN_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(ARJUN_BAZA2)else glCallList(ARJUN_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(ARJUN_BASHNA);
    glTranslatef(0.1,0.201,0);
    glCallList(ARJUN_STVOL);
  glPopMatrix;
end;

procedure Draw_Bunker(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (280-Model[n].AzBase, 0, 1.0, 0);
    glCallList(BUNKER);
  glPopMatrix;
end;

procedure Draw_M1A1(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(M1A1_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(M1A1_BAZA2)else glCallList(M1A1_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(M1A1_BASHNA);
    glTranslatef(0,0.201,-0.18);
    glCallList(M1A1_STVOL);
  glPopMatrix;
end;

procedure Draw_M48(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(M48_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(M48_BAZA2)else glCallList(M48_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(M48_BASHNA);
    glTranslatef(0.14,0.2201,0);
    glCallList(M48_STVOL);
  glPopMatrix;
end;
procedure Draw_T84(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(T84_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(T84_BAZA2)else glCallList(T84_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(T84_BASHNA);
    glTranslatef(0.1,0.201,0);
    glCallList(T84_STVOL);
  glPopMatrix;
end;
procedure Draw_Vijayanta(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(VJAYANTA_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(VJAYANTA_BAZA2)else glCallList(VJAYANTA_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(VJAYANTA_BASHNA);
    glTranslatef(0.1,0.201,0);
    glCallList(VJAYANTA_STVOL);
  glPopMatrix;
end;
procedure Draw_Sapsan(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(SAPSAN);
  glPopMatrix;
end;
procedure Draw_UAZ(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(UAZ_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(UAZ_BAZA2)else glCallList(UAZ_BAZA1);
  glPopMatrix;
end;

procedure Draw_Kamaz(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(KAMAZ_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(KAMAZ_BAZA2)else glCallList(KAMAZ_BAZA1);
  glPopMatrix;
end;

// M113
procedure Draw_M113(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(M113_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(M113_BAZA2)else glCallList(M113_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(M113_STVOL);
  glPopMatrix;
end;

// ���� ����������//---
procedure Draw_T80(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(TANK_BAZA2_T80)else glCallList(TANK_BAZA1_T80);
    end else glCallList(TANK_BAZA1_T80);
    glTranslatef(-0.008,0.016,0);
    glCallList(TANK_KORPUS_T80);
    //  ����� � ����� �-80
    glTranslatef(-0.090,0.002,0);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glTranslatef(0.05,0,0);
    glPushMatrix;
      glScalef(1.1,1.175,1);
      glCallList(TANK_BASHNA_T80);
    glPopMatrix;
    glTranslatef(-0.17,0.071,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
//    glTranslatef(0,0,otkat[n]);
    glCallList(TANK_STVOL_T80);
  glPopMatrix;
end;

procedure Draw_T72(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(TANK_BAZA1_T72);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(TANK_BAZA2_T72)else glCallList(TANK_BAZA1_T72);
    end else glCallList(TANK_BAZA1_T72);
    glTranslatef(-0.008,0.016,0);
    glCallList(TANK_KORPUS_T72);
    //  ����� � ����� �-80
    glTranslatef(-0.090,0.002,0);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glTranslatef(0.05,0,0);
    glPushMatrix;
      glScalef(1.1,1.175,1);
      glCallList(TANK_BASHNA_T72);
    glPopMatrix;
    glTranslatef(-0.17,0.071,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
//    glTranslatef(0,0,otkat[n]);
    glCallList(TANK_STVOL_T72);
  glPopMatrix;
end;

procedure Draw_T55(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glRotatef (-90, 0, 1, 0);
    glCallList(TANK_KORPUS_T55);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(TANK_BAZA2_T55)else glCallList(TANK_BAZA1_T55);
    end else glCallList(TANK_BAZA1_T55);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(TANK_BASHNA_T55);
    glTranslatef(0,0.057,0.15);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(TANK_STVOL_T55);
  glPopMatrix;
end;

procedure Draw_T59(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek+0.01, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(TANK_KORPUS_T59);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(TANK_BAZA2_T59)else glCallList(TANK_BAZA1_T59);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(TANK_BASHNA_T59);
    glTranslatef(0.1,0.17,0);
    glCallList(TANK_STVOL_T59);
  glPopMatrix;
end;

procedure Draw_T69(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek+0.01, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(TANK_KORPUS_T69);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(TANK_BAZA2_T69)else glCallList(TANK_BAZA1_T69);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(TANK_BASHNA_T69);
    glTranslatef(0.1,0.17,0);
    glCallList(TANK_STVOL_T69);
  glPopMatrix;
end;

procedure Draw_T90(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek+0.11, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(TANK_KORPUS_T90);
    //  �������� �-90
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(TANK_BAZA2_T90)else glCallList(TANK_BAZA1_T90);
    end else glCallList(TANK_BAZA1_T90);
    //  ����� � ����� �-90
    glTranslatef(-0.02,-0.020, 0);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glPushMatrix;
      glScalef(0.9,1,1);
      glCallList(TANK_BASHNA_T90);
    glPopMatrix;
    glTranslatef(-0.150,0.084,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(TANK_STVOL_T90);
  glPopMatrix;
end;

// M2
procedure Draw_M2(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(M2_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(M2_BAZA2)else glCallList(M2_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glTranslatef(0, 0.035, 0);
    glScalef(1,0.7,1);
    glCallList(M2_BASHNA);
  glPopMatrix;
end;

procedure Draw_BMP1(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glScalef(0.8,0.8,0.6);
    glCallList(BMP1_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(BMP1_BAZA2)else glCallList(BMP1_BAZA1);
    end else glCallList(BMP1_BAZA1);
    glTranslatef(0.1, -0.014, -0.05);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(BMP1_BASHNA);
    glTranslatef(-0.084, 0.021, 0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(BMP1_STVOL);
    glTranslatef(-0.06,0.032,0);
    glCallList(ROCKET);
  glPopMatrix;
end;

// �������
procedure Draw_Apach(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-Model[n].Kren, 1, 0, 0);
    glCallList(APACH_KORP);
    glTranslatef(0.185017228126526,0.159459412097931,0);
    glPushMatrix;
      glRotatef(rot_vint[n],0,0,1);
      glTranslatef(-0.185017228126526,-0.159459412097931,0);
      glCallList(APACH_STAB);
    glPopMatrix;
    glTranslatef(-0.203,-0.16,-0.0145);
    glRotatef(rot_vint[n],0,1,0);
    glTranslatef(0.0181389451026917,0,0.0145111549645662);
    glCallList(APACH_VINT);
  glPopMatrix;
  if Model[n].Akt>$0f then begin // ����� ����
  end else rot_vint[n]:=rot_vint[n]+50;
end;

// ���� ����������//---
procedure Draw_Leo(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glRotatef (-90, 0, 1, 0);
    glCallList(LEO_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(LEO_BAZA2)else glCallList(LEO_BAZA1);
    end else glCallList(LEO_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(LEO_BASHNA);
    glTranslatef(0,0.057,0.15);
    glRotatef (Model[n].UmPushka-1,0,0,1);
    glCallList(LEO_STVOL);
  glPopMatrix;
end;

procedure Draw_Scorpion(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (90-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glRotatef (-90, 0, 1, 0);
//    glScale(10,10,10);
    glCallList(SCORP_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(SCORP_BAZA2)else glCallList(SCORP_BAZA1);
    end else glCallList(SCORP_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(SCORP_BASHNA);
    glTranslatef(0, 0.18, -0.08);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(SCORP_STVOL);
  glPopMatrix;
end;

procedure Draw_ZSU(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek-0.12, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 1, 0, 0);
    glRotatef (-Model[n].Kren, 0, 0, 1);
    glScalef(1.1,1,0.95);
    glCallList(ZSU_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(ZSU_BAZA2)else glCallList(ZSU_BAZA1);
    end else glCallList(ZSU_BAZA1);
{    glLightfv(GL_LIGHT4,GL_SPOT_DIRECTION,@NaprFarMV);
    glLightfv(GL_LIGHT4, GL_POSITION, @PosFaraMV);
    glLightfv(GL_LIGHT5,GL_SPOT_DIRECTION,@NaprFarMV);
    glLightfv(GL_LIGHT5, GL_POSITION, @PosFaraMV);
    glLightfv(GL_LIGHT6,GL_SPOT_DIRECTION,@NaprFarMV);
    glLightfv(GL_LIGHT6, GL_POSITION, @PosFaraMV);  }

//    glRotatef (-ZSU[n].AzBashna,0,1,0);
    glCallList(ZSU_BASHNA);
    glPushMatrix;
      glRotatef (180,0,1,0);
      glTranslatef(0,0.3,0.085);
      glRotatef (270,1,0,0);
      glCallList(ZSU_SOC);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(0,0.26,-0.105);
      glCallList(ZSU_SSC);
    glPopMatrix;
    glPushMatrix;
//      glRotatef (ZSU[n].UmPushka,0,0,1);
      glTranslatef(0, 0.26, 0.04);
      glCallList(ZSU_STVOL);
    glPopMatrix;
    glPushMatrix;
//      glRotatef (ZSU[n].UmPushka,0,0,1);
      glTranslatef(0, 0.225, 0.095);
      glCallList(ZSU_CONTEN);
    glPopMatrix;
  glPopMatrix;
end;

// ���-3
procedure Draw_BMD3(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek-0.11, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].UmBase, 0.1, 0.0, 0);
    glRotatef (-Model[n].Kren, 0, 0, 1);
    glCallList(BMD3_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
    end;
    if baz_rot[n] then glCallList(BMD3_BAZA2)else glCallList(BMD3_BAZA1);
    //  ����� � �����
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(BMD3_BASHNA);
    glTranslatef(0,0.175,-0.1);
    glRotatef (-Model[n].UmPushka,1,0,0);
    glCallList(BMD3_STVOL);
  glPopMatrix;
end;

procedure Draw_Cobra(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek-0.2, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-Model[n].Kren, 1, 0, 0);
    glPushMatrix;
      glScalef(1,1,2);
      glCallList(COBRA_KORP);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(0.93,0.31,-0.005);
      glRotatef(rot_vint[n],0,0,1);
      glCallList(COBRA_STAB);
    glPopMatrix;
    glRotatef(rot_vint[n],0,1,0);
    glTranslatef(0.0, 0.03, 0.0);
    glCallList(COBRA_VINT);
  glPopMatrix;
  if Model[n].Akt>$0f then begin // ����� ����
  end else rot_vint[n]:=rot_vint[n]+50;
end;
 // �������
procedure Draw_A_10A(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (180-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].Kren, 0, 0, 1);
    glRotatef (Model[n].UmBase, 1, 0, 0);
    glCallList(A_10A);
  glPopMatrix;
end;
procedure Draw_F_16(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (180-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].Kren, 0, 0, 1);
    glRotatef (Model[n].UmBase, 1, 0, 0);
    glCallList(F_16);
  glPopMatrix;
end;
procedure Draw_SU_25(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (180-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].Kren, 0, 0, 1);
    glRotatef (Model[n].UmBase, 1, 0, 0);
    glCallList(SU_25);
  glPopMatrix;
end;
procedure Draw_ALKM(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].Kren, 0, 0, 1);
    glRotatef (Model[n].UmBase, 1, 0, 0);
    glCallList(ALKM);
  glPopMatrix;
end;
procedure Draw_F_15(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (180+Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].Kren, 0, 0, 1);
    glRotatef (Model[n].UmBase, 1, 0, 0);
    glScalef(2,2,2);
    glCallList(F_15);
  glPopMatrix;
end;

procedure  Draw_BMP2(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glScalef(1.07,1,1);
    glCallList(BMP2_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(BMP2_BAZA2)else glCallList(BMP2_BAZA1);
    end else glCallList(BMP2_BAZA1);
    glPushMatrix;
      glScalef(0.94,1,0.94);
      glCallList(BMP2_BASHNA);
    glPopMatrix;
    glTranslatef(-0.118,0.087,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(BMP2_STVOL);
  glPopMatrix;
end;

// ���
procedure  Draw_BTR80(n: integer);
begin
  glPushMatrix;
    glTranslatef(-Model[n].Xtek/10, Model[n].Htek/10, -Model[n].Ytek/10);
    glRotatef (360-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (-Model[n].Kren, 1, 0, 0);
    glScalef(3.5,3,3);
    glCallList(BTR_KORPUS);
    //  ����� ���
    glPushMatrix;
      glTranslatef(X_KOLESO_P, -H_KOLESO, -Y1_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_P);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_P, -H_KOLESO, -Y2_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_P);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_P, -H_KOLESO, -Y3_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_P);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_P, -H_KOLESO, -Y4_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_P);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_L, -H_KOLESO, -Y1_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_L);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_L, -H_KOLESO, -Y2_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_L);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_L, -H_KOLESO, -Y3_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_L);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(X_KOLESO_L, -H_KOLESO, -Y4_KOLESO);
      glRotatef (-rot_koleso[n],1,0,0);
      glCallList(BTR_KOLESO_L);
    glPopMatrix;
    //  ����� � ����� ���
    glTranslatef(X_BASHN, H_BASHN, -Y_BASHN);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(BTR_BASHNA);
    glTranslatef(X_STVOL, H_STVOL, -Y_STVOL);
    glRotatef (-Model[n].UmPushka,1,0,0);
    glCallList(BTR_STVOL);
  glPopMatrix;
end;


procedure  Draw_MI24(n: integer);
begin
end;

procedure  Draw_BTR_RD(n: integer);
begin
end;

procedure  Draw_Bredly(n: integer);
begin
end;

procedure  Draw_2C9(n: integer);
begin
end;

procedure  Draw_D30(n: integer);
begin
end;

end.
