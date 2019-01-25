object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MD5 File Checksum comparer'
  ClientHeight = 175
  ClientWidth = 418
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
    Left = 8
    Top = 11
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Arquivo:'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'MD5 Sugerido:'
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Resultado:'
  end
  object edArquivo: TEdit
    Left = 95
    Top = 8
    Width = 237
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 0
  end
  object edMD5: TEdit
    Left = 95
    Top = 35
    Width = 237
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object btAbrir: TBitBtn
    Left = 176
    Top = 89
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Abrir'
    TabOrder = 2
    OnClick = btAbrirClick
  end
  object btFechar: TBitBtn
    Left = 257
    Top = 89
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = btFecharClick
  end
  object edResultado: TEdit
    Left = 95
    Top = 62
    Width = 237
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 4
  end
  object pbStatus: TProgressBar
    Left = 338
    Top = 8
    Width = 72
    Height = 161
    DoubleBuffered = False
    Orientation = pbVertical
    ParentDoubleBuffered = False
    TabOrder = 5
  end
  object Panel1: TPanel
    Left = 8
    Top = 120
    Width = 324
    Height = 49
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 6
    object lbFile: TLabel
      Left = 16
      Top = 5
      Width = 41
      Height = 13
      Caption = 'Arquivo:'
    end
    object lbStatus: TLabel
      Left = 16
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Status: '
    end
  end
  object pnStatus: TPanel
    Left = 8
    Top = 89
    Width = 162
    Height = 25
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'ABRA UM ARQUIVO -->>'
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 7
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
    Top = 104
  end
end
