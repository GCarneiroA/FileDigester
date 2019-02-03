{
  Autor: Luis Gustavo Carneiro
  email: carneirodelphi@hotmail.com
}

unit _threadDigest;

interface

uses
  System.Hash,
  System.Classes;

const
  _SUSPENDED        = True;

type
  TOnRead = procedure(const bytesRead: Int64; const fileSize: Int64) of object;
  TOnFileOpen = procedure(const fileSize: Int64) of object;
  TDoneProc = procedure(var md5: string) of object;

  TThreadDigest = class(TThread)
  private
    sha256: THashSha2;
    f_sha256string: String;
    md5: THashMD5;
    f_md5string: String;

    f_filename: String;
    f_stream: TStream;
    f_size: Int64;
    f_totalBytes : Int64;

    f_onDone: TDoneProc;
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
  Buffer: array[0..1024] of Byte;
  ReadBytes : Int64;
begin
  md5 := System.Hash.THashMD5.Create;
  sha256 := System.Hash.THashSHA2.Create(System.Hash.THashSHA2.TSHA2Version.SHA256);
  f_size := f_stream.Size;
  f_totalBytes := 0;
  try
    f_stream.Seek(0, soBeginning);
    repeat
      ReadBytes := f_stream.Read(Buffer, SizeOf(Buffer));
      Inc(f_totalBytes, ReadBytes);
      md5.Update(Buffer, ReadBytes);
      sha256.Update(Buffer, ReadBytes);
      Synchronize(OnSync); // Synchronize Interface
    until (ReadBytes = 0) or (f_totalBytes = f_size);
  finally
    FreeAndNil(f_stream);
  end;
  f_md5string := UpperCase(md5.HashAsString);
  f_sha256string := UpperCase(sha256.HashAsString);
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
