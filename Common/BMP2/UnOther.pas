unit UnOther;

interface
  uses UnGeom, Classes;

const
  TIK_SEK=18;
  COL_SNAR=18;                // Максимальное количество снарядов в очереди
  COL_PATR=12;
  COL_EKIP=3;
  COL_MAX_MICH=12;
  //Модель
  COL_TEXNIKA_MODEL=17;
  MAX_COL_ORIENT=12;

type
  TBMP=record                           // Структура Данных по БМП-2
   // Данные от МВ  // real
   Xtek:     real;
   Ytek:     real;
   Htek:     real;              //Текущие координаты БМП  x,z,y
   UmBase:   real;
   AzBase:   real;              // Наклон  базовой машины
   Tangage:  real;              // Продольный наклон
   Skorost:  real;               // Скорость
   Katok: array[1..16] of real;
   RezervMV1real:     real;
   RezervMV2real:     real;
   RezervMV3real:     real;
   RezervMV4real:     real;
   Col_Oborot:                word;
   Nagruzka:                  word;    // Количество оборотов и нагрузка(%)
   Patch_tek                : word;
   Patch_Collis             : word;
   Obj_Collis               : word;
   Az_Paden          : byte;  //угол падения в градусах
   Tg_Paden          : byte;  //тангаж падения в градусах
   Type_Action       : byte;  //Признак разрушения 0- нет, 1- отскок, 2-наклон, 3-разрушение
   Start:            boolean;           // Начало движения
   vod_imp: array[0..2] of byte;        // Органы МВ
   otboy:     boolean;
   fara_MV:   boolean;
   fara_MV_N: boolean;
   pnv_MV:    boolean;
   otkaz : array[0..3] of byte;         //неисправности введенный руководителем
   dust_intens : byte;        //интенсивность загрязнения триплекса механика
   dust_clean  : boolean;     //работает пневмоочистка триплекса механика
   zapot : byte;              //запотевание ТПНО
   TDA : boolean;             //работает ТДА
   Kom_outdoor       : boolean;  //true-командир в машине
   X4:                boolean;
   RezervMV1bool:     boolean;
   RezervMV2bool:     boolean;
   RezervMV3bool:     boolean;
   RezervMV4bool:     boolean;
   RezervMV5bool:     boolean;
   RezervMV6bool:     boolean;
   RezervMV7bool:     boolean;
   RezervMV8bool:     boolean;
   //
   // Данные от наводчика
   UmPushka:         real;              // Положение пушки
   AzBashn:         real;              // Поворот башни
   Xtek_Pushka:   array[1..COL_SNAR] of single;
   Ytek_Pushka:   array[1..COL_SNAR] of single;
   Htek_Pushka:   array[1..COL_SNAR] of single;
   D_Pushka:   array[1..COL_SNAR] of single;                          //Текущие координаты снарядов
   Xtek_PKT:   array[1..COL_PATR] of single;
   Ytek_PKT:   array[1..COL_PATR] of single;
   Htek_PKT:   array[1..COL_PATR] of single;
   D_PKT:      array[1..COL_PATR] of single;//Текущие координаты трассера ПКТ
   Xtek_PTUR: real;
   Ytek_PTUR: real;
   Htek_PTUR: real;
   Tang_X: real;
   Tang_Y: real;
   Tang_H: real;
   D_PTUR: real;   //Текущие координаты ПТР
   AzPTUR: real;
   UmPTUR: real;
   Hpric:  real;              //  Высота точки наблюдения
   ballist: real;                         // Регулировка "Баллистика"
   Shtorka_mov: real;
   Var_Vyv: array [1..4] of real;        // Выверки
   View_Points_rezerv : array [1..6] of Vektor; //положение прицелов
   AzBashn_old: real;
   otkat: real;
   Reserv3,
   Reserv4: real;
   Num_destroy: word;
   Mode: word;
   Lumen_BPK: word;                      // Подсвет шкалы
   Lumen_PTR: word;                      // Подсвет шкалы ПТР
   podryvPTUR: word;                      //Тип подрыва ПТУР
   numKvit:    word;
   pereklFiltrPZ:    word;
   Ispravn_CU:     boolean;
   Ispravn_PTUR_Fill:  boolean;
   Ispravn_PTUR_Optik:  boolean;
   Ispravn_PTUR_Pomexa:  boolean;
   Ispravn_PTUR_Start:  boolean;
   Ispravn_Pushka_Zarjad:  boolean;
   Ispravn_PTUR_Marsh:  boolean;

   Pusk_a_42:  boolean;
   res7,
   res8: word;

   Col_OF: word;                        // Количество осколочных
   Col_BR: word;                        // Количество бронебойных
   Col_Upr: word;                       // Количество управляемых
   Col_PKT: word;                       // Количество боеприпасов к пулемёту
   Col_PyrPatr: byte;           //  Количество пиропатронов
   Col_Dym: byte;                       // Количество дымовых шашек

   Start_Pushka:   array[1..COL_SNAR] of   Boolean; //// Признак существования трассы
   Vystrel_Pushka: array[1..COL_SNAR] of   Boolean;
   Start_PKT:      array[1..COL_PATR] of   Boolean; //
   Start_PTUR:   boolean;               //
   Spusk_PKT:   boolean;               //
   pereklPrivod:   boolean;               //Тумблер привод
   pan: boolean;                         // Режим ПАН


   Diafragma:byte;                      // Шторка и диафрагма
   PNV,
   Aktiv_PNV:           boolean;        // ночной прицел, инфра фара
   activBPK:            boolean;
   Zaslon_9CH,
   Kolpak,
   Shtorka:            boolean;
   Res_bool1:          boolean;
   // л. на ПУО
   stoporBashn: boolean;                // Стопор башни
   stoporPushka: boolean;                // Стопор пушки
   Priv_ver:boolean;                    // Привод вертикальный включен
   Priv_gor:boolean;                    // Привод горизонтальный включен
   Stabil:boolean;
   Privod:boolean;
   PTR:boolean;
   PKT_start: boolean;
   predochrKazen:boolean;
   pereklSpuskiBU25: boolean;
   pereklSpuskiKrBU25: boolean;
   pereklAzimutBU25: boolean;
   pereklBsNbBU25: boolean;
   pereklGnBU25: boolean;
   pereklVnBU25: boolean;
   pereklPreobrBU25: boolean;
   buttonKontrolBU25: boolean;
   pereklDenTKN: boolean;
   pereklBpTKN: boolean;
   pereklFaraTKN: boolean;
   stoporLukTKN: boolean;
   pereklFaraBU25: boolean;
   spuskPushkaKazen: boolean;
   spuskPktKazen: boolean;
   spuskPushkaSturv: boolean;
   spuskPktSturv: boolean;
   fara: boolean;
   RezervNavBool6:     boolean;
   pereklOsveshPZ:     boolean;
   Shtorka_Kom:  byte;
   perebros:          boolean;
   linePushkaPTR:     boolean;
   Uderjanie:         boolean;
   Ispravn_ElSpusk:     boolean;
   //=======================================
   //от командира
   Az_TKN:  real;            // Положение башенки командира
   Um_TKN:  real;
   ballist_kom: real;                         // Регулировка "Баллистика"
   Lumen_1PZ: word;                           // Подсвет шкалы 1ПЗ
   Vybor_snar: word;                            // Заряженный снаряд
   PNV_kom,
   Kratn_Pric: boolean;
   Aktiv_PNV_kom: boolean;
   Kolpak_kom,
   Res_bool2: boolean;
   Diafragma_Kom:byte;                      // Шторка и диафрагма
   //=======================================
   Odin,Korot,Bolsh : boolean;
   Nalob_9CH:          boolean;
   Nalob_TKN: boolean;
   Stab_Push,                            // Стабилизатор орудия
   Gotov_PTUR,                          // Готовность заряжания ракеты
   Gotov_Pushka: boolean;               // Пушка заряжена штатным выстрелом
   Dubl_Soglas:  boolean;               // Башня согласована с башенкой
   LukMV:  boolean; // Люк МВ
   //===============================================

   Col_Rasxod_Avt: word;                 // Расход БП, после которого цикл заряжания-90 сек(руч)
   Col_Rasxod_PKT: word;
   Vtek,
   Vxtek, Vytek, Vhtek: real;   //Текущие скорости  БМП-2
   Axtek, Aytek, Ahtek: real;   //Текущие ускорения   БМП-2

   Xold_PKT, Yold_PKT, Hold_PKT: array[1..COL_PATR] of real;//Текущие координаты трассера ПКТ 144
   Vxtek_PKT, Vytek_PKT, Vhtek_PKT: array[1..COL_PATR] of real;//Текущие скорости трассера ПКТ
   Axtek_PKT, Aytek_PKT, Ahtek_PKT: array[1..COL_PATR] of real;//Текущие ускорение  трассера ПКТ

   Xold_Pushka, Yold_Pushka, Hold_Pushka: array[1..COL_SNAR] of real;//Текущие координаты трассера
   Vxtek_Pushka, Vytek_Pushka, Vhtek_Pushka: array[1..COL_SNAR] of real; //Текущие скорости трассера
   Axtek_Pushka, Aytek_Pushka, Ahtek_Pushka: array[1..COL_SNAR] of real; //Текущие ускорение  трассера

   Xold_PTUR, Yold_PTUR, Hold_PTUR: real;//Текущие координаты трассера ПКТ 144
   Vxtek_PTUR, Vytek_PTUR, Vhtek_PTUR,Vhbeg_PTUR:  real;   //Текущие скорости ПТУРС
   Axtek_PTUR, Aytek_PTUR, Ahtek_PTUR: real;   //Текущие ускорение  ПТУРС

   UmBase_Old,
   AzBase_Old:    real;     // Наклон  базовой машины в предыдущем квадрате        8
   Razgon_PTUR: integer; //Количество тиков для разгона ПТУР
   Angle_CU,     // Азимут ЦУ
   UmPush_Otrab: real;// Требуемое положение пушки
   AzBash_Otrab: real;// Требуемое положение башни
   Otrab_CU: boolean;
   Num_PU,
   temp,               // Количество выстрелов в очереди
   col_ocher_A42,      // Количество оставшихся в очереди выстрелов
   Time_Num_PU: word;  // Время памяти ПУ дым шашки
   Perezar: boolean;
   Perezar_PKT: boolean;
   Ocher_A42,          // Требуется сформировать очередь
   Komandir_CU,
   Privod_kom,
   Ispravn_Priv_Gor: boolean;  // Исправность
   Ispravn_Priv_Ver: boolean;
   Ispravn_Stabil: boolean;
   Ispravn_Starter : boolean;
   Ispravn_Dvig : boolean;
   Ispravn_Povorot_Lev : boolean;
   Ispravn_Povorot_Prav : boolean;
   Ispravn_Power :boolean;
   Start_Pushka_Old: array[1..COL_SNAR] of   Boolean;
   dH_Platform  : real;       //дополнительно по платформе
   AVx_Platform : real;
   AVy_Platform : real;
   dVH_Platform : real;
   perekl902BU25: boolean;
   pereklProjBU25: boolean;
   X4_old: boolean;
   Pos_V_Dym: word;        // Переключатель 902
   Pos_G_Dym: word;        // Переключатель 902
   Num_Dym: array[0..2,0..4] of boolean;
   Vnav_PTR: word;
   dalnCiklePTUR : integer;
   AIx_Platform, AIy_Platform : real;   // Углы наклона платформы
   povorotTKN: word;
   dAngle_TKN: word;
   centrTKN_Az_CU: word;
   buttonNaschet:array[1..2] of  word;
   noisePrivodOn: boolean;
   noiseTimePrivodFunc: word;
   lampTimePrivod: word;
   sound902: boolean;
   soundPiroLoad: boolean;
   pauseTikPushka: word;
   perebrosCU:          boolean;
   summRassoglTknCU: real;
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
    Fire:            boolean;          // Начало движения
  end;
  TBk=record                            // Боекомплект
    Col_OF : word;                      // Количество осколочных
    Col_BR : word;                      // Количество бронебойных
    Col_Upr: word;                      // Количество управляемых
    Col_Dym: word;                      // Количество дымовых шашек
    Col_PKT: word;                      // Количество боеприпасов к пулемёту
  end;
  TTargets=record
    xtek: real;        // координаты мишеней
    ytek: real;
    htek: real;
    angleRotation: real; // угол подъёма мишени
    enableTarget: boolean;
    otobr: boolean;       // мигание при поражении одним снарядом
    fire: boolean;       // вспышки выстрелов
  end;
  Tini=record
    BTR_80:boolean;
    BMP_1:boolean;
    BMP_2:boolean;
    T_55:boolean;
    T_72:boolean;
    T_80:boolean;
    T_90:boolean;
    M_113:boolean;
    M_2:boolean;
    LEOPARD:boolean;
    M_1A1:boolean;
    M_48:boolean;
    T_84:boolean;
    VJAYANTA:boolean;
    ARJUN:boolean;
    T_59:boolean;
    T_69:boolean;
    BUNKER:boolean;
    KAMAZ:boolean;
    UAZ_469:boolean;

    SAPSAN:boolean;
    APACH:boolean;

    ENEMY:boolean;
  end;

  TTask=record                          // Структура задач
    m_t: integer;           //Температура заряда  4
    m_tv: integer;          //Температура воздуха 4
    m_v: integer;           //Скорость ветра 4
    m_az: integer;          //Азимут ветра    4
    m_pv: integer;          //Давление воздуха
    m_ks: integer;          //Износ канала ствола
    temp: word;             //Время суток      4
    ceson: word;            //Время года        4
    mestn: word;            //Местность          4
    m_inten_fog: word;      // Плотность тумана
    m_index: word;          //Индекс задачи
    m_fog: boolean;         // Резерв//&&&&&
    numKvit:byte;           // Номер квитанции
    tStr: word;             // Время на стрельбу
    Bk: TBk;                // Боекомплект
    Col_targ: word;         // Количество мишеней
    typeTarget: array[1..COL_MAX_MICH] of byte;   // Описание мишеней
    Color_Mask: array[1..COL_MAX_MICH] of byte;   // Описание мишеней
  end;
  Mestnik = record
    Num               : integer;  //номер файла компиляции List
    Patch             : integer;  //номер патча
    X,Y,H,A           : real;  //координаты и угол поворота в единицах экрана и градусах
    Sc                : real;  // Масштабирование
    Az_Paden          : real;  //угол падения в градусах
    Tg_Paden          : real;  //тангаж падения в градусах
    Type_Objekt       : integer;  //Признак объекта 1- точка, 2-круг, 3-многоуг-к , 4-ломаная линия
    Type_Action       : integer;  //Признак разрушения 0- нет, 1- отскок, 2-наклон, 3-разрушение
    Col_Points_Objekt : integer;  //Количество ограничивающих точек
   Curver            : TList;    //Список координат
  end;
  PMestnik = ^Mestnik;
  TOrient=record
    Col_orient: word;
    Typ_orient:array[1..MAX_COL_ORIENT] of word;      // Координаты опорных точек
    Xorient:array[1..MAX_COL_ORIENT] of real;      // Координаты опорных точек
    Yorient:array[1..MAX_COL_ORIENT] of real;
    Horient:array[1..MAX_COL_ORIENT] of real;      // Для воздушных целей
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
  //Время года
  SUMMER=1;
  WINTER=2;
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

  SINCHRO=30;                // Проверка наличия в сети
  SINCHRO1=31;                // Проверка наличия в сети
  SINCHRO2=32;                // Проверка наличия в сети
  SINCHRO3=33;                // Проверка наличия в сети

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
  PLTFRM_STOP_DOWN=52;           //остановить, горизонтировать внизу
  PLTFRM_STOP_MIDL=53;           //остановить, горизонтировать посередине
  PLTFRM_SENS=54;           //коефициент чувствительности
  PLTFRM_SCAL=55;           //масштабный коефициент
  PLTFRM_INER=56;           //коефициент учета сил инерции
  PLTFRM_V=57;              //коефициент учета скорости
  PLTFRM_NILL=58;           //смещение нуля

  KOMANDA_CU=128;            // ЦУ от командира наводчику, второй байт- азимут

  // Размер пакетов
  LVS_KOMAND=2;       //
  // Информация от Сервера
  LVS_SERVER_PTUR=200;
  LVS_SERVER1=1233;
  LVS_SERVER2=1234;
  LVS_SERVER3=1235;

  LVS_MATRIX=72;
  LVS_INDIKATOR=43;

  LVS_MODEL=864;     //*10 Сообщения о танках

  LVS_ISX_DAN_TAK=1920;   // Вся задача тактика///>>>>>>>>>>
  LVS_ISX_DAN=2000;   // Вся задача///>>>>>>>>>>

  LVS_VSPY=32;        // Cообщения о взрывах

const
  ISX_POL_BTR_Y_RAV=1670;    // Исходное положение БМП по Y
  ISX_POL_BTR_Y_GOR=1770;    // Исходное положение БМП по Y

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

var
  BMP: array [0..COL_EKIP] of TBMP;
  Model: array[1..COL_TEXNIKA_MODEL] of TModel;/// Структура для передачи///>>>>>>>>
  Task: TTask;
  dirBase: string;
  Orient: TOrient;
  // Переменные поля зрения
  otobr_RM: word;
  real_RM: word;
  Num_BMP: word;

  Povrejden: array[0..COL_EKIP] of word;

  Mestniks : array  of TList;
  Grand_Mestniks : TList;
  TypesOfOrient : TList;

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
  potok: array[0..64,1..6] of integer;    {Массив для постановки в очередь}
  begO,endO: word;                           { программ для обслуживания}
  Mode_off: word;

  Dym_V_X,Dym_V_Y,Dym_Vtek: real;

implementation

uses
main,UnBuildSetka;

procedure SetDimensionDirectris(season,region : integer);
begin
  posH:=posHvis-CountHeight(posX, posY);
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
    BMP[a].UmPushka:=-1;
    BMP[a].UmPTUR:=0;
    BMP[a].Vtek:=0;
    BMP[a].VXtek:=0;
    BMP[a].VYtek:=0;
    BMP[a].VHtek:=0;
    BMP[a].AzBashn:=0;
    BMP[a].AzPTUR:=0;
    BMP[a].Start:=false;
    BMP[a].centrTKN_Az_CU:=0;
    for c:=1 to 12 do BMP[a].Katok[c]:=0.025;
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
    end
    else
     begin                     // Вождение
      BMP[a].AzBase:=90;
      BMP[a].Xtek:=84.9;
      case a of
        1: BMP[a].Ytek:=12.9;
        2: BMP[a].Ytek:=13.4;
        3: BMP[a].Ytek:=13.9;
      end;
    end;
    if Task.m_index=6204 then
    begin
      BMP[a].AzBase:=300;
      BMP[a].Xtek:=106.3;
      case a of
        1: BMP[a].Ytek:=95.4;
        2: BMP[a].Ytek:=95.9;
        3: BMP[a].Ytek:=96.4;
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
  task.ceson:=SUMMER;
  task.mestn:=RAVNINA;
  task.m_index:=4001;
  task.m_t:=15;
  task.m_tv:=15;
  task.m_v:=0;
  task.m_az:=0;
  task.m_pv:=750;
  task.m_ks:=1;
  task.m_inten_fog:=15;
  task.m_fog:=true;
  task.numKvit:=111;
  task.tStr:=180;
  task.Bk.Col_Upr:=10;
end;

procedure Count_pogoda;
var  vx,vy: real;
begin
  vx:=-SkorostM(Task.m_v)*sin(Task.m_az/57.3);
  vy:=SkorostM(Task.m_v)*cos(Task.m_az/57.3);
  Dym_V_X:=vx;
  Dym_V_Y:=vy;
  Dym_Vtek:=sqrt(Dym_V_Y*Dym_V_Y+Dym_V_X*Dym_V_X);
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


end.
