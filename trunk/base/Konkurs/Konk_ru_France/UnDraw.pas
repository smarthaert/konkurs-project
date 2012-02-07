unit UnDraw;

interface

uses
  Windows, Classes, OpenGL, Dglut, Main, Graphics, SysUtils, UnBuild, UnOther, Math;//, UnDinam;

type
  TZav=record
    proc: boolean;                                     // процесс существует
    Sca1,Sca2,Sca3,Sca4 : real;
    time_tik: integer;                                     // Цикл
    time_end: integer;                                     // Время задымления
    x_tek1,y_tek1: real;
    x_tek2,y_tek2: real;
    x_tek3,y_tek3: real;
    x_tek4,y_tek4: real;
    x_beg,y_beg,h_beg, delta: real;
  end;
  TSmock=record
    x_tek: real;
    y_tek: real;
    h_tek: real;
    vx_tek: real;
    vy_tek: real;
    vh_tek: real;
    mat_tek: real;
    vmat_tek: real;
    angle: real;
    vangle: real;
    sca: real;
    vsca: real;
  end;
  procedure DrawScene0;
  // Рисование главной сцены
  procedure DrawScene;
  // Проверка изменений в главной сцене и вызов ReBuilde_Patch
  procedure ChangeScene;
  // Мишенная обстановка
  procedure Draw_Mishen;
  procedure Draw_Model;
  // Техника
  procedure Draw_BMP(n: integer);
  procedure Draw_BMP2(n: integer);
  procedure Draw_Apach(n: integer);
  procedure Draw_M113(n: integer);
  procedure Draw_Leo(n: integer);
  procedure Draw_T80(n: integer);
  // Облака, вспышки, взрывы и дымы
  procedure Draw_Nebo;
  procedure Proc_Beg_Zavesa_rec;
  procedure Draw_Vzryv(n: integer);
  procedure Draw_Dym(n: integer);
  procedure Draw_Dym_Black(n: integer);
  procedure Vystrel_ini(num: word);
  procedure Vystrel_ini_model(n:word);
  procedure Init_Vsp;
  procedure Draw_Pyl(n: integer);
  procedure Draw_Pyl_Black(n: integer);
  procedure Isx_Pyl;
  // Оптическая часть
  procedure Draw_Pricel;
  //Выставленные во вьювере объекты
  procedure DrawNewMestniks;
  procedure Draw_Missile;
  procedure Draw_Trass_Ptur;
  procedure Move_Trass_Ptur;
  procedure Isx_Trass_Ptur;
//==============Спрайтовая анимация========================
const
  VYCHKA_H_RUK=0.3;    //    Положение руководителя на вышке
  COL_PYL=25;
  COL_DYM=10;
  H_OZERO=0.67;
  COL_MAX_VSP=15;
var
   Zav:array[1..3,1..8] of TZav;
   rot_vint: array[1..COL_MAX_OBJEKT_TAK_TEX] of real;
   baz_rot: array[1..COL_MAX_OBJEKT_TAK_TEX]of boolean;
   Rot_kol: array[1..COL_MAX_OBJEKT_TAK_TEX] of real;
   baz_rot_tank: array[1..3]of boolean;
   AnglViewX   : real = 0;
   AnglViewH   : real =5;
   DalView     : real =3;
   az_result,kratn: real;
   Vid_S_Boku: boolean;
   angle_x, angle_y: real;// Для поворота сцены мышью
   Povor_PTUR: word;
   // Подрыв снаряда
   podryv_Pushka: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of boolean;
   oto_vzr_Pushka: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;
   Sca_dym_Pushka: array [1..COL_MAX_OBJEKT_TAK_TEX+3] of real;
   Xdym_Pushka, Ydym_Pushka, Hdym_Pushka: array [1..COL_MAX_OBJEKT_TAK_TEX+3] of real;
   V_Hdym_Pushka: array [1..COL_MAX_OBJEKT_TAK_TEX+3] of real;
   mat_vzr:  array [1..COL_MAX_OBJEKT_TAK_TEX+3] of GLFloat;

   // Выстрел из пушки
   Dym_X_1,Dym_Y_1,Dym_H_1,Dym_Sca_1,Dym_Az_1,Dym_Um_1 : array[1..MAX_COL_PODRYV] of glFloat;


   Pyl_Angle: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Delta_Pyl_Angle: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_X: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_Y: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_H: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_Mat: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_Sca: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Delta_Pyl_Sca: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_PYL] of real;//...
   Pyl_Begin_Index: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...

   Dym_Angle: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Delta_Dym_Angle: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_X: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_Y: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_H: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_Mat: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_Sca: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Delta_Dym_Sca: array[1..COL_MAX_OBJEKT_TAK_TEX+3,0..COL_DYM] of real;//...
   Dym_Begin_Index: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...

   Fire_X: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of real;//...
   Fire_Y: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of real;//...
   Fire_H: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of real;//...
   Fire_Index: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...

   Period_pyl: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...
   Period_pyl_int: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...
   Period_dym: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of word;//...

   Oto: array[1..2,1..3,1..COL_MAX_MICH] of word;
   vspy: array[1..2,1..3,1..COL_MAX_MICH] of boolean;
   vspy_time: array[1..3,1..COL_MAX_MICH] of byte;
   Patch : integer;
   X_scr,H_scr,H_tek,Y_scr: real;
   Y_angl,X_angl: real;
   d_ozero: real;
   delta_ozero:real=0.1;
   art_fakt: array[1..COL_MAX_OBJEKT_TAK_TEX+3] of boolean;
   NewMestniks : TList;
   Sost_Vsp: array[1..COL_MAX_VSP] of word;
   Az_Dym: array[1..MAX_COL_PODRYV] of real;
   Smock: array[1..20]of TSmock;
   Pos_Smock: word;
   Pos_Fire: word;
   Az_Trass: real;

implementation
// Пустая сцена
procedure DrawScene0;
begin
  if Task.Temp=NUIT then begin
    glClearColor(0.2, 0.24, 0.3, 1.0);
  end
  else begin
    if Task.Ceson=IVER then begin
      glClearColor(0.95, 0.95, 1, 1.0);
    end
    else begin
      if Task.Mestn=RAVNINA then glClearColor(0.5, 0.9, 0.7, 1.0);
      if Task.Mestn=GORA then glClearColor(0.7, 0.75, 0.8, 1.0);
      if Task.Mestn=BOLOTO then glClearColor(0.8, 0.7, 0.7, 1.0);
    end;
    if Task.Mestn=PUSTYN then glClearColor(0.9, 0.8, 0.5, 1.0);
  end;
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
end;

// Проверка изменений в главной сцене и вызов ReBuilde_Patch
procedure ChangeScene;
var Colizior : PMestnik;
    temp : real;
begin
  exit;
{ if BMP_Temp.Patch_Collis>0 then
 if not ((otobr_RM=RM_MEXAN) and (BMP_Temp.Num_MV=Num_BMP)) then
 begin
  Colizior:=Mestniks[BMP_Temp.Patch_Collis].Items[BMP_Temp.Obj_Collis];
  temp:=BMP_Temp.Az_Paden*1.41;
  if Colizior.Az_Paden<>temp then
  begin
   Colizior.Az_Paden:=temp;
   Colizior.Tg_Paden:=BMP_Temp.Tg_Paden*1.41;
   Colizior.Type_Action:=0;
   ReBuild_Patch(Colizior^.Patch);
  end;
 end;}
end;


procedure DrawScene;
var a,sector,patch,n,a1:word;
alpha,betta,pia,az,x,y,h : real;
i : integer;
begin
//  ChangeScene;
  // Очистка кадра
  glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT );
  // Внешний источник света
  glEnable(GL_LIGHT0);
  glColor3f(1, 1, 1);
  glEnable(GL_FOG);
  glPushMatrix;
    case otobr_RM of
      RM_RUKOVOD: begin
//        glColor3f(1, 1, 1);
        glRotatef (Angle_x, 1.0, 0.0, 0.0);
        // Горизонт 1 (дымка)
        if (Task.m_inten_fog<11)and (Task.temp=DAY)
                   and (Task.Mestn<>GORA) then glCallList(GORIZONT);
        glScale(kratn,kratn,1);
        az_result:=(Angle_y);
        glRotatef (az_result, 0.0, 1.0, 0.0);
        x:=-Vychka_X; y:=Vychka_Y+0.4; h:=-Vychka_H-VYCHKA_H_RUK;
        glTranslatef(x, h, y);
        patch:=trunc(Vychka_Y/Dlina_Patch_Y)*COL_PATCH_X+trunc(Vychka_X/Dlina_Patch_X)+1
      end;
      RM_NAVOD: begin
        glRotatef (BMP[Num_BMP].UmPricel, 1.0, 0.0, 0.0);
        az_result:=(BMP[Num_BMP].AzPricel);
        glRotatef (az_result, 0.0, 1.0, 0.0);
        BMP[Num_BMP].Hpric:=BMP[Num_BMP].Htek+H_PRICEL;
        x:=-BMP[Num_BMP].Xtek; y:=BMP[Num_BMP].Ytek; h:= -BMP[Num_BMP].Hpric;
        glTranslatef(x, h, y);
//        try
        patch:=trunc(BMP[Num_BMP].Ytek/Dlina_Patch_Y)*COL_PATCH_X+trunc( BMP[Num_BMP].Xtek/Dlina_Patch_X)+1;
//        except
//        patch:=2;
//        end;
      end;
      RM_VIEWER: begin
        glRotatef (Y_angl, 1, 0, 0);
        // Горизонт 1 (дымка)
        if (Task.m_inten_fog<11)and (Task.temp=DAY) and not PNV_off
                   and (Task.Mestn<>GORA) then glCallList(GORIZONT);
        az_result:=(X_angl);
        glRotatef (az_result, 0, 1, 0);
        x:=-X_scr; y:=Y_scr;h:=-H_scr-H_tek;
        glTranslatef(x, h, y);
        patch:=trunc(Y_scr/Dlina_Patch_Y)*COL_PATCH_X+trunc(X_scr/Dlina_Patch_X)+1;
        if((patch>Max_patch_mov-COL_PATCH_X)or(patch<1))and(Task.m_index<6000)then patch:=0;
        DrawNewMestniks;//Выставленные во вьювере объекты
      end;
    end;
    // Расчёт сектора куда смотрим и патча где стоим для дерева видимости
    az:=az_result+COL_DEGRE/2;
    if az>=360 then begin az:=az-360;if az>=360 then az:=az-360; end;
    if az<0 then begin az:=az+360; if az<0 then az:=az+360; end;
    sector:=trunc(az/COL_DEGRE)+1;
    //  Свет для поверхности (для лучшего освещения выпуклостей)
    glLightfv(GL_LIGHT0, GL_AMBIENT, @LightColAmb);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightColDif);
    //  Переносим напрвление и положение источника света
    glLightfv(GL_LIGHT0,GL_SPOT_DIRECTION,@L_Naprav);
    if otobr_RM=RM_RUKOVOD then  begin
      LightPos[0]:=(ISX_POL_LIGHT_X-x)/kratn;
      LightPos[2]:=(ISX_POL_LIGHT_Y-y)/kratn;
    end
    else begin
      LightPos[0]:=ISX_POL_LIGHT_X-x;
      LightPos[2]:=ISX_POL_LIGHT_Y-y;
    end;
    glLightfv(GL_LIGHT0, GL_POSITION, @LightPos);
    glEnable(GL_ALPHA_TEST);
    if (Task.Mestn=GORA) then begin
      if Task.Temp=DAY then glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      if Task.m_index<6000 then begin
        glCallList(GORIZONT_GORA);
      end
      else begin
        glTranslatef(-x, -h, -y);
        glCallList(GORIZONT_GORA+sector);
        glTranslatef(x, h, y);
      end;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    end;
    // Врезанные объекты
    if patch=0 then begin
      for a:=1 to Patch_Draw[Max_patch_mov+1,0,0] do glCallList(OKOP_BAZA+Patch_Draw[Max_patch_mov+1,0,a]);
    end
    else begin
      for a:=1 to Patch_Draw[patch,sector,0] do glCallList(OKOP_BAZA+Patch_Draw[patch,sector,a]);
    end;
    // Для экономии ресурсов включаем воспроизведение только одной стороны поверхности
    glEnable(GL_CULL_FACE);
    glEnable(GL_ALPHA_TEST);
    // Поверхность
    if patch=0 then begin
      for a:=1 to Patch_Draw[Max_patch_mov+1,0,0] do glCallList(SURFACE_BAZA+Patch_Draw[Max_patch_mov+1,0,a]);
    end
    else begin
      for a:=1 to Patch_Draw[patch,sector,0] do glCallList(SURFACE_BAZA+Patch_Draw[patch,sector,a]);
    end;
    // Воспроизведение обеих сторон поверхности
    glDisable(GL_CULL_FACE);

    // Включаем проверку на прозрачность
    glEnable(GL_ALPHA_TEST);
    //  Свет для объектов(для лучшего освещения вертикальных поверхностей)
    glLightfv(GL_LIGHT0, GL_AMBIENT, @LightColAmb_Alt);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, @LightColDif_Alt);
    // МП
    if patch=0 then begin
      for a:=1 to Patch_Draw[Max_patch_mov+1,0,0] do begin
        a1:=Patch_Draw[Max_patch_mov+1,0,a];
        if a1> Col_Patch then a1:=a1-Col_Patch;
        if a1> Col_Patch then a1:=a1-Col_Patch;
        glCallList(SCENE_BAZA+a1);
      end;
    end
    else begin
      for a:=1 to Patch_Draw[patch,sector,0] do begin
        a1:=Patch_Draw[patch,sector,a];
        if a1> Col_Patch then a1:=a1-Col_Patch;
        if a1> Col_Patch then a1:=a1-Col_Patch;
        glCallList(SCENE_BAZA+a1);
      end;
    end;
    // Ориентиры и вышка
    glCallList(ORIENTIR);
    if Task.m_index<5000 then Draw_Mishen else Draw_Model;
//    if BMP[Num_BMP_BO].Start_PTUR then Draw_Missile;
    // Для прозрачных текстур отключаем  тест позрачночти
    glDisable(GL_ALPHA_TEST);
    glDepthMask(GL_FALSE);
    // Облака
    Draw_Nebo;
    // Траектории
    if BMP[Num_BMP_BO].Start_PTUR then begin
      Move_Trass_Ptur;
      Draw_Trass_Ptur;
      glEnable(GL_ALPHA_TEST);
      glDepthMask(GL_TRUE);
      Draw_Missile;
      glDisable(GL_ALPHA_TEST);
      glDepthMask(GL_FALSE);
    end;
    for n:=1 to 3 do begin
      Draw_Vzryv(n);  // Взрыв снаряда
    end;
    // Чёрный дым
    for n:=1 to COL_MAX_OBJEKT_TAK_TEX do begin
      if (Model[n].Typ>0)then begin
        Draw_Pyl(n);
        Draw_Pyl_Black(n);
      end;
      if (Model[n].Typ>0)and(Model[n].Akt>$0f) then Draw_Dym_Black(n);
    end;
    // Дым  и пыль после выстрела пушки
    for n:=1 to COL_MAX_OBJEKT_TAK_TEX do Draw_Dym(n);
    // Постановка дымовой завесы
    glDepthMask(GL_TRUE);
  glPopMatrix;
  // После улицы отключаем внешний свет
  glDisable(GL_LIGHT0);  //Внешний свт
  // Прицел
//  glCallList(MERA);
  Draw_Pricel;
end;


//============== Вспышки, взрывы и дымы====================
// Облака
procedure Draw_Nebo;
var a: word;
d: real;
begin
  // включаем свечение, чтобы не зависеть от освещённости
  if Task.Temp=DAY then begin
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    // Отключаем туман, чтобы он не влиял на цвет облаков
    glDisable(GL_FOG);
  end;
  for a:=1 to COL_MAX_OBL do begin
    glPushMatrix;
      d:=sqrt(Coord_Obl[a].X*Coord_Obl[a].X+Coord_Obl[a].Y*Coord_Obl[a].Y);
      if d=0 then d:=0.0001;
      glScale(1,Coord_Obl[a].H/d,1);
      glTranslatef(Coord_Obl[a].X, Coord_Obl[a].H-d*0.25, -Coord_Obl[a].Y);
      // Поворачиваем облако лицом к наблюдателю
      glRotatef (-az_result, 0.0, 1.0, 0.0);
      if (Task.Mestn=GORA) and (Task.m_index>6000) then glScale(100,200,1)  //@@@@@@
                                                               else glScale(50,100,1);
      glCallList(OBLAKO+Coord_Obl[a].Typ);
    glPopMatrix;
    // Движение облаков
    Coord_Obl[a].X:=Coord_Obl[a].X+Dym_V_X;
    Coord_Obl[a].Y:=Coord_Obl[a].Y+Dym_V_Y;
    // Появление облаков вновь
    if Dym_V_Y>0 then if Coord_Obl[a].Y>GRANICA_OBL then Coord_Obl[a].Y:=Coord_Obl[a].Y-GRANICA_OBL*2 else
                 else if Coord_Obl[a].Y<-GRANICA_OBL then Coord_Obl[a].Y:=Coord_Obl[a].Y+GRANICA_OBL*2;
    if Dym_V_X>0 then if Coord_Obl[a].X>GRANICA_OBL then Coord_Obl[a].X:=Coord_Obl[a].X-GRANICA_OBL*2 else
                 else if Coord_Obl[a].X<-GRANICA_OBL then Coord_Obl[a].X:=Coord_Obl[a].X+GRANICA_OBL*2;
  end;
  if Task.Temp=DAY then glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEnable(GL_FOG);
end;

// Запуск дымовой завесы по сети
procedure Proc_Beg_Zavesa_rec;
var d: real;
num,n:word;
begin
  num:=Vsp.Num;
  n:=Vsp.Pos;
  Zav[num][n].proc:=true;            //Запуск процедуры задымления
  Zav[num][n].time_end:=-60;         //Общее время горения -60 тиков до начала дыма
  Zav[num][n].time_tik:=-60;         //Время цикла дыма
  Zav[num][n].Sca1:=0.001;           //Размеры слоёв
  Zav[num][n].Sca2:=0.001;
  Zav[num][n].Sca3:=0.001;
  Zav[num][n].Sca4:=0.001;
  Zav[num][n].x_beg:=Vsp.X_vsp;
  Zav[num][n].y_beg:=Vsp.Y_vsp;
  Zav[num][n].h_beg:=CountVertexYTri(Zav[num][n].x_beg,Zav[num][n].y_beg);
  Zav[num][n].x_tek1:=0;  // Смещение слоёв относительно друг друга при ветре
  Zav[num][n].y_tek1:=0;
  Zav[num][n].x_tek2:=0;
  Zav[num][n].y_tek2:=0;
  Zav[num][n].x_tek3:=0;
  Zav[num][n].y_tek3:=0;
  Zav[num][n].x_tek4:=0;
  Zav[num][n].y_tek4:=0;
  Zav[num][n].delta:=Vsp.H_vsp;; // Разная скорость нарастания дыма в облаке
  Zav[num][n].delta:=Zav[num][n].delta/800+0.02; //Скорость дымообразования
end;


// Вэрыв снаряда
procedure Draw_Vzryv(n: integer);
const P_vzr:array [0..3] of GLFloat =( 0.3, 0.25, 0.2, 1);
var
sh: glFloat;
begin
  if podryv_Pushka[n] then begin
    glPushMatrix;
      glTranslatef(Xdym_Pushka[n],Hdym_Pushka[n], Ydym_Pushka[n]);
        glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
        P_vzr[3]:=1;//mat_vzr[n];
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_vzr);//Меняем прозрачность материала
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@P_vzr);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_vzr);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        inc(oto_vzr_Pushka[n]);
        // Взрыв
        case oto_vzr_Pushka[n] of
          1:begin
            BMP[n].Start_Ptur:=false;
            V_Hdym_Pushka[n]:=0;
            Sca_dym_Pushka[n]:=0.3;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(SPRITE_VSP+1);
          end;
          2:begin
            Sca_dym_Pushka[n]:=0.7;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(SPRITE_VSP+2);
          end;
          3:begin
            Sca_dym_Pushka[n]:=1.5;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(SPRITE_VSP+5);
          end;
          4:begin
            Sca_dym_Pushka[n]:=2.1;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(SPRITE_VSP+10);
          end;
          5:begin
            Sca_dym_Pushka[n]:=7.5;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(DYM_2);
            Sca_dym_Pushka[n]:=0.33;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(SPRITE_VSP+12);
          end;
          6:begin
            Sca_dym_Pushka[n]:=6;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(DYM_2);
          end;
          7..8:begin
            Sca_dym_Pushka[n]:=Sca_dym_Pushka[n]*1.2;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(DYM_2);
          end;
          9..35:begin
            V_Hdym_Pushka[n]:=V_Hdym_Pushka[n]+0.01;
            Sca_dym_Pushka[n]:=Sca_dym_Pushka[n]*1.03;
            glScale(Sca_dym_Pushka[n],Sca_dym_Pushka[n],Sca_dym_Pushka[n]);
            glCallList(DYM_2);
            glScale(0.4,-0.6,0.1);
            glTranslatef(0,-0.05,0);
            glCallList(SPRITE_PYL);
          end;
          36:begin
            podryv_Pushka[n]:=false;
          end;
          151..159:begin
            V_Hdym_Pushka[n]:=0;
            if oto_vzr_Pushka[n]=151 then begin
              BMP[n].Start_Ptur:=false;
            end;
            if oto_vzr_Pushka[n]=159 then podryv_Pushka[n]:=false;
            glCallList(SPRITE_VSP+oto_vzr_Pushka[n]-150);
          end;
        end;
        glEnable(GL_COLOR_MATERIAL);  //Запрещаем менять прозрачность материала
    glPopMatrix;
    Xdym_Pushka[n]:=Xdym_Pushka[n]+Dym_V_X;
    Ydym_Pushka[n]:=Ydym_Pushka[n]+Dym_V_Y;
    Hdym_Pushka[n]:=Hdym_Pushka[n]-V_Hdym_Pushka[n];
  end;
end;

procedure Draw_Dym(n: integer);
begin
  if mat_dym[n][3]>0.05 then begin
    // Запрещаем запись в буфер глубины
    glPushMatrix;
      glTranslatef(Dym_X_1[n], Dym_H_1[n], Dym_Y_1[n]);  // Дым перед стволом
      glRotatef (-Dym_Az_1[n],0,1,0);
      glRotatef (-Dym_Um_1[n],1,0,0);
      glTranslatef(0.045,0.1,-1.2);
      glRotatef (360-az_result+Dym_Az_1[n], 0.0, 1.0, 0.0);
      if Show_Spr[6].Pos_tek=Show_Spr[6].Pos_end then begin
        glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_dym[n]);//Меняем прозрачность материала
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_dym[n]);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_dym[n]);
        glScale(Dym_Sca_1[n],Dym_Sca_1[n],Dym_Sca_1[n]*2);
        mat_dym[n][3]:=mat_dym[n][3]/1.04;//-0.0003;  // Уменьшение прозрачности
        if mat_dym[n][3]<0.6 then Dym_H_1[n]:=Dym_H_1[n]-0.012;
        Dym_Sca_1[n]:=Dym_Sca_1[n]+0.01;
        Dym_X_1[n]:=Dym_X_1[n]+Dym_V_X;         // Движение дыма
        Dym_Y_1[n]:=Dym_Y_1[n]+Dym_V_Y;
        if otkat[n]<0 then otkat[n]:=otkat[n]+0.008;
      end
      else begin
        otkat[n]:=-0.045*Show_Spr[6].Pos_tek;
      end;
      glCallList(SPRITE+Mont_Spr[6].Index+Show_Spr[6].Pos_tek);
      glEnable(GL_COLOR_MATERIAL);  //Запрещаем менять прозрачность материала
      if Show_Spr[6].Pos_tek<Show_Spr[6].Pos_end then  inc(Show_Spr[6].Pos_tek);
    glPopMatrix;
  end;
end;

procedure Draw_Dym_Black(n: integer); //...
const P_Dym:array [0..3] of GLFloat =( 0.01, 0.01, 0.01, 1);
var a: word;
begin
  inc(Period_dym[n]);
  if Period_dym[n]>10 then begin
    Period_dym[n]:=0;
    if Dym_Begin_Index[n]>COL_Dym then Dym_Begin_Index[n]:=1;
    if n>COL_MAX_OBJEKT_TAK_TEX then begin
      Dym_X[n,Dym_Begin_Index[n]]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Xtek;
      Dym_Y[n,Dym_Begin_Index[n]]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Ytek;
      Dym_H[n,Dym_Begin_Index[n]]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Htek+0.051;
      Fire_X[n]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Xtek;
      Fire_Y[n]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Ytek;
      Fire_H[n]:=BMP[n-COL_MAX_OBJEKT_TAK_TEX].Htek;
    end
    else begin
      Dym_X[n,Dym_Begin_Index[n]]:=Model[n].Xtek;
      Dym_Y[n,Dym_Begin_Index[n]]:=Model[n].Ytek;
      Dym_H[n,Dym_Begin_Index[n]]:=Model[n].Htek+0.051;
      Fire_X[n]:=Model[n].Xtek;
      Fire_Y[n]:=Model[n].Ytek;
      Fire_H[n]:=Model[n].Htek;
    end;
    Dym_Mat[n,Dym_Begin_Index[n]]:=1;
    Dym_Sca[n,Dym_Begin_Index[n]]:=0.4;
    Delta_Dym_Angle[n,Dym_Begin_Index[n]]:=1.7-random(200)/100;
    Delta_Dym_Sca[n,Dym_Begin_Index[n]]:=0.02-random(8)/400;
    inc(Dym_Begin_Index[n]);
  end;
  glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
  for a:=1 to COL_Dym do begin
    if Dym_Mat[n,a]>0.004 then begin
      glPushMatrix;
        //Меняем прозрачность материала
        P_Dym[3]:=Dym_Mat[n,a];
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_Dym);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_Dym);
        Dym_Mat[n,a]:=Dym_Mat[n,a]/1.035;
        // Вращаем, перемещаем и увеличиваем пыль
        glTranslatef(Dym_X[n,a],Dym_H[n,a],-Dym_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glRotatef (-Dym_Angle[n,a], 0.0, 0.0, 1.0);
        glScale(Dym_Sca[n,a],Dym_Sca[n,a],Dym_Sca[n,a]);
        glCallList(SPRITE_PYL);
        Dym_Angle[n,a]:=Dym_Angle[n,a]+Delta_Dym_Angle[n,a];
        if Dym_Angle[n,a]>=360 then Dym_Angle[n,a]:=Dym_Angle[n,a]-360;
        Dym_Y[n,a]:=Dym_Y[n,a]+Dym_V_Y;
        Dym_X[n,a]:=Dym_X[n,a]+Dym_V_X;
        Dym_H[n,a]:=Dym_H[n,a]+0.007;
        Dym_Sca[n,a]:=Dym_Sca[n,a]+Delta_Dym_Sca[n,a];
      glPopMatrix;
    end;
  end;
  glEnable(GL_COLOR_MATERIAL);
  if Fire_Index[n]>24 then Fire_Index[n]:=2;
  glPushMatrix;
    glTranslatef(Fire_X[n], Fire_H[n],-Fire_Y[n]);
    glRotatef (-az_result, 0.0, 1.0, 0.0);
    glCallList(FIRE+Fire_Index[n] div 2);
  glPopMatrix;
  inc(Fire_Index[n]);
end;

// Пыль за машиной
procedure Draw_Pyl(n: integer);
const  P_pyl:array [0..3] of GLFloat =( 1, 0.8, 0.6, 1);
var a,num: integer;
T:array[0..3] of glfloat;
begin
  if Model[n].Start then begin
    if Pyl_Begin_Index[n]>COL_PYL then Pyl_Begin_Index[n]:=2;
    Pyl_X[n,Pyl_Begin_Index[n]]:=Model[n].Xtek;
    if Model[n].Typ=MODEL_BMP1 then Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.7
                               else Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.4;
    Pyl_H[n,Pyl_Begin_Index[n]]:=Model[n].Htek-0.1;
    Delta_Pyl_Angle[n,Pyl_Begin_Index[n]]:=Model[n].Skorost/8-random(100)/20;
    Pyl_Mat[n,Pyl_Begin_Index[n]]:=Model[n].Skorost/30;
    if Pyl_Mat[n,Pyl_Begin_Index[n]]>1 then Pyl_Mat[n,Pyl_Begin_Index[n]]:=1;
    Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.8;
    Delta_Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.06-random(3)/100;
    Pyl_Angle[n,Pyl_Begin_Index[n]]:=Pyl_Angle[n,1];
    inc(Pyl_Begin_Index[n]);
  end;
  glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
  for a:=1 to COL_PYL do begin
    if Pyl_Mat[n,a]>0.02 then begin
      glPushMatrix;
        //Меняем прозрачность материала
        P_pyl[3]:=Pyl_Mat[n,a];
        if Pyl_Mat[n,a]>0.2 then Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.03
                            else Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.2;
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_pyl);
        // Вращаем, перемещаем и увеличиваем пыль
        glTranslatef(Pyl_X[n,a],Pyl_H[n,a],-Pyl_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glScale(Pyl_Sca[n,a],Pyl_Sca[n,a]/2,Pyl_Sca[n,a]);
        glRotatef (-Pyl_Angle[n,a], 0.0, 0.0, 1.0);
        glCallList(SPRITE_PYL);
        Pyl_Angle[n,a]:=Pyl_Angle[n,a]+Delta_Pyl_Angle[n,a];
        if Pyl_Angle[n,a]>=360 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]-360;
        if Pyl_Angle[n,a]<0 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]+360;
        Pyl_H[n,a]:=Pyl_H[n,a]+0.012;
        Pyl_Y[n,a]:=Pyl_Y[n,a]+Dym_V_Y;
        Pyl_X[n,a]:=Pyl_X[n,a]+Dym_V_X;
        Pyl_Sca[n,a]:=Pyl_Sca[n,a]+Delta_Pyl_Sca[n,a];
      glPopMatrix;
    end;
  end;
  glEnable(GL_COLOR_MATERIAL);
end;

// Чёрный дым от летящего вертолёта
procedure Draw_Pyl_Black(n: integer);
const P_pyl:array [0..3] of GLFloat =( 0.1, 0.1, 0.1, 1);
var a: word;
begin
  if Model[n].Start then begin
    inc(Period_pyl[n]);
    if Period_pyl[n]>10 then begin
      Period_pyl[n]:=0;
      if Pyl_Begin_Index[n]>COL_PYL then Pyl_Begin_Index[n]:=1;
      Pyl_X[n,Pyl_Begin_Index[n]]:=Model[n].Xtek;
      if Model[n].Typ=MODEL_BMP1 then Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.4
                                 else Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.2;
      Pyl_H[n,Pyl_Begin_Index[n]]:=Model[n].Htek;
      Pyl_Mat[n,Pyl_Begin_Index[n]]:=0.6;
      Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.1;
      Delta_Pyl_Angle[n,Pyl_Begin_Index[n]]:=0.5-random(100)/100;
      Delta_Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.015-random(75)/10000;
      inc(Pyl_Begin_Index[n]);
    end;
  end;
  glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
  for a:=1 to COL_PYL do begin
    if Pyl_Mat[n,a]>0.01 then begin
      glPushMatrix;
        //Меняем прозрачность материала
        P_pyl[3]:=Pyl_Mat[n,a];
        Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.13;
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_pyl);
        // Вращаем, перемещаем и увеличиваем пыль
        glTranslatef(Pyl_X[n,a],Pyl_H[n,a],-Pyl_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glRotatef (-Pyl_Angle[n,a], 0.0, 0.0, 1.0);
        glScale(Pyl_Sca[n,a],Pyl_Sca[n,a],Pyl_Sca[n,a]);
        glCallList(SPRITE_PYL);
        Pyl_Angle[n,a]:=Pyl_Angle[n,a]+Delta_Pyl_Angle[n,a];
        if Pyl_Angle[n,a]>=360 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]-360;
        Pyl_Sca[n,a]:=Pyl_Sca[n,a]+Delta_Pyl_Sca[n,a];
      glPopMatrix;
    end;
  end;
  glEnable(GL_COLOR_MATERIAL);
end;

//==================== Мишенная обстановка============================
// Мишени
procedure Draw_Mishen;
var a,n: word;
begin
    n:=Num_BMP_BO;
    begin
      for a:=1 to Task.Col_targ do begin
        if Angle_Paden[n,a]>ANGL_PADEN then begin
          glPushMatrix;
            glTranslatef(TargetR[a].Xtek[n][0], TargetR[a].Htek[n][0], -TargetR[a].Ytek[n][0]);
            glRotatef (Angle_Paden[n,a], 1.0, 0.0, 0.0);
            if (rana[n,a]or rana25[n,a]) and (oto[1,n,a]<2) and(oto[2,n,a]<14) then begin
              inc(oto[1,n,a]); //Счётчик частоты миганий
              inc(oto[2,n,a]); //Счётчик миганий
            end
            else begin
              if (Task.Temp=NUIT) then begin
                glCallList(MIN_NUM_TARGET+a);
                if vspy[1,n,a] then begin
                  if ((Task.Target[n,a].Num=M9)or(Task.Target[n,a].Num>M10a))then begin
                    glTranslatef(0, 0.05, 0.01);
                    glCallList(FONAR_JM);
                  end
                  else begin
                    if vspy[2,n,a] then begin
                      glTranslatef(0, 0.05, 0.01);
                      glCallList(FONAR_JM);
                    end;
                  end;
                end;
                vspy[2,n,a]:=not vspy[2,n,a];
              end
              else begin
                glCallList(MIN_NUM_TARGET+a);
              end;
              oto[1,n,a]:=0;
            end;
          glPopMatrix;
        end;
      end;
    end;
end;

procedure Draw_Model;
var n:word;
begin
  for n:=1 to COL_MAX_OBJEKT_TAK_TEX do begin
    if Model[n].Typ>0 then begin
      case Model[n].Typ of
        MODEL_T55:  Draw_Leo(n);
        MODEL_BMP1: Draw_BMP(n);
        MODEL_BMP2: Draw_BMP2(n);
        MODEL_T80:  Draw_T80(n);
      end;
    end;
  end;
end;

//===================== Техника===========================
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

// БМП
procedure Draw_BMP(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(BOX_T+MODEL_BMP1);
    glScale(MASHT_BMP,MASHT_BMP,MASHT_BMP-0.2);
    glCallList(BMP1_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(BMP1_BAZA2)else glCallList(BMP1_BAZA1);
    end else glCallList(BMP1_BAZA1);
    glTranslatef(BMP_X_BASHN, BMP_H_BASHN, -BMP_Y_BASHN);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(BMP1_BASHNA);
    glTranslatef(BMP_X_STVOL, BMP_H_STVOL, -BMP_Y_STVOL);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(BMP1_STVOL);
    glTranslatef(-0.06,0.032,0);
    glCallList(ROCKET);
  glPopMatrix;
end;

procedure  Draw_BMP2(n: integer);/// Переписать под модель
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1.0, 0);
    glRotatef (-Model[n].UmBase, 0.0, 0.0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(BOX_T+MODEL_BMP2);
    glScale(1.07,1,1);
    glCallList(BMP2_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(BMP2_BAZA2)else glCallList(BMP2_BAZA1);
    end else glCallList(BMP2_BAZA1);
    glPushMatrix;
      glScale(0.94,1,0.94);
      glCallList(BMP2_BASHNA);
    glPopMatrix;
    glTranslatef(-0.118,0.087,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glCallList(BMP2_STVOL);
  glPopMatrix;
end;

// Вертолёт
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
  if Model[n].Akt>$0f then begin // когда сбит
  end else rot_vint[n]:=rot_vint[n]+50;
end;

// Танк противника//---
procedure Draw_Leo(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(BOX_T+MODEL_T55);
    glRotatef (-90, 0, 1, 0);
    glCallList(LEO_KORPUS);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(LEO_BAZA2)else glCallList(LEO_BAZA1);
    end else glCallList(LEO_BAZA1);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glCallList(LEO_BASHNA);
    glTranslatef(0,0.057,0.15);
    glRotatef (Model[n].UmPushka,0,0,1);
    glCallList(LEO_STVOL);
  glPopMatrix;
end;

// Танк противника//---
procedure Draw_T80(n: integer);
begin
  glPushMatrix;
    glTranslatef(Model[n].Xtek, Model[n].Htek, -Model[n].Ytek);
    glRotatef (270-Model[n].AzBase, 0, 1, 0);
    glRotatef (-Model[n].UmBase, 0, 0, 1);
    glRotatef (Model[n].Kren, 1, 0, 0);
    glCallList(BOX_T+MODEL_T80);
    if Model[n].start then begin
      baz_rot[n]:=not baz_rot[n];
      if baz_rot[n] then glCallList(TANK_BAZA2)else glCallList(TANK_BAZA1);
    end else glCallList(TANK_BAZA1);
    glTranslatef(-0.008,0.016,0);
    glCallList(TANK_KORPUS);
    //  Башня и ствол Т-80
    glTranslatef(-0.090,0.002,0);
    glRotatef (-Model[n].AzBashn,0,1,0);
    glTranslatef(0.05,0,0);
    glPushMatrix;
      glScale(1.1,1.175,1);
      glCallList(TANK_BASHNA);
    glPopMatrix;
    glTranslatef(-0.17,0.071,0);
    glRotatef (Model[n].UmPushka,0,0,1);
    glRotatef (270, 0, 1.0, 0);
    glTranslatef(0,0,otkat[n]);
    glCallList(TANK_STVOL);
  glPopMatrix;
end;


//======================================================
// Оптическая часть для разных РМ разная
procedure Draw_Pricel;
var a: word;
begin
  case otobr_RM of
    RM_RUKOVOD:;
    RM_NAVOD: begin
      glDisable(GL_FOG);
      if Povrejden=DESTR_COMPL then begin
        glPushMatrix;
          glScale(5,7,1);
          glTranslatef(0, -0.013, -0.0502);
          glCallList(SHTORKA);
        glPopMatrix;
        exit;
      end;
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
      glDisable(GL_LIGHT0);
      glDisable(GL_LIGHT1);
      glCallList(KRUG1);
      case BMP[Num_BMP].lumen of
        1: begin
          LightCol_TPN[0]:=0.25;
          LightCol_TPN[1]:=0.125;
          LightCol_TPN[2]:=0.0625;
        end;
        2:  begin
          LightCol_TPN[0]:=0.5;
          LightCol_TPN[1]:=0.25;
          LightCol_TPN[2]:=0.125;
        end;
        3:  begin
          LightCol_TPN[0]:=1;
          LightCol_TPN[1]:=0.5;
          LightCol_TPN[2]:=0.25;
        end;
      end;
      if BMP[Num_BMP].filtr then begin
        glDepthMask(GL_FALSE);
        if BMP[Num_BMP].Filtr then glCallList(FILTR1);
        glDepthMask(GL_TRUE);
      end;
      glCallList(PRICEL_PTUR);                  // Штрихи баллистики
      glEnable(GL_LIGHT2);                          // Осветитель сетки прицела ТПН
      glLightfv(GL_LIGHT2, GL_AMBIENT, @LightCol_TPN); // Цвет сетки прицела ТПН
      if BMP[Num_BMP].Start_PTUR then glCallList(PRICEL_PTUR_MARKA);
      glDisable(GL_LIGHT2);
    end;
    RM_VIEWER:;
  end;
end;

procedure  Vystrel_ini(num: word);
begin
end;

// Формирование выстрела
procedure Vystrel_ini_model(n:word);
begin
  case Model[n].Typ of
    1: begin
      mat_dym[n+3][3]:=1;
      Dym_Sca_1[n+3]:=0.4;
      Dym_X_1[n+3]:=Model[n].Xtek;
      Dym_Y_1[n+3]:=-Model[n].Ytek;
      Dym_H_1[n+3]:=Model[n].Htek+0.05;
    end;
    2: begin
      mat_dym[n+3][3]:=1;
      Dym_Sca_1[n+3]:=0.3;
      Dym_X_1[n+3]:=Model[n].Xtek;
      Dym_Y_1[n+3]:=-Model[n].Ytek;
      Dym_H_1[n+3]:=Model[n].Htek+0.0;
    end;
    3: begin
      mat_dym[n+3][3]:=1;
      Dym_Sca_1[n+3]:=0.2;
      Dym_X_1[n+3]:=Model[n].Xtek;
      Dym_Y_1[n+3]:=-Model[n].Ytek;
      Dym_H_1[n+3]:=Model[n].Htek+0.05;
    end;
  end;
end;

procedure Init_Vsp;
begin
  case  Vsp.Typ of
    // Без дыма попадания из пушки
    NON_DYM,
    PORAJ_OG,
    NE_PORAJ_OG,
    PORAJ_BT,
    PORAJ_PTUR,
    PORAJ_RANA_BT,PORAJ_RANA_KUM: begin                     //Взрыв без дыма
      Xdym_Pushka[Vsp.Num]:=Vsp.X_vsp;
      Ydym_Pushka[Vsp.Num]:=Vsp.Y_vsp;
      Hdym_Pushka[Vsp.Num]:=Vsp.H_vsp;
      oto_vzr_Pushka[Vsp.Num]:=151;   // Вспышка без дыма
      podryv_Pushka[Vsp.Num]:=true;
      mat_vzr[Vsp.Num]:=1;
    end;
    // С дымом
    YES_DYM,
    PROMAX_PUSHKA,
    OSKOLOK_PUSHKA,
    GABARIT_PUSHKA,
    PROMAX_PTUR:begin                     //Взрыв с дымом
      Xdym_Pushka[Vsp.Num]:=Vsp.X_vsp;
      Ydym_Pushka[Vsp.Num]:=Vsp.Y_vsp;
      Hdym_Pushka[Vsp.Num]:=Vsp.H_vsp;
      oto_vzr_Pushka[Vsp.Num]:=0;   // Вспышка без дыма
      podryv_Pushka[Vsp.Num]:=true;
      mat_vzr[Vsp.Num]:=1;
    end;
    ZAVESA_DYM: Proc_Beg_Zavesa_rec;
  end;
end;

procedure Isx_Pyl;
var a,b: word;
begin
  for a:=1 to COL_MAX_OBJEKT_TAK_TEX+3 do begin
    Pyl_Begin_Index[a]:=1;
    Dym_Begin_Index[a]:=1;
    Fire_Index[a]:=0;
    Period_pyl[a]:=0;
    Period_dym[a]:=0;
    for  b:=1 to COL_DYM do begin
      Dym_Mat[a,b]:=0;
      Dym_Sca[a,b]:=0;
    end;
    for  b:=1 to COL_PYL do begin
      Pyl_Mat[a,b]:=0;
      Pyl_Sca[a,b]:=0;
    end;
  end;
end;

procedure DrawNewMestniks;
var i : integer;
    p : PMestnik;
begin
  if NewMestniks<>nil then begin
  GLEnable(GL_ALPHA_TEST);
    for i:=0 to NewMestniks.Count-1 do begin
      p:=NewMestniks.Items[i];
      glPushMatrix;
        glTranslatef(p^.X,p^.H,-p^.Y);
        if p^.A<>0 then glRotate(p^.A,0,1,0);
        if p^.Num=OZERO then begin
          glAlphaFunc(GL_GEQUAL, 0.2);
          glCallList(p^.Num);
          glAlphaFunc(GL_GEQUAL, 0.8);
        end
        else glCallList(p^.Num);
      glPopMatrix;
    end;
  end;
end;

procedure Draw_Missile;
var i : byte;
begin
  glPushMatrix;
    glTranslatef(BMP[Num_BMP_BO].X_PTUR, BMP[Num_BMP_BO].H_PTUR, BMP[Num_BMP_BO].Y_PTUR);
    Az_Trass:=90-BMP[Num_BMP_BO].Tang_H;
    glRotatef (-Az_Trass, 0.0, 1.0, 0.0);
    glRotatef (-BMP[Num_BMP_BO].Tang_Y, 0.0, 0.0, 1.0);
    glRotatef (BMP[Num_BMP_BO].Tang_X, 1.0, 0.0, 0.0);
    glCallList(MISSILE_PTUR);
    inc(Pos_Fire);
    if Pos_Fire>3 then Pos_Fire:=1;
    glTranslatef(0, 0, 0.4);
    glRotatef (Az_Trass-az_result, 0.0, 1.0, 0.0);
    glScale(1+abs(3*sin((Az_Trass-az_result)/57.3)),1,1);
    glCallList(FIRE_PTUR+Pos_Fire);
  glPopMatrix;
end;

procedure Draw_Trass_Ptur;
const mat: array [0..3] of GLFloat =( 1, 1, 1, 1);
var a: word;
begin
  glDisable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
  for a:=1 to 20 do begin
    if Smock[a].mat_tek>0.1 then begin
      mat[3]:=Smock[a].mat_tek;
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);//Меняем прозрачность материала
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      glPushMatrix;
        glTranslatef(Smock[a].x_tek, Smock[a].h_tek, Smock[a].y_tek);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glScale(Smock[a].sca+abs(30*sin((Az_Trass-az_result)/57.3)),Smock[a].sca,1);
        if Smock[a].sca=1.8 then
                            else glCallList(TRASSA_PTUR+a);
      glPopMatrix;
    end;
  end;
  glEnable(GL_COLOR_MATERIAL);  //Разрешаем менять прозрачность материала
end;

procedure Move_Trass_Ptur;
var a: word;
a_torm,vmat_tek:real;
begin
  inc(Pos_Smock);
  if Pos_Smock>20 then Pos_Smock:=1;
  Smock[Pos_Smock].x_tek:=BMP[Num_BMP_BO].X_PTUR;
  Smock[Pos_Smock].y_tek:=BMP[Num_BMP_BO].Y_PTUR;
  Smock[Pos_Smock].h_tek:=BMP[Num_BMP_BO].H_PTUR;
  Smock[Pos_Smock].mat_tek:=0.23;
  Smock[Pos_Smock].vmat_tek:=1.07;
  vmat_tek:=1.07;
  a_torm:=1.1;
  for a:=1 to 20 do begin
    Smock[a].x_tek:=Smock[a].x_tek+Smock[a].vx_tek;
    Smock[a].y_tek:=Smock[a].y_tek+Smock[a].vy_tek;
    Smock[a].h_tek:=Smock[a].h_tek+Smock[a].vh_tek;
    Smock[a].vx_tek:=Smock[a].vx_tek/a_torm;
    Smock[a].vy_tek:=Smock[a].vy_tek/a_torm;
    Smock[a].vh_tek:=Smock[a].vh_tek/a_torm;
    Smock[a].mat_tek:=Smock[a].mat_tek/vmat_tek;
//    Smock[a].angle:=Smock[a].angle+Smock[a].vangle;
    Smock[a].sca:=Smock[a].sca+Smock[a].vsca;
  end;
  Smock[Pos_Smock].sca:=0.9;
  Smock[Pos_Smock].vsca:=1.9;
end;

procedure Isx_Trass_Ptur;
var a: word;
begin
  for a:=1 to 20 do begin
    Smock[a].mat_tek:=0;
  end;
end;

end.

       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);


