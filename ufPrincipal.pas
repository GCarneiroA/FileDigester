{
  Autor: Luis Gustavo Carneiro
  email: carneirodelphi@hotmail.com

  Biblioteca MD5 utilizada de http://www.endimus.com
    com algumas adaptações
}

unit ufPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  _threadDigest, Vcl.ComCtrls;

type
  TFPrincipal = class(TForm)
    Label1: TLabel;
    edArquivo: TEdit;
    Label2: TLabel;
    edMD5: TEdit;
    btAbrir: TBitBtn;
    btFechar: TBitBtn;
    fOpen: TFileOpenDialog;
    Label3: TLabel;
    edResMD5: TEdit;
    pbStatus: TProgressBar;
    Panel1: TPanel;
    lbFile: TLabel;
    lbStatus: TLabel;
    pnStatus: TPanel;
    Label4: TLabel;
    edResSHA256: TEdit;
    edSHA256: TEdit;
    Label5: TLabel;
    pnMD5Status: TPanel;
    pnSHA256Status: TPanel;
    procedure btFecharClick(Sender: TObject);
    procedure btAbrirClick(Sender: TObject);
  private
    f_lastPerc: Integer;
    f_threadDigest: TThreadDigest;
    procedure OnRead(const bytesRead: Int64; const fileSize: Int64);
    procedure OnFileOpen(const fileSize: Int64);
    procedure Done(var md5: string);
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  md5,
  Math,
  IdHashMessageDigest;

{$R *.dfm}

function FormatByteSize(const bytes: Int64): string;
const
   B = 1; //byte
   KB = 1024 * B; //kilobyte
   MB = 1024 * KB; //megabyte
   GB = 1024 * MB; //gigabyte
begin
   if bytes > GB then
     result := FormatFloat('#.## GB', bytes / GB)
   else
     if bytes > MB then
       result := FormatFloat('#.## MB', bytes / MB)
     else
       if bytes > KB then
         result := FormatFloat('#.## KB', bytes / KB)
       else
         result := FormatFloat('#.## bytes', bytes) ;
end;

procedure TFPrincipal.btAbrirClick(Sender: TObject);
var
  v_file: string;
begin
  pbStatus.Position := 0;

  if fOpen.Execute then v_file := fOpen.FileName;
  edArquivo.Text := v_file;

  if v_file = EmptyStr then Exit;

  f_threadDigest := TThreadDigest.Create(_SUSPENDED);
  try
    f_threadDigest.OnFileOpen := Self.OnFileOpen;
    f_threadDigest.OnRead := Self.OnRead;
    f_threadDigest.OnDone := Self.Done;
    f_threadDigest.FileName := v_file;
    f_threadDigest.Start;
    //f_threadDigest.WaitFor;

  finally
    //FreeAndNil(f_threadDigest);
  end;
end;

procedure TFPrincipal.btFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFPrincipal.Done(var md5: string);
begin
  edResMD5.Text := f_threadDigest.MD5String;
  edResSha256.Text := f_threadDigest.SHA256String;

  f_threadDigest.Terminate;

  if edMD5.Text <> EmptyStr then
  begin
    if edResMD5.Text = edMD5.Text then
    begin
      pnMD5Status.Color := clLime;
      pnMD5Status.Caption := 'MD5 OK';
    end else
    begin
      pnMD5Status.Color := clRed;
      pnMD5Status.Caption := 'CORROMPIDO';
    end;
  end else
  begin
    pnMD5Status.Color := clBlue;
    pnMD5Status.Caption := '...';
  end;

  if edSHA256.Text <> EmptyStr then
  begin
    if edResSHA256.Text = edSHA256.Text then
    begin
      pnSHA256Status.Color := clLime;
      pnSHA256Status.Caption := 'MD5 OK';
    end else
    begin
      pnSHA256Status.Color := clRed;
      pnSHA256Status.Caption := 'CORROMPIDO';
    end;
  end else
  begin
    pnSHA256Status.Color := clBlue;
    pnSHA256Status.Caption := '...';
  end;
end;

procedure TFPrincipal.OnFileOpen(const fileSize: Int64);
begin
  pnStatus.Color := clYellow;
  pnStatus.Caption := 'AGUARDE...';

  f_lastPerc := 0;
  pbStatus.Position := 0;
  if fileSize > MaxInt then
    pbStatus.Max := MaxInt // Usar porcentagem para arquivos muito grandes
  else
    pbStatus.Max := fileSize;
  lbFile.Caption := 'Tamanho do arquivo: ' + FormatByteSize(fileSize);
end;

procedure TFPrincipal.OnRead(const bytesRead, fileSize: Int64);
var
  currPerc: Integer;
begin
  currPerc := Round(bytesRead / fileSize * pbStatus.Max);
  if currPerc > f_lastPerc then
  begin
    f_lastPerc := currPerc;
    pbStatus.Position := currPerc;
    pbStatus.Update;
  end;
  FPrincipal.lbStatus.Caption := 'Bytes lidos: ' + FormatByteSize(bytesRead);
end;

end.
