unit UnOcenka;      //������������ ������ �� ����������� ��������

interface

uses
  Main, Graphics, UnOther, SysUtils,UnEdit;


type
  TOcenka=record                         // ��������� ������ �� ���
    Oc,Oc_alt: word;
    num_rana_PTUR,num_PTUR: array[1..COL_MAX_MICH] of word;
    col_rana_PTUR,col_PTUR: word;
    FirstShot: word;
    Nalichie:boolean;      // ������� �������
  end;

procedure Isx_Ocenka;
procedure Formir_Oc(num: integer);
procedure Ris_target(a,x,y,km,col: integer);

var
  Ocenka: array[1..3] of  TOcenka;

implementation

procedure Isx_Ocenka;
var a: word;
begin
  With Form1 do begin
    Image6.Canvas.Brush.Color:=clBlack;
    Image6.Canvas.Pen.Color:=clFuchsia;
    Image7.Canvas.Brush.Color:=clBlack;
    Image7.Canvas.Pen.Color:=clFuchsia;
    Image8.Canvas.Brush.Color:=clBlack;
    Image8.Canvas.Pen.Color:=clFuchsia;

    for a:=1 to 3 do begin
      Ocenka[a].Col_PTUR:=0;
      Ocenka[a].col_rana_PTUR:=0;
      Ocenka[a].FirstShot:=0;
      Povrejden[a]:=0;
    end;
    Edit23.Text:='';            //������
    Edit24.Text:='';
    Edit27.Text:='';
    Edit30.Text:='';
    Edit31.Text:='';
    Edit30.tag:=0;
    Edit31.tag:=0;
    Edit44.Text:='';
    Edit46.Text:='';
//  Edit47.Text:='';
    Edit45.Color:=$00ADFCDC;
 // Edit47.Color:=$00ADFCDC;
    Image6.Canvas.Pen.Color:=clBlack;   // ������� ������� � ��������
    Image6.Canvas.Rectangle(0,0,93,85);
    Image6.Canvas.Pen.Color:=clFuchsia;
    Image7.Canvas.Pen.Color:=clBlack;
    Image7.Canvas.Rectangle(0,0,93,85);
    Image7.Canvas.Pen.Color:=clFuchsia;
    Image8.Canvas.Pen.Color:=clBlack;
    Image8.Canvas.Rectangle(0,0,93,85);
    Image8.Canvas.Pen.Color:=clFuchsia;
  end;
end;

procedure Formir_Oc(num: integer);
var a,c,d:word;
e,f,k,l,m: boolean;
b: real;
begin
  if Task.m_index >5000 then exit;
  Ocenka[num].Oc:=2;
  case Task.m_index of
    ///��� 1,2
    1111,1112,1113,1121,1122,1123: begin
    end;
    ///��� 2
    1221,1222,1223:begin
    end;
    //���6  �������� ����������� �������
    1511,1512,1513:begin
      e:=false;// 2 ��������� �����
      k:=false;// 1 ��������� �����
      f:=false;// 1 ��������� ����������� �������
      m:=false;// 1 ��������� ���
      // �������� ��������� �����
      for a:=1 to Ocenka[num].col_PTUR do begin
        if (Task.Target[num,Ocenka[num].num_PTUR[a]].Num=M12)or
                 (Task.Target[num,Ocenka[num].num_PTUR[a]].Num=M12b) then f:=true;
      end;
      //=========== ������ 3 =============
      // �������� 2 ������ � �.�. ����
      if (k and f) or (f and m) or (k and m) then Ocenka[num].Oc:=3;
      //=========== ������ 4 =============
      // �������� ��� ������ ��� 2 ������ � �.�. ���� 2 ����������
      if (k and f and m) or (e and f) then Ocenka[num].Oc:=4;
      //=========== ������ 5 =============
      if e and f and m then Ocenka[num].Oc:=5;
      //=========== ����� ������� ������ =============
    end;
    ///��� 3  �������� ����������� �������
    1521,1522,1523:begin
      e:=false;// 2 ��������� �����
      k:=false;// 1 ��������� �����
      f:=false;// 1 ��������� ����������� �������
      l:=false;// 1 ��������� ���
      m:=false;// 1 ��������� ���
      for a:=1 to Ocenka[num].col_PTUR do begin
        if (Task.Target[num,Ocenka[num].num_PTUR[a]].Num=M12)or
                 (Task.Target[num,Ocenka[num].num_PTUR[a]].Num=M12b) then f:=true;
      end;
      //=========== ������ 3 =============
      // �������� 2 ������ � �.�. ����
      if (k and f) or (k and m) or (k and l) or
               (l and f) or (f and m) then Ocenka[num].Oc:=3;
      //=========== ������ 4 =============
      // �������� ��� ������ ��� 3 ������ � �.�. ���� ����� ����������
      if (k and f and m and l) or ((e and f and(l or m))) then Ocenka[num].Oc:=4;
      //=========== ������ 5 =============
      if e and f and m and l then Ocenka[num].Oc:=5;
      //=========== ����� ������� ������ =============
    end;
    else begin
      if Task.Col_targ<>0 then begin
        b:=(Ocenka[num].col_PTUR+Ocenka[num].col_rana_PTUR)/Task.Col_targ;
        if b>=0.5 then Ocenka[num].Oc:=3;
        if b>=0.75 then Ocenka[num].Oc:=4;
        if b>=0.9 then Ocenka[num].Oc:=5;
      end
      else begin
        Ocenka[num].Oc:=0;
      end;
    end;
  end;
  case num of
    1: Form1.Edit23.Text:=inttostr(Ocenka[num].Oc);
    2: Form1.Edit24.Text:=inttostr(Ocenka[num].Oc);
    3: Form1.Edit27.Text:=inttostr(Ocenka[num].Oc);
  end;
  // ��� ���������
  form1.Edit1.Text:=intToStr(Task.Bk.Col_Upr -  Boek[Num_BMP].Col_Upr);
end;

(******** ��������� ������ *******)
procedure Ris_target(a,x,y,km,col: integer);
//num_BMP_temp- ����� ���
//a- ��� ������
//�- ������� ����� ������ ���������
//y- ������� � Count_Target;
//km-  ������ �������� ������
//col- ����
var c: integer;
b,xr,yr: real;
col_tmp: TColor;
begin
  col_tmp:=clFuchsia;
  case col of
    1: col_tmp:=clFuchsia; // ���������
    2: col_tmp:=clGray;    // ����/�������
    3: col_tmp:=clBlue;    // �������
  end;
  b:= Rects[a].Right;
  xr:=b/km;
  x:=x-round(xr/2); //���������� ������� ���������
  b:= Rects[a].Bottom;
  yr:=b/km;
  y:=y-round(yr)-2; // c ������ �������� ������
  b:=Mich[a][1].x;
  xr:=(b/km);
  b:=Mich[a][1].y;
  yr:=(b/km);
  Mich[0][1].x:=round(xr)+x;
  Mich[0][1].y:=round(yr)+y;
  for c:=2 to COL_MAX_TCHK_MICH do begin
    b:=Mich[a][c].x;
    xr:=b/km;
    Mich[0][c].x:=Mich[0][c-1].x+round(xr);
    b:=Mich[a][c].y;
    yr:=b/km;
    Mich[0][c].y:=Mich[0][c-1].y+round(yr);
  end;
  With Form1 do begin
    if km=10 then begin
      Image2.Canvas.Polygon(Mich[0])
    end
    else case num_BMP_temp of
      1: begin
        Image6.Canvas.Pen.Color:=col_tmp;
        Image6.Canvas.Polygon(Mich[0]);
        Image6.Canvas.Pen.Color:=clFuchsia;
      end;
      2: begin
        Image7.Canvas.Pen.Color:=col_tmp;
        Image7.Canvas.Polygon(Mich[0]);
        Image7.Canvas.Pen.Color:=clFuchsia;
      end;
      3: begin
        Image8.Canvas.Pen.Color:=col_tmp;
        Image8.Canvas.Polygon(Mich[0]);
        Image8.Canvas.Pen.Color:=clFuchsia;
      end;
    end;
  end;
end;

end.
