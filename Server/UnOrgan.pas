unit UnOrgan;

interface
  uses Windows, Main, Dialogs,  SysUtils,  Math, Graphics, UnOther,
   UnBuildServer,UnLVS,UnMatrix,UnMissile,Unsound;


  procedure Init_var;
  procedure Init_Org;
  procedure Isx_Pol_Org;
  procedure Obrabotka_Org_Tik;
  procedure Obrabotka_Org_Sek;
  procedure Otrabotka_LVS(n: integer);
  procedure InitMissile;
  procedure StartMissile;
  procedure EndMissile;
  procedure CountNavedenPTUR;
  procedure CheckSostPTUR;
  procedure Read_Qu(FileName: string; num: word);
  procedure Load_Quadr_Task;
  procedure PuskPTUR;
  function Line_PTUR: boolean;
  procedure Count_scene;
  procedure TikSound;


var
  dAngle,
  dUm : real;       // Поворот сцены по азимуту и скорость поворота
  D_PTUR:            word;     // Текущая дальность ПТУР
  V_PTUR:        real;                   // скорость ПТУР на вылете
  T_Tr_PTUR: real;             // Дальность показа тркектории ПТУР

  Povor_PTUR: word;
  Az_To_PTUR,Um_To_PTUR: real;
  Az_PTUR_old, Um_PTUR_old: cardinal;
  Az_PTUR, Um_PTUR: real;

  UmPricel_old:word;
  UM_PU:word=32000;
  H_PRICEL:real=0.00125;
  KOEFF_NAVED_UM:real=160;
  H_Targ: array[1..COL_TEXNIKA_MODEL] of real;  //Размеры квадрата в который необходимо попасть
  X_Targ: array[1..COL_TEXNIKA_MODEL] of real;
  TikSoundExplos: word;

implementation
uses UnGeom;

{************Инициализация переменных*************}
procedure Init_var;
var a: word;
begin
  // ПТУР
  V_PTUR:=220; //  Cкорость ПТУР м/c
  T_Tr_PTUR:=20; // Время показа тркектории ПТУР
  T_Tr_PTUR:=T_Tr_PTUR*18;
  V_PTUR:=SkorostM(V_PTUR);
  BMP[Num_BMP].Kratn_Pric:=1;
  BMP[Num_BMP].lum:=true;
  BMP[Num_BMP].pereklSpuskiKrBU25:=true;
  real_RM:=RM_SERVER;
end;


procedure Init_Org;
begin
  // Установка органов управления в нулевое положение (вкл)
  Isx_Pol_Matrix;
  Isx_Pol_Azimut;
  InitMissile;
  BMP[Num_BMP].Kn_Ptur:=True;
  BMP[Num_BMP].Gotov_PTUR:=true;
  BMP[Num_BMP].time_Gotov_PTUR:=5;
end;


procedure Obrabotka_Org_Tik;
begin
  Read_Discret_Card;
  TikSound;
end;

procedure Obrabotka_Org_Sek;
begin
  if BMP[Num_BMP].time_Gotov_PTUR>0 then begin
    dec(BMP[Num_BMP].time_Gotov_PTUR);
    if BMP[Num_BMP].time_Gotov_PTUR=0 then BMP[Num_BMP].Gotov_PTUR:=true;
  end;
  if BMP[Num_BMP].Gotov_PTUR then form1.Label1.Color:=clGreen else form1.Label1.Color:=clRed;
   //ввод неисправностей
  Missile.otkaz[CAT]        :=  not BMP[Num_BMP].Ispravn_PTUR_Fill;
  Missile.otkaz[IR_GAUGE]   :=  not BMP[Num_BMP].Ispravn_PTUR_Optik;
  Missile.otkaz[IR_HANDICAP]:=  not BMP[Num_BMP].Ispravn_PTUR_Pomexa;
  Missile.otkaz[STARTER]    :=  not BMP[Num_BMP].Ispravn_PTUR_Start;
  Missile.otkaz[ENGINE]     :=  not BMP[Num_BMP].Ispravn_PTUR_Marsh;

end;

procedure Otrabotka_LVS(n: integer);
begin
end;

procedure InitMissile;
var
  tempX,TempT : Vektor;
  az: real;
begin
  TempT:=NulV;
  az:=BMP[Num_BMP].AzBase;
  TempT.H:=Pi/2-az/57.3;
  TempX.X:=(BMP[Num_BMP].Xtek+0.8*sin(az/57.3))*10;
  TempX.Y:=(BMP[Num_BMP].Ytek+0.8*cos(az/57.3))*10;
  TempX.H:=(BMP[Num_BMP].Htek+H_PRICEL)*10;
  Missile:=TMissile.Init(TempX,TempT);
end;

procedure StartMissile;
var
  tempX,TempT : Vektor;
  Az: real;
begin
    TempT:=NulV;
    az:=BMP[Num_BMP].AzBase;
    TempT.H:=Pi/2-az/57.3;
    TempX.X:=(BMP[Num_BMP].Xtek+0.8*sin(az/57.3))*10;
    TempX.Y:=(BMP[Num_BMP].Ytek+0.8*cos(az/57.3))*10;
    TempX.H:=(BMP[Num_BMP].Htek+H_PRICEL)*10;
    Missile.InitPosition(TempX,TempT);
    Missile.Pusk;
end;

procedure EndMissile;
begin
  Missile.Mode:=0;
  BMP[Num_BMP].Start_PTUR:=false;
end;

procedure CountNavedenPTUR;
begin
  inc(BMP[Num_BMP].dalnCiklePTUR);
  // Расчёт Х У Н трассы
  Missile.Chanals[1].Vizir:=XYZ_Bash.Theard;
  Missile.Chanals[2].Vizir.Y:=0;
  Missile.Chanals[2].Vizir.X:=sin(BMP[Num_BMP].UmPricel/57.3);
  Missile.Chanals[2].Vizir.H:=cos(BMP[Num_BMP].UmPricel/57.3);
  Missile.Chanals[2].Vizir:=Loc2Glob(Missile.Chanals[2].Vizir,XYZ_Bash);
  Missile.PU.X:=BMP[num_BMP].View_Points[1].X*10;
  Missile.PU.Y:=BMP[num_BMP].View_Points[1].Y*10;
  Missile.PU.H:=BMP[num_BMP].View_Points[1].H*10;
  if Missile.Mode>0 then begin
    Missile.Move(0.055);
    BMP[Num_BMP].X_PTUR:=Missile.X.X/10;
    BMP[Num_BMP].Y_PTUR:=-Missile.X.Y/10;
    BMP[Num_BMP].H_PTUR:=Missile.X.H/10;
    BMP[Num_BMP].Tang_H:=Missile.Tang.H*57.3;
  end;
end;

procedure CheckSostPTUR;
begin
  BMP[Num_BMP].Mode:=Missile.Mode;
  if (BMP[Num_BMP].Start_PTUR) then  begin
     // Трасса дошла до конца по времени
    if BMP[Num_BMP].dalnCiklePTUR>T_Tr_PTUR then begin
      BMP[Num_BMP].Start_PTUR:=false;
      EndMissile;
    end
    else begin
      case BMP[Num_BMP].Mode of
        // Встреча с землёй
        5: begin
          BMP[Num_BMP].Start_PTUR:=false;
          EndMissile;
          BMP[Num_BMP].podryvPTUR:=PODRYV_PTUR_TERRAN;
          NewRec.Vol[3]:=-BMP[Num_BMP].dalnCiklePTUR*4;
          TikSoundExplos:=BMP[Num_BMP].dalnCiklePTUR div 4;
        end;
        // Встреча с мишенью
        6: begin
          BMP[Num_BMP].Start_PTUR:=false;
          EndMissile;
          BMP[Num_BMP].podryvPTUR:=PODRYV_PTUR_MISHEN;
          Poraj[Num_BMP,Missile.Num_destroy]:=true;
          BMP[Num_BMP].Num_destroy:=Missile.Num_destroy;
          NewRec.Vol[3]:=-BMP[Num_BMP].dalnCiklePTUR*4;
          TikSoundExplos:=BMP[Num_BMP].dalnCiklePTUR div 4;
          LVS.Trans_Kom;
        end;
        // Встреча с препятствием
        7:begin
          BMP[Num_BMP].Start_PTUR:=false;
          EndMissile;
          BMP[Num_BMP].podryvPTUR:=PODRYV_PTUR_MISHEN;
          BMP[Num_BMP].Num_destroy:=Missile.Num_destroy;
          NewRec.Vol[3]:=-BMP[Num_BMP].dalnCiklePTUR*4;
          TikSoundExplos:=BMP[Num_BMP].dalnCiklePTUR div 4;
          LVS.Trans_Kom;
        end;
        else begin
          CountNavedenPTUR;
        end;
      end;
    end;
  end;
end;

procedure Load_Quadr_Task;
var a: word;
begin
  if Task.m_index <5000 then for a:=1 to Task.Col_targ do begin
      // квадрат в который надо попасть
     Read_Qu('Res\Target\QuTg_'+Name_Target(Task.typeTarget[a]) +'.shp',a);
  end;
end;

(********Чтение длины и ширины мишени для попадания*********)
procedure Read_Qu(FileName: string; num: word);
var
  F: TextFile;
  S: String;
begin
  S:=dirBase+FileName;
  AssignFile(F,S);  {Связывание файла с именем}
  Reset(F);
  ReadLn(F, S);
  X_Targ[num]:=strtofloat(copy(S,1,Pos(' ',s)-1));
  X_Targ[num]:=X_Targ[num]/MASHT_RIS_100;
  delete(S,1,Pos(' ',s));
  H_Targ[num]:=strtofloat(copy(S,1,Pos(' ',s)-1));
  H_Targ[num]:=H_Targ[num]/MASHT_RIS_100;
  CloseFile(F);
end;

procedure PuskPTUR;
var a: word;
    tempX,TempT : Vektor;
    az: real;
begin
  if Line_PTUR then  begin
    dec(Boek[Num_BMP].Col_UPR);
    BMP[Num_BMP].Col_UPR:=Boek[Num_BMP].Col_UPR;
    TempT:=NulV;
    BMP[Num_BMP].Start_PTUR:=true;
    BMP[Num_BMP].Gotov_PTUR:=false;
    BMP[Num_BMP].time_Gotov_PTUR:=3;
    NewRec.Play[0]:=true;
    BMP[Num_BMP].dalnCiklePTUR:=0;
    StartMissile;
  end;
end;

function Line_PTUR: boolean;
begin
  if  BMP[Num_BMP].Gotov_PTUR and                           // Птур был заряжен
      BMP[Num_BMP].NalichiePTUR and                         // Наличие ПТУР
         (Boek[Num_BMP].Col_UPR>0) then Line_PTUR:=true     // Есть ПТУР
                                   else Line_PTUR:=false;
end;

procedure Count_scene;
var tempV : Vektor;
    i : byte;
begin
  Obrabotka_Org_Tik;
  Sound_Form.PlayRec;
  XYZ_Bash.Normal.X:=0;
  XYZ_Bash.Normal.Y:=0;
  XYZ_Bash.Normal.H:=1;
  XYZ_Bash.VForward.X:=0;
  XYZ_Bash.VForward.Y:=1;
  XYZ_Bash.VForward.H:=0;
  XYZ_Bash.Theard.X:=-1;
  XYZ_Bash.Theard.Y:=0;
  XYZ_Bash.Theard.H:=0;
  RotateXYZ((-BMP[num_BMP].AzPricel)/57.3,3,XYZ_Bash);
  for i:=1 to 1 do  begin
    TempV:=Loc2Glob(VIEW_POINTS_INIT[i],XYZ_Bash);
    BMP[num_BMP].View_Points[i].X:=BMP[num_BMP].Xtek+TempV.X/10;
    BMP[num_BMP].View_Points[i].Y:=BMP[num_BMP].Ytek+TempV.Y/10;
    BMP[num_BMP].View_Points[i].H:=BMP[num_BMP].Htek+TempV.H/10;
  end;
  if Missile<>nil then CheckSostPTUR;
end;

procedure Isx_Pol_Org;
begin
  Isx_Pol_Azimut;
end;

procedure TikSound;
begin
  if TikSoundExplos>0 then begin
    dec(TikSoundExplos);
    if TikSoundExplos=0 then begin
      NewRec.Play[3]:=true;
    end;
  end;
end;
end.



