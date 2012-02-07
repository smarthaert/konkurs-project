unit UnBuildSetka;

interface
uses
  Dialogs, SysUtils, Classes, UnOther, UnGeom;

type
  TOrientSurf= record
    typ   :word;
    patch :word;
    x     :real;
    y     :real;
    h     :real;
    az    :real;
  end;
  TRegular = array[0..Round(0.5*100),0..Round(0.5*100)] of real;
  PTRegular = ^TRegular;
  dopy  = record
           NetType : byte;      //тип сетки 0 - регулякная
           regular : PTRegular;
           HBase   : real;
           HDelta  : real;
           BaseX   : integer;
           BaseY   : integer;
           irregular : TList;
          end;
  Pdopy = ^dopy;
var
    colTrianglX: word;  // Количество в патче треугольников по Х
    colTrianglY: word;  // Количество в патче треугольников по Y
    colTrianglXSecondLevel: word;  // Количество в патче второго уровня треугольников по Х
    colTrianglYSecondLevel: word;  // Количество в патче второго уровня треугольников по Y
    lenghtTrianglX: real; // Длина треугольников по X
    lenghtTrianglY: real; // Длина треугольников по Y
    lenghtDopTriX: real=0.01; //шаг дополнительной координатной сетки
    lenghtDopTriY: real=0.01; //шаг дополнительной координатной сетки
    lenghtSurfaceX: real;
    lenghtSurfaceY: real;
    //массив вершин сетки высоты
    coy : array of array of array of real;
    //массив вершин дополнительной сетки высоты
    coydop : array of array of Pdopy;
    // Массив наклонов местности на каждом квадрате
    kren_mestn:  array of array of array of real;
    Um_mestn:  array of array of array of real;
    //Предметы на поверхности
    orient_Koord: array of array of array of real; //массив координат местн.предм.
    orient_Type:  array of array of word; ////массив типов местн.предм.
    orient_Col: array of word; //Количество местн.предм. на патче
    orientFileLittle: array[0..200] of TOrientSurf;
    colOrieLittle: word;
    // Границы перемещения по поверхности
    borderLeft:  real;     // Левая граница
    borderRight: real;     // Правая граница
    borderTop:   real;     // Дальняя граница
    borderBottom:real;     // Ближняя граница
    colPatchX: word;
    colPatchY: word;
    lenghtPatchX: real;
    lenghtPatchY: real;
    colPatchSurface: word;
    levelTexture: word;    // Количество уровней текстур

  procedure LoadPatch(fileName: string; num: integer);
  procedure BuildDopSetka(fileName: string);
  function CountHeight(tekX, tekY: real):real;
  function CountHeightMetr(tekX, tekY: real):real;
  function CountPatch(tekX, tekY: real):integer;
  procedure SetSizePatch(index : integer);
  procedure CountKrenTangage(num: integer);
  procedure BuildSetka(fileName: string);
  function CountHeightModel(tekX, tekY: real; var num,index_X,index_Y: integer):real;
  procedure FinalizeCoydop;

implementation

procedure BuildSetka(fileName: string);
var
  x, y, lvl, num: integer;
begin
  BuildDopSetka(fileName);
  // Cоздание основных сеток высот
  for y:=1 to colPatchY do begin
    for x:=1 to colPatchX do begin
      // Номер создаваемого патча
      num:=(x+(y-1)*colPatchX);
      // Загрузка сеток высот
      LoadPatch(dirBase+fileName+inttostr(num)+'.shp',num);
      CountKrenTangage(num);
    end;
  end;
end;

procedure BuildDopSetka(fileName: string);
var
  a, b, i, j: word;
  i1, j1: word;
  s, s1: string;
  f_pole,f_dop: TextFile;
  wc : Char;
  hbase: real;
  net : byte;
  hDelta : real;
  X_col: word;      // Количество треугольников по Х
  Y_col: word;      // Количество треугольников по Y
  a1, a2, b1, b2 : integer;
  flo:real;
  Perim_point : PKoord;
begin
  s:=dirBase+fileName;
  // Создание новых дополнительных сеток высот
  if FileExists(s+'pole.shp') then begin
      AssignFile(f_pole,s+'pole.shp');
      Reset(f_pole);
      for a:=0 to colPatchY*(colTrianglY-1)-1 do  begin
        for b:=0 to colPatchX*(colTrianglX-1)-1 do  begin
          read(f_pole,wc);
          // проверяем наличие дополнительных сеток на патче
          if ((wc<>'0') and (wc<>' ')) then  begin
            // Считываем дополнительную сетку высот
            if not FileExists(s+'_'+wc+'.shp') then begin
              MessageDlg('Нет файла '+s+'_'+wc+'.shp', mtInformation,[mbOk], 0);
            end
            else begin
              AssignFile(f_dop,s+'_'+wc+'.shp');
              Reset(f_dop);
              readln(f_dop,hbase);
              readln(f_dop,s1);
              CloseFile(f_dop);
              AssignFile(f_dop,dirBase+'res\setka\'+s1+'.shp');
              Reset(f_dop);
              readln(f_dop,s1);
              readln(f_dop,net);
              if net=0 then readln(f_dop,s1) else readln(f_dop,hDelta);
              readln(f_dop,X_col);
              readln(f_dop,Y_col);
              b1:=Round(Y_col/lenghtTrianglY/100);
              b2:=Round(X_col/lenghtTrianglX/100);
              a1:=Round(lenghtTrianglY*100);
              a2:=Round(lenghtTrianglX*100);
              for i:=0 to b1-1 do begin
                for j:=0 to b2-1 do begin
                  if net=0 then begin
                    New(coydop[b+j,a+i]);
                    coydop[b+j,a+i].NetType:=net;
                    New(coydop[b+j,a+i].regular);
                    coydop[b+j,a+i].irregular:=nil;
                  end
                  else begin
                    New(coydop[b+j,a+i]);
                    coydop[b+j,a+i].NetType:=net;
                    coydop[b+j,a+i].BaseX:=b;
                    coydop[b+j,a+i].BaseY:=a;
                    if ((i=0) and (j=0)) then begin
                      coydop[b+j,a+i].irregular:=TList.Create;
                      coydop[b+j,a+i].regular:=nil;
                    end;
                  end;
                end;
              end;
              if net=0 then begin
                for i:=0 to b1-1 do begin
                  for i1:=0 to a1 do begin
                    for j:=0 to b2-1 do begin
                      for j1:=0 to a2 do begin
                        if ((j1=0) and (j<>0)) then begin
                          coydop[b+j,a+i]^.regular[j1,i1]:=coydop[b+j-1,a+i]^.regular[a2,i1]
                        end
                        else begin
                          if ((i1=0) and (i<>0)) then begin
                            coydop[b+j,a+i]^.regular[j1,i1]:=coydop[b+j,a+i-1]^.regular[j1,a1]
                          end
                          else begin
                            ReadLn(f_dop,flo);
                            coydop[b+j,a+i]^.regular[j1,i1]:=flo+hbase;// значения высот
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end
              else begin
                if net=1 then begin
                  for i:=0 to 3 do begin
                    New(Perim_point);
                    Read(f_dop,Perim_point^.X);
                    Readln(f_dop,Perim_point^.Y);
                    coydop[b,a]^.irregular.Add(Perim_point);
                  end;
                end;
                coydop[b,a]^.HBase:=hbase;
                coydop[b,a]^.HDelta:=hDelta;
              end;
              CloseFile(f_dop);
            end;
          end;
        end;
        readln(f_pole);
      end;
      CloseFile(f_pole);
  end;
end;

procedure LoadPatch(fileName: string; num: integer);
var
  f: textfile;
  s: string;
  i,j,p: integer;
begin
  if not FileExists(fileName) then begin
    MessageDlg('Нет файла '+fileName, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(f,fileName);//Связь файла с файловой переменной
  Reset(f);              //Открытие файла
  ReadLn(f,s);           //  имя текстуры
  ReadLn(f,s);           // Читается длина по X
  ReadLn(f,s);           // Читается длина по Z
  ReadLn(f,s);           // Читается число разбиений по X
  ReadLn(f,s);           // Читается число разбиений по Z
  for i:=0 to colTrianglY do begin
    for j:=0 to colTrianglX do begin
      ReadLn(f,s);
      Val(s, coy[num][j][i], p);
     end;
  end;
  // Чтение координат местн.предм.
  if not EOF(f) then begin
    ReadLn(f,s); // 'Ориентиры'
    Read(f,Orient_Col[num]); // количество
    for i:=1 to Orient_Col[num] do begin
      Read(f,Orient_Koord[num][i][1]);
      Read(f,Orient_Koord[num][i][2]);
      Read(f,Orient_Type[num][i]); //
    end;
  end else Orient_Col[num]:=0;
  CloseFile(f);
end;

function CountHeight(tekX, tekY: real):real;
var
  delta_x,delta_y: real;
  a,b,index_X,index_Y,num: integer;
  i, j: integer;
  h1,h2,h3,h4,wh,LocX,LocY, dLX, dLY : real;
  HRec : Pdopy;
begin
  if tekX<0 then tekX:=0;
  if tekX>lenghtSurfaceX then tekX:=lenghtSurfaceX-0.5;
  if tekY<0 then tekY:=0;
  if tekY>lenghtSurfaceY then tekY:=lenghtSurfaceY-0.5;

  i:=Trunc(tekX/lenghtTrianglX);
  j:=Trunc(tekY/lenghtTrianglY);
  if coydop[i,j]<>nil then  begin
    HRec:=coydop[i,j];
    if HRec^.NetType=0 then begin  //регулярная сетка
      a:=Trunc((tekX-i*lenghtTrianglX)*10);// ?????
      b:=Trunc((tekY-j*lenghtTrianglY)*10);
      h1:=HRec^.regular[a+1,b];
      h2:=HRec^.regular[a+1,b+1];
      h3:=HRec^.regular[a,b+1];
      h4:=HRec^.regular[a,b];
      dLX:=lenghtDopTriX;
      dLY:=lenghtDopTriY;
    end;
    if HRec^.NetType=1 then begin  //четырехугольная прямая призма
      dLX:=0;
      dLY:=0;
      HRec:=coydop[HRec^.BaseX,HRec^.BaseY];
      delta_x:=tekX-HRec^.BaseX*lenghtTrianglX;
      delta_y:=tekY-HRec^.BaseY*lenghtTrianglY;
      h1:=HRec^.HBase;
      if PointInRect(delta_x,delta_y,HRec^.irregular) then h1:=h1+HRec^.HDelta;
    end;
    if HRec^.NetType=2 then begin  //конус
      dLX:=0;
      dLY:=0;
      HRec:=coydop[HRec^.BaseX,HRec^.BaseY];
      delta_x:=tekX-(HRec^.BaseX+0.5)*lenghtTrianglX;
      delta_y:=tekY-(HRec^.BaseY+0.5)*lenghtTrianglY;
      delta_x:=Sqrt(delta_x*delta_x+delta_y*delta_y);
      h1:=HRec^.HBase;
      if delta_x<HRec^.HDelta then
      h1:=h1-HRec^.HDelta+delta_x;
    end;
  end
  else begin
    i:=Trunc(tekX/lenghtPatchX);
    j:=Trunc(tekY/lenghtPatchY);
    num:=j*colPatchX+i+1;
    delta_x:=tekX-(lenghtPatchX*i);  // Определение отступа от начала патча по X
    delta_y:=tekY-(lenghtPatchY*j);  // Определение отступа от начала патча по Y
    index_X:=Trunc(delta_x/lenghtTrianglX);  // Определение номера прямоугольника
    index_Y:=Trunc(delta_y/lenghtTrianglY);
    h1:=coy[num][index_X+1][index_Y];
    h2:=coy[num][index_X+1][index_Y+1];
    h3:=coy[num][index_X][index_Y+1];
    h4:=coy[num][index_X][index_Y];
    dLX:=lenghtTrianglX;
    dLY:=lenghtTrianglY;
  end;
  if dLX=0 then begin
    wh:=h1;
  end
  else  begin
    LocX:=tekX-dLX*Trunc(tekX/dLX);
    LocY:=tekY-dLY*Trunc(tekY/dLY);
    if LocX>=LocY then wh:=h4+(LocX*(h1-h4)+LocY*(h2-h1))/dLX
                  else wh:=h4+(LocX*(h2-h3)+LocY*(h3-h4))/dLY;
  end;
  CountHeight:=wh;
end;

function CountHeightMetr(tekX, tekY: real):real;
begin
  tekX:=tekX/10;
  tekY:=tekY/10;
  result:=CountHeight(tekX, tekY)*10;
end;

function CountPatch(tekX, tekY: real):integer;
var
  a,b: integer;
begin
  if tekX<0 then CountPatch:=-1
       else if tekX>lenghtSurfaceX then CountPatch:=-1
                else if tekY<0 then CountPatch:=-1
                       else  if tekY>lenghtSurfaceY then CountPatch:=-1;
  a:=trunc(tekX/lenghtPatchX);
  b:=trunc(tekY/lenghtPatchY);
  CountPatch:=b*colPatchX+a+1;
end;

// Установка размеров поверхности
procedure SetSizePatch(index : integer);
var
d:real;
begin
  colTrianglX:=40;
  colTrianglXSecondLevel:=colTrianglX div 2;
  colTrianglY:=40;
  colTrianglYSecondLevel:=colTrianglY div 2;
  lenghtTrianglX:=0.5;
  lenghtTrianglY:=0.5;
  // Длина плоскости по Х
  lenghtPatchX:=colTrianglX*lenghtTrianglX;
  // Длина плоскости по Y
  lenghtPatchY:=colTrianglY*lenghtTrianglY;
  d:=100;
  case index of
    // Стрельбовое поле
    0..4999:begin
      // Количество патчей по Х и Y
      colPatchX:=4;
      colPatchY:=20;
      // Количество уровней текстур
      levelTexture:=3;
      d:=100;
    end;
    // Тактика
    5000..5999:begin
      // Количество патчей по Х и Y
      colPatchX:=4;
//      colPatchX:=6;
      colPatchY:=20;
      // Количество уровней текстур
      levelTexture:=3;
//    levelTexture:=2;
      d:=100;
    end;
    // Вождение
    6000..6999:begin
      // Количество патчей по Х и Y
      colPatchX:=10;
      colPatchY:=10;
      // Количество уровней текстур
      levelTexture:=1;
      d:=0;
    end;
  end;
  // Размеры поверхности
  colPatchSurface:=colPatchX*colPatchY;
  lenghtSurfaceX:=lenghtPatchX*colPatchX;
  lenghtSurfaceY:=lenghtPatchY*colPatchY;
  // Границы движения по поверхности
  borderLeft:=5;
  borderRight:=lenghtSurfaceX-5;
  if d=0 then borderTop:=lenghtSurfaceX-5 else borderTop:=100;
  borderBottom:=5;
end;

procedure CountKrenTangage(num: integer);
var
  i,j: integer;
begin
  for i:=0 to colTrianglY-1 do begin
    for j:=0 to colTrianglX-1 do begin
      um_mestn[num][j][i]:=(arctan((coy[num][j][i+1]-coy[num][j][i])/lenghtTrianglX))*57.3;
      kren_mestn[num][j][i]:=(arctan((coy[num][j+1][i]-coy[num][j][i])/lenghtTrianglX))*57.3;
    end;
    um_mestn[num][colTrianglX][i]:=um_mestn[num][colTrianglX-1][i];
    kren_mestn[num][colTrianglX][i]:=kren_mestn[num][colTrianglX-1][i];
  end;
  um_mestn[num][colTrianglX][colTrianglY]:=um_mestn[num][colTrianglX-1][colTrianglY-1];
  kren_mestn[num][colTrianglX][colTrianglY]:=kren_mestn[num][colTrianglX-1][colTrianglY-1];
end;

function CountHeightModel(tekX, tekY: real; var num,index_X,index_Y: integer):real;
var
  delta_x,delta_y: real;
  a,b: integer;
  i, j: integer;
  h1,h2,h3,h4,wh,LocX,LocY, dLX, dLY : real;
  HRec : Pdopy;
begin
  if tekX<0 then tekX:=0;
  if tekX>lenghtSurfaceX then tekX:=lenghtSurfaceX-0.5;
  if tekY<0 then tekY:=0;
  if tekY>lenghtSurfaceY then tekY:=lenghtSurfaceY-0.5;

  i:=Trunc(tekX/lenghtPatchX);
  j:=Trunc(tekY/lenghtPatchY);
  num:=j*colPatchX+i+1;
  delta_x:=tekX-(lenghtPatchX*i);  // Определение отступа от начала патча по X
  delta_y:=tekY-(lenghtPatchY*j);  // Определение отступа от начала патча по Y
  index_X:=Trunc(delta_x/lenghtTrianglX);  // Определение номера прямоугольника
  index_Y:=Trunc(delta_y/lenghtTrianglY);
  h1:=coy[num][index_X+1][index_Y];
  h2:=coy[num][index_X+1][index_Y+1];
  h3:=coy[num][index_X][index_Y+1];
  h4:=coy[num][index_X][index_Y];
  dLX:=lenghtTrianglX;
  dLY:=lenghtTrianglY;
  LocX:=tekX-dLX*Trunc(tekX/dLX);
  LocY:=tekY-dLY*Trunc(tekY/dLY);
  if LocX>=LocY then wh:=h4+(LocX*(h1-h4)+LocY*(h2-h1))/dLX
                else wh:=h4+(LocX*(h2-h3)+LocY*(h3-h4))/dLY;

  result:=wh;
end;

procedure FinalizeCoydop;
var
  a, b, i: word;
begin
  // Стирание старых дополнительных сеток высот
  for a:=0 to colPatchY*(colTrianglY-1)-1 do begin
    for b:=0 to colPatchX*(colTrianglX-1)-1 do begin
      if coydop[b,a]<>nil then  begin
        if coydop[b,a]^.regular<>nil then Dispose(coydop[b,a].regular);
        if coydop[b,a]^.irregular<>nil then  begin
          for i:=0 to coydop[b,a]^.irregular.Count-1 do Dispose(coydop[b,a]^.irregular.Items[i]);
          coydop[b,a]^.irregular.Free;
        end;
        Dispose(coydop[b,a]);
      end;
    end;
  end;
  coydop:=nil;
end;

end.



