object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MD5 File Checksum comparer'
  ClientHeight = 166
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Arquivo:'
  end
  object Label2: TLabel
    Left = 24
    Top = 43
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'MD5 Sugerido:'
  end
  object edArquivo: TEdit
    Left = 111
    Top = 13
    Width = 237
    Height = 21
    TabOrder = 0
  end
  object edMD5: TEdit
    Left = 111
    Top = 40
    Width = 237
    Height = 21
    TabOrder = 1
  end
  object btAbrir: TBitBtn
    Left = 111
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Abrir'
    TabOrder = 2
    OnClick = btAbrirClick
  end
  object btVerificar: TBitBtn
    Left = 192
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Verificar'
    TabOrder = 3
    OnClick = btVerificarClick
  end
  object pnStatus: TPanel
    Left = 24
    Top = 112
    Width = 324
    Height = 41
    ParentBackground = False
    TabOrder = 4
  end
  object btFechar: TBitBtn
    Left = 273
    Top = 67
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 5
    OnClick = btFecharClick
  end
  object fOpen: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Todos os arquivos'
        FileMask = '*.*'
      end>
    Options = []
    Left = 56
    Top = 72
  end
end
