object FVed_Ta: TFVed_Ta
  Left = 35
  Top = 125
  Width = 1022
  Height = 766
  Caption = 'Rêsultats'
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
    Left = 428
    Top = 712
    Width = 75
    Height = 25
    Caption = 'Fermer'
    ModalResult = 2
    TabOrder = 0
  end
  object Button2: TButton
    Left = 556
    Top = 712
    Width = 75
    Height = 25
    Caption = 'Imprimer'
    TabOrder = 1
    OnClick = Button2Click
  end
end
