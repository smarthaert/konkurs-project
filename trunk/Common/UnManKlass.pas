unit UnManKlass;

interface

uses UnBuildSurface,UnAnimation;

const
MAX_COL_SOLDIER=30;

type

  TMan = class (TObject)
    tekX       : real;
    tekY       : real;
    tekH       : real;

    rotTors: TVector;

    rotTaz_x: real;
    rotTaz_y: real;
    rotTaz_z: real;

    rotHandR1_x: real;
    rotHandR1_y: real;
    rotHandR1_z: real;

    rotHandR2_x: real;
    rotHandR2_y: real;
    rotHandR2_z: real;

    rotHandR3_x: real;
    rotHandR3_y: real;
    rotHandR3_z: real;

    rotHandL1_x: real;
    rotHandL1_y: real;
    rotHandL1_z: real;

    rotHandL2_x: real;
    rotHandL2_y: real;
    rotHandL2_z: real;

    rotHandL3_x: real;
    rotHandL3_y: real;
    rotHandL3_z: real;

    rotLegR1_x: real;
    rotLegR1_y: real;
    rotLegR1_z: real;

    rotLegR2_x: real;
    rotLegR2_y: real;
    rotLegR2_z: real;

    rotLegL1_x: real;
    rotLegL1_y: real;
    rotLegL1_z: real;

    rotLegL2_x: real;
    rotLegL2_y: real;
    rotLegL2_z: real;

    rotFootR_x : real;
    rotFootR_y : real;
    rotFootR_z : real;

    rotFootL_x : real;
    rotFootL_y : real;
    rotFootL_z : real;

    rotNeck_x : real;
    rotNeck_y : real;
    rotNeck_z : real;

    rotHead_x : real;
    rotHead_y : real;
    rotHead_z : real;

    //Gun
    rotGun_x : real;
    rotGun_y : real;
    rotGun_z : real;

    posTors_x: real;
    posTors_y: real;
    posTors_z: real;

    posTaz_x: real;
    posTaz_y: real;
    posTaz_z: real;

    posHandR1_x: real;
    posHandR1_y: real;
    posHandR1_z: real;

    posHandR2_x: real;
    posHandR2_y: real;
    posHandR2_z: real;

    posHandR3_x: real;
    posHandR3_y: real;
    posHandR3_z: real;

    posHandL1_x: real;
    posHandL1_y: real;
    posHandL1_z: real;

    posHandL2_x: real;
    posHandL2_y: real;
    posHandL2_z: real;

    posHandL3_x: real;
    posHandL3_y: real;
    posHandL3_z: real;

    posLegR1_x: real;
    posLegR1_y: real;
    posLegR1_z: real;

    posLegR2_x: real;
    posLegR2_y: real;
    posLegR2_z: real;

    posLegL1_x: real;
    posLegL1_y: real;
    posLegL1_z: real;

    posLegL2_x: real;
    posLegL2_y: real;
    posLegL2_z: real;

    posFootR_x : real;
    posFootR_y : real;
    posFootR_z : real;

    posFootL_x : real;
    posFootL_y : real;
    posFootL_z : real;

    posNeck_x : real;
    posNeck_y : real;
    posNeck_z : real;

    posHead_x : real;
    posHead_y : real;
    posHead_z : real;

    //Gun
    posGun_x : real;
    posGun_y : real;
    posGun_z : real;
    rotateCenter: real;

    //Конец нового

    rotateTorsMain : real;
    rotateHeadMain : real;



  constructor Init(X,Y : real);
  destructor EndMan;
  procedure Move;

public
  procedure Init_position(X,Y : real);
end;

var
//  Man: array[1..MAX_COL_SOLDIER] of TMan;
  Man:  TMan;

implementation

uses
  UnOther;

constructor TMan.Init(X,Y: real);
begin
  Create;
  Init_position(X,Y);
end;

procedure TMan.Init_position(X,Y: real);
begin
  tekX:=X;
  tekY:=Y;
  tekH:=Surface.CountHeight(tekX,tekY);
end;

// Расчёт движения человека
procedure TMan.Move;
begin
  PlayAnimation;
end;

destructor TMan.EndMan;
begin
  Free;
end;


end.

