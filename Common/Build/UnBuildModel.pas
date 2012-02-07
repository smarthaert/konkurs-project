unit UnBuildModel;

interface

uses
  dglOpenGL, UnBuildObject, SysUtils, UnOther;

var
  // Боевая техника
  BMP1_KORPUS: integer;
  BMP1_BASHNA: integer;
  BMP1_STVOL: integer;
  BMP1_VENEZ: integer;
  BMP1_NAPR: integer;
  BMP1_KOLESO: integer;
  BMP1_GUSEN: integer;
  BMP1_BAZA1: integer;
  BMP1_BAZA2: integer;
  BMP1_KONKURS : integer;
  ROCKET : integer;

  APACH_KORP: integer;
  APACH_STAB: integer;
  APACH_VINT: integer;

  LEO_KORPUS: integer;
  LEO_BASHNA: integer;
  LEO_STVOL: integer;
  LEO_BAZA1: integer;
  LEO_BAZA2: integer;

  BTR_KORPUS: integer;
  BTR_KOLESO_P: integer;
  BTR_KOLESO_L: integer;
  BTR_STVOL: integer;
  BTR_BASHNA: integer;
  BTR_KOLESO_P_TEK: integer;
  BTR_KOLESO_L_TEK: integer;

  M113_KORPUS: integer;
  M113_STVOL: integer;
  M113_BAZA1: integer;
  M113_BAZA2: integer;

  BMP2_KORPUS: integer;
  BMP2_BASHNA: integer;
  BMP2_STVOL: integer;
  BMP2_BAZA1: integer;
  BMP2_BAZA2: integer;
  BMP2_OTBOY_1: integer;
  BMP2_OTBOY_2: integer;
  BMP2_PERED_1: integer;
  BMP2_PERED_2: integer;

  M2_KORPUS: integer;
  M2_STVOL: integer;
  M2_BAZA1: integer;
  M2_BAZA2: integer;
  M2_BASHNA: integer;

  ARJUN_KORPUS: integer;
  ARJUN_STVOL: integer;
  ARJUN_BAZA1: integer;
  ARJUN_BAZA2: integer;
  ARJUN_BASHNA: integer;
  BUNKER: integer;
  KAMAZ_KORPUS: integer;
  KAMAZ_BAZA1: integer;
  KAMAZ_BAZA2: integer;

  M1A1_KORPUS: integer;
  M1A1_STVOL: integer;
  M1A1_BAZA1: integer;
  M1A1_BAZA2: integer;
  M1A1_BASHNA: integer;

  M48_KORPUS: integer;
  M48_STVOL: integer;
  M48_BAZA1: integer;
  M48_BAZA2: integer;
  M48_BASHNA: integer;

  SAPSAN: integer;

  T84_KORPUS: integer;
  T84_STVOL: integer;
  T84_BAZA1: integer;
  T84_BAZA2: integer;
  T84_BASHNA: integer;

  UAZ_KORPUS: integer;
  UAZ_BAZA1: integer;
  UAZ_BAZA2: integer;

  VJAYANTA_KORPUS: integer;
  VJAYANTA_STVOL: integer;
  VJAYANTA_BAZA1: integer;
  VJAYANTA_BAZA2: integer;
  VJAYANTA_BASHNA: integer;

  TANK_KORPUS_T72: integer;
  TANK_BASHNA_T72: integer;
  TANK_STVOL_T72: integer;
  TANK_BAZA1_T72: integer;
  TANK_BAZA2_T72: integer;

  TANK_KORPUS_T80: integer;
  TANK_BASHNA_T80: integer;
  TANK_STVOL_T80: integer;
  TANK_BAZA1_T80: integer;
  TANK_BAZA2_T80: integer;

  TANK_KORPUS_T90: integer;
  TANK_BASHNA_T90: integer;
  TANK_STVOL_T90: integer;
  TANK_BAZA1_T90: integer;
  TANK_BAZA2_T90: integer;

  TANK_KORPUS_T55: integer;
  TANK_BASHNA_T55: integer;
  TANK_STVOL_T55: integer;
  TANK_BAZA1_T55: integer;
  TANK_BAZA2_T55: integer;

  TANK_KORPUS_T59: integer;
  TANK_BASHNA_T59: integer;
  TANK_STVOL_T59: integer;
  TANK_BAZA1_T59: integer;
  TANK_BAZA2_T59: integer;

  TANK_KORPUS_T69: integer;
  TANK_BASHNA_T69: integer;
  TANK_STVOL_T69: integer;
  TANK_BAZA1_T69: integer;
  TANK_BAZA2_T69: integer;

  SCORP_KORPUS: integer;
  SCORP_BASHNA: integer;
  SCORP_STVOL: integer;
  SCORP_BAZA1: integer;
  SCORP_BAZA2: integer;


  ZSU_KORPUS: integer;
  ZSU_BASHNA: integer;
  ZSU_STVOL: integer;
  ZSU_BAZA1: integer;
  ZSU_BAZA2: integer;
  ZSU_SOC: integer;
  ZSU_SSC: integer;
  ZSU_CONTEN: integer;
  ZUR: integer;

  BMD3_KORPUS: integer;
  BMD3_STVOL: integer;
  BMD3_BASHNA: integer;
  BMD3_BAZA1: integer;
  BMD3_BAZA2: integer;

  // Самолёт A_10A
  A_10A: integer;
  OSKOL_A_10A_BASE: array[1..5] of integer;
  // Самолёт F-15
  F_15: integer;
  // осколки самолёта
  OSKOL_F_15_BASE: array[1..5] of integer;
  // Самолёт F-16
  F_16: integer;
  OSKOL_F_16_BASE: array[1..5] of integer;
  // Вертолёт AH-1F
  COBRA_KORP: integer;
  // Винты
  COBRA_VINT: integer;
  COBRA_STAB: integer;
  OSKOL_COBRA_BASE: array[1..5] of integer;
  // Крылатая ракета
  ALKM: integer;
  OSKOL_ALKM_BASE: array[1..5] of integer;
  // Самолёт СУ-25
  SU_25: integer;
  OSKOL_SU_25_BASE: array[1..5] of integer;



  // Бронеобъекты
  procedure BuildModel;
  procedure Build_Leo;
  procedure Build_Apach;
  procedure Build_BMP1;
  procedure Build_M113;
  procedure Build_M2;
  procedure Build_T72;
  procedure Build_T80;
  procedure Build_BMP2;
  procedure BuildOtherTexnika;
  procedure Build_Scorpion;
  procedure Build_ZSU;
  procedure Build_BTR;

  procedure Build_Samolet_1;

  procedure Build_BMD3;




implementation

uses
  UnBuild;

procedure BuildModel;
begin
  if Task.enableModel[MODEL_LEOPARD] then Build_Leo;
  if Task.enableModel[MODEL_APACH] then Build_Apach;
  if Task.enableModel[MODEL_M113] then Build_M113;
  if Task.enableModel[MODEL_M2] then Build_M2;
  if Task.enableModel[MODEL_BMP1] then Build_BMP1;
  if Task.enableModel[MODEL_T72] then Build_T72;
  if Task.enableModel[MODEL_T80] then Build_T80;
  if Task.enableModel[MODEL_BMP2] then Build_BMP2;
  if Task.enableModel[MODEL_SCORPION] then Build_Scorpion;
  if Task.enableModel[MODEL_BMD3] then Build_BMD3;
  if Task.enableModel[MODEL_BTR80] then Build_BTR;
  BuildOtherTexnika;
  Build_Samolet_1;
//  Build_ZSU;
end;

procedure Build_Leo;
begin
  // Танк противника//---
  MontObject('res/Leopard/Leo_baza.shp',LEO_KORPUS);
  MontObject('res/Leopard/Leo_Bash.shp',LEO_BASHNA);
  MontObject('res/Leopard/Leo_Stv.shp',LEO_STVOL);
  MontObject('res/Leopard/Leo_Dv1.shp',LEO_BAZA1);
  MontObject('res/Leopard/Leo_Dv2.shp',LEO_BAZA2);
end;

procedure Build_Apach;
begin
  // Вертолёт
  MontObject('res/Apach/Apach.shp',APACH_KORP);
  MontObject('res/Apach/Ap_Stab.shp',APACH_STAB);
  MontObject('res/Apach/Ap_Vint.shp',APACH_VINT);
end;

procedure Build_M113;
begin
  // M113
  MontObject('res/M-113/Baza.shp',M113_KORPUS);
  MontObject('res/M-113/Pulem.shp',M113_STVOL);
  MontObject('res/M-113/Dv1.shp',M113_BAZA1);
  MontObject('res/M-113/Dv2.shp',M113_BAZA2);
end;

procedure Build_M2;
begin
  // Мардер
  MontObject('res/M-2/m2_Baza.shp',M2_KORPUS);
  MontObject('res/M-2/m2_bash.shp',M2_BASHNA);
  MontObject('res/M-2/Dv1.shp',M2_BAZA1);
  MontObject('res/M-2/Dv2.shp',M2_BAZA2);
end;

procedure Build_BMP1;
var a: word;
begin
    // БМП-1
  MontObject('res/BMP_1/BMP_1.shp',BMP1_KORPUS);
  MontObject('res/BMP_1/BMP_Bash.shp',BMP1_BASHNA);
  MontObject('res/BMP_1/BMP_Stv.shp',BMP1_STVOL);
  MontObject('res/BMP_1/BMP_kole.shp',BMP1_KOLESO);
  MontObject('res/BMP_1/BMP_vene.shp',BMP1_VENEZ);
  MontObject('res/BMP_1/BMP_napr.shp',BMP1_NAPR);
  MontObject('res/BMP_1/BMP_gus.shp',BMP1_GUSEN);
  MontObject('res/BMP_1/BMP_konk.shp',BMP1_KONKURS);
  MontObject('res/BMP_1/BMP_Rock.shp',ROCKET);
  BMP1_BAZA1:=glGenLists(1);
  glNewList (BMP1_BAZA1, GL_COMPILE);
    glPushMatrix;
      glTranslatef(-0.13,-0.17,0.1497);
      glScalef(1,1,-1);
      for a:= 1 to 6 do begin
        glCallList(BMP1_KOLESO);
        glTranslatef(0.09,0.0,0.0);
      end;
    glPopMatrix;
    glPushMatrix;
      glTranslatef(-0.13,-0.17,-0.275);
      for a:= 1 to 6 do begin
        glCallList(BMP1_KOLESO);
        glTranslatef(0.09,0.0,0.0);
      end;
    glPopMatrix;
    glPushMatrix;
      glTranslatef(0.38,-0.122,0.1257);
      glCallList(BMP1_NAPR);
      glTranslatef(0.0,0.0,-0.4);
      glCallList(BMP1_NAPR);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(-0.214,-0.124,0.1257);
      glCallList(BMP1_VENEZ);
      glTranslatef(0.0,0.0,-0.4);
      glCallList(BMP1_VENEZ);
    glPopMatrix;
    glCallList(BMP1_GUSEN);
  glEndList;
  BMP1_BAZA2:=glGenLists(1);
  glNewList (BMP1_BAZA2, GL_COMPILE);
    glPushMatrix;
      glTranslatef(-0.13,-0.17,0.1497);
      glScalef(1,1,-1);
      for a:= 1 to 6 do begin
        glPushMatrix;
          glRotatef (36, 0.0, 0, 1.0);
          glCallList(BMP1_KOLESO);
        glPopMatrix;
        glTranslatef(0.09,0.0,0.0);
      end;
    glPopMatrix;
    glPushMatrix;
      glTranslatef(-0.13,-0.17,-0.275);
      for a:= 1 to 6 do begin
        glPushMatrix;
          glRotatef (36, 0.0, 0, 1.0);
          glCallList(BMP1_KOLESO);
        glPopMatrix;
        glTranslatef(0.09,0.0,0.0);
      end;
    glPopMatrix;
    glPushMatrix;
      glTranslatef(0.38,-0.122,0.1257);
      glRotatef (36, 0.0, 0, 1.0);
      glCallList(BMP1_NAPR);
      glTranslatef(0.0,0.0,-0.4);
      glCallList(BMP1_NAPR);
    glPopMatrix;
    glPushMatrix;
      glTranslatef(-0.214,-0.124,0.1257);
      glRotatef (36, 0.0, 0, 1.0);
      glCallList(BMP1_VENEZ);
      glTranslatef(0.0,0.0,-0.4);
      glCallList(BMP1_VENEZ);
    glPopMatrix;
    glCallList(BMP1_GUSEN);
  glEndList;
end;

procedure Build_BMP2;
begin
  MontObject('res/BMP_2/bm2_basa.shp',BMP2_KORPUS);
  MontObject('res/BMP_2/bm2_bash.shp',BMP2_BASHNA);
  MontObject('res/BMP_2/bm2_stv.shp',BMP2_STVOL);
  MontObject('res/BMP_2/bm2_dv1.shp',BMP2_BAZA1);
  MontObject('res/BMP_2/bm2_dv2.shp',BMP2_BAZA2);
  MontObject('res/BMP_2_V2/otboy.shp',BMP2_OTBOY_1);
  MontObject('res/BMP_2_V2/otboy2.shp',BMP2_OTBOY_2);
  MontObject('res/BMP_2_V2/pered.shp',BMP2_PERED_1);
  MontObject('res/BMP_2_V2/pered2.shp',BMP2_PERED_2);
end;


procedure Build_T72;
begin
  // Танк Т-72
  MontObject('res/T-72v2/T_72basa.shp',TANK_KORPUS_T72);
  MontObject('res/T-72v2/T_72Bash.shp',TANK_BASHNA_T72);
  MontObject('res/T-72v2/T_72_baza1.shp',TANK_BAZA1_T72);
  MontObject('res/T-72v2/T_72_baza2.shp',TANK_BAZA2_T72);
  MontObject('res/T-72v2/T_72Stv.shp',TANK_STVOL_T72);
end;

procedure Build_T80;
begin
  // Танк Т-80
  MontObject('res/T-80/T-80bas.shp',TANK_KORPUS_T80);
  MontObject('res/T-80/T-80Bash.shp',TANK_BASHNA_T80);
  MontObject('res/T-80/T-80Dvig.shp',TANK_BAZA1_T80);
  MontObject('res/T-80/T-80Dvig2.shp',TANK_BAZA2_T80);
  MontObject('res/T-80/T-80Stv.shp',TANK_STVOL_T80);
end;

procedure BuildOtherTexnika;
begin
  if Task.enableModel[MODEL_ARJUN] then begin
    MontObject('res/Arjun/Arjun_bash.SHP',ARJUN_BASHNA);
    MontObject('res/Arjun/Arjun_dvig1.SHP',ARJUN_BAZA1);
    MontObject('res/Arjun/Arjun_dvig.SHP',ARJUN_BAZA2);
    MontObject('res/Arjun/Arjun_korp.SHP',ARJUN_KORPUS);
    MontObject('res/Arjun/Arjun_stvol.SHP',ARJUN_STVOL);
  end;

  if Task.enableModel[MODEL_BUNKER] then begin
    MontObject('res/Bunker/Bunker.SHP',BUNKER);
  end;

  if Task.enableModel[MODEL_KAMAZ] then begin
    MontObject('res/Kamaz/Kamaz_dvig1.SHP',KAMAZ_BAZA1);
    MontObject('res/Kamaz/Kamaz_dvig.SHP',KAMAZ_BAZA2);
    MontObject('res/Kamaz/Kamaz_korp.SHP',KAMAZ_KORPUS);
  end;

  if Task.enableModel[MODEL_M1A1] then begin
    MontObject('res/M1A1/M1A1_bash.SHP',M1A1_BASHNA);
    MontObject('res/M1A1/M1A1_dvig1.SHP',M1A1_BAZA1);
    MontObject('res/M1A1/M1A1_dvig2.SHP',M1A1_BAZA2);
    MontObject('res/M1A1/M1A1_korp.SHP',M1A1_KORPUS);
    MontObject('res/M1A1/M1A1_stvol.SHP',M1A1_STVOL);
  end;

  if Task.enableModel[MODEL_M48] then begin
    MontObject('res/M48/M48_bash.SHP',M48_BASHNA);
    MontObject('res/M48/M48_dvig1.SHP',M48_BAZA1);
    MontObject('res/M48/M48_dvig.SHP',M48_BAZA2);
    MontObject('res/M48/M48_korp.SHP',M48_KORPUS);
    MontObject('res/M48/M48_stvol.SHP',M48_STVOL);
  end;

  if Task.enableModel[MODEL_SAPSAN] then begin
    MontObject('res/Sapsan/Sapsan.SHP',SAPSAN);
  end;

  if Task.enableModel[MODEL_T84] then begin
    MontObject('res/T-84/T84_bash.SHP',T84_BASHNA);
    MontObject('res/T-84/T84_dvig1.SHP',T84_BAZA1);
    MontObject('res/T-84/T84_dvig.SHP',T84_BAZA2);
    MontObject('res/T-84/T84_korp.SHP',T84_KORPUS);
    MontObject('res/T-84/T84_stvol.SHP',T84_STVOL);
  end;

  if Task.enableModel[MODEL_UAZ469] then begin
    MontObject('res/UAZ/UAZ_wheel1.SHP',UAZ_BAZA1);
    MontObject('res/UAZ/UAZ_wheel.SHP',UAZ_BAZA2);
    MontObject('res/UAZ/UAZ_korp.SHP',UAZ_KORPUS);
  end;

  if Task.enableModel[MODEL_VJAYANTA] then begin
    MontObject('res/Vijayanta/Vij_bash.SHP',VJAYANTA_BASHNA);
    MontObject('res/Vijayanta/Vij_dvig1.SHP',VJAYANTA_BAZA1);
    MontObject('res/Vijayanta/Vij_dvig.SHP',VJAYANTA_BAZA2);
    MontObject('res/Vijayanta/Vij_korp.SHP',VJAYANTA_KORPUS);
    MontObject('res/Vijayanta/Vij_stvol.SHP',VJAYANTA_STVOL);
  end;

  if Task.enableModel[MODEL_T90] then begin
    // Танк Т-90
    MontObject('res/T-90/T-90Bas.shp',TANK_KORPUS_T90);
    MontObject('res/T-90/T-90Bash.shp',TANK_BASHNA_T90);
    MontObject('res/T-90/T-90Dvig.shp',TANK_BAZA1_T90);
    MontObject('res/T-90/T-90Dvig2.shp',TANK_BAZA2_T90);
    MontObject('res/T-90/T-90Stv.shp',TANK_STVOL_T90);
  end;

  if Task.enableModel[MODEL_T55] then begin
    // Танк Т-55
    MontObject('res/T-55/t-55basa.shp',TANK_KORPUS_T55);
    MontObject('res/T-55/T-55Bash.shp',TANK_BASHNA_T55);
    MontObject('res/T-55/T-55Dv1.shp',TANK_BAZA1_T55);
    MontObject('res/T-55/T-55Dv2.shp',TANK_BAZA2_T55);
    MontObject('res/T-55/t-55stv.shp',TANK_STVOL_T55);
  end;

  if Task.enableModel[MODEL_T59] then begin
    // Танк Т-59
    MontObject('res/T-59/t59_korp.shp',TANK_KORPUS_T59);
    MontObject('res/T-59/t59_Bash.shp',TANK_BASHNA_T59);
    MontObject('res/T-59/t59_Dvig1.shp',TANK_BAZA1_T59);
    MontObject('res/T-59/t59_Dvig.shp',TANK_BAZA2_T59);
    MontObject('res/T-59/t59_stvol.shp',TANK_STVOL_T59);
  end;

  if Task.enableModel[MODEL_T69] then begin
    // Танк Т-69
    MontObject('res/T-69/t69_korp.shp',TANK_KORPUS_T69);
    MontObject('res/T-69/t69_Bash.shp',TANK_BASHNA_T69);
    MontObject('res/T-69/t69_Dvig1.shp',TANK_BAZA1_T69);
    MontObject('res/T-69/t69_Dvig.shp',TANK_BAZA2_T69);
    MontObject('res/T-69/t69_stvol.shp',TANK_STVOL_T69);
  end;
end;

procedure Build_ZSU;
begin
  MontObject('res/2C6/2c6_korp.shp',ZSU_KORPUS);
  MontObject('res/2C6/2c6_bash.shp',ZSU_BASHNA);
  MontObject('res/2C6/2c6_gun.shp',ZSU_STVOL);
  MontObject('res/2C6/2c6_dvig1.shp',ZSU_BAZA1);
  MontObject('res/2C6/2c6_dvig2.shp',ZSU_BAZA2);
  MontObject('res/2C6/2c6_soc.shp',ZSU_SOC);
  MontObject('res/2C6/2c6_ssc.shp',ZSU_SSC);
  MontObject('res/2C6/2c6_missile.shp',ZSU_CONTEN);
  MontObject('res/2C6/ZUR.shp',ZUR);
end;

procedure Build_Scorpion;
begin
  MontObject('res/Scorpion/Scorpion_korp.SHP',SCORP_KORPUS);
  MontObject('res/Scorpion/Scorpion_bash.SHP',SCORP_BASHNA);
  MontObject('res/Scorpion/Scorpion_stvol.SHP',SCORP_STVOL);
  MontObject('res/Scorpion/Scorpion_dvig1.SHP',SCORP_BAZA1);
  MontObject('res/Scorpion/Scorpion_dvig2.SHP',SCORP_BAZA2);
end;

procedure Build_BMD3;
begin
  MontObject('res/BMD_3/Korp.shp',BMD3_KORPUS);
  MontObject('res/BMD_3/stvol.shp',BMD3_STVOL);
  MontObject('res/BMD_3/Bash.shp',BMD3_BASHNA);
  MontObject('res/BMD_3/dv1.shp',BMD3_BAZA1);
  MontObject('res/BMD_3/dv2.shp',BMD3_BAZA2);
end;

procedure Build_Samolet_1;
var a: word;
begin
  if Task.enableModel[MODEL_A10A] then begin
    // Самолёт A_10A
    MontObject('res\a-10a\a-10a.SHP',A_10A);
    // осколки самолёта
    for a:=1 to 5 do MontObject('res\a-10a\a-10a_osk'+inttostr(a)+'.shp',OSKOL_A_10A_BASE[a]);
  end;

  if Task.enableModel[MODEL_F16] then begin
    // Самолёт F-16
    MontObject('res\F-16\F-16.SHP',F_16);
    // осколки самолёта
    for a:=1 to 5 do MontObject('res\F-16\F-16_osk'+inttostr(a)+'.shp',OSKOL_F_16_BASE[a]);
  end;

  if Task.enableModel[MODEL_COBRA] then begin
    // Вертолёт AH-1F
    MontObject('res\AH-1F\AH-1F.SHP',COBRA_KORP);
    // Винты
    MontObject('res\AH-1F\AH-1F_vint.SHP',COBRA_VINT);
    MontObject('res\AH-1F\AH-1F_stab.SHP',COBRA_STAB);
    // осколки вертолёта
    for a:=1 to 5 do MontObject('res\AH-1F\AH-1F_osk'+inttostr(a)+'.shp',OSKOL_COBRA_BASE[a]);
  end;

  if Task.enableModel[MODEL_ALKM] then begin
    // Крылатая ракета
    MontObject('res\ALCM\ALCM.SHP',ALKM);
    // осколки ракеты
    for a:=1 to 5 do MontObject('res\ALCM\ALCM_osk'+inttostr(a)+'.shp',OSKOL_ALKM_BASE[a]);
  end;

  if Task.enableModel[MODEL_SU25] then begin
    // Самолёт СУ-25
    MontObject('res\SU-25\SU-25.SHP',SU_25);
    // осколки самолёта
    for a:=1 to 5 do MontObject('res\SU-25\SU-25_osk'+inttostr(a)+'.shp',OSKOL_SU_25_BASE[a]);
  end;

  if Task.enableModel[MODEL_F15] then begin
    // Самолёт F-15
    MontObject('res/F-15/F-15.shp',F_15);
    // осколки самолёта
    for a:=1 to 5 do MontObject('res/F-15/F_Osk'+inttostr(a)+'.shp',OSKOL_F_15_BASE[a]);
  end;

end;

procedure Build_BTR;
begin
  MontObject('res/BTR/BTR_80_M.shp',BTR_KORPUS);
  MontObject('res/BTR/Koleso.shp',BTR_KOLESO_P);
  MontObject('res/BTR/Bashna.shp',BTR_BASHNA);
  MontObject('res/BTR/Stvol.shp',BTR_STVOL);
  BTR_KOLESO_L:=glGenLists(1);
  glNewList (BTR_KOLESO_L, GL_COMPILE);
    glPushMatrix;
    glRotatef (180, 0, 1, 0);
    glCallList(BTR_KOLESO_P);
    glPopMatrix;
  glEndList;

end;

end.

