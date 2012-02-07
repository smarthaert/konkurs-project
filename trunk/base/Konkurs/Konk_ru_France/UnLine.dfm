object FormLine: TFormLine
  Left = 167
  Top = 120
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Готовность танка'
  ClientHeight = 502
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 414
    Top = 8
    Width = 139
    Height = 170
    TabOrder = 3
    object Shape20: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape21: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape23: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape24: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape25: TShape
      Left = 6
      Top = 102
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape26: TShape
      Left = 6
      Top = 122
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape22: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object StaticText18: TStaticText
      Left = 18
      Top = 6
      Width = 119
      Height = 20
      Caption = 'Стабилизатор'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText19: TStaticText
      Left = 24
      Top = 26
      Width = 63
      Height = 17
      Caption = 'т. СУО (ПН)'
      TabOrder = 1
    end
    object StaticText21: TStaticText
      Left = 24
      Top = 46
      Width = 54
      Height = 17
      Caption = 'Руч.-Стаб.'
      TabOrder = 2
    end
    object StaticText23: TStaticText
      Left = 24
      Top = 108
      Width = 83
      Height = 17
      Caption = 'Гироскоп готов'
      TabOrder = 3
    end
    object StaticText24: TStaticText
      Left = 24
      Top = 87
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 4
    end
    object StaticText25: TStaticText
      Left = 24
      Top = 67
      Width = 93
      Height = 17
      Caption = 'Арретир расстоп.'
      TabOrder = 5
    end
    object StaticText26: TStaticText
      Left = 24
      Top = 128
      Width = 113
      Height = 17
      Caption = 'Испр. Стабилизатора'
      TabOrder = 6
    end
    object Edit1: TEdit
      Left = 106
      Top = 106
      Width = 31
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
  end
  object Panel12: TPanel
    Left = 529
    Top = 292
    Width = 165
    Height = 169
    TabOrder = 11
    Visible = False
    object Shape75: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape76: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape77: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape79: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape81: TShape
      Left = 6
      Top = 80
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape82: TShape
      Left = 6
      Top = 100
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText75: TStaticText
      Left = 20
      Top = 6
      Width = 113
      Height = 20
      Caption = 'Стабил.ТКН-4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText76: TStaticText
      Left = 20
      Top = 26
      Width = 86
      Height = 17
      Caption = 'т. Стабилизатор'
      TabOrder = 1
    end
    object StaticText77: TStaticText
      Left = 20
      Top = 62
      Width = 4
      Height = 4
      TabOrder = 2
    end
    object StaticText79: TStaticText
      Left = 20
      Top = 45
      Width = 37
      Height = 17
      Caption = 'т. Люк'
      TabOrder = 3
    end
    object StaticText80: TStaticText
      Left = 20
      Top = 64
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 4
    end
    object StaticText81: TStaticText
      Left = 20
      Top = 83
      Width = 76
      Height = 17
      Caption = '"А" ЗУ БПВ29'
      TabOrder = 5
    end
    object StaticText83: TStaticText
      Left = 20
      Top = 102
      Width = 83
      Height = 17
      Caption = 'Гироскоп готов'
      TabOrder = 6
    end
  end
  object Panel1: TPanel
    Left = 12
    Top = 8
    Width = 131
    Height = 170
    TabOrder = 0
    object Shape1: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape2: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape3: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape5: TShape
      Left = 6
      Top = 64
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape6: TShape
      Left = 6
      Top = 84
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape7: TShape
      Left = 6
      Top = 104
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText1: TStaticText
      Left = 24
      Top = 6
      Width = 91
      Height = 20
      Caption = 'Привод ГН'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText2: TStaticText
      Left = 24
      Top = 26
      Width = 63
      Height = 17
      Caption = 'т. СУО (ПН)'
      TabOrder = 1
    end
    object StaticText3: TStaticText
      Left = 24
      Top = 46
      Width = 75
      Height = 17
      Caption = 'Стопор башни'
      TabOrder = 2
    end
    object StaticText5: TStaticText
      Left = 24
      Top = 69
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 3
    end
    object StaticText6: TStaticText
      Left = 24
      Top = 90
      Width = 73
      Height = 17
      Caption = 'т. МПБ (ЩРЛ)'
      TabOrder = 4
    end
    object StaticText7: TStaticText
      Left = 24
      Top = 110
      Width = 88
      Height = 17
      Caption = 'Исправность ГН'
      TabOrder = 5
    end
  end
  object Panel2: TPanel
    Left = 146
    Top = 8
    Width = 131
    Height = 170
    TabOrder = 1
    object Shape8: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape9: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape10: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape12: TShape
      Left = 6
      Top = 64
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape13: TShape
      Left = 6
      Top = 84
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape14: TShape
      Left = 6
      Top = 104
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape15: TShape
      Left = 6
      Top = 124
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText8: TStaticText
      Left = 24
      Top = 6
      Width = 93
      Height = 20
      Caption = 'Привод ВН'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText9: TStaticText
      Left = 24
      Top = 26
      Width = 63
      Height = 17
      Caption = 'т. СУО (ПН)'
      TabOrder = 1
    end
    object StaticText10: TStaticText
      Left = 24
      Top = 46
      Width = 54
      Height = 17
      Caption = 'Руч.-Стаб.'
      TabOrder = 2
    end
    object StaticText12: TStaticText
      Left = 24
      Top = 69
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 3
    end
    object StaticText13: TStaticText
      Left = 24
      Top = 90
      Width = 67
      Height = 17
      Caption = 'т. УВ  (ЩРЛ)'
      TabOrder = 4
    end
    object StaticText14: TStaticText
      Left = 24
      Top = 110
      Width = 89
      Height = 17
      Caption = 'Исправность ВН'
      TabOrder = 5
    end
    object StaticText15: TStaticText
      Left = 24
      Top = 128
      Width = 83
      Height = 17
      Caption = 'Эл.маш. стопор'
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 280
    Top = 8
    Width = 131
    Height = 170
    TabOrder = 2
    object Shape16: TShape
      Left = 6
      Top = 40
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape17: TShape
      Left = 6
      Top = 60
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape18: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape19: TShape
      Left = 6
      Top = 80
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape58: TShape
      Left = 6
      Top = 100
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape74: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText16: TStaticText
      Left = 24
      Top = 6
      Width = 94
      Height = 20
      Caption = 'Дальномер'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText17: TStaticText
      Left = 24
      Top = 46
      Width = 96
      Height = 17
      Caption = 'т.Дальномер (ПН)'
      TabOrder = 1
    end
    object StaticText20: TStaticText
      Left = 24
      Top = 67
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 2
    end
    object StaticText22: TStaticText
      Left = 24
      Top = 86
      Width = 101
      Height = 17
      Caption = 'Испр. Дальномера'
      TabOrder = 3
    end
    object StaticText57: TStaticText
      Left = 16
      Top = 106
      Width = 112
      Height = 17
      Caption = 'Нет управления РМИ'
      TabOrder = 4
    end
    object StaticText74: TStaticText
      Left = 24
      Top = 26
      Width = 63
      Height = 17
      Caption = 'т. СУО (ПН)'
      TabOrder = 5
    end
  end
  object Panel5: TPanel
    Left = 356
    Top = 180
    Width = 165
    Height = 280
    TabOrder = 4
    object Shape27: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape29: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape31: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape32: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape33: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape34: TShape
      Left = 6
      Top = 102
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape35: TShape
      Left = 6
      Top = 122
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape72: TShape
      Left = 6
      Top = 142
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape73: TShape
      Left = 6
      Top = 162
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText27: TStaticText
      Left = 24
      Top = 6
      Width = 79
      Height = 20
      Caption = 'Готов АЗ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText28: TStaticText
      Left = 24
      Top = 26
      Width = 105
      Height = 17
      Caption = 'Пушка не заряжена'
      TabOrder = 1
    end
    object StaticText29: TStaticText
      Left = 24
      Top = 104
      Width = 100
      Height = 17
      Caption = ' Стопор конвейера'
      TabOrder = 2
    end
    object StaticText31: TStaticText
      Left = 24
      Top = 45
      Width = 83
      Height = 17
      Caption = 'т.Дв МЗ [ЩРП] '
      TabOrder = 3
    end
    object StaticText32: TStaticText
      Left = 24
      Top = 64
      Width = 64
      Height = 17
      Caption = 'т. Дв (ЩРП)'
      TabOrder = 4
    end
    object StaticText33: TStaticText
      Left = 24
      Top = 84
      Width = 73
      Height = 17
      Caption = 'т. т. МЗ   [ПH)'
      TabOrder = 5
    end
    object StaticText36: TStaticText
      Left = 24
      Top = 164
      Width = 95
      Height = 17
      Caption = 'Есть Тип снаряда'
      TabOrder = 6
    end
    object StaticText73: TStaticText
      Left = 24
      Top = 123
      Width = 98
      Height = 17
      Caption = 'т. Эл. Спуск (ЩРП)'
      TabOrder = 7
    end
    object StaticText60: TStaticText
      Left = 24
      Top = 144
      Width = 69
      Height = 17
      Caption = 'Клин закрыт'
      TabOrder = 8
    end
  end
  object Panel6: TPanel
    Left = 529
    Top = 180
    Width = 165
    Height = 109
    TabOrder = 5
    object Shape38: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape39: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape40: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape41: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape42: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText38: TStaticText
      Left = 24
      Top = 6
      Width = 94
      Height = 20
      Caption = 'Заряжание'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText46: TStaticText
      Left = 20
      Top = 26
      Width = 107
      Height = 17
      Caption = 'Процесс заряжания'
      TabOrder = 1
    end
    object StaticText47: TStaticText
      Left = 20
      Top = 86
      Width = 76
      Height = 17
      Caption = 'МЗ Пуск  (ПН)'
      TabOrder = 2
    end
    object StaticText48: TStaticText
      Left = 20
      Top = 66
      Width = 136
      Height = 17
      Caption = 'Пушка на угле заряжания'
      TabOrder = 3
    end
    object StaticText58: TStaticText
      Left = 20
      Top = 46
      Width = 110
      Height = 17
      Caption = 'Замок клина закрыт'
      TabOrder = 4
    end
  end
  object Panel7: TPanel
    Left = 556
    Top = 8
    Width = 139
    Height = 170
    TabOrder = 6
    object Shape37: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape43: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape44: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape45: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape46: TShape
      Left = 6
      Top = 102
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape48: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object StaticText37: TStaticText
      Left = 18
      Top = 6
      Width = 110
      Height = 20
      Caption = 'Вычислитель'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText39: TStaticText
      Left = 24
      Top = 26
      Width = 63
      Height = 17
      Caption = 'т. СУО (ПН)'
      TabOrder = 1
    end
    object StaticText40: TStaticText
      Left = 24
      Top = 46
      Width = 82
      Height = 17
      Caption = 'т. Вычислитель'
      TabOrder = 2
    end
    object StaticText42: TStaticText
      Left = 24
      Top = 86
      Width = 99
      Height = 17
      Caption = 'т. Преобраз.(ЩРЛ)'
      TabOrder = 3
    end
    object StaticText43: TStaticText
      Left = 24
      Top = 66
      Width = 75
      Height = 17
      Caption = 'Стопор башни'
      TabOrder = 4
    end
    object StaticText44: TStaticText
      Left = 24
      Top = 106
      Width = 103
      Height = 17
      Caption = 'Испр. Вычислителя'
      TabOrder = 5
    end
  end
  object Panel8: TPanel
    Left = 11
    Top = 180
    Width = 165
    Height = 280
    TabOrder = 7
    object Shape47: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape49: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape50: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape51: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape52: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape53: TShape
      Left = 6
      Top = 102
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape55: TShape
      Left = 6
      Top = 122
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape56: TShape
      Left = 6
      Top = 142
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape4: TShape
      Left = 6
      Top = 162
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText41: TStaticText
      Left = 24
      Top = 6
      Width = 89
      Height = 20
      Caption = 'Готов ПКТ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText45: TStaticText
      Left = 24
      Top = 26
      Width = 103
      Height = 17
      Caption = 'Не нажат ЭС пушки'
      TabOrder = 1
    end
    object StaticText49: TStaticText
      Left = 24
      Top = 126
      Width = 140
      Height = 17
      Caption = 'Соглас.с линией выстрела'
      TabOrder = 2
    end
    object StaticText50: TStaticText
      Left = 24
      Top = 66
      Width = 74
      Height = 17
      Caption = 'Есть патроны'
      TabOrder = 3
    end
    object StaticText51: TStaticText
      Left = 24
      Top = 86
      Width = 69
      Height = 17
      Caption = 'Нагнетатель'
      TabOrder = 4
    end
    object StaticText52: TStaticText
      Left = 24
      Top = 106
      Width = 98
      Height = 17
      Caption = 'т. Эл. Спуск (ЩРП)'
      TabOrder = 5
    end
    object StaticText54: TStaticText
      Left = 24
      Top = 46
      Width = 112
      Height = 17
      Caption = 'Нет управления РМИ'
      TabOrder = 6
    end
    object StaticText55: TStaticText
      Left = 26
      Top = 148
      Width = 77
      Height = 17
      Caption = 'т. ЦС (ТКН-4С)'
      TabOrder = 7
    end
    object StaticText4: TStaticText
      Left = 26
      Top = 166
      Width = 55
      Height = 17
      Caption = 'т. ЦС (ПН)'
      TabOrder = 8
    end
  end
  object Panel9: TPanel
    Left = 184
    Top = 180
    Width = 165
    Height = 280
    TabOrder = 8
    object Shape57: TShape
      Left = 6
      Top = 22
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape59: TShape
      Left = 6
      Top = 42
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape60: TShape
      Left = 4
      Top = 4
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape61: TShape
      Left = 6
      Top = 62
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape62: TShape
      Left = 6
      Top = 82
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape63: TShape
      Left = 6
      Top = 102
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape66: TShape
      Left = 6
      Top = 122
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape65: TShape
      Left = 6
      Top = 160
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object Shape11: TShape
      Left = 6
      Top = 140
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText56: TStaticText
      Left = 26
      Top = 6
      Width = 119
      Height = 20
      Caption = 'Готова  Пушка'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object StaticText59: TStaticText
      Left = 24
      Top = 28
      Width = 94
      Height = 17
      Caption = 'Не нажат ЭС ПКТ'
      TabOrder = 1
    end
    object StaticText61: TStaticText
      Left = 24
      Top = 68
      Width = 90
      Height = 17
      Caption = 'Пушка заряжена'
      TabOrder = 2
    end
    object StaticText62: TStaticText
      Left = 24
      Top = 88
      Width = 72
      Height = 17
      Caption = ' Нагнетатель'
      TabOrder = 3
    end
    object StaticText63: TStaticText
      Left = 24
      Top = 108
      Width = 98
      Height = 17
      Caption = 'т. Эл. Спуск (ЩРП)'
      TabOrder = 4
    end
    object StaticText65: TStaticText
      Left = 24
      Top = 48
      Width = 112
      Height = 17
      Caption = 'Нет управления РМИ'
      TabOrder = 5
    end
    object StaticText66: TStaticText
      Left = 24
      Top = 128
      Width = 77
      Height = 17
      Caption = 'т. ЦС (ТКН-4С)'
      TabOrder = 6
    end
    object StaticText11: TStaticText
      Left = 24
      Top = 146
      Width = 55
      Height = 17
      Caption = 'т. ЦС (ПН)'
      TabOrder = 7
    end
    object StaticText35: TStaticText
      Left = 22
      Top = 160
      Width = 110
      Height = 17
      Caption = 'Замок клина закрыт'
      TabOrder = 8
    end
  end
  object Panel10: TPanel
    Left = 262
    Top = 470
    Width = 185
    Height = 27
    TabOrder = 9
    object Shape69: TShape
      Left = 12
      Top = 2
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object StaticText69: TStaticText
      Left = 44
      Top = 3
      Width = 126
      Height = 20
      Caption = 'Режим "ДУБЛЬ"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel11: TPanel
    Left = 509
    Top = 470
    Width = 185
    Height = 27
    TabOrder = 10
    object Shape70: TShape
      Left = 6
      Top = 2
      Width = 8
      Height = 21
      Brush.Color = clRed
      Shape = stRoundRect
    end
    object Shape71: TShape
      Left = 98
      Top = 2
      Width = 8
      Height = 21
      Brush.Color = clLime
      Shape = stRoundRect
    end
    object StaticText70: TStaticText
      Left = 24
      Top = 4
      Width = 31
      Height = 17
      Caption = 'Выкл'
      TabOrder = 0
    end
    object StaticText71: TStaticText
      Left = 118
      Top = 4
      Width = 23
      Height = 17
      Caption = 'Вкл'
      TabOrder = 1
    end
  end
  object Panel13: TPanel
    Left = 12
    Top = 470
    Width = 185
    Height = 27
    TabOrder = 12
    object Shape83: TShape
      Left = 12
      Top = 2
      Width = 13
      Height = 21
      Brush.Color = clLime
      Shape = stCircle
    end
    object StaticText84: TStaticText
      Left = 44
      Top = 3
      Width = 87
      Height = 20
      Caption = 'Экипаж №'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 218
    Top = 470
  end
end
