object FrmDemoMain: TFrmDemoMain
  Left = 230
  Top = 127
  Width = 861
  Height = 677
  Caption = 'Bicubic vs StretchBlt '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 17
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 853
    Height = 153
    Align = alTop
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 0
    DesignSize = (
      849
      149)
    object lblOriginalValue: TLabel
      Left = 12
      Top = 129
      Width = 88
      Height = 17
      Caption = 'lblOriginalValue'
    end
    object lblResizedValue: TLabel
      Left = 438
      Top = 129
      Width = 89
      Height = 17
      Caption = 'lblResizedValue'
    end
    object btnDoOpenBMP: TButton
      Left = 710
      Top = 48
      Width = 113
      Height = 33
      Anchors = [akTop, akRight]
      Caption = 'Load Bitmap'
      TabOrder = 1
      OnClick = btnDoOpenBMPClick
    end
    object GroupBox1: TGroupBox
      Left = 4
      Top = 10
      Width = 698
      Height = 119
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Resizing Zone'
      TabOrder = 0
      DesignSize = (
        698
        119)
      object Bevel1: TBevel
        Left = 229
        Top = 18
        Width = 454
        Height = 88
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        Style = bsRaised
      end
      object lblScaleValue: TLabel
        Left = 10
        Top = 82
        Width = 30
        Height = 17
        Caption = '25%'
        OnClick = lblScaleValueClick
      end
      object TrackBar1: TTrackBar
        Left = 10
        Top = 26
        Width = 197
        Height = 49
        Max = 400
        Min = 5
        PageSize = 20
        Frequency = 20
        Position = 25
        TabOrder = 0
        OnChange = TrackBar1Change
      end
      object btnDoBicubic: TButton
        Left = 239
        Top = 67
        Width = 98
        Height = 32
        Caption = 'Bicubic'
        Default = True
        TabOrder = 3
        OnClick = btnDoBicubicClick
      end
      object btnDoStretchBlt: TButton
        Left = 239
        Top = 26
        Width = 98
        Height = 33
        Caption = 'StretchBlt'
        TabOrder = 1
        OnClick = btnDoStretchBltClick
      end
      object ckbEnableHalftone: TCheckBox
        Left = 345
        Top = 31
        Width = 158
        Height = 23
        Caption = 'Enable HALFTONE'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = btnDoStretchBltClick
      end
      object ProgressBar1: TProgressBar
        Left = 345
        Top = 73
        Width = 326
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Step = 1
        TabOrder = 4
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 153
    Width = 853
    Height = 496
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 430
      Top = 1
      Width = 4
      Height = 494
      OnMoved = Splitter1Moved
    end
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 429
      Height = 494
      Align = alLeft
      TabOrder = 0
      object imgOriginal: TImage
        Left = 0
        Top = 0
        Width = 137
        Height = 137
        AutoSize = True
      end
    end
    object ScrollBox2: TScrollBox
      Left = 434
      Top = 1
      Width = 418
      Height = 494
      Align = alClient
      TabOrder = 1
      object imgResized: TImage
        Left = 0
        Top = 0
        Width = 137
        Height = 137
        AutoSize = True
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 584
    Top = 64
  end
end
