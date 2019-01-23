unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFPrincipal = class(TForm)
    Label1: TLabel;
    edArquivo: TEdit;
    Label2: TLabel;
    edMD5: TEdit;
    btAbrir: TBitBtn;
    btVerificar: TBitBtn;
    pnStatus: TPanel;
    btFechar: TBitBtn;
    fOpen: TFileOpenDialog;
    procedure btFecharClick(Sender: TObject);
    procedure btAbrirClick(Sender: TObject);
    procedure btVerificarClick(Sender: TObject);
  private
    procedure VerificarArquivo;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  IdHashMessageDigest;

{$R *.dfm}

procedure TFPrincipal.btAbrirClick(Sender: TObject);
begin
  pnStatus.Caption := EmptyStr;
  pnStatus.Color := clBtnFace;

  if fOpen.Execute then
    edArquivo.Text := fOpen.FileName;
end;

procedure TFPrincipal.btFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFPrincipal.btVerificarClick(Sender: TObject);
begin
  if FileExists(edArquivo.Text) then
    VerificarArquivo
  else
  begin
    pnStatus.Color := clRed;
    pnStatus.Caption := 'Arquivo n�o encontrado...';
  end;
end;

procedure TFPrincipal.VerificarArquivo;
var
  IdMD5: TIdHashMessageDigest5;
  digest: string;
begin
  IdMD5 := TIdHashMessageDigest5.Create;
  try
    digest := IdMD5.HashStreamAsHex(TFileStream.Create(edArquivo.Text, fmOpenRead or fmShareDenyWrite));
    if edMD5.Text <> EmptyStr then
    begin
      if digest = edMD5.Text then
      begin
        pnStatus.Color := clGreen;
        pnStatus.Caption := 'Arquivo OK...';
      end else
      begin
        pnStatus.Color := clRed;
        pnStatus.Caption := 'Arquivo corrompido...';
      end;
    end else
    begin
      pnStatus.Color := clYellow;
      pnStatus.Caption := digest;
    end;
  finally
    FreeAndNil(IdMD5);
  end;
end;

end.
