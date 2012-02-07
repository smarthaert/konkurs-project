unit UnNadpis;   // ���������� �������� �� ������ ��������

interface
  procedure Zapolnen_Nadp;

implementation

uses Main,Graphics;

procedure Zapolnen_Nadp;
var a: word;
begin
  for a:=0 to COL_MAX_NADPIS do begin
    case a of
      1: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=32;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=2;           // ����� ������������
        Nadpis.Pos_X[1,a]:=390;
        Nadpis.Pos_Y[1,a]:=390;
        Nadpis.Arr_string[1,a]:='  ������  ';
      end;
      2: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������� �� ��������� ��������� � ������ (����) ';
      end;
      3: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������� �� ��������� ��������� � ������ (�����) ';
      end;
      4: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������� �� ������� ��������� � �������� (����) ';
      end;
      5: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������� �� ������� ��������� � �������� (�����) ';
      end;
      6: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=18;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=100;
        Nadpis.Pos_Y[1,a]:=470;
        Nadpis.Arr_string[1,a]:=' ���������� ��� ������ ���������� �������� � �������� ���������';
      end;

      18: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=220;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ��������� ����� ������� ��� - 60 ���. ';
      end;
      19: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=320;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������ ��������� -90 ���. ';
      end;
      21: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // ������ ������
        Nadpis.Col_str[a]:=2;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=320;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ������! �������� ';
        Nadpis.Arr_string[2,a]:=' ������! �������� '; // ���������� ������
      end;
      61: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ���� ��������� ��� ��������� ��� '; // ���������� ������
      end;
      62: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ���� ��������� ��� �������� ����� < 2 ��/��.��. '; // ���������� ������
      end;
      63: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ������ ��� �������� �� ����� ��������� '; // ���������� ������
      end;
      64: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ���� ��������� ��������� ��� ������� ��. ��� ����. '; // ���������� ������
      end;
      65: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ������ �������� ��� ����� ��������� > 8 ���. '; // ���������� ������
      end;
      66: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // ������ ������
        Nadpis.Col_str[a]:=1;     // ���������� �����
        Nadpis.Time[a]:=5;           // ����� ������������
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ������!  �������-�������� ';
        Nadpis.Arr_string[2,a]:='             ��������� ���������� ��� t>90 ����. '; // ���������� ������
      end;
    end;
  end;
end;


end.
