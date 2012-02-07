unit UnBuildKoord;
interface

uses UnBuildIndex,UnVarConstOpenGL,UnOther,SysUtils, Dialogs,
     UnBuildTexture, UnGeom, Classes, Math,UnBuildSetka;

  procedure BuildKoord(season,region : integer);
  procedure BuildObjectsScene(season,region : integer);
  procedure BuildObjectsFitToSurf(season,region : integer);
//  procedure BuildKoordStolb;
//  procedure BuildKoordDirectris;
  procedure CountObjects;
  procedure DeterminTypesObjects(typ,a : integer; x,y,h,az,t : real);
  procedure AddMestnik(Num,Patch : integer; x,y,h,a,Sc : real);
  procedure Isx_Pol_Scene;
//  procedure ReBuild_Patch(num_patch: word);
//  procedure BuildKoordOrientir;
//  procedure CountKoordOrientir;
  procedure ObjectKoord(filename: string; num: word);
  procedure ReadFaceTemp(var F_Name: TextFile);

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

procedure BuildKoord(season,region : integer);
begin
  // Столбики для Курса стрельб и для вождения
  if (Task.m_index <5000)or(Task.m_index >6000) then begin
//    BuildKoordStolb;
  end;
  BuildObjectsScene(season,region);
  BuildObjectsFitToSurf(season,region);
//  BuildKoordDirectris;
//  BuildKoordOrientir;
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


procedure Build_Stolb;
begin
  // Столбики
  ObjectKoord('res/Oborud/St_Black.shp',STOLB_BLACK);
  ObjectKoord('res/Oborud/St_Blk_05.shp',STOLB_BLACK_05);
  ObjectKoord('res/Oborud/St_Red.shp',STOLB_RED);
  ObjectKoord('res/Oborud/St_Blue.shp',STOLB_BLUE);
  ObjectKoord('res/Oborud/St_White.shp',STOLB_WHITE);
  ObjectKoord('res/Oborud/Znak_St.shp',ZNAK_STOP);
  ObjectKoord('res/Oborud/Znak1.shp',ZNAK1);
  ObjectKoord('res/Oborud/Znak2.shp',ZNAK2);
  ObjectKoord('res/Oborud/Znak3.shp',ZNAK3);
  ObjectKoord('res/Oborud/Znak4.shp',ZNAK4);
  ObjectKoord('res/Oborud/Znak5.shp',ZNAK5);
  ObjectKoord('res/Oborud/Znak6.shp',ZNAK6);
  ObjectKoord('res/Oborud/Znak7.shp',ZNAK7);
  ObjectKoord('res/Oborud/Znak8.shp',ZNAK8);
  ObjectKoord('res/Oborud/Znak9.shp',ZNAK9);
  ObjectKoord('res/Oborud/Znak10.shp',ZNAK10);
  ObjectKoord('res/Oborud/Znak11.shp',ZNAK11);
  ObjectKoord('res/Oborud/Znak12.shp',ZNAK12);
  ObjectKoord('res/Oborud/Znak13.shp',ZNAK13);
  ObjectKoord('res/Oborud/Znak14.shp',ZNAK14);
  ObjectKoord('res/Oborud/Znak15.shp',ZNAK15);
  ObjectKoord('res/Oborud/Znak16.shp',ZNAK16);
  ObjectKoord('res/Oborud/Znak17.shp',ZNAK17);
  ObjectKoord('res/Oborud/Znak18.shp',ZNAK18);
  ObjectKoord('res/Oborud/Znak20.shp',ZNAK20);
  ObjectKoord('res/Oborud/Znak24.shp',ZNAK24);
  ObjectKoord('res/Oborud/Znak25.shp',ZNAK25);
  ObjectKoord('res/Oborud/Znak26.shp',ZNAK26);
  ObjectKoord('res/Oborud/Znak27.shp',ZNAK27);
  ObjectKoord('res/Oborud/Znak_r.shp',ZNAK_R);
  ObjectKoord('res/Oborud/Znak_l.shp',ZNAK_L);
  ObjectKoord('res/Oborud/ZnakMi.shp',ZNAK_MIN1);
  ObjectKoord('res/Oborud/ZnakMi2.shp',ZNAK_MIN2);
  ObjectKoord('res/Oborud/ZnakMi3.shp',ZNAK_MIN3);
  if Task.Temp=NIGHT then ObjectKoord('res/Oborud/fonar.shp',FONAR)
                     else  ObjectKoord('res/Oborud/St_Black.shp',FONAR);
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
  for a:=1 to KOL_TYPE_LES do ObjectKoord('res/Les/Les'+inttostr(a)+s+'.shp',n[a]);
  LES:=n[1];
  if region=PUSTYN then s:='p';
  for a:=1 to KOL_TYPE_TREE do ObjectKoord('res/Tree/Tree'+inttostr(a)+s+'.shp',n[a]);
  DEREVO:=n[1];
  for a:=1 to KOL_TYPE_KUST do ObjectKoord('res/Kust/Kust'+inttostr(a)+s+'.shp',n[a]);
  KUST:=n[1];
  // Мелкие хоз постройки
  for a:=1 to KOL_TYPE_HAUS_1 do ObjectKoord('res/Haus/Haus'+inttostr(a)+'.shp',n[a]);
  HAUS_1:=n[1];
  // Одноэтажные постройки
  if region=PUSTYN then begin
    for a:=1 to KOL_TYPE_HAUS_2_PUST do begin
      ObjectKoord('res/Haus/Haus'+inttostr(a)+'p.shp',n[a]);
    end;
    HAUS_2:=n[1];
  end
  else begin
    for a:=1 to KOL_TYPE_HAUS_2 do begin
      ObjectKoord('res/Haus/Haus'+inttostr(10+a)+'.shp',n[a]);
    end;
    HAUS_2:=n[1];
  end;
  // Двухэтажные постройки
  for a:=1 to KOL_TYPE_HAUS_3 do begin
    ObjectKoord('res/Haus/Haus'+inttostr(30+a)+'.shp',n[a]);
  end;
  HAUS_3:=n[1];
  // хоз. и тех. постройки
  for a:=1 to KOL_TYPE_HAUS_TEX_1 do begin
    ObjectKoord('res/Building/Build'+inttostr(a)+'.shp',n[a]);
  end;
  HAUS_TEX_1:=n[1];
  for a:=1 to KOL_TYPE_HAUS_TEX_2 do begin
    ObjectKoord('res/Building/Build'+inttostr(10+a)+'.shp',n[a]);
  end;
  HAUS_TEX_2:=n[1];
  ObjectKoord('res/Oborud/Vychka3.shp',VYCHKA);
  ObjectKoord('res/Oborud/Nadolb.shp',NADOLB);
  ObjectKoord('res/Oborud/Brevno.shp',BREVNO);
  ObjectKoord('res/Building/Bash_Kr.shp',BASH_KR);
  ObjectKoord('res/Building/Bash_Kv.shp',BASH_KV);
  ObjectKoord('res/Building/cercov.shp',CERCOV);
  ObjectKoord('res/Building/Stolb_E.shp',STOLB_E);
  ObjectKoord('res/Building/Stolb_V.shp',STOLB_V);
  ObjectKoord('res/Building/ZaborB1_.shp',ZABOR);
  ObjectKoord('res/Building/ZaborB1.shp',n[1]);
  ObjectKoord('res/Building/ZaborD1_.shp',n[1]);
  ObjectKoord('res/Building/ZaborD1.shp',n[1]);
  ObjectKoord('res/Building/ZaborD2_.shp',n[1]);
  ObjectKoord('res/Building/ZaborD2.shp',n[1]);
  ObjectKoord('res/Pereezd/Pereezd.shp',PEREEZD);
  ObjectKoord('res/Pereezd/Zn_g_d.shp',ZNAK_G_D);
  ObjectKoord('res/Most/MostKol1.shp',MOST_KOL1);
  ObjectKoord('res/Most/Most_Gorb.shp',MOST_GORB);
  ObjectKoord('res/Most/MostLong.shp',MOST_LONG);
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
  ObjectKoord('res/Okop/Okop1.shp',OKOP_1);
  ObjectKoord('res/Okop/Okop2.shp',OKOP_2);
  ObjectKoord('res/Okop/Okop3'+s+'.shp',OKOP_3);
  ObjectKoord('res/Okop/okop6'+s+'.shp',USTUP);
  ObjectKoord('res/Okop/okop7'+s+'.shp',ASCARP);
  ObjectKoord('res/Okop/Okop10.shp',OKOP_10);
  ObjectKoord('res/Okop/Okop10.shp',OKOP_10_TEMP);
  ObjectKoord('res/Okop/Okop10t.shp',OKOP_10_TEMP_VERCH);
  ObjectKoord('res/Okop/Okop11.shp',OKOP_11);
  ObjectKoord('res/Okop/Okop11.shp',OKOP_11_TEMP);
  ObjectKoord('res/Okop/Okop11t.shp',OKOP_11_TEMP_VERCH);
  ObjectKoord('res/Okop/Voronka.shp',VORONKA);
  ObjectKoord('res/Okop/Voronka.shp',VORONKA_TEMP);
  ObjectKoord('res/Okop/Voronkat.shp',VORONKA_TEMP_VERCH);
  ObjectKoord('res/ozero/ozero.shp',OZERO_TEMP);
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
    DeterminTypesObjects(orient_File_Little[a].typ,
               orient_File_Little[a].patch,
               orient_File_Little[a].x,
               orient_File_Little[a].y,
               orient_File_Little[a].h,
               orient_File_Little[a].az,
               1);
  end;
end;

procedure Isx_Pol_Scene;
var a,b: word;
p : PMestnik;
begin
  OKOP_BAZA:=SCENE_BAZA+colPatchSurface;
  for a:=1 to colPatchSurface do begin
    if Mestniks[a].Count>0 then begin//***
      for b:=0 to Mestniks[a].Count-1 do if Mestniks[a]<>nil then begin // Количество местников на патче
        p:=Mestniks[a].Items[b];
        p^.Az_Paden:=-1;  // Восстановление углов поворота
      end;
//      ReBuild_Patch(a);    // Восстановление патча
    end;
  end;
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

// Создание ориентиров
procedure Build_Orientir;
var a: word;
begin
  ObjectKoord('res/Building/Build12.shp',MIN_NUM_ORIENTIR[0]);      //1
  if Task.Mestn=PUSTYN then ObjectKoord('res/Haus/Haus3p.shp',MIN_NUM_ORIENTIR[1])
                       else ObjectKoord('res/Haus/Haus5.shp',MIN_NUM_ORIENTIR[1]);           //2
  ObjectKoord('res/Building/Stolb_E.shp',MIN_NUM_ORIENTIR[2]);      //3
  ObjectKoord('res/Building/Stolb_V.shp',MIN_NUM_ORIENTIR[3]);//4
  ObjectKoord('res/Building/Bash_Kr.shp',MIN_NUM_ORIENTIR[4]);      //5
  ObjectKoord('res/Building/Bash_Kv.shp',MIN_NUM_ORIENTIR[5]);      //6
  if Task.Mestn=PUSTYN then ObjectKoord('res/Haus/Haus5p.shp',MIN_NUM_ORIENTIR[6])
                       else ObjectKoord('res/Haus/Haus15.shp',MIN_NUM_ORIENTIR[6]);           //7
  if Task.Mestn=PUSTYN then ObjectKoord('res/Haus/Haus1p.shp',MIN_NUM_ORIENTIR[7])
                       else ObjectKoord('res/Haus/Haus11.shp',MIN_NUM_ORIENTIR[7]);           //8
  if Task.ceson=SUMMER then begin
    if Task.Mestn=PUSTYN then begin
      ObjectKoord('res/Tree/Tree2p.shp',MIN_NUM_ORIENTIR[8]);         //9
      ObjectKoord('res/Tree/Tree4p.shp',MIN_NUM_ORIENTIR[9]);         //10
      ObjectKoord('res/Kust/Kust2p.shp',MIN_NUM_ORIENTIR[10]);         //11
    end
    else begin
      ObjectKoord('res/Tree/Tree11.shp',MIN_NUM_ORIENTIR[8]);         //9
      ObjectKoord('res/Tree/Tree20.shp',MIN_NUM_ORIENTIR[9]);         //10
      ObjectKoord('res/Kust/Kust2.shp',MIN_NUM_ORIENTIR[10]);          //11
    end;
  end
  else begin
    ObjectKoord('res/Tree/Tree6W.shp',MIN_NUM_ORIENTIR[8]);         //9
    ObjectKoord('res/Tree/Tree2W.shp',MIN_NUM_ORIENTIR[9]);         //10
    ObjectKoord('res/Kust/Kust2W.shp',MIN_NUM_ORIENTIR[10]);         //11
  end;
  if Task.Mestn=PUSTYN then ObjectKoord('res/Haus/Haus2p.shp',MIN_NUM_ORIENTIR[11])
                       else ObjectKoord('res/Haus/Haus12.shp',MIN_NUM_ORIENTIR[11]);//12
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

procedure ObjectKoord(filename: string; num: word);
var
 f: textfile;
 s,s1: string;
 a, b, c, d: integer;
begin
  S:=dirBase+filename;
  if not FileExists(s) then begin
    MessageDlg('Нет файла '+S, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {Связывание файла с именем}
  Reset(F);
  ReadLn(F, S);     //Описание БМП
  ReadLn(F, S);     //Количество объектов
  ReadLn(F, S);
  a:=strtoint(S);
  for b:=1 to a do begin
    ReadLn(F, S);     //Имя объекта
    ReadLn(F, S);
    ReadLn(F, S);     //Перенос
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //Поворот
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //Масштабирование
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //Имя текстуры
    ReadLn(F, S);
    S1:=S;
    ReadLn(F, S);     //Материал текстуры или способ наложения
    S:=copy(S,1,1);
    // Светящиеся текстуры
    c:=0;
    if (s='2')or(s='3')or(s='4')or(s='5')or(s='6')or(s='7')or(s='8') or (s='10')
                              then val(s,d,c)
                              else d:=1;
    texVarName[b]:=CreateTexture(s1, d, TEXTURE_FILTR_ON);//текстура накладывается
    ReadLn(F, S);     //зеркальный
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);       //рассеяный
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);        //диффузный
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);           //Тип примитива
    ReadLn(F, S);
    c:=strtoint(S);
    case c of
      2: ReadFaceTemp(F);
      3: begin
        ReadLn(F, S);     //Количество вершин
        ReadLn(F, S);
        d:=strtoint(S);
        ReadLn(F, S);     //Вершины
        for a:=1 to d+2 do begin
          if a<=d then begin     //считываем вершины обычыным порядком
            ReadLn(F, S);  //Номер Вершины
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
          end;
        end;
      end;
      5:begin
        ReadLn(F, S);
      end;
      7:  begin                 //Диск
        ReadLn(F, S);  //Внутренний радиус
        ReadLn(F, S);
        ReadLn(F, S);  //Внешний радиус
        ReadLn(F, S);
      end;
      8: begin                 //цилиндр
        ReadLn(F, S);  //Нижний  радиус
        ReadLn(F, S);
        ReadLn(F, S);  //Верхний радиус
        ReadLn(F, S);
        ReadLn(F, S);  //высота
        ReadLn(F, S);
      end;
      9:  begin                 //Сфера
        ReadLn(F, S);  //Внутренний радиус
        ReadLn(F, S);
        ReadLn(F, S);  //Внешний радиус
        ReadLn(F, S);
      end;
      10: begin                   // Тор
        ReadLn(F, S);  //Внутренний радиус
        ReadLn(F, S);
        ReadLn(F, S);  //Внешний радиус
        ReadLn(F, S);
      end;
    end;
  end;
  CloseFile(F);
end;

// Чтение данных типа примитива 2 (GL_TRIANGLES)
procedure ReadFaceTemp(var F_Name: TextFile);
var
  i,j: integer;
  S: string;
  vert_count, norm_count, tex_count, face_count : integer;
begin
  ReadLn(F_Name, S);//Количество вершин
  ReadLn(F_Name, S);
  vert_count := strtoint(S);
  ReadLn(F_Name, S);//Вершины
  for i:=0 to vert_count-1 do  begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//Количество нормалей
  ReadLn(F_Name, S);
  norm_count:=strtoint(S);
  ReadLn(F_Name, S);//Нормали
  for i:=0 to norm_count-1 do begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//Количество текстурных координат
  ReadLn(F_Name, S);
  tex_count:=strtoint(S);
  ReadLn(F_Name, S);//Координаты
  for i:=0 to tex_count-1 do  begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//Количество треугольников
  ReadLn(F_Name, S);
  face_count :=strtoint(S);
  ReadLn(F_Name, S);//Треугольники
  for i:=0 to face_count-1 do begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
end;

end.
