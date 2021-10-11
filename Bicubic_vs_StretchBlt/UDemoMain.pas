unit UDemoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ExtDlgs, ComCtrls;

type
  TFrmDemoMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    ScrollBox2: TScrollBox;
    imgOriginal: TImage;
    imgResized: TImage;
    btnDoBicubic: TButton;
    btnDoStretchBlt: TButton;
    ckbEnableHalftone: TCheckBox;
    btnDoOpenBMP: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    ProgressBar1: TProgressBar;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    lblScaleValue: TLabel;
    lblOriginalValue: TLabel;
    lblResizedValue: TLabel;
    Bevel1: TBevel;
    procedure btnDoBicubicClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDoStretchBltClick(Sender: TObject);
    procedure btnDoOpenBMPClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure lblScaleValueClick(Sender: TObject);
  private
    { Déclarations privées }
    procedure SetScale;
  public
    { Déclarations publiques }
  end;

var
  FrmDemoMain: TFrmDemoMain;

implementation
uses Bicubics;
{$R *.dfm}

var
  aBmp: TBitmap;
  ScaleValue: Extended = 1.0;

procedure TFrmDemoMain.btnDoBicubicClick(Sender: TObject);
begin
  BiCubicScale(imgOriginal.Picture.Bitmap, imgOriginal.Picture.Bitmap.Width, imgOriginal.Picture.Bitmap.Height,
    imgResized.Picture.Bitmap, imgResized.Picture.Bitmap.Width, imgResized.Picture.Bitmap.Height,
    ProgressBar1.StepIt);
  imgResized.Invalidate;
end;

procedure TFrmDemoMain.btnDoStretchBltClick(Sender: TObject);
var pt : TPoint;
begin
  if ckbEnableHalftone.Checked then
    if GetStretchBltMode(imgResized.Picture.Bitmap.Canvas.Handle) <> HalfTone then
    begin
      GetBrushOrgEx(imgResized.Picture.Bitmap.Canvas.Handle, pt);
      SetStretchBltMode(imgResized.Picture.Bitmap.Canvas.Handle, HalfTone);      {    }
      SetBrushOrgEx(imgResized.Picture.Bitmap.Canvas.Handle, pt.x, pt.y, @pt);
    end;

  StretchBlt(imgResized.Picture.Bitmap.Canvas.Handle, 0, 0,
    imgResized.Picture.Bitmap.Width, imgResized.Picture.Bitmap.Height,
    imgOriginal.Picture.Bitmap.Canvas.Handle, 0, 0,
    imgOriginal.Picture.Bitmap.Width, imgOriginal.Picture.Bitmap.Height, SRCCOPY);

  imgResized.Invalidate;
end;

procedure TFrmDemoMain.btnDoOpenBMPClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgOriginal.Picture.Bitmap.LoadFromFile(OpenPictureDialog1.FileName);
    TrackBar1Change(self);
    TrackBar1.SetFocus;
  end;
end;

procedure TFrmDemoMain.FormCreate(Sender: TObject);
begin
  aBmp := TBitmap.Create;
  imgResized.Picture.Bitmap := aBmp;
  TrackBar1Change(self);
  imgResized.Picture.Bitmap.Canvas.Pixels[0,0] := imgResized.Picture.Bitmap.Canvas.Pixels[0,0];
end;

procedure TFrmDemoMain.FormDestroy(Sender: TObject);
begin
  aBmp.Free;
end;

procedure TFrmDemoMain.lblScaleValueClick(Sender: TObject);
begin
  TrackBar1.SetFocus;
end;

procedure TFrmDemoMain.SetScale;
begin
  imgResized.Picture.Bitmap.Width := Round(imgOriginal.Picture.Bitmap.Width * ScaleValue);
  imgResized.Picture.Bitmap.Height := Round(imgOriginal.Picture.Bitmap.Height * ScaleValue);
  ProgressBar1.Max := imgResized.Picture.Bitmap.Height;
  ProgressBar1.Position := 0;
end;

procedure TFrmDemoMain.Splitter1Moved(Sender: TObject);
begin
  lblResizedValue.Left := ScrollBox2.Left + 6;
end;

procedure TFrmDemoMain.TrackBar1Change(Sender: TObject);
begin
  ScaleValue := TrackBar1.Position / 100;
  SetScale;
  lblScaleValue.Caption := Format('%d%%', [TrackBar1.Position]);
  lblOriginalValue.Caption := Format('Original Size: %dx%d', [imgOriginal.Picture.Bitmap.Width, imgOriginal.Picture.Bitmap.Height]);
  lblResizedValue.Caption := Format('Resized at %s: %dx%d', [lblScaleValue.Caption, imgResized.Picture.Bitmap.Width, imgResized.Picture.Bitmap.Height]);
end;

end.
