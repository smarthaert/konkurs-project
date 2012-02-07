unit UnBuildBuilding;

interface

uses dglOpenGL,UnBuildIndex,UnVarConstOpenGL,UnOther,SysUtils, Dialogs,
     UnBuildTexture,UnBuildObject, UnGeom, Classes, Math,UnBuildSetka;

  procedure BuildBuilding(season,region : integer);
  procedure BuildGorisont;
  procedure BuildObjectsScene(season,region : integer);
  procedure BuildObjectsFitToSurf(season,region : integer);
  procedure Build_Stolb;
  procedure BuildDirectris;
  procedure CountObjects;
  procedure DeterminTypesObjects(typ,a : integer; x,y,h,az,t : real);
  procedure AddMestnik(Num,Patch : integer; x,y,h,a,Sc : real);
  procedure Isx_Pol_Scene;
  procedure ReBuild_Patch(num_patch: word);
  procedure Build_Orientir;
  procedure Count_Orientir;

var
  // Строения жилые
  HAUS_1: integer; // Дома всего до 100
  HAUS_2: integer;
  HAUS_3: integer;
  // Растительность
  DEREVO: integer; // Типы деревьев до 40
  LES: integer;    // Кромка леса до 10
  KUST: integer;   // Типы кустов до 30
  TRAVA: integer;  // Травянной покров
  // Другие объекты
  HAUS_TEX_1: integer;
  HAUS_TEX_2: integer;
  CERCOV: integer;
  STOLB_E: integer;
  STOLB_V: integer;
  BASH_KR: integer;
  BASH_KV: integer;
  ZABOR: integer;  // Заборы 18
  OKOP: integer;
  OKOP_1: integer;
  OKOP_2: integer;
  OKOP_3: integer;
  OKOP_10: integer;  //Ров с мостиком
  OKOP_11: integer;  //траншея
  MOST_KOL1: integer;
  MOST: integer;
  VYCHKA: integer;
  ASCARP: integer;
  USTUP: integer;
  PEREEZD: integer;
  OZERO_TEMP: integer;
  OZERO: integer;
  NADOLB: integer;
  BREVNO: integer;
  VODA: integer;
  OKOP_10_TEMP_VERCH: integer;
  OKOP_10_TEMP: integer;
  OKOP_11_TEMP_VERCH: integer;
  OKOP_11_TEMP: integer;
  VORONKA: integer;
  VORONKA_TEMP: integer;
  VORONKA_TEMP_VERCH: integer;
  MOST_GORB: integer;
  MOST_LONG: integer;
  // Знаки и столбы
  ZNAK_STOP: integer;
  ZNAK1: integer;
  ZNAK2: integer;
  ZNAK3: integer;
  ZNAK4: integer;
  ZNAK5: integer;
  ZNAK6: integer;
  ZNAK7: integer;
  ZNAK8: integer;
  ZNAK9: integer;
  ZNAK10: integer;
  ZNAK11: integer;
  ZNAK12: integer;
  ZNAK13: integer;
  ZNAK14: integer;
  ZNAK15: integer;
  ZNAK16: integer;
  ZNAK17: integer;
  ZNAK18: integer;
  ZNAK20: integer;
  ZNAK_R: integer;
  ZNAK_L: integer;
  ZNAK_G_D: integer; // Знак "Железнодорожный переезд"
  ZNAK_MIN1: integer;
  ZNAK_MIN2: integer;
  ZNAK24: integer;
  ZNAK25: integer;
  ZNAK26: integer;
  ZNAK27: integer;
  ZNAK_MIN3: integer;

  FONAR_CENTR: integer;
  FONAR_BOK: integer;
  FONAR_RM: integer;
  FONAR_WM: integer;
  FONAR_BM: integer;
  FONAR_JM: integer;
  FONAR: integer;
  FONAR1: integer;

  STOLB: integer;
  STOLB_WHITE: integer;
  STOLB_RED: integer;
  STOLB_BLUE: integer;
  STOLB_BLACK: integer;
  STOLB_BLACK_05: integer;

  // Поверхность и связанные с ней местные предметы
  SCENE_BAZA: integer;
  OKOP_BAZA: integer;

implementation

const
  KOL_TYPE_TREE=20;
  KOL_TYPE_LES=4;
  KOL_TYPE_KUST=7;
  KOL_TYPE_HAUS_1=5;
  KOL_TYPE_HAUS_2=13;
  KOL_TYPE_HAUS_2_PUST=5;
  KOL_TYPE_HAUS_3=1;
  KOL_TYPE_BASH=2;
  KOL_TYPE_HAUS_TEX_1=3;
  KOL_TYPE_HAUS_TEX_2=1;
  SET_OF_RANDOM : array [1..15] of integer = (110,120,130,200,210,220,310,320,330,350,360,400,410,420,430);

procedure BuildBuilding(season,region : integer);
begin
  // Столбики для Курса стрельб и для вождения
  if (Task.m_index <5000)or(Task.m_index >6000) then begin
    Build_Stolb;
  end;
  BuildGorisont;
  BuildObjectsScene(season,region);
  BuildObjectsFitToSurf(season,region);
  BuildDirectris;
  Build_Orientir;
  CountObjects;
  Isx_Pol_Scene;
  // Остальные построения для огневого поля
{  if Task.m_index<5000 then Count_Stolb;
  // Местные предметы
  Count_Scene;
  // Ориентиры, поставленные руководителем занятий
  Build_Orientir;}
//  for a:=1 to COL_MAX_OBJEKT_TAK_TEX do AddDinamic(TANK_KORPUS,-5000,-5000,0);
//  for a:=1 to 3 do  if a<>Num_BMP then  AddDinamic(TANK_KORPUS,BMP[a].Xtek,BMP[a].Ytek,BMP[a].AzBase);
end;

procedure BuildGorisont;
var x,y: real;
a: word;
  numTexture2: integer;
begin
  MontObject('res/Gorizont.shp',GORIZONT2);
  GORIZONT:=glGenLists(1);
  glNewList(GORIZONT, GL_COMPILE);
    glDisable(GL_DEPTH_TEST);                             //Выключение теста глубины сцены
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
    glPushMatrix;
      glScalef(8,20,1);
      glCallList(GORIZONT2);
    glPopMatrix;
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEnable(GL_DEPTH_TEST);                             //Включение теста глубины сцены
  glEndList;

  if Task.Mestn<>GORA then exit;
  if (Task.m_index<6000) then begin
  GORIZONT_GORA[0]:=glGenLists(1);
  numTexture:=CreateTexture('Nebo\Gora2.bmp', 2, TEXTURE_FILTR_ON);//текстура накладывается
  numTexture2:=CreateTexture('Nebo\Goriz_gor3.bmp', 2, TEXTURE_FILTR_ON);//текстура накладывается
  glNewList (GORIZONT_GORA[0], GL_COMPILE);
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glBegin(GL_QUADS);            //Четырёхугольник
      glTexCoord2f(0,0);
      glVertex3f(140, 0, 180);
      glTexCoord2f(1,0);
      glVertex3f(-70, 0, 180);
      glTexCoord2f(1,1);
      glVertex3f(-70, 50, 180);
      glTexCoord2f(0,1);
      glVertex3f(140, 50, 180);
    glEnd;
    glBindTexture(GL_TEXTURE_2D, numTexture2);
    glBegin(GL_QUADS);            //Четырёхугольник
      glTexCoord2f(0,0);
      glVertex3f(-220, 10, 0);
      glTexCoord2f(1,0);
      glVertex3f(20, 30, -400);
      glTexCoord2f(1,1);
      glVertex3f(20, 140, -400);
      glTexCoord2f(0,1);
      glVertex3f(-220, 20, 0);
    glEnd;
    glBegin(GL_QUADS);            //Четырёхугольник
      glTexCoord2f(0,0);
      glVertex3f(340, -5, 100);
      glTexCoord2f(1,0);
      glVertex3f(70, 21, -200);
      glTexCoord2f(1,1);
      glVertex3f(70, 90, -200);
      glTexCoord2f(0,1);
      glVertex3f(340, 40, 100);
    glEnd;
  glEndList;
  end
  else begin
    for a:=1 to 12 do begin
      GORIZONT_GORA[a+16]:=glGenLists(1);
      MontObject('res/Nebo/Gora_'+inttostr(a)+'.shp',GORIZONT_GORA[a+16]);
    end;
    for a:=1 to 12 do begin
      GORIZONT_GORA[a]:=glGenLists(1);
      glNewList (GORIZONT_GORA[a], GL_COMPILE);
        glDisable(GL_DEPTH_TEST);
        glPushMatrix;
          glScalef(150,150,150);
          glTranslatef(0, -0.04, 0);
          glCallList(GORIZONT_GORA[a+16]);
        glPopMatrix;
        glEnable(GL_DEPTH_TEST);
      glEndList;
    end;
  end;
end;

procedure Build_Stolb;
begin
  // Столбики
  MontObject('res/Oborud/St_Black.shp',STOLB_BLACK);
  MontObject('res/Oborud/St_Blk_05.shp',STOLB_BLACK_05);
  MontObject('res/Oborud/St_Red.shp',STOLB_RED);
  MontObject('res/Oborud/St_Blue.shp',STOLB_BLUE);
  MontObject('res/Oborud/St_White.shp',STOLB_WHITE);
  MontObject('res/Oborud/Znak_St.shp',ZNAK_STOP);
  MontObject('res/Oborud/Znak1.shp',ZNAK1);
  MontObject('res/Oborud/Znak2.shp',ZNAK2);
  MontObject('res/Oborud/Znak3.shp',ZNAK3);
  MontObject('res/Oborud/Znak4.shp',ZNAK4);
  MontObject('res/Oborud/Znak5.shp',ZNAK5);
  MontObject('res/Oborud/Znak6.shp',ZNAK6);
  MontObject('res/Oborud/Znak7.shp',ZNAK7);
  MontObject('res/Oborud/Znak8.shp',ZNAK8);
  MontObject('res/Oborud/Znak9.shp',ZNAK9);
  MontObject('res/Oborud/Znak10.shp',ZNAK10);
  MontObject('res/Oborud/Znak11.shp',ZNAK11);
  MontObject('res/Oborud/Znak12.shp',ZNAK12);
  MontObject('res/Oborud/Znak13.shp',ZNAK13);
  MontObject('res/Oborud/Znak14.shp',ZNAK14);
  MontObject('res/Oborud/Znak15.shp',ZNAK15);
  MontObject('res/Oborud/Znak16.shp',ZNAK16);
  MontObject('res/Oborud/Znak17.shp',ZNAK17);
  MontObject('res/Oborud/Znak18.shp',ZNAK18);
  MontObject('res/Oborud/Znak20.shp',ZNAK20);
  MontObject('res/Oborud/Znak24.shp',ZNAK24);
  MontObject('res/Oborud/Znak25.shp',ZNAK25);
  MontObject('res/Oborud/Znak26.shp',ZNAK26);
  MontObject('res/Oborud/Znak27.shp',ZNAK27);
  MontObject('res/Oborud/Znak_r.shp',ZNAK_R);
  MontObject('res/Oborud/Znak_l.shp',ZNAK_L);
  MontObject('res/Oborud/ZnakMi.shp',ZNAK_MIN1);
  MontObject('res/Oborud/ZnakMi2.shp',ZNAK_MIN2);
  MontObject('res/Oborud/ZnakMi3.shp',ZNAK_MIN3);
  if Task.Temp=NIGHT then MontObject('res/Oborud/fonar.shp',FONAR)
                     else  MontObject('res/Oborud/St_Black.shp',FONAR);
end;

// Создание местных предметов
procedure BuildObjectsScene(season,region : integer);
var a: integer;
    s : string;
    n: array[1..50] of integer;
begin
  s:='';
  // Создание местн.предм.
  if season=SUMMER then s:='';
  if season=WINTER then s:='w';
  for a:=1 to KOL_TYPE_LES do MontObject('res/Les/Les'+inttostr(a)+s+'.shp',n[a]);
  LES:=n[1];
  if region=PUSTYN then s:='p';
  for a:=1 to KOL_TYPE_TREE do MontObject('res/Tree/Tree'+inttostr(a)+s+'.shp',n[a]);
  DEREVO:=n[1];
  for a:=1 to KOL_TYPE_KUST do MontObject('res/Kust/Kust'+inttostr(a)+s+'.shp',n[a]);
  KUST:=n[1];
  // Мелкие хоз постройки
  for a:=1 to KOL_TYPE_HAUS_1 do MontObject('res/Haus/Haus'+inttostr(a)+'.shp',n[a]);
  HAUS_1:=n[1];
  // Одноэтажные постройки
  if region=PUSTYN then begin
    for a:=1 to KOL_TYPE_HAUS_2_PUST do begin
      MontObject('res/Haus/Haus'+inttostr(a)+'p.shp',n[a]);
    end;
    HAUS_2:=n[1];
  end
  else begin
    for a:=1 to KOL_TYPE_HAUS_2 do begin
      MontObject('res/Haus/Haus'+inttostr(10+a)+'.shp',n[a]);
    end;
    HAUS_2:=n[1];
  end;
  // Двухэтажные постройки
  for a:=1 to KOL_TYPE_HAUS_3 do begin
    MontObject('res/Haus/Haus'+inttostr(30+a)+'.shp',n[a]);
  end;
  HAUS_3:=n[1];
  // хоз. и тех. постройки
  for a:=1 to KOL_TYPE_HAUS_TEX_1 do begin
    MontObject('res/Building/Build'+inttostr(a)+'.shp',n[a]);
  end;
  HAUS_TEX_1:=n[1];
  for a:=1 to KOL_TYPE_HAUS_TEX_2 do begin
    MontObject('res/Building/Build'+inttostr(10+a)+'.shp',n[a]);
  end;
  HAUS_TEX_2:=n[1];
  MontObject('res/Oborud/Vychka3.shp',VYCHKA);
  MontObject('res/Oborud/Nadolb.shp',NADOLB);
  MontObject('res/Oborud/Brevno.shp',BREVNO);
  MontObject('res/Building/Bash_Kr.shp',BASH_KR);
  MontObject('res/Building/Bash_Kv.shp',BASH_KV);
  MontObject('res/Building/cercov.shp',CERCOV);
  MontObject('res/Building/Stolb_E.shp',STOLB_E);
  MontObject('res/Building/Stolb_V.shp',STOLB_V);
  MontObject('res/Building/ZaborB1_.shp',ZABOR);
  MontObject('res/Building/ZaborB1.shp',n[1]);
  MontObject('res/Building/ZaborD1_.shp',n[1]);
  MontObject('res/Building/ZaborD1.shp',n[1]);
  MontObject('res/Building/ZaborD2_.shp',n[1]);
  MontObject('res/Building/ZaborD2.shp',n[1]);
  MontObject('res/Pereezd/Pereezd.shp',PEREEZD);
  MontObject('res/Pereezd/Zn_g_d.shp',ZNAK_G_D);
  MontObject('res/Most/MostKol1.shp',MOST_KOL1);
  MontObject('res/Most/Most_Gorb.shp',MOST_GORB);
  MontObject('res/Most/MostLong.shp',MOST_LONG);
end;


// Создание предметов, врезанных в поверхность
procedure BuildObjectsFitToSurf(season,region : integer);
var
  s : string;
begin
  case region of
    RAVNINA : if season=SUMMER then s:='' else s:='w';
    PUSTYN  : s:='p';
    GORA    : s:='g';
    BOLOTO  : s:='b';
    else s:='';
  end;
  MontObject('res/Okop/Okop1.shp',OKOP_1);
  MontObject('res/Okop/Okop2.shp',OKOP_2);
  MontObject('res/Okop/Okop3'+s+'.shp',OKOP_3);
  MontObject('res/Okop/okop6'+s+'.shp',USTUP);
  MontObject('res/Okop/okop7'+s+'.shp',ASCARP);
  MontObject('res/Okop/Okop10.shp',OKOP_10);
  MontObject('res/Okop/Okop10.shp',OKOP_10_TEMP);
  MontObject('res/Okop/Okop10t.shp',OKOP_10_TEMP_VERCH);
  OKOP_10:=glGenLists(1);
  glNewList (OKOP_10, GL_COMPILE);
    glCallList(OKOP_10_TEMP);
    glDisable(GL_ALPHA_TEST);
    glDepthMask(false);
    glCallList(OKOP_10_TEMP_VERCH);
    glDepthMask(true);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  MontObject('res/Okop/Okop11.shp',OKOP_11);
  MontObject('res/Okop/Okop11.shp',OKOP_11_TEMP);
  MontObject('res/Okop/Okop11t.shp',OKOP_11_TEMP_VERCH);
  OKOP_11:=glGenLists(1);
  glNewList (OKOP_11, GL_COMPILE);
    glCallList(OKOP_11_TEMP);
    glDisable(GL_ALPHA_TEST);
    glCallList(OKOP_11_TEMP_VERCH);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  MontObject('res/Okop/Voronka.shp',VORONKA);
  MontObject('res/Okop/Voronka.shp',VORONKA_TEMP);
  MontObject('res/Okop/Voronkat.shp',VORONKA_TEMP_VERCH);
  VORONKA:=glGenLists(1);
  glNewList (VORONKA, GL_COMPILE);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
    glCallList(VORONKA_TEMP);
    glDisable(GL_ALPHA_TEST);
    glCallList(VORONKA_TEMP_VERCH);
    glEnable(GL_ALPHA_TEST);
    glCullFace(GL_BACK);
    glDisable(GL_CULL_FACE);
  glEndList;

  MontObject('res/ozero/ozero.shp',OZERO_TEMP);
  OZERO:=glGenLists(1);
  glNewList (OZERO, GL_COMPILE);
    glDisable(GL_ALPHA_TEST);
      glCallList(OZERO_TEMP);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  // Вода, закрывает прицел
  MontObject('res/ozero/Voda.shp',VODA);
end;

// Расстановка местных предметов
procedure CountObjects;
var a,b,n: word;
x,h,y,t: real;
InSetRandom : boolean;
i : integer;
begin
  t:=1;
  RandSeed:=1;// Чтобы разброс был всегда одинаков
  // Расстановка местн.предм.
  for a:=1 to colPatchSurface do begin
    for b:=1 to Orient_Col[a] do begin
      InSetRandom:=false;
      for i:=1 to 15 do if Orient_Type[a,b]=SET_OF_RANDOM[i] then InSetRandom:=true;
      if InSetRandom then t:=(Random(40)-20)/100 else t:=0;
      x:=Orient_Koord[a][b][1]+t;
      if InSetRandom then t:=(Random(40)-20)/100 else t:=0;
      y:=Orient_Koord[a][b][2]+t;
      h:=CountHeight(x,y)-0.02;
      t:=1;
      DeterminTypesObjects(Orient_Type[a,b],a, x,y,h,0,t );
    end;
  end;
  for a:=1 to colOrieLittle do begin
    DeterminTypesObjects(orientFileLittle[a].typ,
               orientFileLittle[a].patch,
               orientFileLittle[a].x,
               orientFileLittle[a].y,
               orientFileLittle[a].h,
               orientFileLittle[a].az,
               1);
  end;
end;

procedure Isx_Pol_Scene;
var a,b: word;
p : PMestnik;
begin
  SCENE_BAZA:=glGenLists(colPatchSurface*2);
  OKOP_BAZA:=SCENE_BAZA+colPatchSurface;
  for a:=1 to colPatchSurface do begin
    if Mestniks[a].Count>0 then begin//***
      for b:=0 to Mestniks[a].Count-1 do if Mestniks[a]<>nil then begin // Количество местников на патче
        p:=Mestniks[a].Items[b];
        p^.Az_Paden:=-1;  // Восстановление углов поворота
      end;
      ReBuild_Patch(a);    // Восстановление патча
    end
    else begin
      glNewList (SCENE_BAZA+a, GL_COMPILE); // Создание пустого списка
        glPushMatrix;                       // Номера должны быть заняты
        glPopMatrix;
      glEndList;
      glNewList (OKOP_BAZA+a, GL_COMPILE); // Создание пустого  списка
        glPushMatrix;
        glPopMatrix;
      glEndList;
    end;
  end;
end;


procedure ReBuild_Patch(num_patch: word);
var b: word;
p : PMestnik;
h : GlFloat;
begin
  // Поверхности
  // Удаление списка, если он существует
  if glIsList(SCENE_BAZA+num_patch) then glDeleteLists (SCENE_BAZA+num_patch,1);//***
  glNewList (SCENE_BAZA+num_patch, GL_COMPILE); // Создание нового списка
    for b:=0 to Mestniks[num_patch].Count-1 do begin // Количество местников на патче
      p:=Mestniks[num_patch].Items[b];
      if (p^.Num<>OKOP_10)and
         (p^.Num<>OKOP_11)and
         (p^.Num<>VORONKA) then begin
        glPushMatrix;
          if p^.Az_Paden<>-1 then begin  // если есть признак падения, то
            h:=CountHeight(p^.x,p^.y);
            glTranslatef(p^.x,h,-p^.y);    //устанавливаем местный предмет по координатам
          end
          else begin
            glTranslatef(p^.x,p^.h,-p^.y);    //устанавливаем местный предмет по координатам
          end;
          if p^.A<>0 then glRotatef(p^.A,0,1,0); // поворачиваем его
          if p^.Az_Paden<>-1 then begin  // если есть признак падения, то
            glRotatef(p^.Az_Paden,0,1,0); // поворачиваем его в направлении падения
            glRotatef(p^.Tg_Paden,1,0,0);          // опускаем предмет на землю
          end;
          // Некоторые местники имеют разный масштаб
          if (p^.Num>=LES) and (p^.Num<=LES+KOL_TYPE_LES-1) then glScalef(p^.Sc,p^.Sc,p^.Sc)
                else if (p^.Num>=DEREVO) and (p^.Num<=DEREVO+KOL_TYPE_TREE-1) then glScalef(p^.Sc,p^.Sc,p^.Sc)
                   else if (p^.Num>=KUST) and (p^.Num<=KUST+KOL_TYPE_KUST-1) then glScalef(p^.Sc,p^.Sc,p^.Sc);
          glCallList(p^.Num); // Визуализируем предмет
        glPopMatrix;
      end;
    end;
  glEndList;
  // Врезанные объекты
  // Удаление списка, если он существует
  if glIsList(OKOP_BAZA+num_patch) then glDeleteLists (OKOP_BAZA+num_patch,1);//***
  glNewList (OKOP_BAZA+num_patch, GL_COMPILE); // Создание нового списка
    for b:=0 to Mestniks[num_patch].Count-1 do begin // Количество местников на патче
      p:=Mestniks[num_patch].Items[b];
      if (p^.Num=OKOP_10) or
         (p^.Num=OKOP_11) or
         (p^.Num=VORONKA) then begin
        glPushMatrix;
          if p^.Az_Paden<>-1 then begin  // если есть признак падения, то
            h:=CountHeight(p^.x,p^.y);
            glTranslatef(p^.x,h,-p^.y);    //устанавливаем местный предмет по координатам
          end
          else glTranslatef(p^.x,p^.h,-p^.y);    //устанавливаем местный предмет по координатам
          if p^.A<>0 then glRotatef(p^.A,0,1,0); // поворачиваем его
          if p^.Az_Paden<>-1 then begin  // если есть признак падения, то
            glRotatef(p^.Az_Paden,0,1,0); // поворачиваем его в направлении падения
            glRotatef(p^.Tg_Paden,1,0,0);          // опускаем предмет на землю
          end;
          glCallList(p^.Num); // Визуализируем предмет
        glPopMatrix;
      end;
    end;
  glEndList;
end;

procedure AddMestnik(Num,Patch : integer; x,y,h,a,Sc : real);
var p,pp : PMestnik;
    i : integer;
    c,d : PKoord;
    cosa,sina,xx,yy,max_delta : real;
begin
  if TypesOfOrient.Count>0 then begin
    cosa:=cos(Pi*a/180);
    sina:=sin(Pi*a/180);
    i:=-1;
    repeat
      Inc(i);
      pp:=TypesOfOrient.Items[i];
    until((i=TypesOfOrient.Count-1) or (pp^.Num=Num));
    if pp^.Num=Num then begin
      New(p);
      p^.Num:=Num;
      p^.Patch:=Patch;
      p^.X:=x;
      p^.Y:=y;
      p^.H:=h;
      p^.A:=a;
      p^.Sc:=Sc;
      p^.Az_Paden:=-1;
      p^.Type_Objekt:=pp^.Type_Objekt;
      p^.Type_Action:=pp^.Type_Action;
      p^.Col_Points_Objekt:=pp^.Col_Points_Objekt;
      p^.Curver:=TList.Create;
      max_delta:=0;
      if p^.Type_Objekt>2 then begin
        for i:=0 to p^.Col_Points_Objekt-1 do  begin
          New(c);
          d:=pp^.Curver[i];
          if abs(d.X)>max_delta then max_delta:=abs(d.X);
          if abs(d.Y)>max_delta then max_delta:=abs(d.Y);
          xx:=d.X*cosa+d.Y*sina;
          yy:=d.Y*cosa-d.X*sina;
          c^.X:=x+xx;
          c^.Y:=y-yy;
          p^.Curver.Add(c);
        end;
      end
      else  begin
        New(c);
        d:=pp^.Curver[0];
        xx:=d.X*cosa+d.Y*sina;
        yy:=d.Y*cosa-d.X*sina;
        c^.X:=x+xx;
        c^.Y:=y-yy;
        p^.Curver.Add(c);
        if p^.Type_Objekt=2 then   begin
          New(c);
          d:=pp^.Curver[1];
          if abs(d.X)>max_delta then max_delta:=abs(d.X);
          if abs(d.Y)>max_delta then max_delta:=abs(d.Y);
          c^.X:=d.X;
          c^.Y:=d.Y;
          p^.Curver.Add(c);
        end;
      end;
      if max_delta<min(lenghtPatchX/5,lenghtPatchY/5) then Mestniks[Patch].Add(p)
                                                      else Grand_Mestniks.Add(p);
    end;
  end;
end;

procedure DeterminTypesObjects(typ,a : integer; x,y,h,az,t : real);
var
  n: integer;
  n_haus: integer;
begin
  n_haus:=-1;
  case typ of
    23: AddMestnik(STOLB_WHITE,a,x,y,h,0,t);//Черный столбик
    24: AddMestnik(STOLB_RED,a,x,y,h,0,t);  //Красный столбик
    25: AddMestnik(STOLB_BLUE,a,x,y,h,0,t); //Голубой столбик
    // Деревья
    110,120,130: begin
      t:=1+Random(5)/8;
      n:=Random(KOL_TYPE_TREE);
      AddMestnik(DEREVO+n,a,x,y,h,0,t);
    end;
    124: AddMestnik(VYCHKA,a,x,y,h,0,t); //Вышка
    // Участки леса
    150: begin
      t:=0.81+Random(5)/8;
      AddMestnik(LES,a,x,y,h-0.15,0,t);
    end;
    151: begin
      t:=0.81+Random(5)/8;
      AddMestnik(LES+1,a,x,y,h-0.15,0,t);
    end;
    152: begin
      t:=0.81+Random(5)/8;
      AddMestnik(LES+2,a,x,y,h-0.15,0,t);
    end;
    153: begin
      t:=0.81+Random(5)/8;
      AddMestnik(LES+3,a,x,y,h-0.15,0,t);
    end;
    193: AddMestnik(ZNAK4,a,x,y,h,0,t);
    194: AddMestnik(ZNAK1,a,x,y,h,0,t); //Знак 1
    195: AddMestnik(ZNAK2,a,x,y,h,0,t); //Знак 2
    196: AddMestnik(ZNAK3,a,x,y,h,0,t); //Знак 3
    197: AddMestnik(ZNAK_STOP,a,x,y,h,0,t); //Знак стоп
    198: AddMestnik(STOLB_BLACK,a,x,y,h,0,t); //Черный столбик
    200: AddMestnik(ZNAK5,a,x,y,h,0,t);
    201: AddMestnik(ZNAK6,a,x,y,h,0,t);
    202: AddMestnik(ZNAK7,a,x,y,h,0,t);
    203: AddMestnik(ZNAK8,a,x,y,h,0,t);
    204: AddMestnik(ZNAK9,a,x,y,h,0,t);
    205: AddMestnik(ZNAK10,a,x,y,h,0,t);
    206: AddMestnik(ZNAK11,a,x,y,h,0,t);
    207: AddMestnik(ZNAK12,a,x,y,h,0,t);
    208: AddMestnik(ZNAK_R,a,x,y,h,0,t);
    209: AddMestnik(ZNAK_L,a,x,y,h,0,t);
    // Куст
    210,220: begin
      t:=1+Random(5)/8;
      n:=Random(KOL_TYPE_KUST);
      AddMestnik(KUST+n,a,x,y,h,0,t);
    end;
    // Строения
    310: begin
      n:=Random(KOL_TYPE_HAUS_3);
      AddMestnik(HAUS_3+n,a,x,y,h,0,t);
    end;
    320: begin
      inc(n_haus);
      if n_haus>=KOL_TYPE_HAUS_2 then n_haus:=0;
      n:=n_haus;
      AddMestnik(HAUS_2+n,a,x,y,h,0,t);
    end;
    330: begin
      n:=Random(KOL_TYPE_HAUS_1);
      AddMestnik(HAUS_1+n,a,x,y,h,0,t);
    end;
    350: begin
      n:=Random(KOL_TYPE_HAUS_TEX_2);
      AddMestnik(HAUS_TEX_2+n,a,x,y,h,0,t);
    end;
    360: begin
      n:=Random(KOL_TYPE_HAUS_TEX_1);
      AddMestnik(HAUS_TEX_1+n,a,x,y,h,0,t);
    end;
    400: begin
      AddMestnik(BASH_KR,a,x,y,h,0,t); //Водонапорная
    end;
    410: AddMestnik(CERCOV,a,x,y,h,0,t);   //Церковь
    430: AddMestnik(STOLB_V,a,x,y,h,0,t);  //Столб В
    420: AddMestnik(STOLB_E,a,x,y,h,0,t);  //Столб Е
    450: AddMestnik(ZABOR,a,x,y,h,0,t);    //Забор
    451: AddMestnik(ZABOR+1,a,x,y,h,0,t);  //Забор
    460: AddMestnik(ZABOR+2,a,x,y,h,0,t);  //Забор
    461: AddMestnik(ZABOR+3,a,x,y,h,0,t);  //Забор
    462: AddMestnik(ZABOR+4,a,x,y,h,0,t);  //Забор
    463: AddMestnik(ZABOR+5,a,x,y,h,0,t);  //Забор
    800: AddMestnik(BASH_KR,a,x,y,h,0,t);
    801: AddMestnik(BASH_KV,a,x,y,h,0,t);
    850: AddMestnik(OKOP_1,a,x,y,h,0,t);   //Окоп
    851: AddMestnik(OKOP_2,a,x,y,h,0,t);   //Окоп
    852: AddMestnik(OKOP_3,a,x,y,h,0,t);   //Окоп
    855: AddMestnik(MOST_KOL1,a,x,y,h,0,t);//Колейный мостик
    860: AddMestnik(PEREEZD,a,x,y,h,0,t);  //Переезд
    861: AddMestnik(ZNAK_G_D,a,x,y,h,0,t); //Знак переезл
    862: AddMestnik(OZERO,a,x,y,h,0,t);    //Озеро
  end;
end;

procedure BuildDirectris;
var
  x,y,h: real;
  t: integer;
begin
  // Фонари на столбиках
  if Task.Temp=NIGHT then begin
    FONAR_RM:=glGenLists(1);
    numTexture:=CreateTexture('Oborud/Red.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
    glNewList (FONAR_RM, GL_COMPILE);
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
       glBindTexture(GL_TEXTURE_2D, numTexture);
       glPushMatrix;
         glTranslatef(0,0.112,0);
         gluDisk(Quadric, 0, 0.009,12,5);                    //фонарь
       glPopMatrix;
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
    FONAR_WM:=glGenLists(1);
    numTexture:=CreateTexture('Oborud/White.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
    glNewList (FONAR_WM, GL_COMPILE);
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
       glBindTexture(GL_TEXTURE_2D, numTexture);
       glPushMatrix;
         glTranslatef(0,0.112,0);
         gluDisk(Quadric, 0, 0.009,12,5);                    //фонарь
       glPopMatrix;
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
    numTexture:=CreateTexture('Oborud/Blue.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
    FONAR_BM:=glGenLists(1);
    glNewList (FONAR_BM, GL_COMPILE);
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
       glBindTexture(GL_TEXTURE_2D, numTexture);
       glPushMatrix;
         glTranslatef(0,0.112,0);
         gluDisk(Quadric, 0, 0.009,12,5);                    //фонарь
       glPopMatrix;
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
  // Знаки обозначающие огневое поле
  FONAR_CENTR:=glGenLists(1);
  numTexture:=CreateTexture('Oborud/Znak_Centr.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
  t:=CreateTexture('Oborud/Green.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
  glNewList (FONAR_CENTR, GL_COMPILE);            //Центральное направление
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-0.075, 0, 0);
      glTexCoord2f(0, 1);
      glVertex3f(-0.075, 0.15, 0);
      glTexCoord2f(1, 1);
      glVertex3f(0.075, 0.15, 0);
      glTexCoord2f(1, 0);
      glVertex3f(0.075, 0, 0);
    glEnd;
    if Task.Temp=NIGHT then begin
      glDisable(GL_FOG);
      glBindTexture(GL_TEXTURE_2D, t);
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      glPointSize(2);
      glBegin(GL_Points);
        glTexCoord2f(0, 0);
        glVertex3f(0, 0.00, 0.015);
        glVertex3f(0, 0.075, 0.015);
        glVertex3f(0, 0.15, 0.015);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
      glEnable(GL_FOG);
    end;
    glScalef(1, -6, 1);
    glCallList(STOLB_WHITE);
  glEndList;

  FONAR_BOK:=glGenLists(1);
  numTexture:=CreateTexture('Oborud/Znak_Bok.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
  t:=CreateTexture('Oborud/Red.bmp', 1, TEXTURE_FILTR_ON);//текстура накладывается
  glNewList (FONAR_BOK, GL_COMPILE);            //Боковые ограничители
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glBegin(GL_TRIANGLES);
      glTexCoord2f(0, 0);
      glVertex3f(-0.1, 0,0);
      glTexCoord2f(0.5, 1);
      glVertex3f(0, 0.16,0);
      glTexCoord2f(1, 0);
      glVertex3f(0.1, 0,0);
    glEnd;
    if Task.Temp=NIGHT then begin
      glDisable(GL_FOG);
      glBindTexture(GL_TEXTURE_2D, t);
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      glPointSize(2);
      glBegin(GL_Points);
        glTexCoord2f(0.5, 0.5);
        glVertex3f(-0.09, 0.01, 0.01);
        glVertex3f(0, 0.15, 0.01);
        glVertex3f(0.09, 0.01, 0.01);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
      glEnable(GL_FOG);
    end;
    glScalef(1, -6, 1);
    glCallList(STOLB_WHITE);
  glEndList;
  // Построение единного списка для столбиков и ограничителей
  STOLB:=glGenLists(1);
  glNewList (STOLB, GL_COMPILE);                       //
    glPushMatrix;                      // Белые столбики
      x:=StolbLeft/MASHT_RIS_100-(STOLB_SHIR/MASHT_RIS_100)/2;
      y:=-StolbBottom/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //1
      if Task.Temp=NIGHT then glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //2
      if Task.Temp=NIGHT then glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX1/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //3
      if Task.Temp=NIGHT then glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //4
      if Task.Temp=NIGHT then glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX2/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //5
      if Task.Temp=NIGHT then glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_WHITE);         //6
      if Task.Temp=NIGHT then  glCallList(FONAR_WM);
    glPopMatrix;
    glPushMatrix;                      // Красные столбики
      x:=stolbLeft/MASHT_RIS_100-(STOLB_SHIR/MASHT_RIS_100)/2;
      y:=y-STOLB_DY_R/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //1
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //2
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX1/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //3
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //4
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX2/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //5
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_RED);         //6
      if Task.Temp=NIGHT then glCallList(FONAR_RM);
    glPopMatrix;
    glPushMatrix;                      // Cиние столбики
      x:=stolbLeft/MASHT_RIS_100-(STOLB_SHIR/MASHT_RIS_100)/2;
      y:=Y-STOLB_DY_BL/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //1
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //2
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX1/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //3
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //4
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;
      x:=x+stolbDX2/MASHT_RIS_100-STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //5
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;
      x:=x+STOLB_SHIR/MASHT_RIS_100;
      h:=CountHeight(x,-y);
      glTranslatef(x,h,y);
      glCallList(STOLB_BLUE);         //6
      if Task.Temp=NIGHT then glCallList(FONAR_BM);
    glPopMatrix;
    glPushMatrix;          //Ограничители
      x:=(stolbLeft+stolbDX1)/MASHT_RIS_100;
      y:=-STOLB_DY_GRAN/MASHT_RIS_100;
      h:=CountHeight(x,-y)+H_STOLB_GRAN;
      glTranslatef(x, h, y);
      glCallList(FONAR_CENTR);
    glPopMatrix;
    glPushMatrix;
      x:=x+(stolbDX2*2)/MASHT_RIS_100;
      y:=-STOLB_DY_GRAN/MASHT_RIS_100;
      h:=CountHeight(x,-y)+H_STOLB_GRAN;
      glTranslatef(x, h, y);
      glCallList(FONAR_BOK);
    glPopMatrix;
    glPushMatrix;
      x:=x-(stolbDX2*4)/MASHT_RIS_100;
      y:=-STOLB_DY_GRAN/MASHT_RIS_100;
      h:=CountHeight(x,-y)+H_STOLB_GRAN;
      glTranslatef(x, h, y);
      glCallList(FONAR_BOK);
    glPopMatrix;
  glEndList;
end;
// Создание ориентиров
procedure Build_Orientir;
var a: word;
begin
  MontObject('res/Building/Build12.shp',MIN_NUM_ORIENTIR[0]);      //1
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus3p.shp',MIN_NUM_ORIENTIR[1])
                       else MontObject('res/Haus/Haus5.shp',MIN_NUM_ORIENTIR[1]);           //2
  MontObject('res/Building/Stolb_E.shp',MIN_NUM_ORIENTIR[2]);      //3
  MontObject('res/Building/Stolb_V.shp',MIN_NUM_ORIENTIR[3]);//4
  MontObject('res/Building/Bash_Kr.shp',MIN_NUM_ORIENTIR[4]);      //5
  MontObject('res/Building/Bash_Kv.shp',MIN_NUM_ORIENTIR[5]);      //6
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus5p.shp',MIN_NUM_ORIENTIR[6])
                       else MontObject('res/Haus/Haus15.shp',MIN_NUM_ORIENTIR[6]);           //7
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus1p.shp',MIN_NUM_ORIENTIR[7])
                       else MontObject('res/Haus/Haus11.shp',MIN_NUM_ORIENTIR[7]);           //8
  if Task.ceson=SUMMER then begin
    if Task.Mestn=PUSTYN then begin
      MontObject('res/Tree/Tree2p.shp',MIN_NUM_ORIENTIR[8]);         //9
      MontObject('res/Tree/Tree4p.shp',MIN_NUM_ORIENTIR[9]);         //10
      MontObject('res/Kust/Kust2p.shp',MIN_NUM_ORIENTIR[10]);         //11
    end
    else begin
      MontObject('res/Tree/Tree11.shp',MIN_NUM_ORIENTIR[8]);         //9
      MontObject('res/Tree/Tree20.shp',MIN_NUM_ORIENTIR[9]);         //10
      MontObject('res/Kust/Kust2.shp',MIN_NUM_ORIENTIR[10]);          //11
    end;
  end
  else begin
    MontObject('res/Tree/Tree6W.shp',MIN_NUM_ORIENTIR[8]);         //9
    MontObject('res/Tree/Tree2W.shp',MIN_NUM_ORIENTIR[9]);         //10
    MontObject('res/Kust/Kust2W.shp',MIN_NUM_ORIENTIR[10]);         //11
  end;
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus2p.shp',MIN_NUM_ORIENTIR[11])
                       else MontObject('res/Haus/Haus12.shp',MIN_NUM_ORIENTIR[11]);//12
end;

// Расстановка ориентеров по условиям задачи
procedure Count_Orientir;
var a,patch: word;
x,y,h: real;
begin
  for a:=1 to Orient.Col_orient   do begin
    x:=Orient.Xorient[a]*MASHT_RIS_10/MASHT_RIS_100;
    y:=Orient.Yorient[a]*MASHT_RIS_10/MASHT_RIS_100;
    patch:=CountPatch(x,y);
    h:=CountHeight(x,y);
    AddMestnik(MIN_NUM_ORIENTIR[Orient.Typ_orient[a]-1],patch,x,y,h,0,1);
  end;
  // Вышка
  if Task.m_index<6000 then begin
    if Task.Mestn=GORA then begin
      Vychka_X:=VYCHKA_X_GOR/MASHT_RIS_100;
      Vychka_Y:=VYCHKA_Y_GOR/MASHT_RIS_100;
    end
    else begin
      Vychka_X:=VYCHKA_X_RAV/MASHT_RIS_100;
      Vychka_Y:=VYCHKA_Y_RAV/MASHT_RIS_100;
    end;
  end
  else begin
    Vychka_X:=VYCHKA_X_MV/MASHT_RIS_100;
    Vychka_Y:=VYCHKA_Y_MV/MASHT_RIS_100;
  end;
  patch:=CountPatch(Vychka_X,Vychka_Y);
  Vychka_H:=CountHeight(Vychka_X,Vychka_Y);
  AddMestnik(VYCHKA,patch,Vychka_X,Vychka_Y,Vychka_H,0,1);
end;

end.
