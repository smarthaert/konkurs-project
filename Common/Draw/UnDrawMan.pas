unit UnDrawMan;

interface
uses
  dglOpenGL, UnBuildMan, Main, UnBuildSetka;

procedure DrawSoldiers;
procedure DrawMan(numSoldier, numAction, numFrame: word);
procedure MoveMan;

implementation

procedure DrawSoldiers;
var
a: word;
begin
  for a:=1 to MAX_COL_SOLDIER do begin
    if Soldier[a].enable then  begin
      DrawMan(a, Soldier[a].action, Soldier[a].frame);
    end;
  end;
  MoveMan;
end;


procedure DrawMan(numSoldier, numAction, numFrame: word);
begin
    //Центр (так как торс и руки крутятся вместе, теперь на него нельзя "вешать" все остальные
    //объекты (ноги, там, и т.д.), и я поместила в центр персонажа объект, который рисуется первый
    //и за счет которого происходит поворот всего персонажа вокруг оси
    glPushMatrix;
      //таз
      glTranslatef(Soldier[numSoldier].tekX, Soldier[numSoldier].tekH+0.1, -Soldier[numSoldier].tekY);
      glTranslatef(man.posTaz[numAction, numFrame].x,
                   man.posTaz[numAction, numFrame].y,
                   man.posTaz[numAction, numFrame].z);
      glRotatef(Soldier[numSoldier].rotateCenter, 0, 1, 0);
      glRotatef(man.rotTaz[numAction, numFrame].x, 1, 0, 0);
      glRotatef(man.rotTaz[numAction, numFrame].y, 0, 1, 0);
      glRotatef(man.rotTaz[numAction, numFrame].z, 0, 0, 1);
      glCallList(TAZ);
      glTranslatef(0,-0.014,-0.011);
      // Левая нога
      glPushMatrix;
        glTranslatef(0.008, -0.001, 0.011);
//          glTranslatef(man.posLegL1_x,man.posLegL1_y,man.posLegL1_z);
          glRotatef(man.rotLegL1[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotLegL1[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotLegL1[numAction, numFrame].z, 0, 0, 1);
          glCallList(LEG_L1);
          glTranslatef(0, -0.045, 0);
//          glTranslatef(man.posLegL2_x,man.posLegL2_y,man.posLegL2_z);
          glRotatef(man.rotLegL2[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotLegL2[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotLegL2[numAction, numFrame].z, 0, 0, 1);
          glCallList(LEG_L2);
          glTranslatef(0.001, -0.032, 0.007);
          glRotatef(5, 0,1,0);
//          glTranslatef(man.posFootL_x,man.posFootL_y,man.posFootL_z);
          glRotatef(man.rotFootL[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotFootL[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotFootL[numAction, numFrame].z, 0, 0, 1);
          glCallList(FOOT_L);
        glPopMatrix;
        // Правая нога
        glPushMatrix;
          glTranslatef(-0.008, -0.001, 0.011);
//          glTranslatef(man.posLegR1_x,man.posLegR1_y,man.posLegR1_z);
          glRotatef(man.rotLegR1[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotLegR1[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotLegR1[numAction, numFrame].z, 0, 0, 1);
          glCallList(LEG_R1);
          glTranslatef(0, -0.045, 0);
//          glTranslatef(man.posLegR2_x,man.posLegR2_y,man.posLegR2_z);
          glRotatef(man.rotLegR2[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotLegR2[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotLegR2[numAction, numFrame].z, 0, 0, 1);
          glCallList(LEG_R2);
          glTranslatef(-0.001, -0.032, 0.007);
          glRotatef(-5, 0,1,0);
//          glTranslatef(man.posFootR_x,man.posFootR_y,man.posFootR_z);
          glRotatef(man.rotFootR[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotFootR[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotFootR[numAction, numFrame].z, 0, 0, 1);
          glCallList(FOOT_R);
        glPopMatrix;
      //торс с руками
        glTranslatef(0, 0.0105, 0.012);
//        glTranslatef(man.posTors[numAction, numFrame].x,
//                     man.posTors[numAction, numFrame].y,
//                     man.posTors[numAction, numFrame].z);
        glRotatef(man.rotTors[numAction, numFrame].x, 1, 0, 0);
        glRotatef(man.rotTors[numAction, numFrame].y, 0, 1, 0);
        glRotatef(man.rotTors[numAction, numFrame].z, 0, 0, 1);
        glCallList(TORS);
        //Шея
        glPushMatrix;
          glTranslatef(0, 0.045, -0.002);
//          glTranslatef(man.posNeck_x,man.posNeck_y,man.posNeck_z);
          glRotatef(man.rotNeck[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotNeck[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotNeck[numAction, numFrame].z, 0, 0, 1);
          glCallList(NECK);
        //Голова
          glTranslatef(0, 0.006, 0.002);
//          glTranslatef(man.posHead_x,man.posHead_y,man.posHead_z);
          glRotatef(man.rotHead[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHead[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHead[numAction, numFrame].z, 0, 0, 1);
          glCallList(HEAD);
        glPopMatrix;
        //Левая рука
        glPushMatrix;
          glTranslatef(0.015, 0.042, -0.002);
//          glTranslatef(man.posHandL1_x,man.posHandL1_y,man.posHandL1_z);
          glRotatef(man.rotHandL1[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandL1[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandL1[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_L1);
          glTranslatef(0.006, -0.031, 0);
//          glTranslatef(man.posHandL2_x,man.posHandL2_y,man.posHandL2_z);
          glRotatef(man.rotHandL2[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandL2[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandL2[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_L2);
          glTranslatef(0.002, -0.028, -0.003);
//          glTranslatef(man.posHandL3_x,man.posHandL3_y,man.posHandL3_z);
          glRotatef(man.rotHandL3[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandL3[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandL3[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_L3);
        glPopMatrix;
        //Правая рука
        glPushMatrix;
          glTranslatef(-0.015, 0.042, -0.002);
//          glTranslatef(man.posHandR1_x,man.posHandR1_y,man.posHandR1_z);
          glRotatef(man.rotHandR1[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandR1[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandR1[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_R1);
          glTranslatef(-0.006, -0.031, 0);
//          glTranslatef(man.posHandR2_x,man.posHandR2_y,man.posHandR2_z);
          glRotatef(man.rotHandR2[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandR2[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandR2[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_R2);
          glTranslatef(-0.002, -0.028, -0.003);
//          glTranslatef(man.posHandR3_x,man.posHandR3_y,man.posHandR3_z);
          glRotatef(man.rotHandR3[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotHandR3[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotHandR3[numAction, numFrame].z, 0, 0, 1);
          glCallList(HAND_R3);
          //Ружье
          glTranslatef(0, -0.007, 0);

          glTranslatef(man.posGun[numAction, numFrame].x,
                       man.posGun[numAction, numFrame].y,
                       man.posGun[numAction, numFrame].z);
          glRotatef(man.rotGun[numAction, numFrame].x, 1, 0, 0);
          glRotatef(man.rotGun[numAction, numFrame].y, 0, 1, 0);
          glRotatef(man.rotGun[numAction, numFrame].z, 0, 0, 1);
          glCallList(GUN);
        glPopMatrix;
      glPopMatrix;
end;

procedure MoveMan;
var
  a: word;
begin
  for a:=1 to MAX_COL_SOLDIER do begin
    if Soldier[a].enable then  begin
      //Перемещение
      if Soldier[a].action=2 then Soldier[a].tekY:=Soldier[a].tekY-0.0113;
      // Возвращаем назад
      if Soldier[a].tekY<0.5 then Soldier[a].tekY:=20;
      // Высота земли
      Soldier[a].tekH:=CountHeight(Soldier[a].tekX, Soldier[a].tekY);
      //следующий кадр в Action
      inc(Soldier[a].frame);
      // Кадры кончились, меняем действие
      if Soldier[a].frame>AnimaMan.colFrame[Soldier[a].action] then begin
        Soldier[a].frame:=1;
        inc(Soldier[a].action);
        // Действия кончились возвращаемся к бегу
        if Soldier[a].action>9 then Soldier[a].action:=2;
      end;
    end;
  end;
end;

end.

2 бег
3 падение (убит)
4 --> стрельба с колена
5 стрельба с колена
6 стрельба с колена -->
7 --> стрельба лёжа
8 стрельба лёжа
9 стрельба лёжа -->

