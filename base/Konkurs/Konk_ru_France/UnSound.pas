unit UnSound;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DXSounds, DirectX;


type
  TSound = class
  private

  public
    procedure GetSound(sountype: integer; len: Cardinal); {Набор функций, отвечающий}
    procedure GetSound_BOY(len: Cardinal);         {за вывод определенного звука}
    procedure GetSound_OTBOY(len: Cardinal);
    procedure GetSound_PULEM(len: Cardinal);
    procedure GetSound_PUSHKA(len: Cardinal);
    procedure GetSound_MOTOR1(len: Cardinal);
    procedure GetSound_MOTOR2(len: Cardinal);
    {Инициализация объекта DirectSound, создание буферов и загрузка в них звуков}
    procedure SoundCardInit(hand: integer; Aud1,Aud2,Aud3,Aud4,Aud5,Aud6: TDirectSoundBuffer);
    {Уничтожение объекта DirectSound}
    procedure SoundCardDestroy;
    procedure StopSound1;   {Набор вспомагательных функций}
    procedure StopSound2;
    procedure StopSound3;
    procedure StopSound4;
    procedure StopSound5;
    procedure StopSound6;
    procedure Contin1;
    procedure Contin2;
    procedure Contin3;
    procedure Contin4;
    procedure Contin5;
    procedure Contin6;
end;

const
  BOY=1;
  OTBOY=2;
  PULEM=3;
  PUSHKA=4;
  MOTOR1=5;
  MOTOR2=6;
var
soundCard: TDirectSound;
handler:integer;
Audio1,Audio2,Audio3,Audio4,Audio5,Audio6: TDirectSoundBuffer;
loop1,loop2,loop3,loop4,loop5,loop6: Boolean;   {Переменные отвечающие за продолжение }
             {или прекращение воспроизведения}
implementation
uses Main;
procedure TSound.SoundCardInit(hand: integer;   Aud1,Aud2,Aud3,Aud4,Aud5,Aud6: TDirectSoundBuffer);
var buf1,buf2,buf3,buf4,buf5,buf6: TDSBUFFERDESC; {Структура описывающая буфер}
begin
  Audio1:=Aud1;
  Audio2:=Aud2;
  Audio3:=Aud3;
  Audio4:=Aud4;
  Audio5:=Aud5;
  Audio6:=Aud6;

  handler:=hand;
  soundCard:=TDirectSound.Create(nil);
  soundCard.ISound.SetCooperativeLevel(handler, DSSCL_NORMAL);

  Audio1:=TDirectSoundBuffer.Create(soundCard);
  buf1.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf1.dwBufferBytes:=32000;
  Audio1.CreateBuffer(buf1);

  Audio2:=TDirectSoundBuffer.Create(soundCard);
  buf2.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf2.dwBufferBytes:=32000;
  Audio2.CreateBuffer(buf2);

  Audio3:=TDirectSoundBuffer.Create(soundCard);
  buf3.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf3.dwBufferBytes:=64000;
  Audio3.CreateBuffer(buf3);

  Audio4:=TDirectSoundBuffer.Create(soundCard);
  buf4.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf4.dwBufferBytes:=64000;
  Audio4.CreateBuffer(buf4);

  Audio5:=TDirectSoundBuffer.Create(soundCard);
  buf5.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf5.dwBufferBytes:=32000;
  Audio5.CreateBuffer(buf5);

  Audio6:=TDirectSoundBuffer.Create(soundCard);
  buf6.dwFlags:=DSBCAPS_LOCSOFTWARE;
  buf6.dwBufferBytes:=64000;
  Audio6.CreateBuffer(buf6);

  Audio1.LoadFromFile(Form1.dir+'wav/boy.wav');
  Audio2.LoadFromFile(Form1.dir+'wav/otboy.wav');
  Audio3.LoadFromFile(Form1.dir+'wav/pulem.wav');
  Audio4.LoadFromFile(Form1.dir+'wav/pushka.wav');
  Audio5.LoadFromFile(Form1.dir+'wav/starter.wav');
  Audio6.LoadFromFile(Form1.dir+'wav/motor.wav');
end;

procedure TSound.SoundCardDestroy;
begin
  Audio1.free; Audio1:=nil;
  Audio2.free; Audio2:=nil;
  Audio3.free; Audio3:=nil;
  Audio4.free; Audio4:=nil;
  Audio5.free; Audio5:=nil;
  Audio6.free; Audio6:=nil;
end;

procedure TSound.GetSound(sountype: integer; len: Cardinal);
begin
case (sountype) of
  BOY: GetSound_BOY(len);            //k БОЮ
  OTBOY: GetSound_OTBOY(len);        //Отбой
  PULEM: GetSound_PULEM(len);        //ПКТ
  PUSHKA: GetSound_PUSHKA(len);      //А-42
  MOTOR1: GetSound_MOTOR1(len);
  MOTOR2: GetSound_MOTOR2(len);
end;

end;

procedure TSound.GetSound_BOY(len: Cardinal);
begin
  loop1:=true;
  Audio1.Play;
  SetTimer(handler, 1111, len, @TSound.StopSound1);
  SetTimer(handler, 2222, 100, @TSound.Contin1);
end;

procedure TSound.GetSound_OTBOY(len: Cardinal);
begin
  loop2:=true;
  Audio2.Play;
  SetTimer(handler, 3333, len, @TSound.StopSound2);
  SetTimer(handler, 4444, 100, @TSound.Contin2);
end;

procedure TSound.GetSound_PULEM(len: Cardinal);
begin
  loop3:=true;
  Audio3.Play;
  SetTimer(handler, 5555, len, @TSound.StopSound3);
  SetTimer(handler, 6666, 100, @TSound.Contin3);
end;

procedure TSound.GetSound_PUSHKA(len: Cardinal);
begin
  loop4:=true;
  Audio4.Play;
  SetTimer(handler, 7777, len, @TSound.StopSound4);
  SetTimer(handler, 8888, 100, @TSound.Contin4);
end;

procedure TSound.GetSound_MOTOR1(len: Cardinal);
begin
  loop5:=true;
  Audio5.Play;
  SetTimer(handler, 8889, len, @TSound.StopSound5);
  SetTimer(handler, 8890, 100, @TSound.Contin5);
end;
procedure TSound.GetSound_MOTOR2(len: Cardinal);
begin
  loop6:=true;
  Audio6.Play;
  SetTimer(handler, 8891, len, @TSound.StopSound6);
  SetTimer(handler, 8892, 100, @TSound.Contin6);
end;
procedure TSound.StopSound1;
begin
  loop1:=false;
  Audio1.Stop;
  Audio1.Position:=0;
  KillTimer(handler,1111);
end;

procedure TSound.StopSound2;
begin
  loop2:=false;
  Audio2.Stop;
  Audio2.Position:=0;
  KillTimer(handler,3333);
end;

procedure TSound.StopSound3;
begin
  loop3:=false;
  Audio3.Stop;
  Audio3.Position:=0;
  KillTimer(handler,5555);
end;

procedure TSound.StopSound4;
begin
  loop4:=false;
  Audio4.Stop;
  Audio4.Position:=0;
  KillTimer(handler,7777);
end;

procedure TSound.StopSound5;
begin
  loop5:=false;
  Audio5.Stop;
  Audio5.Position:=0;
  KillTimer(handler,8889);
end;
procedure TSound.StopSound6;
begin
  loop6:=false;
  Audio6.Stop;
  Audio6.Position:=0;
  KillTimer(handler,8891);
end;

procedure TSound.Contin1;
begin
  If loop1=true then Audio1.Play else begin
   KillTimer(handler,2222);
  end;
end;

procedure TSound.Contin2;
begin
  If loop2=true then Audio2.Play else begin
   KillTimer(handler,4444);
  end;
end;

procedure TSound.Contin3;
begin
  If loop3=true then Audio3.Play else begin
   KillTimer(handler,6666);
  end;
end;

procedure TSound.Contin4;
begin
  If loop4=true then Audio4.Play else begin
   KillTimer(handler,8888);
  end;
end;
procedure TSound.Contin5;
begin
  If loop5=true then Audio5.Play else begin
   KillTimer(handler,8890);
  end;
end;
procedure TSound.Contin6;
begin
  If loop6=true then Audio6.Play else begin
   KillTimer(handler,8892);
  end;
end;
end.
