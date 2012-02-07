unit UnOther;

interface
  uses UnGeom, Classes;

const
  TIK_SEK=18;
  COL_EKIP=3;
  COL_MAX_MICH=15;
  COL_TEXNIKA_MODEL=15;
  COL_MAX_TIPE_TECHN=200;
  COL_MAX_MICH_TAK=30;
  MAX_COL_ORIENT=15;
  COL_MAX_POINTS=10;
  VIEW_POINTS_INIT : array [1..1] of Vektor = ((X:0.0;Y:0.0;H:1.0));

type
  TBMP=record                           //Структура Данных
   Xtek,
   Ytek,
   Htek,
   AzBase,
   UmBase,
   Tangage,
   X_PTUR,Y_PTUR,H_PTUR,Tang_X,Tang_Y,Tang_H: real;   //Текущие координаты снаряда
   UmPricel:          real;                           //Поворот прицела по углу места
   AzPricel:          real;                           //Поворот прицела по азимуту
   Hpric:             real;                           //Высота точки наблюдения
   Kratn_Pric:        real;
   Reserv1: real;
   Reserv2: real;
   Lumen_PTR: real;
   View_Points : array [1..1] of Vektor;
   Col_Upr: word;                                   //Количество управляемых
   Kvit_NA: word;
   dalnCiklePTUR: word;
   lumen: word;
   Num_destroy: word;
   podryvPTUR: word;
   reserv_word1: word;
   reserv_word2: word;
   reserv_word3: word;
   numKvit: byte;
   Gotov_PTUR: boolean;
   Kn_Ptur: boolean;
   Start_PTUR:   boolean;               //
   Time_Pusk,
   Stopor,                                          //Стопор башни
   lum,
   Filtr,                                           //Фильтр ПДПН
   StopPush: boolean;                               //Cтопор пушки
   Zaslon_9CH: boolean;
   Mode: word;
   pereklBsNbBU25: boolean;
   pereklSpuskiKrBU25: boolean;
   reserv_byte1:boolean;
   reserv_byte2:boolean;
   reserv_byte3:boolean;
   reserv_byte4:boolean;
   time_Gotov_PTUR: word;
   AzPricelMemo:          real;              // Поворот прицела по азимуту
   AzPricelTemp:          real;              // Поворот прицела по азимуту
   azimutSpeed: boolean;
   NalichiePTUR: boolean;
   Ispravn_PTUR_Fill:  boolean;
   Ispravn_PTUR_Optik:  boolean;
   Ispravn_PTUR_Pomexa:  boolean;
   Ispravn_PTUR_Start:  boolean;
   Ispravn_PTUR_Marsh:  boolean;

  end;

  TModel=record                         // Структура Данных по танкам
    Xtek, Ytek, Htek: real;             // Текущие координаты   x,z,y
    AzBase:           real;             // Поворот
    UmBase:           real;             // Продольный наклон  базовой машины
    Kren:             real;             // Поперечный наклон
    UmPushka:         real;             // Положение пушки
    AzBashn:          real;             // Поворот башни
    Skorost:          word;             // Другая информация (Пыль)
    Typ:              byte;             // Информация о танке
    Akt:              byte;             // Активность танка
    Start:            boolean;          // Начало движения
    Attace          : byte;             // номер атакуемого комбатанта или 0
    Ver_poraz       : byte;             // вероятность поражения комбатанта Attace
    Fire:            boolean;           // Начало движения
  end;

  TBk=record                            // Боекомплект
    Col_Upr: word;                      // Количество управляемых
  end;
  TTargets=record
    xtek: real;           // координаты мишеней
    ytek: real;
    htek: real;
    angleRotation: real;  // угол подъёма мишени
    enableTarget: boolean;
    otobr: boolean;       // мигание при поражении одним снарядом
    fire: boolean;        // вспышки выстрелов
  end;
    ///Структура для ориентиров
  TOrient=record
    Col_orient: word;
    Typ_orient:array[1..MAX_COL_ORIENT] of word;   // Координаты опорных точек
    Xorient:array[1..MAX_COL_ORIENT] of real;      // Координаты опорных точек
    Yorient:array[1..MAX_COL_ORIENT] of real;
    Horient:array[1..MAX_COL_ORIENT] of real;      // Для воздушных целей
  end;
    /// Тактика
  TTarRec_TAK=record                   // Описание мишени
    Num: byte;                         // Номер мишени
    ColPoints: byte;                   // Количество опорных точек
    Aktiv: byte;                       // Активность мишени
    Color_Mask: byte;                  // Цвет мишени
    Tst: word;                         // Время появления
    Tend: word;                        // Время удаления
    Xtek:array[0..COL_MAX_POINTS] of word;      // Координаты опорных точек
    Ytek:array[0..COL_MAX_POINTS] of word;
    Htek:array[0..COL_MAX_POINTS] of word;
    Tstop:array[0..COL_MAX_POINTS] of word;        // Время остановки в точке
    Skor:array[0..COL_MAX_POINTS] of byte;      // Cкорость движения на участках
    Visible:array[0..COL_MAX_POINTS] of boolean;   // Видимость на участке
    Mov: boolean;                        // движущаяся
  end;

  TTarget=record                                  // Описание мишени
    Num       : word;                             // Номер мишени
    Aktiv     : word;                             // Активность мишени
    Color_Mask: word;                             // Цвет мишени
    Mov       : boolean;                          // Тип- не движется/движется
    Air       : boolean;                          // Тип- наземная/воздушная
    Tst       : word;                             // Время появления
    Tend      : word;                             // Время удаления
    ColPoints : word;                             // Количество опорных точек
                                                  // Точка № 0 - стартовая
    Xtek    : array[0..COL_MAX_POINTS] of integer;      // Координаты опорных точек
    Ytek    : array[0..COL_MAX_POINTS] of integer;      // Координаты опорных точек
    Htek    : array[0..COL_MAX_POINTS] of integer;      // Для воздушных целей
    Tstop   : array[0..COL_MAX_POINTS] of word;        // Время остановки в точке
    Skor    : array[0..COL_MAX_POINTS] of integer;      // Cкорость движения на участках
    Visible : array[0..COL_MAX_POINTS] of boolean;   // Видимость на участке
  end;

  TTask=record              // Структура задач
    m_t: integer;           //Температура заряда  4
    m_tv: integer;          //Температура воздуха 4
    m_v: integer;           //Скорость ветра 4
    m_az: integer;          //Азимут ветра    4
    m_pv: integer;          //Давление воздуха
    m_ks: integer;          //Износ канала ствола
    Temp: word;             //Время суток      4
    Ceson: word;            //Время года        4
    Mestn: word;            //Местность          4
    m_inten_fog: word;      // Плотность тумана
    m_index: word;          //Индекс задачи
    m_fog: boolean;         // Плотность тумана
    NumKvit:byte;           // Номер квитанции
    Tstr: word;             // Время на стрельбу
    Col_targ: word;         // Количество мишеней
    Reserv1: word;
    Reserv2: word;
    Reserv3: word;
    Reserv4: word;
    Reserv5: word;
    Reserv6: word;
    Bk: TBk;                // Боекомплект
    typeTarget: array[1..COL_MAX_MICH] of byte;   // Описание мишеней
    Color_Mask: array[1..COL_MAX_MICH] of byte;   // Описание мишеней
    Orient: TOrient;
    enableModel: array[1..COL_MAX_TIPE_TECHN] of boolean;
    Target: array[1..3,1..COL_MAX_MICH] of TTarget;   // Описание мишеней
  end;
  Mestnik = record
    Num               : integer;    //номер файла компиляции List
    Patch             : integer;    //номер патча
    X,Y,H,A           : real;       //координаты и угол поворота в единицах экрана и градусах
    Sc                : real;       // Масштабирование
    Az_Paden          : real;       //угол падения в градусах
    Tg_Paden          : real;       //тангаж падения в градусах
    Type_Objekt       : integer;    //Признак объекта 1- точка, 2-круг, 3-многоуг-к , 4-ломаная линия
    Type_Action       : integer;    //Признак разрушения 0- нет, 1- отскок, 2-наклон, 3-разрушение
    Col_Points_Objekt : integer;    //Количество ограничивающих точек
   Curver            : TList;       //Список координат
  end;
  PMestnik = ^Mestnik;

  TBox_Tank=record                  // Структура Данных
    x1_box: real;
    y1_box: real;
    h1_box: real;
    x2_box: real;
    y2_box: real;
    h2_box: real;
  end;

const
  // Рабочие места
  //
{  RM_RUKOVOD=0;
  RM_KOMAND=1;
  RM_NAVOD=2;
  RM_MEXAN=3;}

  RM_RUKOVOD=0;
  RM_NAVOD_BPK=1;
  RM_NAVOD_PTU=2;
  RM_KOMAND_PZ=3;
  RM_KOMAND_TKN=4;
  RM_MEXAN=5;
  RM_SERVER=6;
  RM_NAVOD_PNV=7;
  RM_KOMAND_PNV=8;

  //Время суток
  DAY=1;
  NIGHT=2;
  GLOAMING=3;

  //Время года
  SUMMER=1;
  WINTER=2;
  AUTUMN=3;
  
  //Местность
  RAVNINA=1;
  GORA=2;
  BOLOTO=3;
  PUSTYN=4;
  // Мишени
  M6=1;
  M7=2;
  M8=3;
  M8A=4;
  M9=5;
  M9A=6;
  M9C=7;
  M10=8;
  M10A=9;
  M11=10;
  M12=11;
  M12A=12;
  M12B=13;
  M13=14;
  M13A=15;
  M14=16;
  M17=17;
  M17A=18;
  M17B=19;
  M18=20;
  M19=21;
  M20=22;
  M20A=23;
  M25=24;

  MODEL_T55=1;
  MODEL_T72=2;
  MODEL_T80=3;
  MODEL_T90=4;
  MODEL_T59=5;
  MODEL_T69=6;
  MODEL_T84=7;
  MODEL_ARJUN=8;
  MODEL_VJAYANTA=9;
  MODEL_LEOPARD=10;
  MODEL_M1A1=11;
  MODEL_M48=12;

  MODEL_BMP1=31;
  MODEL_BMP2=32;
  MODEL_BMD3=33;
  MODEL_M2=34;
  MODEL_SCORPION=35;
  MODEL_BREDLY=36;

  MODEL_BTR80=41;
  MODEL_M113=42;
  MODEL_BTR_RD=43;

  MODEL_APACH=51;
  MODEL_COBRA=52;
  MODEL_MI24=53;

  MODEL_A10A=71;
  MODEL_F15=72;
  MODEL_F16=73;
  MODEL_SU25=74;

  MODEL_ALKM=91;
  MODEL_SAPSAN=92;

  MODEL_KAMAZ=101;
  MODEL_UAZ469=102;
  MODEL_2C9=103;
  MODEL_D30=104;
  MODEL_BUNKER=105;

 //===============Двухбайтные команды============================
    // Команды передаваемые по сети
  ZADACHA=1;        // Начало, конец задачи, просмотр рабочего места
    ZAD_SIGNAL=1;
    ZAD_BEGIN_UPR=2;
    ZAD_END_UPR=3;
    ZAD_ISX_POL=4;
    ZAD_UPRAVL_RMI=5; // Управление рабочим местом
    ZAD_UPRAVL_OTKL=6;
    ZAD_PROSMOTR_RMI=7;
    ZAD_PROSMOTR_OTKL=8;
    ZAD_PROSMOTR_ORG_UPR=9;
    ZAD_PROSMOTR_ORG_UPR_OTKL=10;
    ZAD_ZARJAJANIE=11;
  PANTOGRAF=2;
    PANT_1=1;         // Первый пантограф
    PANT_2=2;         // второй пантограф
    PANT_3=3;         // третий пантограф
    PANT_ERR=4;      //  ошибка
    PANT_PNT=5;      //  пройдена опорная точка
    PANT_END=6;      //  пройдена последняя точка
  OPERATION=3;        // Тренировка, контроль, самообучение

    OPER_CTRL_FUNCTION=24;
    OPER_RASSOGL_VYVER=25;
    OPER_SOGL_VYVER=26;
    OPER_SAMOOB_BEGIN=31;
    OPER_TRENIR_BEGIN=32;
    OPER_KONTRL_BEGIN=33;
    OPER_END=39;


  PORAJ_PKT=4; // Чем и как произведено поражение,  второй байт- номер поражённой мишени
  PORAJ_OG=5;
  PORAJ_BT=6;
  PORAJ_KUM=7;
  PORAJ_PTUR=8;
  PORAJ_RANA_BT=9;
  PORAJ_RANA25=10;
  PORAJ_SOSED=11;
  PORAJ_SOSED_1=12;
  PORAJ_SOSED_2=13;
  PORAJ_SOSED_3=14;
  PROMAX_PUSHKA=15;
  PROMAX_PTUR=16;
  OSKOLOK_PUSHKA=17;
  GABARIT_PUSHKA=18;
  NE_PORAJ_OG=19;

  POWER_PK=20;
    POWER_CLOSE=0;  // Выход из программы
    POWER_OFF=1;    // Выключение
    POWER_REBOOT=2; // Перезагрузка

  KVITANCIA=21;     // второй байт-номер квитанции

  TEST_=22;         //  Тест
    TEST_ON=1;
    TEST_OFF=2;
    TEST_KALIBR_MIN=3;
    TEST_KALIBR_MAX=4;
    TEST_KALIBR_SAVE=5;

  PORAJ_MODEL_OG=23;// Чем и как произведено поражение,  второй байт- номер поражённой мишени
  PORAJ_MODEL_BT=24;
  PORAJ_MODEL_KUM=25;
  PORAJ_MODEL_PTUR=26;

  STVOL_DYM_TAK=28;        // Выстрел модели

  DESTROY_TANK=29;         // Выход из строя
    DESTR_COMPL=1;           // Поражение полное
    DESTR_NAVOD=2;           // Наводчика (дальномер,стабилизатор, привод, дельта Д)
    DESTR_DALN=3;            // Дальномер
    DESTR_PRIVOD=4;          // Привод
    DESTR_PRIVOD_VER=5;      // Привод верт
    DESTR_PRIVOD_GOR=6;      // Привод горизонт
    DESTR_STABIL=7;          // Стабилизатор
    DESTR_AZ=8;              // Автомат заряжания
    DESTR_PNV=9;             // Ночное видение
    DESTR_UPR_RAK=10;        // Канал управляемой ракеты

    DESTR_VOD=20;            // База без движения
    DESTR_DVIG=21;           // Двигатель
    DESTR_POVOROT_LEV=22;    // Повороты
    DESTR_POVOROT_PRAV=23;
    DESTR_STARTER=24;        // Стартер
    DESTR_SCEPLENIE=25;      // Сцепление
    DESTR_TANK_1=31;            // Cоседний танк
    DESTR_TANK_2=32;            // Cоседний танк
    DESTR_TANK_3=33;            // Cоседний танк

  PORAJ_RANA_SOSED=31;
  PORAJ_RANA_SOSED_1=32;
  PORAJ_RANA_SOSED_2=33;
  PORAJ_RANA_SOSED_3=34;

  PEREKL_MONITOR=35;

  ERROR_ACTION=40;          // Ошибки экипажа
    // Командир
    ERROR_KOM_1=1;
    ERROR_KOM_2=2;
    ERROR_KOM_3=3;
    ERROR_KOM_4=4;
    ERROR_KOM_5=5;
    ERROR_KOM_6=6;
    // Наводчик
    ERROR_NAV_1=81;
    ERROR_NAV_2=82;
    ERROR_NAV_3=83;
    ERROR_NAV_4=84;
    ERROR_NAV_5=85;
    ERROR_NAV_6=86;
    // Механик-водитель
    ERROR_MV_1=161;
    ERROR_MV_2=162;
    ERROR_MV_3=163;
    ERROR_MV_4=164;
    ERROR_MV_5=165;
    ERROR_MV_6=166;

  OPER_TRENIR_ERROR=42;
  ISPRAVN1=43;
  ISPRAVN2=44;
  PORAZ_STAC_OBJ = 45;

  FUNCTION_SYSTEM=50;       // Сигналы, возникающие в процессе функционирования
    ZARJAD=1;               // Заряжание пушки
    SPUSK_PKT=2;            // Холостой спуск

    PLAY_BATTLE_NOISE=0;
    STOP_BATTLE_NOISE=1;

  MARK_MOVE=51;             //Информация по Кусу Вождения передается код буквы события или ошибки
  //управление платформой
  PLTFRM_STOP_DOWN=52;      //остановить, горизонтировать внизу
  PLTFRM_STOP_MIDL=53;      //остановить, горизонтировать посередине
  PLTFRM_SENS=54;           //коефициент чувствительности
  PLTFRM_SCAL=55;           //масштабный коефициент
  PLTFRM_INER=56;           //коефициент учета сил инерции
  PLTFRM_V=57;              //коефициент учета скорости
  PLTFRM_NILL=58;           //смещение нуля

  VIEWER_MODE=59;
    VIEWER_RIGHRT=20;
    VIEWER_LEFT=21;
    VIEWER_UP=22;
    VIEWER_DOUN=23;
    VIEWER_SCALE_PLUS=25;
    VIEWER_SCALE_MINUS=26;
    VIEWER_VID_SBOKU=27;
    VIEWER_DALN_PLUS=28;
    VIEWER_DALN_MINUS=29;

  ISPRAVN1_1=43;
  ISPRAVN1_2=44;
  ISPRAVN1_3=45;
  ISPRAVN2_1=46;
  ISPRAVN2_2=47;
  ISPRAVN2_3=48;

  //////////////////////////////////////////////////////////////////////////////
  VVODNAYA=60;             //ввод неисправности от руководителя
  // неисправности ПТУР
    CAT=1;                      //обрыв провода                          //AVP
    IR_GAUGE=2;                 //неисправен ИК датчик координатора      //AVP
    IR_HANDICAP=3;              //ИК помеха                              //AVP
    STARTER=4;                  //неисправен стартовый двигатель         //AVP
    ENGINE=5;                   //неисправен маршевый двигатель          //AVP
 ///////////////////////////////////////////////////////////////////////////////

  KOMANDA_CU=128;            // ЦУ от командира наводчику, второй байт- азимут

  SINCHRO=130;                // Проверка наличия в сети, второй байт-  номер квитанции
                              // +20

  PODRYV_PTUR_TERRAN=1;
  PODRYV_PTUR_MISHEN=2;
  PODRYV_PTUR_NONE=3;


  // Размер пакетов
  LVS_KOMAND=2;       //
  // Информация от Сервера
  LVS_SERVER_PTUR=216;
  LVS_TARGET=1200;
  LVS_TARG_TAK=1200;
  LVS_MODEL=720;     //*10 Сообщения о танках
  LVS_TAKTIKA=1920;  //  LVS_MODEL=720 +  LVS_TARG_TAK=1200;

  LVS_SERVER1=1233;
  LVS_SERVER2=1234;
  LVS_SERVER3=1235;

  LVS_MATRIX=72;
  LVS_INDIKATOR=43;

  LVS_ISX_DAN=680;   // Вся задача///>>>>>>>>>>

  LVS_VSPY=32;        // Cообщения о взрывах

  STOLB_BOTTOM_RAV=1780;      //     Расстояние от задней кромки поверхности
  STOLB_BOTTOM_GOR=1880;      //     Расстояние от задней кромки поверхности

  STOLB_SHIR=60;
  STOLB_LEFT_RAV=1800;         // Расстояние от левого края
  STOLB_DX1_RAV=1445;         //     Расстояние от 1 до 2 дорожки
  STOLB_DX2_RAV=1525;         //     Расстояние от 2 до 3 дорожки
  STOLB_LEFT_GOR=2930;         // Расстояние от левого края
  STOLB_DX1_GOR=980;         //     Расстояние от 1 до 2 дорожки
  STOLB_DX2_GOR=980;         //     Расстояние от 2 до 3 дорожки

  STOLB_DY_R=80;         //     Расстояние от белых до красных
  STOLB_DY_BL=6700;       //    Расстояние от красных до голубых
  STOLB_DY_GRAN=14000;    //     Расстояние от красных до знаков сектора запрета
  H_STOLB_GRAN=0.6;       //Высота ограничивающих столбов в оконных координатах

  ISX_POL_BTR_Y_RAV=1670;    // Исходное положение БМП по Y
  ISX_POL_BTR_Y_GOR=1770;    // Исходное положение БМП по Y


  // Размещение оборудования на полигоне в дм
  VYCHKA_X_RAV=2200;
  VYCHKA_Y_RAV=950;
  VYCHKA_X_MV=8510;
  VYCHKA_Y_MV=720;
  VYCHKA_X_GOR=3580;
  VYCHKA_Y_GOR=1390;

  MASHT_RIS_100=100;
  MASHT_RIS_10=10;


  procedure SetDimensionDirectris(season,region : integer);
  procedure Isx_Pol_GM;
  procedure Count_pogoda;
  procedure SettingTaskDefault;
  function SkorostK(v: real): real;
  function SkorostM(v: real): real;
  function Uskoren(a: real): real;
  function  Num_Target(Name: string): integer;
  function  Name_Target(Num: integer): string;
  function Name_Target_rus(Num: integer): string;// для ведомости у руководителя
  procedure SetBoxTank;
  procedure Vostan_BK;
  procedure IspravnostBMP;
var
  BMP: array [1..COL_EKIP] of TBMP;
  BMP_Temp: array [1..COL_EKIP] of TBMP;
  Model: array[1..COL_TEXNIKA_MODEL] of TModel;/// Структура для передачи///>>>>>>>>
  Task: TTask;
  dirBase: string;
  Orient: TOrient;
  // Переменные поля зрения
  otobr_RM: word;
  real_RM: word;
  Num_BMP: word=2;
  stop_prog: boolean;
  Povrejden: array[0..COL_EKIP] of word;

  Mestniks : array  of TList;
  Grand_Mestniks : TList;
  TypesOfOrient : TList;
  DinamicObj : TList;

  // Пременные, описывающие размеры полигона
  stolbLeft: real;    // Исходное положение БМП по Y
  stolbDX1,
  stolbDX2: real;
  stolbBottom: real;
  begPositionY: real;
  Vychka_X: real;
  Vychka_Y: real;
  Vychka_H: real;

  Targets: array[1..3,1..COL_MAX_MICH] of TTargets;
  TargetsTaktika: array[1..COL_MAX_MICH_TAK] of TTargets;
  Mode_off: word;

  Dym_V_X,Dym_V_Y,Dym_Vtek: real;

  XYZ_Bash : TXYZ;

  Boek: array[1..3] of TBk;// Текущее количество боеприпасов

  Box_Tank: array[1..4,1..2] of TBox_Tank;
  Poraj: array[1..3,1..COL_MAX_MICH] of boolean;
  Mont_Target: array[1..3,1..COL_MAX_MICH] of boolean;
  DeMont_Target: array[1..3,1..COL_MAX_MICH] of boolean;
  potok: array[0..64,1..6] of integer;    {Массив для постановки в очередь}
  begO,endO: word;                           { программ для обслуживания}
  surfaceNight:real;
  skyNight:real;

implementation

uses
main,UnBuildSetka;

procedure SetDimensionDirectris(season,region : integer);
begin
  if (region=GORA) or (season=WINTER) then begin
    begPositionY:=ISX_POL_BTR_Y_GOR;// Исходное положение БМП по Y
    stolbBottom:=STOLB_BOTTOM_GOR; // Расстояние от задней кромки поверхности
    stolbLeft:=STOLB_LEFT_GOR;
    stolbDX1:=STOLB_DX1_GOR;
    stolbDX2:=STOLB_DX2_GOR;
  end
  else begin
    begPositionY:=ISX_POL_BTR_Y_RAV;    // Исходное положение БМП по Y
    stolbBottom:=STOLB_BOTTOM_RAV;      //     Расстояние от задней кромки поверхности
    stolbLeft:=STOLB_LEFT_RAV;
    stolbDX1:=STOLB_DX1_RAV;
    stolbDX2:=STOLB_DX2_RAV;
  end;
end;

procedure Isx_Pol_GM;
var a, c: word;
begin
  for a:=1 to 3 do begin
    BMP[a].UmBase:=0;
    BMP[a].AzBase:=0;
    BMP[a].Tangage:=0;
    if Task.m_index<6000 then begin //Стрельба
      BMP[a].AzBase:=0;
      BMP[a].Ytek:=begPositionY/MASHT_RIS_100;  //
      case a of
        1: BMP[a].Xtek:=0;//(Stolb_left-BTR_SHIRINA_05)/MASHT_RIS_100;
        2: BMP[a].Xtek:=(stolbLeft+stolbdX1)/MASHT_RIS_100;
        3: BMP[a].Xtek:=0;//(Stolb_left+stolb_dX1+stolb_dX2)/MASHT_RIS_100;
      end;
      if Task.m_index=5005 then begin
        if Task.mestn=GORA then BMP[2].Ytek:=81.5 else BMP[2].Ytek:=40;//110
        BMP[2].AzBase:=180;
      end;
    end;
    if a=2 then BMP[a].Htek:=CountHeight(BMP[a].Xtek,BMP[a].Ytek)
           else BMP[a].Htek:=-10;
  end;
end;

 (**************Инициализация ***************)
procedure SettingTaskDefault;
begin
  task.temp:=DAY;
//  task.temp:=NIGHT;
  task.ceson:=SUMMER;
  task.mestn:=RAVNINA;
//  task.mestn:=GORA;
//  task.mestn:=PUSTYN;
  task.m_index:=4001;
  task.m_t:=15;
  task.m_tv:=15;
  task.m_v:=0;
  task.m_az:=0;
  task.m_pv:=750;
  task.m_ks:=1;
  task.m_inten_fog:=10;
  task.m_fog:=true;
  task.numKvit:=111;
  task.tStr:=180;
  task.Bk.Col_Upr:=10;
end;

procedure Count_pogoda;
var  vx,vy: real;
begin
  vx      :=  -SkorostM(Task.m_v)*sin(Task.m_az/57.3);
  vy      :=  SkorostM(Task.m_v)*cos(Task.m_az/57.3);
  Dym_V_X :=  vx/2;
  Dym_V_Y :=  vy/2;
  Dym_Vtek:=  sqrt(Dym_V_Y*Dym_V_Y+Dym_V_X*Dym_V_X);
end;

{****************Расчёты****************}

function SkorostK(v: real): real;
begin
  result:=v*10/3.6/TIK_SEK/MASHT_RIS_100;             // v/Перевод в дм/c /TIK_SEK/ Масштаб
end;

function SkorostM(v: real): real;
begin
  result:=v*10/TIK_SEK/MASHT_RIS_100;             // v* Перевод в дм/c /TIK_SEK/ Масштаб
end;

function Uskoren(a: real): real;
begin
  result:=a*10/TIK_SEK/TIK_SEK/MASHT_RIS_100;             // a * Перевод в дм/c/ TIK_SEK/Масштаб
end;

function Num_Target(Name: string): integer;
begin
  Num_Target:=M8;
  if Name='6'then Num_Target:=M6;
  if Name='7'then Num_Target:=M7;
  if Name='8'then Num_Target:=M8;
  if Name='8a'then Num_Target:=M8A;
  if Name='9'then Num_Target:=M9;
  if Name='9a'then Num_Target:=M9A;
  if Name='9c'then Num_Target:=M9C;
  if Name='10'then Num_Target:=M10;
  if Name='10a'then Num_Target:=M10A;
  if Name='11'then Num_Target:=M11;
  if Name='12'then Num_Target:=M12;
  if Name='12a'then Num_Target:=M12A;
  if Name='12b'then Num_Target:=M12B;
  if Name='13'then Num_Target:=M13;
  if Name='13a'then Num_Target:=M13A;
  if Name='14'then Num_Target:=M14;
  if Name='17'then Num_Target:=M17;
  if Name='17a'then Num_Target:=M17A;
  if Name='17b'then Num_Target:=M17B;
  if Name='18'then Num_Target:=M18;
  if Name='19'then Num_Target:=M19;
  if Name='20'then Num_Target:=M20;
  if Name='20a'then Num_Target:=M20A;
  if Name='25'then Num_Target:=M25;
end;

function Name_Target(Num: integer): string;
begin
  result:='8';
  case Num of
    M6: result:='6';
    M7: result:='7';
    M8: result:='8';
    M8A: result:='8a';
    M9: result:='9';
    M9A: result:='9a';
    M9C: result:='9c';
    M10: result:='10';
    M10A: result:='10a';
    M11: result:='11';
    M12: result:='12';
    M12A: result:='12a';
    M12B: result:='12b';
    M13: result:='13';
    M13A: result:='13a';
    M14: result:='14';
    M17: result:='17';
    M17A: result:='17a';
    M17B: result:='17b';
    M18: result:='18';
    M19: result:='19';
    M20: result:='20';
    M20A: result:='20a';
    M25: result:='25';
  end;
end;

function Name_Target_rus(Num: integer): string;
begin
  result:='8';
  case Num of
    M6: result:='6';
    M7: result:='7';
    M8: result:='8';
    M8A: result:='8a';
    M9: result:='9';
    M9A: result:='9а';
    M9C: result:='9в';
    M10: result:='10';
    M10A: result:='10a';
    M11: result:='11';
    M12: result:='12';
    M12A: result:='12a';
    M12B: result:='12б';
    M13: result:='13';
    M13A: result:='13a';
    M14: result:='14';
    M17: result:='17';
    M17A: result:='17a';
    M17B: result:='17б';
    M18: result:='18';
    M19: result:='19';
    M20: result:='20';
    M20A: result:='20a';
    M25: result:='25';
  end;
end;

procedure SetBoxTank;
begin
  Box_Tank[1,1].x1_box:=-0.285;
  Box_Tank[1,1].h1_box:=-0.12;
  Box_Tank[1,1].y1_box:=-0.15;
  Box_Tank[1,1].x2_box:=0.28;
  Box_Tank[1,1].y2_box:=0.13;
  Box_Tank[1,1].h2_box:=0.01;

  Box_Tank[1,2].x1_box:=-0.14;
  Box_Tank[1,2].h1_box:=0.01;
  Box_Tank[1,2].y1_box:=-0.1;
  Box_Tank[1,2].x2_box:=0.13;
  Box_Tank[1,2].h2_box:=0.1;
  Box_Tank[1,2].y2_box:=0.1;

  Box_Tank[2,1].x1_box:=-0.27;
  Box_Tank[2,1].h1_box:=-0.18;
  Box_Tank[2,1].y1_box:=-0.21;
  Box_Tank[2,1].x2_box:=0.42;
  Box_Tank[2,1].h2_box:=-0.02;
  Box_Tank[2,1].y2_box:=0.11;

  Box_Tank[2,2].x1_box:=0.01;
  Box_Tank[2,2].h1_box:=-0.02;
  Box_Tank[2,2].y1_box:=-0.125;
  Box_Tank[2,2].x2_box:=0.19;
  Box_Tank[2,2].h2_box:=0.03;
  Box_Tank[2,2].y2_box:=0.04;

  Box_Tank[3,1].x1_box:=-0.44;
  Box_Tank[3,1].h1_box:=-0.09;
  Box_Tank[3,1].y1_box:=-0.14;
  Box_Tank[3,1].x2_box:=0.19;
  Box_Tank[3,1].h2_box:=0.05;
  Box_Tank[3,1].y2_box:=0.16;

  Box_Tank[3,2].x1_box:=-0.13;
  Box_Tank[3,2].h1_box:=0.05;
  Box_Tank[3,2].y1_box:=-0.11;
  Box_Tank[3,2].x2_box:=0.065;
  Box_Tank[3,2].h2_box:=0.11;
  Box_Tank[3,2].y2_box:=0.1;

  Box_Tank[4,1].x1_box:=-0.41;
  Box_Tank[4,1].h1_box:=-0.11;
  Box_Tank[4,1].y1_box:=-0.18;
  Box_Tank[4,1].x2_box:=0.23;
  Box_Tank[4,1].h2_box:=0.05;
  Box_Tank[4,1].y2_box:=0.17;

  Box_Tank[4,2].x1_box:=-0.2;
  Box_Tank[4,2].h1_box:=0.05;
  Box_Tank[4,2].y1_box:=-0.12;
  Box_Tank[4,2].x2_box:=0.03;
  Box_Tank[4,2].h2_box:=0.13;
  Box_Tank[4,2].y2_box:=0.12;

end;

procedure Vostan_BK;
var a,b,c: word;
begin
  Boek[Num_BMP].Col_Upr:=Task.Bk.Col_Upr;
  BMP[Num_BMP].Col_Upr:=Boek[Num_BMP].Col_Upr;
end;

procedure IspravnostBMP;
begin
  BMP[num_BMP].Ispravn_PTUR_Fill:=true;
  BMP[num_BMP].Ispravn_PTUR_Optik:=true;
  BMP[num_BMP].Ispravn_PTUR_Pomexa:=true;
  BMP[num_BMP].Ispravn_PTUR_Start:=true;
  BMP[num_BMP].Ispravn_PTUR_Marsh:=true;
end;

end.
