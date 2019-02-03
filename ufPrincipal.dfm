object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MD5 File Checksum comparer'
  ClientHeight = 262
  ClientWidth = 444
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
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Arquivo:'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'MD5 Sugerido:'
  end
  object Label3: TLabel
    Left = 8
    Top = 92
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'MD5:'
  end
  object Label4: TLabel
    Left = 8
    Top = 119
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'SHA256:'
  end
  object Label5: TLabel
    Left = 8
    Top = 65
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'SHA256 Sugerido:'
  end
  object edArquivo: TEdit
    Left = 114
    Top = 8
    Width = 323
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 0
  end
  object edMD5: TEdit
    Left = 114
    Top = 35
    Width = 323
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object btAbrir: TBitBtn
    Left = 281
    Top = 143
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Abrir'
    TabOrder = 5
    OnClick = btAbrirClick
  end
  object btFechar: TBitBtn
    Left = 362
    Top = 143
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Fechar'
    TabOrder = 6
    OnClick = btFecharClick
  end
  object edResMD5: TEdit
    Left = 114
    Top = 89
    Width = 237
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 3
  end
  object pbStatus: TProgressBar
    Left = 8
    Top = 174
    Width = 429
    Height = 27
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 7
  end
  object Panel1: TPanel
    Left = 8
    Top = 207
    Width = 429
    Height = 49
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 9
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
    Top = 143
    Width = 267
    Height = 25
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'ABRA UM ARQUIVO -->>'
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 8
  end
  object edResSHA256: TEdit
    Left = 114
    Top = 116
    Width = 237
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 4
  end
  object edSHA256: TEdit
    Left = 114
    Top = 62
    Width = 323
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object pnMD5Status: TPanel
    Left = 357
    Top = 89
    Width = 80
    Height = 21
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 10
  end
  object pnSHA256Status: TPanel
    Left = 357
    Top = 116
    Width = 80
    Height = 21
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 11
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
