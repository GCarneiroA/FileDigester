program fileDigest;

uses
  Vcl.Forms,
  ufPrincipal in 'ufPrincipal.pas' {FPrincipal},
  _threadDigest in '_threadDigest.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
