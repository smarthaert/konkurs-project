unit UnModel;     //Описание моделей

interface
uses
  Windows,SysUtils, Main, UnOther, Math, UnBuildSetka, UnGeom, UnLVS;

type

TTarget_Model_Tek=record                       // Описание мишени
    Num: byte;                         // Номер мишени
    ColPoints: byte;                   // Количество опорных точек
    Aktiv: byte;                       // Активность мишени
    Color_Mask: byte;                  // Цвет мишени
    Tst: word;                         // Время появления
    Tend: word;                        // Время удаления
    Tzar: word;                        // Время необходимое для заряжания
    PointTek: word;

    UmBase,            // Наклон  базовой машины
    Tangage:          real;             // Продольный наклон
    UmPushka:         real;             // Положение пушки
    AzBashn:          real;             // Поворот башни
    Start:            boolean;          // Начало движения
    Typ:              byte;             // Информация о танке
    Akt:              byte;             // Активность танка(>$0f- подбит)
    Zar:              boolean;          // Заряжен
    Svoboden:         boolean;          // Не занят обстрелом цели
    Gotov:            boolean;          // Готов к стрельбе
    Vystrel:          boolean;          // Выстрел произведён
    Time_Zar:         word;             // Время оставшееся до конца заряжания
    Num_BMP:          word;             // Номер танка, по которому стреляет

    AzBase:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Xtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;      // Координаты опорных точек
    Ytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Htek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Tstop:array[0..COL_MAX_POINTS_TAK_TEX] of word;        // Время остановки в точке
    Skor:array[0..COL_MAX_POINTS_TAK_TEX] of real;      // Cкорость движения на участках
    Visible:array[0..COL_MAX_POINTS_TAK_TEX] of boolean;   // Видимость на участке
    Time_stop:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;  //Время остановки в точке
    Complited:array[0..COL_MAX_POINTS_TAK_TEX] of  boolean;   //true если точка пройдена
    Vxtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vhtek:array[0..COL_MAX_POINTS_TAK_TEX] of  real;         // Для воздушных целей
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
    Mov: boolean;                        // движущаяся

    Delta       : real;     //радиус описанной окружности
    XNow        : Koord;    //координаты текущей точки
    XNext       : Koord;    //координаты точки назначения
    Dir         : Koord;    //орт направления движения
    Coners      : array [1..4] of Koord; //углы базы начиная с левого переднего по направлению движения
    obhod       : integer;  //направление обхода 0-нет обхода, -1-направо, 1-налево
    NoForvard   : boolean;  //нельзя идти вперед
  end;
    TTarget_Model_Isx=record                       // Описание мишени
    Num: byte;                         // Номер мишени
    ColPoints: byte;                   // Количество опорных точек
    Aktiv: byte;                       // Активность мишени
    Color_Mask: byte;                  // Цвет мишени
    Tst: word;                         // Время появления
    Tend: word;                        // Время удаления
    PointTek: word;

    UmBase, AzBase:   real;             // Наклон  базовой машины
    Tangage:          real;             // Продольный наклон
    UmPushka:         real;             // Положение пушки
    AzBashn:          real;             // Поворот башни
    Start:            boolean;          // Начало движения
    Typ:              byte;             // Информация о танке
    Akt:              byte;             // Активность танка

    Xtek:array[0..COL_MAX_POINTS_TAK_TEX] of word;      // Координаты опорных точек
    Ytek:array[0..COL_MAX_POINTS_TAK_TEX] of word;
    Htek:array[0..COL_MAX_POINTS_TAK_TEX] of word;
    Tstop:array[0..COL_MAX_POINTS_TAK_TEX] of word;        // Время остановки в точке
    Skor:array[0..COL_MAX_POINTS_TAK_TEX] of word;      // Cкорость движения на участках
    Visible:array[0..COL_MAX_POINTS_TAK_TEX] of boolean;   // Видимость на участке
    Time_stop:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;  //Время остановки в точке
    Time_mov:array[0..COL_MAX_POINTS_TAK_TEX] of  integer;   //Время движения до следующей точки
    Vxtek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vytek:array[0..COL_MAX_POINTS_TAK_TEX] of real;
    Vhtek:array[0..COL_MAX_POINTS_TAK_TEX] of  real;         // Для воздушных целей
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
    Mov: boolean;                        // движущаяся
  end;



    procedure Count_Poraj_model(n:word);
    procedure CountParamModel_Tik;
    procedure CountParamModel_Sek;
    function StandColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {расчет коллизий для стационарных объектов}
    function DinColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {расчет коллизий для динамических объектов}
    function Colligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {расчет коллизий для стационарных объектов}
    procedure GetWay(var Stepper : TTarget_Model_Tek);           //выбор пути
    procedure GetDir(var Stepper :TTarget_Model_Tek);           //выбор направления
    procedure IsPointCompleted(var Stepper : TTarget_Model_Tek);   //проверка прихода в точку назначения
    procedure Isx_Model;
    procedure Otvet_Model(num: word);

var
   Target_Model_Tek: array[1..COL_MAX_OBJEKT_TAK_TEX] of TTarget_Model_Tek;
   Target_Model_Isx: array[1..COL_MAX_OBJEKT_TAK_TEX] of TTarget_Model_Isx;
   Poraj_TAK_TEX: array[1..COL_MAX_OBJEKT_TAK_TEX] of word;////0-Не поражен, 1-горит, 2-Нет
   d_um_gm : array[1..COL_MAX_OBJEKT_TAK_TEX] of real;       // Скорость качания по УМ
   d_kren_gm: array[1..COL_MAX_OBJEKT_TAK_TEX] of real;


implementation

const
EPS = 1;              //точность прихода в точку назначения десятков метров

procedure CountParamModel_Sek;
var
a: word;
begin
  for a:=1 to Col_Model do begin
    if Poraj_TAK_TEX[a]>0 then begin // Мишень поражена
      // Передаётся для отображения
      Model[a].Akt:=Poraj_TAK_TEX[a] shl 4;// Инф о поражении передаётся в старшем полубайте
      Model[a].Start:=false;               // Остановка машины
      // Используется внутри для расчётов
      Target_Model_Tek[a].Gotov:=false;    // Переменные Готов стрелять,
      Target_Model_Tek[a].Zar:=false;      // Заряжен
      Target_Model_Tek[a].Svoboden:=false;// и Свободен для назначения обнуляются
    end
    else begin
      // Если скорость=0 то гусеницы не перемещаются
      if Target_Model_Tek[a].Skor[0]>0 then Model[a].Start:=true else Model[a].Start:=false;
      Model[a].Skorost:=round(Target_Model_Tek[a].Skor[0]*1000);
      // Если время движения до очередной не истекло
      if not Target_Model_Tek[a].Complited[Target_Model_Tek[a].PointTek] then begin
        // Скорость движения на текущем участке
        Target_Model_Tek[a].Vhtek[0]:=Target_Model_Tek[a].Vhtek[Target_Model_Tek[a].PointTek];
        Target_Model_Tek[a].Skor[0]:=Target_Model_Tek[a].Skor[Target_Model_Tek[a].PointTek];
        //расчет коллизий с местными предметами и выбор пути
        Target_Model_Tek[a].XNow.X:=Model[a].Xtek;
        Target_Model_Tek[a].XNow.Y:=Model[a].Ytek;
        Target_Model_Tek[a].XNext.X:=Target_Model_Tek[a].Xtek[Target_Model_Tek[a].PointTek];
        Target_Model_Tek[a].XNext.Y:=Target_Model_Tek[a].Ytek[Target_Model_Tek[a].PointTek];
        if Model[a].Typ<>3 then GetWay(Target_Model_Tek[a]);
        IsPointCompleted(Target_Model_Tek[a]);
        Target_Model_Tek[a].Vxtek[0]:=Target_Model_Tek[a].Skor[0]*Target_Model_Tek[a].Dir.X;
        Target_Model_Tek[a].Vytek[0]:=Target_Model_Tek[a].Skor[0]*Target_Model_Tek[a].Dir.Y;
          /// Азимут направления движения
        if not Target_Model_Tek[a].Complited[Target_Model_Tek[a].PointTek] then
        begin
         Target_Model_Tek[a].AzBase[0]:=90-ArcSin(Target_Model_Tek[a].Dir.Y)/Pi*180;
         if Target_Model_Tek[a].Dir.X<0 then Target_Model_Tek[a].AzBase[0]:=-Target_Model_Tek[a].AzBase[0];
        end;
      end
      else begin
        //Если на очередной точке нужно постоять
        if Target_Model_Tek[a].Time_stop[Target_Model_Tek[a].PointTek]>0 then begin
          // Уменьшаем время
          dec(Target_Model_Tek[a].Time_stop[Target_Model_Tek[a].PointTek]);
          // Стоим
          Target_Model_Tek[a].Vxtek[0]:=0;
          Target_Model_Tek[a].Vytek[0]:=0;
          Target_Model_Tek[a].Vhtek[0]:=0;
          Target_Model_Tek[a].Skor[0]:=0;
        end
        else begin
          // Если точки не кончились
          if Target_Model_Tek[a].PointTek<Target_Model_Isx[a].ColPoints then begin
            // Переходим к очередной точке
            inc(Target_Model_Tek[a].PointTek);
            Target_Model_Tek[a].XNow.X:=Model[a].Xtek;
            Target_Model_Tek[a].XNow.Y:=Model[a].Ytek;
            Target_Model_Tek[a].XNext.X:=Target_Model_Tek[a].Xtek[Target_Model_Tek[a].PointTek];
            Target_Model_Tek[a].XNext.Y:=Target_Model_Tek[a].Ytek[Target_Model_Tek[a].PointTek];
            GetDir(Target_Model_Tek[a]);
          end
          else begin
            // Если точки кончились не знаю что делать
          end;
        end;
      end;
      // Если не заряжен
      if Target_Model_Tek[a].Time_Zar<TIME_ZAR_MODEL then begin
        // Время заряжания
        inc(Target_Model_Tek[a].Time_Zar);
        Target_Model_Tek[a].Zar:=false;
      end
      else begin
        Target_Model_Tek[a].Zar:=true;
        // Если свободен и заряжен, то готов
        if Target_Model_Tek[a].Svoboden and Target_Model_Tek[a].Zar then Target_Model_Tek[a].Gotov:=true;
      end;
      /// Ответный выстрел
      if not Target_Model_Tek[a].Svoboden then begin // Занят ответным выстрелом
        if Model[a].AzBase=Target_Model_tek[a].AzBase[0]then begin /// танк развернулся  в нужном направлении
          if Target_Model_Tek[a].Vystrel then begin// если на предыдущей сек был выстрел, то
            Count_Poraj_model(a);                  // определяем поражение
            Target_Model_Tek[a].Vystrel:=false;
            // если не поразил, то стрельбу повторяет
            if Povrejden[Num_BMP]=DESTR_COMPL then Target_Model_Tek[a].Svoboden:=true;
          end;
          // Если заряжен то выстрел
          if Target_Model_Tek[a].Zar then begin
            // Формируем выстрел
//            Vystrel_model(a);
            KommandTr[1]:=STVOL_DYM_TAK;          // Передать всем выстрел
            KommandTr[2]:=a;
            LVS.Trans_kom;
            Target_Model_Tek[a].Zar:=false;     // Поставить после выстрела на заряжание
            Target_Model_Tek[a].Time_Zar:=0;
            Target_Model_Tek[a].Vystrel:=true;  // Временная задержка на результат выстрела
          end;
        end;
      end;
    end;
    //Показ мишеней
    //Подошло время показа
    if (Model[a].Typ=0)and (time_Upr>Target_Model_Isx[a].Tst) and (time_Upr<Target_Model_Isx[a].Tend)
                        { and (Target_Model_Isx[a].Visible[Target_Model_Isx[a].PointTek]) }then begin
      //если мишень не показана и не поражена, то показать
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
      if Poraj_TAK_TEX[a]>0 then begin // модель поражена
        // Вертолёт падает на землю
        if Model[a].Typ=MODEL_APACH then if Model[a].Htek>CountHeight(Model[a].Xtek,Model[a].Ytek) then begin
          Model[a].Htek:=Model[a].Htek+Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek];
          Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek]:=Target_Model_Tek[a].VHtek[Target_Model_Tek[a].PointTek]-0.004;
          Model[a].Xtek:=Model[a].Xtek+Target_Model_Tek[a].Vxtek[0];
          Target_Model_Tek[a].Vxtek[0]:=Target_Model_Tek[a].Vxtek[0]/1.01;
          Model[a].Ytek:=Model[a].Ytek+Target_Model_Tek[a].Vytek[0];
          Target_Model_Tek[a].Vytek[0]:=Target_Model_Tek[a].Vytek[0]/1.01;
          // Вращается в воздухе
          Model[a].UmBase:=Model[a].UmBase+2;
        end;
      end
      else begin
        ///Движение
        if (Model[a].Xtek>4) and (Model[a].Xtek<(lenghtSurfaceX-4)) /// Ограничение движения
             and(Model[a].Ytek>8) and (Model[a].Ytek<lenghtSurfaceY-4) then begin
          if Model[a].Typ=MODEL_APACH then Model[a].Htek:=Model[a].Htek+Target_Model_Tek[a].Vhtek[0]
          else Model[a].Htek:=Target_Model_Tek[a].Htek_const[Target_Model_Tek[a].PointTek]
                                             +CountHeightModel(Model[a].Xtek,Model[a].Ytek,num_patch_h,index_X,index_Y);
          // Поворот и движение мишени
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
          // Упрощённый расчёт наклона по крену и тангажу
          asin:=sin(Model[a].AzBase/57.3);
          acos:=cos(Model[a].AzBase/57.3);
          /// Тангаж
          d:=(Um_mestn[num_patch_h][index_X][index_Y]*acos+
            Kren_mestn[num_patch_h][index_X][index_Y]*asin)-Model[a].UmBase;
          d_um_gm[a]:=d_um_gm[a]+d/9 - d_um_gm[a]/12;// d_um_gm- промежуточный параметр для демпфирования и качки
          Model[a].UmBase:=Model[a].UmBase + d_um_gm[a];
          // Крен
          d:=Um_mestn[num_patch_h][index_X][index_Y]*asin+
             Kren_mestn[num_patch_h][index_X][index_Y]*acos-Model[a].Kren;
          d_kren_gm[a]:=d_kren_gm[a]+d/9 - d_kren_gm[a]/12;
          Model[a].Kren:=Model[a].Kren + d_kren_gm[a];
        end
        else begin
          // на границе останавливавемся
          Target_Model_Tek[a].Vxtek[0]:=0;
          Target_Model_Tek[a].Vytek[0]:=0;
          Target_Model_Tek[a].Skor[0]:=0;
        end;
      end;
    end;
  end;
end;


// Расчёт поражения
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
      if Povrejden[Num_BMP]>0 then begin  // Если было повреждение, то
        KommandTr[2]:=DESTR_COMPL;           // Поражение полное
      end
      else begin
        case random(6) of
          0: KommandTr[2]:=DESTR_COMPL;           // Поражение полное
          1: KommandTr[2]:=DESTR_NAVOD;           // Наводчика (дальномер,стабилизатор, привод, дельта Д)
          2: KommandTr[2]:=DESTR_PRIVOD;          // Привод
          3: KommandTr[2]:=DESTR_DVIG;           // Двигатель
          4: KommandTr[2]:=DESTR_POVOROT_LEV;    // Повороты
          5: KommandTr[2]:=DESTR_POVOROT_PRAV;
        end;
      end;
    end;
    3:if random(100)>25 then begin
      KommandTr[1]:=DESTROY_TANK;
      if Povrejden[Num_BMP]>0 then begin  // Если было повреждение, то
        KommandTr[2]:=DESTR_COMPL;           // Поражение полное
      end
      else begin
        case random(7) of
          0: KommandTr[2]:=DESTR_COMPL;           // Поражение полное
          1: KommandTr[2]:=DESTR_NAVOD;           // Наводчика (дальномер,стабилизатор, привод, дельта Д)
          2: KommandTr[2]:=DESTR_PRIVOD;          // Привод
          3: KommandTr[2]:=DESTR_DALN;          // Дальномер
          4: KommandTr[2]:=DESTR_DVIG;            // Двигатель
          5: KommandTr[2]:=DESTR_POVOROT_LEV;     // Повороты
          6: KommandTr[2]:=DESTR_POVOROT_PRAV;
        end;
      end;
    end;
    4:begin
      KommandTr[1]:=DESTROY_TANK;
      if Povrejden[Num_BMP]>0 then begin  // Если было повреждение, то
        KommandTr[2]:=DESTR_COMPL;           // Поражение полное
      end
      else begin
        case random(3) of
          0: KommandTr[2]:=DESTR_COMPL;           // Поражение полное
          1: KommandTr[2]:=DESTR_NAVOD;           // Наводчика (дальномер,стабилизатор, привод, дельта Д)
          2: KommandTr[2]:=DESTR_DVIG;            // Двигатель
        end;
      end;
    end;
  end;
  if  KommandTr[2]=DESTR_COMPL then begin  // Всем
    LVS.Trans_kom;
  end
  else if  KommandTr[2]<DESTR_DVIG then LVS.Trans_kom;// Наводчику
  n:=Target_Model_Tek[n].Num_BMP;
  Povrejden[Num_BMP]:=KommandTr[2];
{  case Kommand[2] of
    DESTR_COMPL: Form1.Memo1.Lines.add('Поражение своего танка '+ inttostr(n));
    DESTR_NAVOD: Form1.Memo1.Lines.add('Выведен из строя 1А40 танка '+ inttostr(n));
    DESTR_DALN: Form1.Memo1.Lines.add('Выведен из строя дальномер танка '+ inttostr(n));
    DESTR_PRIVOD: Form1.Memo1.Lines.add('Выведен из строя привод танка '+ inttostr(n));
    DESTR_PRIVOD_VER: Form1.Memo1.Lines.add('Выведен из строя верт.привод танка '+ inttostr(n));
    DESTR_PRIVOD_GOR: Form1.Memo1.Lines.add('Выведен из строя гор.привод танка '+ inttostr(n));
    DESTR_STABIL: Form1.Memo1.Lines.add('Выведен из строя стабилизатор танка '+ inttostr(n));
    DESTR_AZ: Form1.Memo1.Lines.add('Выведен из строя автомат заряжания танка '+ inttostr(n));
    DESTR_PNV: Form1.Memo1.Lines.add('Выведен из строя ночной прицел танка '+ inttostr(n));
    DESTR_UPR_RAK: Form1.Memo1.Lines.add('Выведен из строя 1К13 танка '+ inttostr(n));
    DESTR_VOD: Form1.Memo1.Lines.add('Выведена из строя базовая машина танка '+ inttostr(n));
    DESTR_DVIG: Form1.Memo1.Lines.add('Выведен из строя двигатель танка '+ inttostr(n));
    DESTR_POVOROT_LEV: Form1.Memo1.Lines.add('Выведен из строя лев. фрикцион танка '+ inttostr(n));
    DESTR_POVOROT_PRAV: Form1.Memo1.Lines.add('Выведен из строя прав. фрикцион танка '+ inttostr(n));
    DESTR_STARTER: Form1.Memo1.Lines.add('Выведен из строя стартер танка '+ inttostr(n));
    DESTR_SCEPLENIE: Form1.Memo1.Lines.add('Выведено из строя сцепление танка '+ inttostr(n));
    else Form1.Memo1.Lines.add('Промах по своему танку '+ inttostr(n));
  end;}
end;

 function DinColligion(Stepper,NextStep : TTarget_Model_Tek) : boolean; {расчет коллизий для динамических объектов}
 var a : integer;
 begin
  DinColligion:=false;
  for a:=1 to Col_Model do
  if ((abs(Model[a].Xtek-Stepper.XNow.X)>Stepper.Delta/10) and (abs(Model[a].Ytek-Stepper.XNow.Y)>Stepper.Delta/10)) then
  if ((abs(Model[a].Xtek-NextStep.XNow.X)<Stepper.Delta+Target_Model_Tek[a].Delta) and
      (abs(Model[a].Ytek-NextStep.XNow.Y)<Stepper.Delta+Target_Model_Tek[a].Delta)) then
  DinColligion:=true;
 end;

 function StandColligion(Stepper,NextStep :TTarget_Model_Tek) : boolean; {расчет коллизий для стационарных объектов}
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
{точка}        1: if ((Abs(NextStep.XNow.X-pp^.X)<Stepper.Delta) and (Abs(NextStep.XNow.Y-pp^.Y)<Stepper.Delta)) then StandColligion:=true;
{окружность}   2: if PointInCircl(NextStep.XNow.X,NextStep.XNow.Y,p^.Curver) then StandColligion:=true;
{прямоугольник}3: if (PointInRect(NextStep.Coners[1].X,NextStep.Coners[1].Y,p^.Curver) or
                      CrossPolygon(NextStep.Coners[1],NextStep.Coners[2],p^.Curver)) then StandColligion:=true;
{отрезок}      4: if CrossLine(Stepper.XNow.X,Stepper.XNow.Y,NextStep.XNow.X,NextStep.XNow.Y,p^.Curver) then StandColligion:=true;
        end;
       end;
      end;
 end;

 function Colligion(Stepper,NextStep :TTarget_Model_Tek) : boolean; {расчет коллизий}
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

procedure IsPointCompleted(var Stepper :TTarget_Model_Tek);   //проверка прихода в точку назначения
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
//    if Form1.ComboBox1.ItemIndex=0 then exit;  // Огонь не ведёт
    r:=R_REAK_MODEL;
    b:=0;
    for a:=1 to Col_Model do begin // Находим Заряженный, ближайший танк от взрыва
      if (Target_Model_Tek[a].Gotov){and(Model[a].Typ<>2)} then begin
        d:=sqr(BMP[num].X_PTUR-Model[a].Xtek)+sqr(BMP[num].Y_PTUR+Model[a].Ytek);
        if d<r then begin
          r:=d;
          b:=a;
        end;
      end;
    end;
    if b=0 then begin // Если нет заряженного, то хотя бы свободный
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
      Target_Model_Tek[b].Svoboden:=false;/// выбранный танк становится занятым
      Target_Model_Tek[b].Num_BMP:=num;   //  номер нашего танка, по которому будет вестись огонь
      // Задаём направление движения
      r:=(BMP[num].Ytek-Model[b].Ytek);
      if r=0 then r:=0.00001;
      p:=Target_Model_Tek[b].PointTek;// Чтобы записи были короче(номер текущей точки)
      Target_Model_Tek[b].AzBase[p]:= ArcTan((BMP[num].Xtek-Model[b].Xtek)/r)*57.3;
      if r<0 then Target_Model_Tek[b].AzBase[p]:=Target_Model_Tek[b].AzBase[p]+180
             else if (BMP[num].Xtek-Model[b].Xtek)<0 then Target_Model_Tek[b].AzBase[p]:=Target_Model_Tek[b].AzBase[p]+360;
      Target_Model_Tek[b].Vytek[p]:=Target_Model_Tek[b].Skor[p]*cos(Target_Model_Tek[b].AzBase[p]/57.3);
      Target_Model_Tek[b].Vxtek[p]:=Target_Model_Tek[b].Skor[p]*sin(Target_Model_Tek[b].AzBase[p]/57.3);
    end;
  end;
end;

end.
