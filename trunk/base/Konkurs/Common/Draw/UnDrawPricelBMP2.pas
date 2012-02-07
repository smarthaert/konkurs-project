unit UnDrawPricelBMP2;

interface

uses
  dglOpenGL, UnBuildPricelBMP2, UnOther, UnVarConstOpenGL;

  // ���������� �����
  procedure Draw_Pricel;
  procedure PricelNavodBPK;
  procedure PricelNavodPNV;
  procedure PricelNavodPTU;
  procedure PricelKomandPZ;
  procedure PricelKomandTKN;
  procedure PricelMexanik;
  //���� � �����������
  procedure Clear_Dust;
  procedure Add_Dust(intens : real);
  procedure Draw_Dust;
  procedure Draw_ZAPOT_NAV(transp: real);
  procedure Draw_ZAPOT_MV(transp: real);

implementation

type
  TDustPoint=record
    x: word;
    y: word;
    size : word;
  end;

const
  DUST_X = 512;
  DUST_Y = 384;
  DUST_COUNT = 20000;

var
  Dust_Exist : boolean = false;  //false ���� �������� ������
  Dust : array[1..DUST_COUNT] of TDustPoint;

const
 LIGHT_TEMP: Array [0..3] of GLFloat = (1, 0.8, 0, 1.0);

// ���������� ����� ��� ������ �� ������
procedure Draw_Pricel;
begin
  glDisable(GL_FOG);
  glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);

  case otobr_RM of
    RM_RUKOVOD:;
    RM_KOMAND_TKN: PricelKomandTKN;
    RM_KOMAND_PZ:  PricelKomandPZ;
    RM_NAVOD_PTU:  PricelNavodPTU;
    RM_NAVOD_BPK:  PricelNavodBPK;
    RM_NAVOD_PNV:  PricelNavodPNV;
    RM_MEXAN:      PricelMexanik;
  end;
  glEnable(GL_FOG);
end;

procedure PricelNavodBPK;
begin
  // ���� ���� ��������
  if (Povrejden[Num_BMP]=DESTR_COMPL) then begin
    glCallList(SHTORKA);
    exit;
  end;
  glPushMatrix;
    if  BMP[Num_BMP].Kolpak then  glCallList(SHTORKA);
    glCallList(KRUG4); // ���� ������� ��������
    glAlphaFunc(GL_GEQUAL,0.3);
    glEnable(GL_ALPHA_TEST);
    if BMP[Num_BMP].pereklSpuskiKrBU25 then glEnable(GL_LIGHT2); // ���������� ����� ������� 1A40
    LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_BPK/255;
    LIGHT_TEMP[1]:=LIGHT_TEMP[0];
    glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� �������
    glTranslatef(BMP[Num_BMP].Var_vyv[1], BMP[Num_BMP].Var_vyv[2], 0);     // �������
    glCallList(PRICEL_N_D);                        // ����� � ������������� �������
    // �������������� �����
    glTranslatef(0,(BMP[Num_BMP].ballist),0);
    glCallList(PRICEL_N_DM);
    glDisable(GL_LIGHT2);
    glDisable(GL_ALPHA_TEST);
    glAlphaFunc(GL_GEQUAL,0.5);
  glPopMatrix;
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure PricelNavodPNV;
const
  mat: array[0..3] of GLfloat=(0,0,0,1);
begin
  // ���� ���� ��������
  if (Povrejden[Num_BMP]=DESTR_COMPL) then begin
    glCallList(SHTORKA);
    exit;
  end;
  glPushMatrix;
    if  BMP[Num_BMP].Kolpak then  glCallList(SHTORKA);
    if BMP[Num_BMP].Shtorka  then begin
      if (BMP[Num_BMP].Diafragma>0) then begin       // ���������
        mat[3]:=BMP[Num_BMP].Diafragma/255;
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
        glCallList(DIAFRAGMA);
      end;
    end
    else begin
      glCallList(SHTORKA);
    end;
    glCallList(KRUG4); // ���� ������� ��������
    glAlphaFunc(GL_GEQUAL,0.3);
    glEnable(GL_ALPHA_TEST);
    if BMP[Num_BMP].pereklSpuskiKrBU25 then glEnable(GL_LIGHT2); // ���������� ����� ������� 1A40
    LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_BPK/255;
    LIGHT_TEMP[1]:=LIGHT_TEMP[0];
    glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� �������
    glTranslatef(BMP[Num_BMP].Var_vyv[1], BMP[Num_BMP].Var_vyv[2], 0);     // �������
    // �������������� �����
    glTranslatef(0,(BMP[Num_BMP].ballist),0);
    glCallList(PRICEL_N_N);// ������ �����
  glPopMatrix;
  glDisable(GL_LIGHT2);
  glDisable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GEQUAL,0.5);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure PricelNavodPTU;
begin
  // ���� ���� ��������
  if Povrejden[Num_BMP]=DESTR_COMPL then begin
    glCallList(SHTORKA);
    exit;
  end;
  if  BMP[Num_BMP].Zaslon_9CH then   glCallList(SHTORKA);
  glCallList(KRUG3); // ���� ������� ��������
  LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_PTR/255;
  LIGHT_TEMP[1]:=LIGHT_TEMP[0];
  glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ���
  glCallList(PRICEL_PTUR);
  glEnable(GL_LIGHT2);                          // ���������� ����� ������� ���
  LIGHT_TEMP[1]:=0;
  LIGHT_TEMP[2]:=0;
  if not BMP[Num_BMP].pereklBsNbBU25 then begin
    glEnable(GL_LIGHT2);                          // ���������� ����� ������� ����
    LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_PTR/255;
    glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ����
    glCallList(PRICEL_PTUR_MARKA);
  end
  else begin
    if BMP[Num_BMP].Start_PTUR then begin
      glEnable(GL_LIGHT2);                          // ���������� ����� ������� ����
      if BMP[Num_BMP].pereklSpuskiKrBU25 then LIGHT_TEMP[0]:=1;
      glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ����
      glCallList(PRICEL_PTUR_MARKA);
    end;
  end;
  glDisable(GL_LIGHT2);
end;

procedure PricelKomandPZ;
begin
  // ���� ���� ��������
  if Povrejden[Num_BMP]=DESTR_COMPL then begin
    glCallList(SHTORKA);
    exit;
  end;
  if  BMP[Num_BMP].Kolpak_kom then glCallList(SHTORKA);
  LIGHT_TEMP[0]:=BMP[Num_BMP].Lumen_1PZ/255;
  LIGHT_TEMP[1]:=LIGHT_TEMP[0];
  glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ���
  if BMP[Num_BMP].X4 then begin
    glCallList(KRUG1); // ���� ������� ��������
    if BMP[Num_BMP].pereklSpuskiKrBU25 and BMP[Num_BMP].pereklOsveshPZ then glEnable(GL_LIGHT2);                          // ���������� ����� ������� ���
    glPushMatrix;
      glAlphaFunc(GL_GEQUAL,0.3);
      glEnable(GL_ALPHA_TEST);
      glTranslatef(BMP[Num_BMP].Var_vyv[3], BMP[Num_BMP].Var_vyv[4], 0);     // �������
      glCallList(PRICEL_K_D);                        // ����� � ������������� �������
      // �������������� �����
      glTranslatef(0,(BMP[Num_BMP].ballist_kom),0);
      LIGHT_TEMP[1]:=0;
      glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ���
      glCallList(PRICEL_K_DM);
    glPopMatrix;
  end
  else begin
    glCallList(KRUG2); // ���� ������� ��������
    if BMP[Num_BMP].pereklSpuskiKrBU25 and BMP[Num_BMP].pereklOsveshPZ then glEnable(GL_LIGHT2);                          // ���������� ����� ������� ���
    glPushMatrix;
      glAlphaFunc(GL_GEQUAL,0.3);
      glEnable(GL_ALPHA_TEST);
      glTranslatef(BMP[Num_BMP].Var_vyv[3], BMP[Num_BMP].Var_vyv[4], 0);     // �������
      glCallList(PRICEL_K_D2);                        // ����� � ������������� �������
      // �������������� �����
      glTranslatef(0,(BMP[Num_BMP].ballist_kom),0);
      LIGHT_TEMP[1]:=0;
      glLightfv(GL_LIGHT2, GL_AMBIENT, @LIGHT_TEMP); // ���� ����� ������� ���
      glCallList(PRICEL_K_DM);
    glPopMatrix;
  end;
  glDisable(GL_LIGHT2);
  glDisable(GL_ALPHA_TEST);
  case BMP[Num_BMP].pereklFiltrPZ of
    0: ;
    1: glCallList(FILTR1);
    2: glCallList(FILTR2);
  else ;
  end;
  glAlphaFunc(GL_GEQUAL,0.5);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure PricelKomandTKN;
const
  mat: array[0..3] of GLfloat=(0,0,0,1);
begin
  // ���� ���� ��������
  if Povrejden[Num_BMP]=DESTR_COMPL then begin
    glPushMatrix;
      glScalef(5,7,1);
      glTranslatef(0, -0.013, -0.0502);
      glCallList(SHTORKA);
    glPopMatrix;
    exit;
  end;
  if BMP[Num_BMP].PNV_kom then begin
    mat[3]:=BMP[Num_BMP].Diafragma_kom/255;
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
    glCallList(DIAFRAGMA);
    glPushMatrix;
      glTranslatef(0, BMP[Num_BMP].Shtorka_kom*0.00015, 0.001);
      glCallList(SHTORKA);
    glPopMatrix;
  end;
  if not BMP[Num_BMP].pereklBpTKN and BMP[Num_BMP].pereklDenTKN then begin
    glPushMatrix;
      glScalef(5,7,1);
      glTranslatef(0, -0.013, 0.001);
      glCallList(SHTORKA);
    glPopMatrix;
  end;
  glCallList(KRUG1); // ���� ������� ��������
  glAlphaFunc(GL_GEQUAL,0.3);
  glEnable(GL_ALPHA_TEST);
  glCallList(PRICEL_TKN);
  glAlphaFunc(GL_GEQUAL,0.5);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
end;

procedure PricelMexanik;
begin
  // ���� ���� ��������
  if Povrejden[Num_BMP]=DESTR_COMPL then begin
    glPushMatrix;
      glScalef(10,8,1);
      glTranslatef(0, -0.013, -0.0502);
      glCallList(SHTORKA);
    glPopMatrix;
  end
  else begin
    if Dust_Exist then Draw_Dust;
    Draw_ZAPOT_MV(BMP[Num_BMP].zapot/255);
  end;
  // ������ (����)
  if Dust_Exist and BMP[Num_BMP].dust_clean then Clear_Dust;
  Add_Dust(BMP[Num_BMP].Skorost/100*BMP[Num_BMP].dust_intens/255);
end;

procedure Clear_Dust;
var
  i: integer;
begin
  Dust_Exist:=false;
  for i:=1 to DUST_COUNT do Dust[i].size:=0;
end;

procedure Add_Dust(intens : real);
var k,Count,n : integer;
begin
  Dust_Exist:=true;
  Count:=Round(DUST_COUNT*intens);
  for k:=0 to Count-1 do begin
    n:=1+Round(Random*(DUST_COUNT-1));
    if Dust[n].size=0 then  begin
      Dust[n].x:=Round(Random*(DUST_X-1));
      Dust[n].y:=Round(Random*(DUST_Y-1));
    end;
    Inc(Dust[n].size);
  end;
end;

procedure Draw_Dust;
const
    mat:  Array [0..3] of GLFloat=(1,1,1,1);
var i : integer;
    a,b : glFloat;
begin
  if not Dust_Exist then exit;
  glPointSize(1);
  glDisable(GL_TEXTURE_2D);  //��������� ������ ������������ ���������
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);//������ ������������ ���������
  glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
  glPushMatrix;
    glTranslatef(0, 0.0002, -0.049);
    for i:=1 to DUST_COUNT do if Dust[i].size>0 then begin
      glPointSize(Dust[i].size);
      a:=(2-4*Dust[i].x/DUST_X)/128;
      b:=(1-2*Dust[i].y/DUST_Y-0.02)/92;
      glBegin(GL_POINTS);
        glVertex2f(a,b);
      glEnd;
    end;
  glPopMatrix;
  glEnable(GL_TEXTURE_2D);
end;

procedure Draw_ZAPOT_NAV(transp: real);
const
  mat:array [0..3] of GLFloat =( 1, 1, 1, 1);
begin
  //������ ������������ ���������
  mat[3]:=transp;
  // ��������� ������ ������������ ���������
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
  glCallList(ZAPOT_NAV);
  // ��������������� ���������
  mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
end;

procedure Draw_ZAPOT_MV(transp: real);
const
  mat:array [0..3] of GLFloat =( 1, 1, 1, 1);
begin
  //������ ������������ ���������
  mat[3]:=transp;
  // ��������� ������ ������������ ���������
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
  glCallList(ZAPOT_MV);
  // ��������������� ���������
  mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
end;

end.
