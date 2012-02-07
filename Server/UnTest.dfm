object Test: TTest
  Left = 1
  Top = 1
  Width = 1022
  Height = 766
  Cursor = -1
  Caption = 'Тест'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 121
    Top = 173
    Width = 786
    Height = 384
    Cursor = -1
    TabOrder = 0
    object Label001: TLabel
      Left = 10
      Top = 7
      Width = 737
      Height = 13
      Cursor = -1
      Caption = 
        '------------------------------------------------Состояние  орган' +
        'ов  управления рабочего места наводчика-------------------------' +
        '---------------------'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox013: TGroupBox
      Left = 542
      Top = 190
      Width = 124
      Height = 75
      Cursor = -1
      Caption = 'Пульт 902'
      TabOrder = 0
      object Shape044: TShape
        Left = 8
        Top = 42
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape045: TShape
        Left = 8
        Top = 57
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape046: TShape
        Left = 53
        Top = 42
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape047: TShape
        Left = 53
        Top = 57
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText065: TStaticText
        Left = 66
        Top = 39
        Width = 10
        Height = 17
        Cursor = -1
        Caption = '3'
        TabOrder = 0
      end
      object StaticText063: TStaticText
        Left = 22
        Top = 54
        Width = 10
        Height = 17
        Cursor = -1
        Caption = '2'
        TabOrder = 1
      end
      object StaticText062: TStaticText
        Left = 21
        Top = 39
        Width = 10
        Height = 17
        Cursor = -1
        Caption = '1'
        TabOrder = 2
      end
      object StaticText066: TStaticText
        Left = 66
        Top = 54
        Width = 29
        Height = 17
        Cursor = -1
        Caption = 'Пуск'
        TabOrder = 3
      end
      object Edit020: TEdit
        Left = 8
        Top = 15
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 4
      end
      object StaticText064: TStaticText
        Left = 46
        Top = 18
        Width = 69
        Height = 17
        Cursor = -1
        Caption = 'Перекл. 0...4'
        TabOrder = 5
      end
    end
    object GroupBox014: TGroupBox
      Left = 674
      Top = 28
      Width = 93
      Height = 224
      Cursor = -1
      Caption = 'ПН'
      TabOrder = 1
      object Shape048: TShape
        Left = 10
        Top = 119
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape049: TShape
        Left = 10
        Top = 100
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape050: TShape
        Left = 10
        Top = 138
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape051: TShape
        Left = 10
        Top = 43
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape052: TShape
        Left = 10
        Top = 24
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape053: TShape
        Left = 10
        Top = 62
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape054: TShape
        Left = 10
        Top = 81
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText067: TStaticText
        Left = 23
        Top = 116
        Width = 66
        Height = 17
        Cursor = -1
        Caption = 'Д.Проверка'
        TabOrder = 0
      end
      object StaticText068: TStaticText
        Left = 23
        Top = 97
        Width = 55
        Height = 17
        Cursor = -1
        Caption = 'Д. Работа'
        TabOrder = 1
      end
      object StaticText069: TStaticText
        Left = 23
        Top = 135
        Width = 28
        Height = 17
        Cursor = -1
        Caption = 'Сход'
        TabOrder = 2
      end
      object StaticText070: TStaticText
        Left = 23
        Top = 40
        Width = 31
        Height = 17
        Cursor = -1
        Caption = 'т. МЗ'
        TabOrder = 3
      end
      object StaticText071: TStaticText
        Left = 23
        Top = 21
        Width = 30
        Height = 17
        Cursor = -1
        Caption = 'т. ЦС'
        TabOrder = 4
      end
      object StaticText072: TStaticText
        Left = 23
        Top = 59
        Width = 27
        Height = 17
        Cursor = -1
        Caption = 'СУО'
        TabOrder = 5
      end
      object StaticText073: TStaticText
        Left = 23
        Top = 78
        Width = 45
        Height = 17
        Cursor = -1
        Caption = 'Вычисл.'
        TabOrder = 6
      end
    end
    object GroupBox004: TGroupBox
      Left = 150
      Top = 28
      Width = 124
      Height = 224
      Cursor = -1
      Caption = 'ТПН'
      TabOrder = 2
      object Shape018: TShape
        Left = 22
        Top = 182
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape056: TShape
        Left = 22
        Top = 201
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape058: TShape
        Left = 22
        Top = 158
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape057: TShape
        Left = 22
        Top = 142
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Edit003: TEdit
        Left = 10
        Top = 15
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit004: TEdit
        Left = 10
        Top = 37
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit005: TEdit
        Left = 10
        Top = 59
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 2
      end
      object StaticText018: TStaticText
        Left = 41
        Top = 197
        Width = 64
        Height = 17
        Cursor = -1
        Caption = 'Диафрагма'
        TabOrder = 3
      end
      object StaticText020: TStaticText
        Left = 48
        Top = 18
        Width = 49
        Height = 17
        Cursor = -1
        Caption = 'В-П-П1-А'
        TabOrder = 4
      end
      object StaticText021: TStaticText
        Left = 48
        Top = 40
        Width = 58
        Height = 17
        Cursor = -1
        Caption = 'Выверка Г'
        TabOrder = 5
      end
      object StaticText022: TStaticText
        Left = 48
        Top = 62
        Width = 59
        Height = 17
        Cursor = -1
        Caption = 'Выверка В'
        TabOrder = 6
      end
      object StaticText025: TStaticText
        Left = 41
        Top = 180
        Width = 54
        Height = 17
        Cursor = -1
        Caption = 'Налобник'
        TabOrder = 7
      end
      object Edit007: TEdit
        Left = 10
        Top = 87
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 8
      end
      object StaticText024: TStaticText
        Left = 48
        Top = 90
        Width = 47
        Height = 17
        Cursor = -1
        Caption = 'Яркость'
        TabOrder = 9
      end
      object StaticText026: TStaticText
        Left = 48
        Top = 111
        Width = 64
        Height = 17
        Cursor = -1
        Caption = 'Баллистика'
        TabOrder = 10
      end
      object Edit024: TEdit
        Left = 10
        Top = 109
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 11
      end
      object StaticText28: TStaticText
        Left = 41
        Top = 140
        Width = 70
        Height = 17
        Cursor = -1
        Caption = 'Уменьшение'
        TabOrder = 12
      end
      object StaticText6: TStaticText
        Left = 41
        Top = 156
        Width = 65
        Height = 17
        Cursor = -1
        Caption = 'Увеличение'
        TabOrder = 13
      end
    end
    object GroupBox002: TGroupBox
      Left = 19
      Top = 258
      Width = 124
      Height = 115
      Cursor = -1
      Caption = 'МПП'
      TabOrder = 3
      object Shape014: TShape
        Left = 8
        Top = 79
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText014: TStaticText
        Left = 21
        Top = 77
        Width = 93
        Height = 17
        Cursor = -1
        Caption = 'Электроспуск ор.'
        TabOrder = 0
      end
      object StaticText015: TStaticText
        Left = 21
        Top = 19
        Width = 79
        Height = 17
        Cursor = -1
        Caption = 'Подъем пушки'
        TabOrder = 1
      end
      object Edit025: TEdit
        Left = 45
        Top = 40
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object GroupBox012: TGroupBox
      Left = 542
      Top = 28
      Width = 124
      Height = 159
      Cursor = -1
      Caption = 'ПУ188'
      TabOrder = 4
      object Shape039: TShape
        Left = 8
        Top = 94
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape040: TShape
        Left = 8
        Top = 109
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape041: TShape
        Left = 8
        Top = 124
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape042: TShape
        Left = 8
        Top = 139
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText38: TStaticText
        Left = 20
        Top = 121
        Width = 53
        Height = 17
        Cursor = -1
        Caption = 'Измер. Д'
        TabOrder = 0
      end
      object StaticText059: TStaticText
        Left = 22
        Top = 106
        Width = 45
        Height = 17
        Cursor = -1
        Caption = 'Эс. ПКТ'
        TabOrder = 1
      end
      object StaticText058: TStaticText
        Left = 21
        Top = 91
        Width = 38
        Height = 17
        Cursor = -1
        Caption = 'Эс. ор.'
        TabOrder = 2
      end
      object StaticText060: TStaticText
        Left = 21
        Top = 136
        Width = 47
        Height = 17
        Cursor = -1
        Caption = 'Сброс Д'
        TabOrder = 3
      end
      object Edit018: TEdit
        Left = 8
        Top = 17
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 4
      end
      object StaticText056: TStaticText
        Left = 46
        Top = 20
        Width = 17
        Height = 17
        Cursor = -1
        Caption = 'Ux'
        TabOrder = 5
      end
      object Edit019: TEdit
        Left = 8
        Top = 39
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 6
      end
      object StaticText057: TStaticText
        Left = 46
        Top = 42
        Width = 17
        Height = 17
        Cursor = -1
        Caption = 'Uy'
        TabOrder = 7
      end
      object StaticText061: TStaticText
        Left = 46
        Top = 63
        Width = 64
        Height = 17
        Cursor = -1
        Caption = 'Баллистика'
        TabOrder = 8
      end
      object Edit023: TEdit
        Left = 8
        Top = 61
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 9
      end
    end
    object GroupBox007: TGroupBox
      Left = 279
      Top = 28
      Width = 256
      Height = 224
      Cursor = -1
      Caption = '1Г46'
      TabOrder = 5
      object Shape032: TShape
        Left = 140
        Top = 132
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape033: TShape
        Left = 140
        Top = 147
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape026: TShape
        Left = 8
        Top = 162
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape025: TShape
        Left = 8
        Top = 147
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape024: TShape
        Left = 8
        Top = 132
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape055: TShape
        Left = 140
        Top = 162
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Edit008: TEdit
        Left = 8
        Top = 17
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit009: TEdit
        Left = 8
        Top = 39
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 1
      end
      object Edit010: TEdit
        Left = 8
        Top = 61
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 2
      end
      object Edit011: TEdit
        Left = 8
        Top = 83
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 3
      end
      object StaticText031: TStaticText
        Left = 46
        Top = 20
        Width = 76
        Height = 17
        Cursor = -1
        Caption = 'Выверка Г (Д)'
        TabOrder = 4
      end
      object StaticText032: TStaticText
        Left = 46
        Top = 42
        Width = 77
        Height = 17
        Cursor = -1
        Caption = 'Выверка В (Д)'
        TabOrder = 5
      end
      object StaticText033: TStaticText
        Left = 46
        Top = 64
        Width = 82
        Height = 17
        Cursor = -1
        Caption = 'Выверка Г (УВ)'
        TabOrder = 6
      end
      object StaticText034: TStaticText
        Left = 46
        Top = 86
        Width = 83
        Height = 17
        Cursor = -1
        Caption = 'Выверка В (УВ)'
        TabOrder = 7
      end
      object StaticText045: TStaticText
        Left = 185
        Top = 42
        Width = 59
        Height = 17
        Cursor = -1
        Caption = 'Выверка В'
        TabOrder = 8
      end
      object Edit013: TEdit
        Left = 147
        Top = 17
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 9
      end
      object StaticText044: TStaticText
        Left = 185
        Top = 20
        Width = 58
        Height = 17
        Cursor = -1
        Caption = 'Выверка Г'
        TabOrder = 10
      end
      object Edit014: TEdit
        Left = 147
        Top = 39
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 11
      end
      object Edit012: TEdit
        Left = 8
        Top = 105
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 12
      end
      object StaticText035: TStaticText
        Left = 46
        Top = 107
        Width = 55
        Height = 17
        Cursor = -1
        Caption = 'У-Б-О-Н-П'
        TabOrder = 13
      end
      object Edit015: TEdit
        Left = 147
        Top = 61
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 14
      end
      object StaticText046: TStaticText
        Left = 185
        Top = 64
        Width = 47
        Height = 17
        Cursor = -1
        Caption = 'Яркость'
        TabOrder = 15
      end
      object Edit016: TEdit
        Left = 147
        Top = 105
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 16
      end
      object StaticText047: TStaticText
        Left = 185
        Top = 108
        Width = 60
        Height = 17
        Cursor = -1
        Caption = 'Uрн ПДПН'
        TabOrder = 17
      end
      object StaticText049: TStaticText
        Left = 153
        Top = 129
        Width = 20
        Height = 17
        Cursor = -1
        Caption = 'МЗ'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object StaticText050: TStaticText
        Left = 153
        Top = 144
        Width = 54
        Height = 17
        Cursor = -1
        Caption = 'Налобник'
        TabOrder = 19
      end
      object StaticText038: TStaticText
        Left = 21
        Top = 159
        Width = 49
        Height = 17
        Cursor = -1
        Caption = 'Контр. Д'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 20
      end
      object StaticText037: TStaticText
        Left = 21
        Top = 144
        Width = 61
        Height = 17
        Cursor = -1
        Caption = 'Порог/раб.'
        TabOrder = 21
      end
      object StaticText036: TStaticText
        Left = 21
        Top = 129
        Width = 66
        Height = 17
        Cursor = -1
        Caption = 'Выверка Ор'
        TabOrder = 22
      end
      object StaticText1: TStaticText
        Left = 153
        Top = 159
        Width = 67
        Height = 17
        Cursor = -1
        Caption = 'Выверка УВ'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 23
      end
    end
    object GroupBox003: TGroupBox
      Left = 150
      Top = 258
      Width = 124
      Height = 115
      Cursor = -1
      Caption = 'МПБ'
      TabOrder = 6
      object Shape016: TShape
        Left = 8
        Top = 80
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText016: TStaticText
        Left = 21
        Top = 77
        Width = 100
        Height = 17
        Cursor = -1
        Caption = 'Электроспуск ПКТ'
        TabOrder = 0
      end
      object StaticText017: TStaticText
        Left = 21
        Top = 20
        Width = 82
        Height = 17
        Cursor = -1
        Caption = 'Поворот башни'
        TabOrder = 1
      end
      object Edit026: TEdit
        Left = 45
        Top = 38
        Width = 33
        Height = 21
        Cursor = -1
        TabStop = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object GroupBox005: TGroupBox
      Left = 279
      Top = 258
      Width = 124
      Height = 52
      Cursor = -1
      Caption = 'Стопор башни'
      TabOrder = 7
      object Shape020: TShape
        Left = 8
        Top = 20
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape021: TShape
        Left = 8
        Top = 35
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText027: TStaticText
        Left = 27
        Top = 16
        Width = 40
        Height = 17
        Cursor = -1
        Caption = 'Застоп'
        TabOrder = 0
      end
      object StaticText028: TStaticText
        Left = 29
        Top = 32
        Width = 46
        Height = 17
        Cursor = -1
        Caption = 'Расстоп'
        TabOrder = 1
      end
    end
    object GroupBox006: TGroupBox
      Left = 279
      Top = 314
      Width = 124
      Height = 59
      Cursor = -1
      Caption = 'Мех. подъемник'
      TabOrder = 8
      object Shape022: TShape
        Left = 8
        Top = 20
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape023: TShape
        Left = 8
        Top = 36
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText029: TStaticText
        Left = 21
        Top = 17
        Width = 24
        Height = 17
        Cursor = -1
        Caption = 'Руч.'
        TabOrder = 0
      end
      object StaticText030: TStaticText
        Left = 21
        Top = 33
        Width = 31
        Height = 17
        Cursor = -1
        Caption = 'Стаб.'
        TabOrder = 1
      end
    end
    object GroupBox008: TGroupBox
      Left = 674
      Top = 258
      Width = 93
      Height = 52
      Cursor = -1
      Caption = 'Арретир'
      TabOrder = 9
      object Shape028: TShape
        Left = 8
        Top = 20
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape029: TShape
        Left = 8
        Top = 35
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText040: TStaticText
        Left = 21
        Top = 17
        Width = 40
        Height = 17
        Cursor = -1
        Caption = 'Застоп'
        TabOrder = 0
      end
      object StaticText041: TStaticText
        Left = 21
        Top = 32
        Width = 46
        Height = 17
        Cursor = -1
        Caption = 'Расстоп'
        TabOrder = 1
      end
    end
    object GroupBox011: TGroupBox
      Left = 411
      Top = 332
      Width = 254
      Height = 41
      Cursor = -1
      Caption = 'Казенник'
      TabOrder = 10
      object Shape008: TShape
        Left = 98
        Top = 18
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText9: TStaticText
        Left = 109
        Top = 15
        Width = 32
        Height = 17
        Cursor = -1
        Caption = 'Клин '
        TabOrder = 0
      end
    end
    object GroupBox001: TGroupBox
      Left = 17
      Top = 28
      Width = 124
      Height = 224
      Cursor = -1
      Caption = 'ЩРЛ'
      TabOrder = 11
      object Shape004: TShape
        Left = 8
        Top = 74
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape001: TShape
        Left = 8
        Top = 20
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape002: TShape
        Left = 8
        Top = 38
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape007: TShape
        Left = 8
        Top = 110
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape006: TShape
        Left = 8
        Top = 92
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object Shape003: TShape
        Left = 8
        Top = 56
        Width = 8
        Height = 8
        Cursor = -1
        Brush.Color = clLime
        Shape = stCircle
      end
      object StaticText004: TStaticText
        Left = 21
        Top = 71
        Width = 75
        Height = 17
        Cursor = -1
        Caption = 'Стабилизатор'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object StaticText001: TStaticText
        Left = 21
        Top = 17
        Width = 42
        Height = 17
        Cursor = -1
        Caption = 'Преобр'
        TabOrder = 1
      end
      object StaticText002: TStaticText
        Left = 21
        Top = 35
        Width = 19
        Height = 17
        Cursor = -1
        Caption = 'УВ'
        TabOrder = 2
      end
      object StaticText007: TStaticText
        Left = 21
        Top = 107
        Width = 22
        Height = 17
        Cursor = -1
        Caption = '902'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
      end
      object StaticText006: TStaticText
        Left = 21
        Top = 89
        Width = 27
        Height = 17
        Cursor = -1
        Caption = 'ТПН'
        TabOrder = 4
      end
      object StaticText003: TStaticText
        Left = 21
        Top = 53
        Width = 28
        Height = 17
        Cursor = -1
        Caption = 'МПБ'
        TabOrder = 5
      end
    end
  end
  object GroupBox102: TGroupBox
    Left = 532
    Top = 434
    Width = 124
    Height = 52
    Cursor = -1
    Caption = '9С517'
    TabOrder = 1
    object Shape005: TShape
      Left = 8
      Top = 20
      Width = 8
      Height = 8
      Cursor = -1
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape009: TShape
      Left = 8
      Top = 35
      Width = 8
      Height = 8
      Cursor = -1
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape010: TShape
      Left = 77
      Top = 20
      Width = 8
      Height = 8
      Cursor = -1
      Brush.Color = clLime
      Shape = stCircle
    end
    object Shape011: TShape
      Left = 77
      Top = 35
      Width = 8
      Height = 8
      Cursor = -1
      Brush.Color = clLime
      Shape = stCircle
    end
    object StaticText114: TStaticText
      Left = 21
      Top = 17
      Width = 11
      Height = 17
      Cursor = -1
      Caption = 'К'
      TabOrder = 0
    end
    object StaticText115: TStaticText
      Left = 21
      Top = 32
      Width = 12
      Height = 17
      Cursor = -1
      Caption = 'И'
      TabOrder = 1
    end
    object StaticText116: TStaticText
      Left = 90
      Top = 17
      Width = 12
      Height = 17
      Cursor = -1
      Caption = 'Н'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object StaticText117: TStaticText
      Left = 90
      Top = 32
      Width = 11
      Height = 17
      Cursor = -1
      Caption = 'В'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object Timer1: TTimer
    Interval = 110
    OnTimer = Timer1Timer
    Left = 58
    Top = 42
  end
end
