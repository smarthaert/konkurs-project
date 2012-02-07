unit UnGLSL;

interface

uses
dglOpenGL, Dialogs, SysUtils, Windows, Main ;

type
  PVector4f = ^TVector4f;

  GlslProgramm = class ( TObject )
  private
    programShader: GLhandleARB;
    vertexShader: GLhandleARB;
    fragmentShader: GLhandleARB;
    log: string;
    ok: boolean;
    glError: string;
  public
    constructor InitGlslProgramm;
    destructor FreeGlslProgramm;
    function LoadShaders ( vertexFileName, fragmentFileName: string ) : boolean;
    function LoadShadersPas ( vertexFile, fragmentFile: string ) : boolean;
    function GetLog: string;
    function GetGlError: string;
    function GetVersion: string;
    function IsOk: boolean;
    function IsSupported: boolean;
    procedure Bind;
    procedure UnBind;
    function SetUniformVector2D ( name: Pchar; value: Pointer) : boolean;
    function SetUniformVector3D ( name: Pchar; value: Pointer) : boolean;
    function SetUniformVector4D ( name: Pchar; value: Pointer) : boolean;
    function SetUniformFloat ( name: Pchar; value: real) : boolean;
    function SetUniformIntA ( name: Pchar; value: integer) : boolean;
    function SetUniformInt ( loc, value: integer) : boolean;
    function SetTextureA ( name: Pchar; texUnit: integer) : boolean;
    function SetTexture ( loc, texUnit: integer) : boolean;
//    function SetUniformVector: boolean;
  protected
    function LoadShader ( shader: GLhandleARB; str: string ) : boolean;
    function LoadShaderPas (shader: GLhandleARB; str: string ): boolean;
    function CheckGlError: boolean;
    procedure LoadLog ( obj: GLhandleARB );
  end;
  var
    GLSL: GlslProgramm;

implementation

constructor GlslProgramm.InitGlslProgramm;
begin
  programShader := 0;
  vertexShader := 0;
  fragmentShader := 0;
  ok := false;
end;

function GlslProgramm.LoadShaders ( vertexFileName, fragmentFileName: string ): boolean;
var
  linked: GLint;
begin
  ok := false;
  if programShader = 0 then programShader := glCreateProgramObjectARB;
  if not CheckGlError then begin
    result := false;
    exit;
  end;

  vertexShader := glCreateShaderObjectARB ( GL_VERTEX_SHADER_ARB );
  fragmentShader := glCreateShaderObjectARB ( GL_FRAGMENT_SHADER_ARB );

  log := log + 'Loading vertex shader ';
  if not LoadShader ( vertexShader, vertexFileName ) then begin
    result := false;
    exit;
  end;

  log := log + 'Loading fragment shader ';
  if not LoadShader ( fragmentShader, fragmentFileName ) then begin
    result := false;
    exit;
  end;

  glAttachObjectARB ( programShader, vertexShader );
  glAttachObjectARB ( programShader, fragmentShader );

  log := log + 'Linking program ';
  glLinkProgramARB ( programShader );
  glGetObjectParameterivARB ( programShader, GL_OBJECT_LINK_STATUS_ARB, @linked );
//  LoadLog ( programShader );
  if linked = GL_FALSE then begin
    result := false;
    exit;
  end;
  ok := true;
  result := ok;
end;

procedure GlslProgramm.Bind;
begin
  glUseProgramObjectARB ( programShader );
end;

procedure GlslProgramm.UnBind;
begin
  glUseProgramObjectARB ( 0 );
end;

function GlslProgramm.LoadShader(shader: GLhandleARB; str: string): boolean;
var
  ch: array of char;
  a: integer;
  f: TextFile;
  s1, s2: string;
  compileStatus: GLint;
begin
  s2:='';
  if not FileExists(str) then begin
    MessageDlg('Нет файла '+str, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,Str);
  Reset(F);
  while not Eof(f) do begin
    ReadLn(F, s1);
    s2:=s2+s1;
  end;
  CloseFile(F);
  a:=Length(S2);
  SetLength(ch, a);
  glShaderSourceARB(shader,1,@s2,@a);
  glCompileShaderARB(shader);
  // освобождение памяти
  Finalize(ch);
  if not CheckGlError then begin
    result := false;
    exit;
  end;
  glGetObjectParameterivARB ( shader, GL_OBJECT_COMPILE_STATUS_ARB, @compileStatus );
//  loadLog ( shader );
  if compileStatus = GL_FALSE then result := false
                              else result := true;
end;

function GlslProgramm.CheckGlError: boolean;
var
  glErr: GLenum;
  retCode: boolean;
begin
  retCode:=true;
  glErr:=glGetError;
  if glErr=GL_NO_ERROR then begin
    result:=retCode;
    exit;
  end;
  glError := gluErrorString(glErr);
  retCode:=false;
  result:= retCode;
end;

procedure GlslProgramm.LoadLog ( obj: GLhandleARB );
var
  longLength: integer;
  charsWritten: integer;
  buffer: string;
begin
  longLength := 0;
  charsWritten := 0;
  glGetObjectParameterivARB ( obj, GL_OBJECT_INFO_LOG_LENGTH_ARB, @longLength );
  if not checkGlError then exit;
  if longLength < 1 then exit;
  glGetInfoLogARB ( obj, longLength, charsWritten, @buffer );
  log := log + buffer;
  Finalize ( buffer );
end;

function GlslProgramm.GetLog: string;
begin
  GetLog:=log;
end;

function GlslProgramm.IsOk: boolean;
begin
  IsOk:=ok;
end;

function GlslProgramm.GetGlError: string;
begin
  GetGlError:=glError;
end;

function GlslProgramm.GetVersion: string;
var
  stVer: string;
begin
  stVer := glGetString ( GL_SHADING_LANGUAGE_VERSION );
  if glGetError = GL_NO_ERROR then result := stVer
                              else result := '1.051';
end;

function GlslProgramm.IsSupported: boolean;
var
s: string;
begin
  s:=glGetString(GL_EXTENSIONS);
end;

function GlslProgramm.SetUniformVector2D ( name: Pchar; value: Pointer ) : boolean;
var
  loc : integer;
begin
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform2fvARB ( loc, 1, value );
  result:=true;
end;

function GlslProgramm.SetUniformVector3D ( name: Pchar; value: Pointer ) : boolean;
var
  loc : integer;
begin
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform3fvARB ( loc, 1, value );
  result:=true;
end;

function GlslProgramm.SetUniformVector4D ( name: Pchar; value: Pointer ) : boolean;
var
  loc : integer;
begin
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform4fvARB ( loc, 1, value );
  result:=true;
end;

function GlslProgramm.SetUniformFloat ( name: Pchar; value: real ): boolean;
var
  loc : integer;
begin
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform1fARB ( loc, value );
  result:=true;
end;

function GlslProgramm.SetUniformIntA ( name: Pchar; value: integer): boolean;
var
  loc : integer;
begin
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform1fARB ( loc, value );
  result:=true;
end;

function GlslProgramm.SetUniformInt ( loc, value: integer) : boolean;
begin
  glUniform1iARB ( loc, value );
  result:=true;
end;

function GlslProgramm.SetTextureA ( name: Pchar; texUnit: integer): boolean;
var
  loc : integer;
begin 
  loc := glGetUniformLocationARB ( programShader, name );
  if loc<0 then begin
    result:=false;
    exit;
  end;
  glUniform1iARB ( loc, texUnit );
  result:=true;
end;

function GlslProgramm.SetTexture ( loc, texUnit: integer) : boolean;
begin
  glUniform1iARB ( loc, texUnit );
  result:=true;
end;

function GlslProgramm.LoadShadersPas ( vertexFile, fragmentFile: string ): boolean;
var
  linked: GLint;
begin
  ok := false;
  if programShader = 0 then programShader := glCreateProgramObjectARB;
  if not CheckGlError then begin
    result := false;
    exit;
  end;

  vertexShader := glCreateShaderObjectARB ( GL_VERTEX_SHADER_ARB );
  fragmentShader := glCreateShaderObjectARB ( GL_FRAGMENT_SHADER_ARB );

  log := log + 'Loading vertex shader ';
  if not LoadShaderPas ( vertexShader, vertexFile ) then begin
    result := false;
    exit;
  end;

  log := log + 'Loading fragment shader ';
  if not LoadShaderPas ( fragmentShader, fragmentFile ) then begin
    result := false;
    exit;
  end;

  glAttachObjectARB ( programShader, vertexShader );
  glAttachObjectARB ( programShader, fragmentShader );

  log := log + 'Linking program ';
  glLinkProgramARB ( programShader );
  glGetObjectParameterivARB ( programShader, GL_OBJECT_LINK_STATUS_ARB, @linked );
  //LoadLog ( programShader );
  if linked = GL_FALSE then begin
    result := false;
    exit;
  end;
  ok := true;
  result := ok;
end;

function GlslProgramm.LoadShaderPas(shader: GLhandleARB; str: string): boolean;
var
  ch: array of char;
  a: integer;
  compileStatus: GLint;
  s: string;
begin
  s:=str;
  a:=Length ( s );
  SetLength ( ch, a );
  glShaderSourceARB ( shader, 1, @s, @a );
  glCompileShaderARB ( shader );
  // освобождение памяти
  Finalize ( ch );
  if not CheckGlError then begin
    result := false;
    exit;
  end;
  glGetObjectParameterivARB ( shader, GL_OBJECT_COMPILE_STATUS_ARB, @compileStatus );
//  loadLog ( shader );
  if compileStatus = GL_FALSE then result := false
                              else result := true;
end;

destructor GlslProgramm.FreeGlslProgramm;
begin
  glDeleteObjectARB( programShader);
  glDeleteObjectARB( vertexShader);
  glDeleteObjectARB( fragmentShader);
  programShader:=0;
  vertexShader:=0;
  fragmentShader:=0;
  ok:=false;
end;

end.


  InitTextShader;
  GLSL := GlslProgramm.InitGlslProgramm;
  GLSL.LoadShadersPas ( vsShaderColor, frShaderColor );


  GLSL.Bind;
  GLSL.UnBind;

