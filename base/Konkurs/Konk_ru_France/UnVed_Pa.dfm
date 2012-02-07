object FVed_Pa: TFVed_Pa
  Left = -4
  Top = -4
  Width = 1032
  Height = 776
  Caption = 'Ведомость'
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
    Left = 410
    Top = 712
    Width = 75
    Height = 25
    Caption = 'Закрыть'
    ModalResult = 2
    TabOrder = 0
  end
  object Button2: TButton
    Left = 556
    Top = 712
    Width = 75
    Height = 25
    Caption = 'Печать'
    TabOrder = 1
    OnClick = Button2Click
  end
end
