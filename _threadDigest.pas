{
  Autor: Luis Gustavo Carneiro
  email: carneirodelphi@hotmail.com

  Biblioteca MD5 utilizada de http://www.endimus.com
    com algumas adaptações
}

unit _threadDigest;

interface

uses
  md5, IdHashMessageDigest, System.Classes;

const
  TIMER_INTERVAL    = 1000;
  _SUSPENDED        = True;

  ERR_OK            = 0;

type
  TOnRead = procedure(const bytesRead: Int64; const fileSize: Int64) of object;
  TOnFileOpen = procedure(const fileSize: Int64; const Opened: Boolean) of object;
  TDoneProc = procedure(var md5: string; const error_code: Integer) of object;

  TThreadDigest = class(TThread)
  private
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
    procedure sync;
    procedure Execute; override;
  public
    property MD5String: String read f_md5string;
    property OnRead: TOnRead read f_onRead write f_onRead;
    property OnDone: TDoneProc read f_ondone write f_ondone;
    property OnFileOpen: TOnFileOpen read f_onFileOpen write f_onFileOpen;
    property FileName: String read f_filename write SetFileName;
  end;

implementation

uses
  System.SysUtils;

{ TThreadDigest }

procedure TThreadDigest.Execute;
var
  Digest: TMD5Digest;
  Context: TMD5Context;
  Buffer: array[0..1024] of Byte;
  ReadBytes : Int64;
  SavePos: Int64;
begin
  MD5Init(Context);
  f_size := f_stream.Size;
  SavePos := f_stream.Position;
  f_totalBytes := 0;
  try
    f_stream.Seek(0, soBeginning);
    repeat
      ReadBytes := f_stream.Read(Buffer, SizeOf(Buffer));
      Inc(f_totalBytes, ReadBytes);
      MD5Update(Context, @Buffer, ReadBytes);
      Synchronize(sync);
    until (ReadBytes = 0) or (f_totalBytes = f_size);
  finally
    f_stream.Seek(SavePos, soBeginning);
  end;
  MD5Final(Digest, Context);

  f_md5string := MD5DigestToStr(Digest);
  if Assigned(f_ondone) then f_ondone(f_md5string, ERR_OK);
end;

procedure TThreadDigest.SetFileName(const Value: String);
begin
  if (Value <> f_filename) then f_filename := Value;
  if Assigned(f_stream) then FreeAndNil(f_stream);
  f_stream := TFileStream.Create(Value, fmOpenRead or fmShareDenyWrite);
  if Assigned(f_stream) and Assigned(f_onFileOpen) then
    f_onFileOpen(f_stream.Size, f_stream.Size > 0);
end;

procedure TThreadDigest.sync;
begin
  if Assigned(f_onRead) then
    f_onRead(f_totalBytes, f_size);
end;

end.
