{
  Autor: Luis Gustavo Carneiro
  email: carneirodelphi@hotmail.com

  Biblioteca MD5 utilizada de http://www.endimus.com
    com algumas adaptações
}

unit _threadDigest;

interface

uses
  md5,
  System.Hash,
  System.Classes;

const
  TIMER_INTERVAL    = 1000;
  _SUSPENDED        = True;



type
  TOnRead = procedure(const bytesRead: Int64; const fileSize: Int64) of object;
  TOnFileOpen = procedure(const fileSize: Int64) of object;
  TDoneProc = procedure(var md5: string) of object;

  TThreadDigest = class(TThread)
  private
    sha256: THashSha2;
    f_sha256string: String;
    f_size: Int64;
    f_totalBytes : Int64;
    f_md5string: String;
    f_stream: TStream;
    f_onDone: TDoneProc;
    f_filename: String;
    f_onFileOpen: TOnFileOpen;
    f_onRead: TOnRead;
    procedure SetFileName(const Value: String);
  protected
    procedure DoFileOpen;
    procedure OnSync;
    procedure Execute; override;
  public
    property MD5String: String read f_md5string;
    property SHA256String: String read f_sha256string;
    property OnRead: TOnRead read f_onRead write f_onRead;
    property OnDone: TDoneProc read f_ondone write f_ondone;
    property OnFileOpen: TOnFileOpen read f_onFileOpen write f_onFileOpen;
    property FileName: String read f_filename write SetFileName;
  end;

implementation

uses
  System.SysUtils;

{ TThreadDigest }

procedure TThreadDigest.DoFileOpen;
begin
  if Assigned(f_onFileOpen) then f_onFileOpen(f_stream.Size);
end;

procedure TThreadDigest.Execute;
var
  Digest: TMD5Digest;
  Context: TMD5Context;
  Buffer: array[0..1024] of Byte;
  ReadBytes : Int64;
  SavePos: Int64;
begin
  sha256 := System.Hash.THashSHA2.Create(System.Hash.THashSHA2.TSHA2Version.SHA256);
  MD5Init(Context);

  f_size := f_stream.Size;
  SavePos := f_stream.Position;
  f_totalBytes := 0;
  try
    f_stream.Seek(0, soBeginning);
    repeat
      ReadBytes := f_stream.Read(Buffer, SizeOf(Buffer));
      Inc(f_totalBytes, ReadBytes);

      sha256.Update(Buffer, ReadBytes);
      MD5Update(Context, @Buffer, ReadBytes);

      Synchronize(OnSync);
    until (ReadBytes = 0) or (f_totalBytes = f_size);
  finally
    f_stream.Seek(SavePos, soBeginning);
    FreeAndNil(f_stream);
  end;
  MD5Final(Digest, Context);
  f_md5string := MD5DigestToStr(Digest);
  f_sha256string := sha256.HashAsString;

  if Assigned(f_ondone) then f_ondone(f_md5string);
end;

procedure TThreadDigest.SetFileName(const Value: String);
begin
  if (Value <> f_filename) then f_filename := Value;
  if Assigned(f_stream) then FreeAndNil(f_stream);
  f_stream := TFileStream.Create(Value, fmOpenRead or fmShareDenyWrite);
  DoFileOpen;
end;

procedure TThreadDigest.OnSync;
begin
  if Assigned(f_onRead) then f_onRead(f_totalBytes, f_size);
end;

end.
