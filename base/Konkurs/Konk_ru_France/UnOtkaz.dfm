object Otkaz: TOtkaz
  Left = 366
  Top = 278
  Width = 417
  Height = 191
  Caption = 'Les pannes de l'#39'armement'
  Color = 11391946
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel16: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 164
    Align = alClient
    TabOrder = 0
    object Label16: TLabel
      Left = 17
      Top = 1
      Width = 259
      Height = 24
      Caption = 'Les pannes de l'#39'armement'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object CheckBox16: TCheckBox
      Left = 25
      Top = 33
      Width = 280
      Height = 17
      Caption = 'La rupture du fil de la fusee antichar dirigee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBox16Click
    end
    object CheckBox18: TCheckBox
      Left = 25
      Top = 55
      Width = 344
      Height = 17
      Caption = 'La panne du canal optique de la fusee antichar dirigee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBox16Click
    end
    object CheckBox19: TCheckBox
      Left = 25
      Top = 76
      Width = 248
      Height = 17
      Caption = 'L'#39'obstacle a la fusee antichar dirigee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBox16Click
    end
    object CheckBox20: TCheckBox
      Left = 25
      Top = 98
      Width = 368
      Height = 17
      Caption = 'La panne du moteur de depart de la fusee antichar dirigee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = CheckBox16Click
    end
    object CheckBox22: TCheckBox
      Left = 25
      Top = 119
      Width = 368
      Height = 17
      Caption = 'La panne du moteur de marche de la fusee antichar dirigee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = CheckBox16Click
    end
  end
end
