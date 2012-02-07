// Модуль чтения, хранения и записи общих параметров
unit uParams;

interface

uses IniFiles, SysUtils, Logging, UnGeom;

const
  // Разновидности тренажеров
  KT_72M1 = 0;   // Комплексный тренажер 72-ки М1 с ТПН   (как для кенийцев)
  KT_72B  = 1;   // Комплексный тренажер 72-ки Б  с 1К-13(управляемый снаряд) (как для казахов)
  KT_BMP2 = 2;   // Комплексный тренажер БМП-2
  KT_55   = 3;   // Комплексный тренажер T-55   (c ТПН)
  KT_55AM = 4;   // Комплексный тренажер T-55AM (c 1K13 и балличстическим вычислителем)
  TMV_72  = 10;
  TMV_2   = 11;

  // Части тренажера
  APP_SERVER = 0;   // Сервер
  APP_INSTR  = 1;   // Руководитель
  APP_VIEWER = 2;   // Вьювер

  // Язык интерефейса
  LANG_RUS = 0;     // Русский
  LANG_ENG = 1;     // Английский
  LANG_FR  = 2;     // Французский

var
  g_SimType   : Byte;
  g_AppType   : Byte;
  g_Language  : Byte;

  g_ExePath     : String;  // Путь к exe-файлу
  g_IpBroadcast : String;  // Широковещательный IP
  g_IpBroadcastInst : String;  // IP instructor
  g_LocalPort_BO   : Integer;
  g_RemotePort_BO  : Integer;
  g_LocalPort_MV   : Integer;
  g_RemotePort_MV  : Integer;
  g_CheckSumBO  : Boolean;
  g_DriveName   : String;
  g_TimerUpdate : Integer;  // таймер

  g_MapLengthX  : Single;  // Размеры карты (в метрах)
  g_MapLengthY  : Single;

  g_ServerTankGabaritLf  : Single;  // смещение габаритов танка от центра
  g_ServerTankGabaritLb  : Single;  // смещение габаритов танка от центра
  g_ServerTankGabaritW   : Single;  // смещение габаритов танка от центра
  g_IsTurretInert        : boolean; // Учитывать инерционность башни или нет
  g_IsUderjan            : boolean; // Есть ли механизм удержания

  g_FOtdacha             : Single;
  g_TOtdacha             : Byte;
  g_DrawAZU              : Boolean;

  g_GroundAskStart : boolean;
  g_GroundAskExePath  : String;

  g_DefTaskIndex   : word;     // Вождение: 61 - PU, 62 - UU, 63 - ZU, 64 - KU
  g_DefTaskSeason  : byte;     // 1 - Лето, 2 - Зима
  g_DefTaskCountry : byte;     // 1 - равнина, 2 - горы, 3 - болота, 4 - пустыня

  g_PlatfType_MV   : Integer;   // Тип платформы
  g_PlatfType_BO   : Integer;   // 3 - 3-х степенная, 6 - 6-ти степенная

  CountViewPoints : Byte;
  ViewPoints : array of Vektor; //локальныен координаты водителя

// Чтение общих параметров
procedure ReadAppParams;
// Запись изменяемых параметров
procedure WriteAppParams;

implementation

var
  IniFileName : string;

procedure ReadAppParams;
var
  Ini : TIniFile;
  I   : Integer;
begin
  g_ExePath    := ExtractFilePath(ParamStr(0));
  g_DriveName  := ExtractFileDrive(ParamStr(0));
  IniFileName := ChangeFileExt(ParamStr(0), '.ini');
  Ini := TIniFile.Create(IniFileName);
  try
    g_SimType     := Ini.ReadInteger('MAIN', 'SIM_TYPE', 0);
    g_AppType     := Ini.ReadInteger('MAIN', 'APP_TYPE', 0);
    g_Language    := Ini.ReadInteger('MAIN', 'LANGUAGE', 0);
    g_IpBroadcast := Ini.ReadString('NETWORK', 'IP_BROADCAST', '192.168.0.255');
    g_IpBroadcastInst := Ini.ReadString('NETWORK', 'IP_BROADCAST_INST', '192.168.0.1');
    g_TimerUpdate := Ini.ReadInteger('MAIN', 'UPDATE_TIMER', 55);

    case g_AppType of
      APP_SERVER :
      begin
        g_LocalPort_BO  := Ini.ReadInteger('NETWORK', 'LOCAL_PORT_BO', 6701);
        g_RemotePort_BO := Ini.ReadInteger('NETWORK', 'REMOTE_PORT_BO', 6702);
        g_LocalPort_MV  := Ini.ReadInteger('NETWORK', 'LOCAL_PORT_MV', 6704);
        g_RemotePort_MV := Ini.ReadInteger('NETWORK', 'REMOTE_PORT_MV', 6705);
        g_CheckSumBO    := Ini.ReadBool('NETWORK', 'CHECK_SUM_BO', False);
        g_DrawAZU       := Ini.ReadBool('MAIN', 'IS_DRAW_AZU', False);

        g_ServerTankGabaritLf  := Ini.ReadFloat('TANK', 'GABARIT_LF', 0); // смещение габаритов
        g_ServerTankGabaritLb  := Ini.ReadFloat('TANK', 'GABARIT_LB', 0);  // смещение габаритов
        g_ServerTankGabaritW   := Ini.ReadFloat('TANK',  'GABARIT_W', 0);  // смещение габаритов
        g_IsTurretInert        := Ini.ReadBool('TANK', 'IS_TURRET_INERT', False);
        g_IsUderjan            := Ini.ReadBool('TANK', 'IS_UDERJAN', False);

        g_FOtdacha             := Ini.ReadFloat('TANK', 'F_OTDACHA', 400000);
        g_TOtdacha             := Ini.ReadInteger('TANK', 'T_OTDACHA', 4);

        g_MapLengthX  := Ini.ReadFloat('MAP', 'LENGTH_X', 1000);
        g_MapLengthY  := Ini.ReadFloat('MAP', 'LENGTH_Y', 1000);
        g_GroundAskStart   := Ini.ReadBool('GROUND_ASK', 'START', False);
        g_GroundAskExePath := Ini.ReadString('GROUND_ASK', 'EXE_PATH', '');

        g_DefTaskIndex   := Ini.ReadInteger('MAP', 'DEF_TASK_INDEX',   6101);
        g_DefTaskSeason  := Ini.ReadInteger('MAP', 'DEF_TASK_SEASON',  1);
        g_DefTaskCountry := Ini.ReadInteger('MAP', 'DEF_TASK_COUNTRY', 1);

        CountViewPoints := Ini.ReadInteger('SIT_PLACE', 'COUNT_VP', 1);
        SetLength(ViewPoints, CountViewPoints);
        for I := 0 to CountViewPoints - 1 do
        begin
          ViewPoints[I].X    := Ini.ReadFloat('SIT_PLACE', 'X'+IntToStr(I), 0);
          ViewPoints[I].Y    := Ini.ReadFloat('SIT_PLACE', 'Y'+IntToStr(I), 0);
          ViewPoints[I].H    := Ini.ReadFloat('SIT_PLACE', 'H'+IntToStr(I), 0);
        end;

        g_PlatfType_MV   := Ini.ReadInteger('SIM_CONFIG','PLATF_TYPE_MV', 3);
        g_PlatfType_BO   := Ini.ReadInteger('SIM_CONFIG','PLATF_TYPE_BO', 3);
      end;
    end;
  except
    LogMsg('Ошибка чтения файла ' + Ini.FileName);
    Ini.Free;
    raise;
  end;
  Ini.Free;
end;

procedure WriteAppParams;
{var
  Ini: TIniFile;}
begin
{  Ini := TIniFile.Create(IniFileName);
  try
    // Тут будут параметры которые могут изменяться в процессе работы программы
  except
    LogMsg('Ошибка записи в файл ' + Ini.FileName);
    Ini.Free;
    raise;
  end;
  Ini.Free; }
  ViewPoints := NIL;
end;

end.
