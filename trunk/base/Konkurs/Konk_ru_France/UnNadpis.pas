unit UnNadpis;   // Заполнение надписей на экране монитора

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
        Nadpis.Size[a]:=32;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=2;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=390;
        Nadpis.Pos_Y[1,a]:=390;
        Nadpis.Arr_string[1,a]:='  Ошибка  ';
      end;
      2: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Перевод из походного положения в боевое (днем) ';
      end;
      3: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Перевод из походного положения в боевое (ночью) ';
      end;
      4: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Перевод из боевого положения в походное (днем) ';
      end;
      5: begin
        Nadpis.Color[a]:=clBlue;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=150;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Перевод из боевого положения в походное (ночью) ';
      end;
      6: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=18;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=100;
        Nadpis.Pos_Y[1,a]:=470;
        Nadpis.Arr_string[1,a]:=' Переведите все органы управления тренажёра в исходное состояние';
      end;

      18: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=220;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Заряжание новой коробки ПКТ - 60 сек. ';
      end;
      19: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=320;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' Ручное заряжание -90 сек. ';
      end;
      21: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=24;       // Размер шрифта
        Nadpis.Col_str[a]:=2;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=320;
        Nadpis.Pos_Y[1,a]:=370;
        Nadpis.Arr_string[1,a]:=' ОШИБКА! Командир ';
        Nadpis.Arr_string[2,a]:=' ОШИБКА! Командир '; // Содержание ошибки
      end;
      61: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Пуск двигателя без включения МЗН '; // Содержание ошибки
      end;
      62: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Пуск двигателя при давлении масла < 2 кг/см.кв. '; // Содержание ошибки
      end;
      63: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Кнопка ЭПК отпущена до пуска двигателя '; // Содержание ошибки
      end;
      64: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Пуск двигателя стартером при нажатой кн. МЗН ДВИГ. '; // Содержание ошибки
      end;
      65: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Работа стартера при пуске двигателя > 8 сек. '; // Содержание ошибки
      end;
      66: begin
        Nadpis.Color[a]:=clRed;
        Nadpis.Size[a]:=14;       // Размер шрифта
        Nadpis.Col_str[a]:=1;     // количество строк
        Nadpis.Time[a]:=5;           // Время демонстрации
        Nadpis.Pos_X[1,a]:=5;
        Nadpis.Pos_Y[1,a]:=564;
        Nadpis.Arr_string[1,a]:=' ОШИБКА!  Механик-водитель ';
        Nadpis.Arr_string[2,a]:='             Остановка двигкателя при t>90 град. '; // Содержание ошибки
      end;
    end;
  end;
end;


end.
