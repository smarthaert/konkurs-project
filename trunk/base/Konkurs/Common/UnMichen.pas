unit UnMichen;

interface
uses
  UnOther, dglOpenGL, UnBuildBuilding, UnBuildObject,UnBuildTexture;

  // Мишенная обстановка
  procedure Draw_Mishen;
  procedure Build_Mishen;
  function  Name_Target(Num: integer): string;


implementation
var
  Rana: array[1..3,1..COL_MAX_MICH] of boolean;
  Rana25: array[1..3,1..COL_MAX_MICH] of boolean;
  Mont_Target: array[1..3,1..COL_MAX_MICH] of boolean;
  DeMont_Target: array[1..3,1..COL_MAX_MICH] of boolean;
  Oto: array[1..2,1..3,1..COL_MAX_MICH] of word;
  vspy: array[1..2,1..3,1..COL_MAX_MICH] of boolean;
  MIN_NUM_TARGET: array[1..COL_MAX_MICH] of  integer;


// Мишени
procedure Draw_Mishen;
var a,n: word;
begin
  if Task.m_index <5000 then begin
//    for n:=1 to 3 do
    n:=2;
    begin
      for a:=1 to COL_MAX_MICH do begin
        if targets[n,a].enableTarget then begin
          glPushMatrix;
            glTranslatef(targets[n,a].xTek, targets[n,a].hTek, -targets[n,a].yTek);
            glRotatef (targets[n,a].angleRotation, 1.0, 0.0, 0.0);
            if (rana[n,a]or rana25[n,a]) and (oto[1,n,a]<2) and(oto[2,n,a]<14) then begin
              inc(oto[1,n,a]); //Счётчик частоты миганий
              inc(oto[2,n,a]); //Счётчик миганий
            end
            else begin
              if (Task.Temp=NIGHT) then begin
                glCallList(MIN_NUM_TARGET[a]);
                if vspy[1,n,a] then begin
                  if ((Task.typeTarget[a] = M9) or
                      (Task.typeTarget[a] > M10a))then begin
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
                glCallList(MIN_NUM_TARGET[a]);
              end;
              oto[1,n,a]:=0;
            end;
          glPopMatrix;
        end;
      end;
    end;
  end;
end;

procedure Build_Mishen;
var
a: word;
begin
  for a:=1  to  Task.Col_targ do begin           // Мишени
    if Task.Ceson=WINTER then otherTexture:=5       // Вид накладываемой текстуры
                         else otherTexture:=0;
    if Task.Mestn=PUSTYN then otherTexture:=4
                         else otherTexture:=0;
    if Task.Color_Mask[a]>0 then otherTexture:=Task.Color_Mask[a];
    MontObject('res\Target\targ_'+Name_Target(Task.typeTarget[a]) +'.shp', MIN_NUM_TARGET[a]);
  end;
  otherTexture:=0;
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

end.
