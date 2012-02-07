object Vedom: TVedom
  Left = 84
  Top = 108
  Width = 1032
  Height = 776
  Anchors = []
  BorderIcons = [biSystemMenu]
  Caption = 'Bulletin'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 692
    Top = 712
    Width = 75
    Height = 25
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button6: TButton
    Left = 558
    Top = 712
    Width = 75
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button6Click
  end
  object Panel1: TPanel
    Left = 4
    Top = 2
    Width = 1015
    Height = 743
    Color = 8107947
    TabOrder = 2
    object StringGrid1: TStringGrid
      Left = 8
      Top = 10
      Width = 999
      Height = 687
      Color = 12443359
      ColCount = 10
      DefaultColWidth = 30
      FixedCols = 0
      RowCount = 2
      TabOrder = 0
      OnDblClick = StringGrid1DblClick
      ColWidths = (
        39
        130
        109
        110
        123
        110
        100
        110
        72
        57)
    end
  end
  object Button2: TButton
    Left = 410
    Top = 712
    Width = 75
    Height = 25
    Caption = 'Fermer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
  end
end
