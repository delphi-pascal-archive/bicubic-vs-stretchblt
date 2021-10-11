program BicubicScaleDemo;

uses
  Forms,
  UDemoMain in 'UDemoMain.pas' {FrmDemoMain},
  Bicubics in 'Bicubics.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDemoMain, FrmDemoMain);
  Application.Run;
end.
