unit UnOther;

interface
  uses UnGeom, Classes;

const
  TIK_SEK=18;
  COL_SNAR=18;                // ������������ ���������� �������� � �������
  COL_PATR=12;
  COL_EKIP=3;
  COL_MAX_MICH=12;
  //������
  COL_TEXNIKA_MODEL=17;
  MAX_COL_ORIENT=12;

type
  TBMP=record                           // ��������� ������ �� ���-2
   // ������ �� ��  // real
   Xtek:     real;
   Ytek:     real;
   Htek:     real;              //������� ���������� ���  x,z,y
   UmBase:   real;
   AzBase:   real;              // ������  ������� ������
   Tangage:  real;              // ���������� ������
   Skorost:  real;               // ��������
   Katok: array[1..16] of real;
   RezervMV1real:     real;
   RezervMV2real:     real;
   RezervMV3real:     real;
   RezervMV4real:     real;
   Col_Oborot:                word;
   Nagruzka:                  word;    // ���������� �������� � ��������(%)
   Patch_tek                : word;
   Patch_Collis             : word;
   Obj_Collis               : word;
   Az_Paden          : byte;  //���� ������� � ��������
   Tg_Paden          : byte;  //������ ������� � ��������
   Type_Action       : byte;  //������� ���������� 0- ���, 1- ������, 2-������, 3-����������
   Start:            boolean;           // ������ ��������
   vod_imp: array[0..2] of byte;        // ������ ��
   otboy:     boolean;
   fara_MV:   boolean;
   fara_MV_N: boolean;
   pnv_MV:    boolean;
   otkaz : array[0..3] of byte;         //������������� ��������� �������������
   dust_intens : byte;        //������������� ����������� ��������� ��������
   dust_clean  : boolean;     //�������� ������������� ��������� ��������
   zapot : byte;              //����������� ����
   TDA : boolean;             //�������� ���
   Kom_outdoor       : boolean;  //true-�������� � ������
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
   // ������ �� ���������
   UmPushka:         real;              // ��������� �����
   AzBashn:         real;              // ������� �����
   Xtek_Pushka:   array[1..COL_SNAR] of single;
   Ytek_Pushka:   array[1..COL_SNAR] of single;
   Htek_Pushka:   array[1..COL_SNAR] of single;
   D_Pushka:   array[1..COL_SNAR] of single;                          //������� ���������� ��������
   Xtek_PKT:   array[1..COL_PATR] of single;
   Ytek_PKT:   array[1..COL_PATR] of single;
   Htek_PKT:   array[1..COL_PATR] of single;
   D_PKT:      array[1..COL_PATR] of single;//������� ���������� �������� ���
   Xtek_PTUR: real;
   Ytek_PTUR: real;
   Htek_PTUR: real;
   Tang_X: real;
   Tang_Y: real;
   Tang_H: real;
   D_PTUR: real;   //������� ���������� ���
   AzPTUR: real;
   UmPTUR: real;
   Hpric:  real;              //  ������ ����� ����������
   ballist: real;                         // ����������� "����������"
   Shtorka_mov: real;
   Var_Vyv: array [1..4] of real;        // �������
   View_Points_rezerv : array [1..6] of Vektor; //��������� ��������
   AzBashn_old: real;
   otkat: real;
   Reserv3,
   Reserv4: real;
   Num_destroy: word;
   Mode: word;
   Lumen_BPK: word;                      // ������� �����
   Lumen_PTR: word;                      // ������� ����� ���
   podryvPTUR: word;                      //��� ������� ����
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

   Col_OF: word;                        // ���������� ����������
   Col_BR: word;                        // ���������� �����������
   Col_Upr: word;                       // ���������� �����������
   Col_PKT: word;                       // ���������� ����������� � �������
   Col_PyrPatr: byte;           //  ���������� ������������
   Col_Dym: byte;                       // ���������� ������� �����

   Start_Pushka:   array[1..COL_SNAR] of   Boolean; //// ������� ������������� ������
   Vystrel_Pushka: array[1..COL_SNAR] of   Boolean;
   Start_PKT:      array[1..COL_PATR] of   Boolean; //
   Start_PTUR:   boolean;               //
   Spusk_PKT:   boolean;               //
   pereklPrivod:   boolean;               //������� ������
   pan: boolean;                         // ����� ���


   Diafragma:byte;                      // ������ � ���������
   PNV,
   Aktiv_PNV:           boolean;        // ������ ������, ����� ����
   activBPK:            boolean;
   Zaslon_9CH,
   Kolpak,
   Shtorka:            boolean;
   Res_bool1:          boolean;
   // �. �� ���
   stoporBashn: boolean;                // ������ �����
   stoporPushka: boolean;                // ������ �����
   Priv_ver:boolean;                    // ������ ������������ �������
   Priv_gor:boolean;                    // ������ �������������� �������
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
   //�� ���������
   Az_TKN:  real;            // ��������� ������� ���������
   Um_TKN:  real;
   ballist_kom: real;                         // ����������� "����������"
   Lumen_1PZ: word;                           // ������� ����� 1��
   Vybor_snar: word;                            // ���������� ������
   PNV_kom,
   Kratn_Pric: boolean;
   Aktiv_PNV_kom: boolean;
   Kolpak_kom,
   Res_bool2: boolean;
   Diafragma_Kom:byte;                      // ������ � ���������
   //=======================================
   Odin,Korot,Bolsh : boolean;
   Nalob_9CH:          boolean;
   Nalob_TKN: boolean;
   Stab_Push,                            // ������������ ������
   Gotov_PTUR,                          // ���������� ��������� ������
   Gotov_Pushka: boolean;               // ����� �������� ������� ���������
   Dubl_Soglas:  boolean;               // ����� ����������� � ��������
   LukMV:  boolean; // ��� ��
   //===============================================

   Col_Rasxod_Avt: word;                 // ������ ��, ����� �������� ���� ���������-90 ���(���)
   Col_Rasxod_PKT: word;
   Vtek,
   Vxtek, Vytek, Vhtek: real;   //������� ��������  ���-2
   Axtek, Aytek, Ahtek: real;   //������� ���������   ���-2

   Xold_PKT, Yold_PKT, Hold_PKT: array[1..COL_PATR] of real;//������� ���������� �������� ��� 144
   Vxtek_PKT, Vytek_PKT, Vhtek_PKT: array[1..COL_PATR] of real;//������� �������� �������� ���
   Axtek_PKT, Aytek_PKT, Ahtek_PKT: array[1..COL_PATR] of real;//������� ���������  �������� ���

   Xold_Pushka, Yold_Pushka, Hold_Pushka: array[1..COL_SNAR] of real;//������� ���������� ��������
   Vxtek_Pushka, Vytek_Pushka, Vhtek_Pushka: array[1..COL_SNAR] of real; //������� �������� ��������
   Axtek_Pushka, Aytek_Pushka, Ahtek_Pushka: array[1..COL_SNAR] of real; //������� ���������  ��������

   Xold_PTUR, Yold_PTUR, Hold_PTUR: real;//������� ���������� �������� ��� 144
   Vxtek_PTUR, Vytek_PTUR, Vhtek_PTUR,Vhbeg_PTUR:  real;   //������� �������� �����
   Axtek_PTUR, Aytek_PTUR, Ahtek_PTUR: real;   //������� ���������  �����

   UmBase_Old,
   AzBase_Old:    real;     // ������  ������� ������ � ���������� ��������        8
   Razgon_PTUR: integer; //���������� ����� ��� ������� ����
   Angle_CU,     // ������ ��
   UmPush_Otrab: real;// ��������� ��������� �����
   AzBash_Otrab: real;// ��������� ��������� �����
   Otrab_CU: boolean;
   Num_PU,
   temp,               // ���������� ��������� � �������
   col_ocher_A42,      // ���������� ���������� � ������� ���������
   Time_Num_PU: word;  // ����� ������ �� ��� �����
   Perezar: boolean;
   Perezar_PKT: boolean;
   Ocher_A42,          // ��������� ������������ �������
   Komandir_CU,
   Privod_kom,
   Ispravn_Priv_Gor: boolean;  // �����������
   Ispravn_Priv_Ver: boolean;
   Ispravn_Stabil: boolean;
   Ispravn_Starter : boolean;
   Ispravn_Dvig : boolean;
   Ispravn_Povorot_Lev : boolean;
   Ispravn_Povorot_Prav : boolean;
   Ispravn_Power :boolean;
   Start_Pushka_Old: array[1..COL_SNAR] of   Boolean;
   dH_Platform  : real;       //������������� �� ���������
   AVx_Platform : real;
   AVy_Platform : real;
   dVH_Platform : real;
   perekl902BU25: boolean;
   pereklProjBU25: boolean;
   X4_old: boolean;
   Pos_V_Dym: word;        // ������������� 902
   Pos_G_Dym: word;        // ������������� 902
   Num_Dym: array[0..2,0..4] of boolean;
   Vnav_PTR: word;
   dalnCiklePTUR : integer;
   AIx_Platform, AIy_Platform : real;   // ���� ������� ���������
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
  TModel=record                         // ��������� ������ �� ������
    Xtek, Ytek, Htek: real;             // ������� ����������   x,z,y
    AzBase:           real;             // �������
    UmBase:           real;             // ���������� ������  ������� ������
    Kren:             real;             // ���������� ������
    UmPushka:         real;             // ��������� �����
    AzBashn:          real;             // ������� �����
    Skorost:          word;             // ������ ���������� (����)
    Typ:              byte;             // ���������� � �����
    Akt:              byte;             // ���������� �����
    Start:            boolean;          // ������ ��������
    Attace          : byte;             // ����� ���������� ���������� ��� 0
    Ver_poraz       : byte;             // ����������� ��������� ���������� Attace
    Fire:            boolean;          // ������ ��������
  end;
  TBk=record                            // �����������
    Col_OF : word;                      // ���������� ����������
    Col_BR : word;                      // ���������� �����������
    Col_Upr: word;                      // ���������� �����������
    Col_Dym: word;                      // ���������� ������� �����
    Col_PKT: word;                      // ���������� ����������� � �������
  end;
  TTargets=record
    xtek: real;        // ���������� �������
    ytek: real;
    htek: real;
    angleRotation: real; // ���� ������� ������
    enableTarget: boolean;
    otobr: boolean;       // ������� ��� ��������� ����� ��������
    fire: boolean;       // ������� ���������
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

  TTask=record                          // ��������� �����
    m_t: integer;           //����������� ������  4
    m_tv: integer;          //����������� ������� 4
    m_v: integer;           //�������� ����� 4
    m_az: integer;          //������ �����    4
    m_pv: integer;          //�������� �������
    m_ks: integer;          //����� ������ ������
    temp: word;             //����� �����      4
    ceson: word;            //����� ����        4
    mestn: word;            //���������          4
    m_inten_fog: word;      // ��������� ������
    m_index: word;          //������ ������
    m_fog: boolean;         // ������//&&&&&
    numKvit:byte;           // ����� ���������
    tStr: word;             // ����� �� ��������
    Bk: TBk;                // �����������
    Col_targ: word;         // ���������� �������
    typeTarget: array[1..COL_MAX_MICH] of byte;   // �������� �������
    Color_Mask: array[1..COL_MAX_MICH] of byte;   // �������� �������
  end;
  Mestnik = record
    Num               : integer;  //����� ����� ���������� List
    Patch             : integer;  //����� �����
    X,Y,H,A           : real;  //���������� � ���� �������� � �������� ������ � ��������
    Sc                : real;  // ���������������
    Az_Paden          : real;  //���� ������� � ��������
    Tg_Paden          : real;  //������ ������� � ��������
    Type_Objekt       : integer;  //������� ������� 1- �����, 2-����, 3-�������-� , 4-������� �����
    Type_Action       : integer;  //������� ���������� 0- ���, 1- ������, 2-������, 3-����������
    Col_Points_Objekt : integer;  //���������� �������������� �����
   Curver            : TList;    //������ ���������
  end;
  PMestnik = ^Mestnik;
  TOrient=record
    Col_orient: word;
    Typ_orient:array[1..MAX_COL_ORIENT] of word;      // ���������� ������� �����
    Xorient:array[1..MAX_COL_ORIENT] of real;      // ���������� ������� �����
    Yorient:array[1..MAX_COL_ORIENT] of real;
    Horient:array[1..MAX_COL_ORIENT] of real;      // ��� ��������� �����
  end;

const
  // ������� �����
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

  //����� �����
  DAY=1;
  NIGHT=2;
  //����� ����
  SUMMER=1;
  WINTER=2;
  //���������
  RAVNINA=1;
  GORA=2;
  BOLOTO=3;
  PUSTYN=4;
  // ������
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


 //===============����������� �������============================
    // ������� ������������ �� ����
  ZADACHA=1;        // ������, ����� ������, �������� �������� �����
    ZAD_SIGNAL=1;
    ZAD_BEGIN_UPR=2;
    ZAD_END_UPR=3;
    ZAD_ISX_POL=4;
    ZAD_UPRAVL_RMI=5; // ���������� ������� ������
    ZAD_UPRAVL_OTKL=6;
    ZAD_PROSMOTR_RMI=7;
    ZAD_PROSMOTR_OTKL=8;
    ZAD_PROSMOTR_ORG_UPR=9;
    ZAD_PROSMOTR_ORG_UPR_OTKL=10;
    ZAD_ZARJAJANIE=11;
  PANTOGRAF=2;
    PANT_1=1;         // ������ ���������
    PANT_2=2;         // ������ ���������
    PANT_3=3;         // ������ ���������
    PANT_ERR=4;      //  ������
    PANT_PNT=5;      //  �������� ������� �����
    PANT_END=6;      //  �������� ��������� �����
  OPERATION=3;        // ����������, ��������, ������������

    OPER_CTRL_FUNCTION=24;
    OPER_RASSOGL_VYVER=25;
    OPER_SOGL_VYVER=26;
    OPER_SAMOOB_BEGIN=31;
    OPER_TRENIR_BEGIN=32;
    OPER_KONTRL_BEGIN=33;
    OPER_END=39;


  PORAJ_PKT=4; // ��� � ��� ����������� ���������,  ������ ����- ����� ��������� ������
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
    POWER_CLOSE=0;  // ����� �� ���������
    POWER_OFF=1;    // ����������
    POWER_REBOOT=2; // ������������

  KVITANCIA=21;     // ������ ����-����� ���������

  TEST_=22;         //  ����
    TEST_ON=1;
    TEST_OFF=2;
    TEST_KALIBR_MIN=3;
    TEST_KALIBR_MAX=4;
    TEST_KALIBR_SAVE=5;

  PORAJ_MODEL_OG=23;// ��� � ��� ����������� ���������,  ������ ����- ����� ��������� ������
  PORAJ_MODEL_BT=24;
  PORAJ_MODEL_KUM=25;
  PORAJ_MODEL_PTUR=26;

  STVOL_DYM_TAK=28;        // ������� ������

  DESTROY_TANK=29;         // ����� �� �����
    DESTR_COMPL=1;           // ��������� ������
    DESTR_NAVOD=2;           // ��������� (���������,������������, ������, ������ �)
    DESTR_DALN=3;            // ���������
    DESTR_PRIVOD=4;          // ������
    DESTR_PRIVOD_VER=5;      // ������ ����
    DESTR_PRIVOD_GOR=6;      // ������ ��������
    DESTR_STABIL=7;          // ������������
    DESTR_AZ=8;              // ������� ���������
    DESTR_PNV=9;             // ������ �������
    DESTR_UPR_RAK=10;        // ����� ����������� ������

    DESTR_VOD=20;            // ���� ��� ��������
    DESTR_DVIG=21;           // ���������
    DESTR_POVOROT_LEV=22;    // ��������
    DESTR_POVOROT_PRAV=23;
    DESTR_STARTER=24;        // �������
    DESTR_SCEPLENIE=25;      // ���������
    DESTR_TANK_1=31;            // C������� ����
    DESTR_TANK_2=32;            // C������� ����
    DESTR_TANK_3=33;            // C������� ����

  SINCHRO=30;                // �������� ������� � ����
  SINCHRO1=31;                // �������� ������� � ����
  SINCHRO2=32;                // �������� ������� � ����
  SINCHRO3=33;                // �������� ������� � ����

  PORAJ_RANA_SOSED=31;
  PORAJ_RANA_SOSED_1=32;
  PORAJ_RANA_SOSED_2=33;
  PORAJ_RANA_SOSED_3=34;

  PEREKL_MONITOR=35;

  ERROR_ACTION=40;          // ������ �������
    // ��������
    ERROR_KOM_1=1;
    ERROR_KOM_2=2;
    ERROR_KOM_3=3;
    ERROR_KOM_4=4;
    ERROR_KOM_5=5;
    ERROR_KOM_6=6;
    // ��������
    ERROR_NAV_1=81;
    ERROR_NAV_2=82;
    ERROR_NAV_3=83;
    ERROR_NAV_4=84;
    ERROR_NAV_5=85;
    ERROR_NAV_6=86;
    // �������-��������
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

  FUNCTION_SYSTEM=50;       // �������, ����������� � �������� ����������������
    ZARJAD=1;               // ��������� �����
    SPUSK_PKT=2;            // �������� �����

    PLAY_BATTLE_NOISE=0;
    STOP_BATTLE_NOISE=1;

  MARK_MOVE=51;             //���������� �� ���� �������� ���������� ��� ����� ������� ��� ������
  //���������� ����������
  PLTFRM_STOP_DOWN=52;           //����������, ��������������� �����
  PLTFRM_STOP_MIDL=53;           //����������, ��������������� ����������
  PLTFRM_SENS=54;           //���������� ����������������
  PLTFRM_SCAL=55;           //���������� ����������
  PLTFRM_INER=56;           //���������� ����� ��� �������
  PLTFRM_V=57;              //���������� ����� ��������
  PLTFRM_NILL=58;           //�������� ����

  KOMANDA_CU=128;            // �� �� ��������� ���������, ������ ����- ������

  // ������ �������
  LVS_KOMAND=2;       //
  // ���������� �� �������
  LVS_SERVER_PTUR=200;
  LVS_SERVER1=1233;
  LVS_SERVER2=1234;
  LVS_SERVER3=1235;

  LVS_MATRIX=72;
  LVS_INDIKATOR=43;

  LVS_MODEL=864;     //*10 ��������� � ������

  LVS_ISX_DAN_TAK=1920;   // ��� ������ �������///>>>>>>>>>>
  LVS_ISX_DAN=2000;   // ��� ������///>>>>>>>>>>

  LVS_VSPY=32;        // C�������� � �������

const
  ISX_POL_BTR_Y_RAV=1670;    // �������� ��������� ��� �� Y
  ISX_POL_BTR_Y_GOR=1770;    // �������� ��������� ��� �� Y

  STOLB_BOTTOM_RAV=1780;      //     ���������� �� ������ ������ �����������
  STOLB_BOTTOM_GOR=1880;      //     ���������� �� ������ ������ �����������

  STOLB_SHIR=60;
  STOLB_LEFT_RAV=1800;         // ���������� �� ������ ����
  STOLB_DX1_RAV=1445;         //     ���������� �� 1 �� 2 �������
  STOLB_DX2_RAV=1525;         //     ���������� �� 2 �� 3 �������
  STOLB_LEFT_GOR=2930;         // ���������� �� ������ ����
  STOLB_DX1_GOR=980;         //     ���������� �� 1 �� 2 �������
  STOLB_DX2_GOR=980;         //     ���������� �� 2 �� 3 �������

  STOLB_DY_R=80;         //     ���������� �� ����� �� �������
  STOLB_DY_BL=6700;       //    ���������� �� ������� �� �������
  STOLB_DY_GRAN=14000;    //     ���������� �� ������� �� ������ ������� �������
  H_STOLB_GRAN=0.6;       //������ �������������� ������� � ������� �����������

  // ���������� ������������ �� �������� � ��
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
  function Name_Target_rus(Num: integer): string;// ��� ��������� � ������������

var
  BMP: array [0..COL_EKIP] of TBMP;
  Model: array[1..COL_TEXNIKA_MODEL] of TModel;/// ��������� ��� ��������///>>>>>>>>
  Task: TTask;
  dirBase: string;
  Orient: TOrient;
  // ���������� ���� ������
  otobr_RM: word;
  real_RM: word;
  Num_BMP: word;

  Povrejden: array[0..COL_EKIP] of word;

  Mestniks : array  of TList;
  Grand_Mestniks : TList;
  TypesOfOrient : TList;

  // ���������, ����������� ������� ��������
  stolbLeft: real;    // �������� ��������� ��� �� Y
  stolbDX1,
  stolbDX2: real;
  stolbBottom: real;
  begPositionY: real;
  Vychka_X: real;
  Vychka_Y: real;
  Vychka_H: real;

  Targets: array[1..3,1..COL_MAX_MICH] of TTargets;
  potok: array[0..64,1..6] of integer;    {������ ��� ���������� � �������}
  begO,endO: word;                           { �������� ��� ������������}
  Mode_off: word;

  Dym_V_X,Dym_V_Y,Dym_Vtek: real;

implementation

uses
main,UnBuildSetka;

procedure SetDimensionDirectris(season,region : integer);
begin
  posH:=posHvis-CountHeight(posX, posY);
  if (region=GORA) or (season=WINTER) then begin
    begPositionY:=ISX_POL_BTR_Y_GOR;// �������� ��������� ��� �� Y
    stolbBottom:=STOLB_BOTTOM_GOR; // ���������� �� ������ ������ �����������
    stolbLeft:=STOLB_LEFT_GOR;
    stolbDX1:=STOLB_DX1_GOR;
    stolbDX2:=STOLB_DX2_GOR;
  end
  else begin
    begPositionY:=ISX_POL_BTR_Y_RAV;    // �������� ��������� ��� �� Y
    stolbBottom:=STOLB_BOTTOM_RAV;      //     ���������� �� ������ ������ �����������
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
    if Task.m_index<6000 then begin //��������
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
     begin                     // ��������
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

 (**************������������� ***************)
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

{****************�������****************}

function SkorostK(v: real): real;
begin
  result:=v*10/3.6/TIK_SEK/MASHT_RIS_100;             // v/������� � ��/c /TIK_SEK/ �������
end;

function SkorostM(v: real): real;
begin
  result:=v*10/TIK_SEK/MASHT_RIS_100;             // v* ������� � ��/c /TIK_SEK/ �������
end;

function Uskoren(a: real): real;
begin
  result:=a*10/TIK_SEK/TIK_SEK/MASHT_RIS_100;             // a * ������� � ��/c/ TIK_SEK/�������
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
    M9A: result:='9�';
    M9C: result:='9�';
    M10: result:='10';
    M10A: result:='10a';
    M11: result:='11';
    M12: result:='12';
    M12A: result:='12a';
    M12B: result:='12�';
    M13: result:='13';
    M13A: result:='13a';
    M14: result:='14';
    M17: result:='17';
    M17A: result:='17a';
    M17B: result:='17�';
    M18: result:='18';
    M19: result:='19';
    M20: result:='20';
    M20A: result:='20a';
    M25: result:='25';
  end;
end;


end.
