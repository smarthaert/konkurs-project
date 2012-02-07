unit ComCryptM;

interface

uses
  Windows, SysUtils, Classes,Forms;
Const
{$INCLUDE 'CryptKey.Pas';}

type
  TBaudRate = ( br110, br300, br600, br1200, br2400, br4800,br9600,
           br14400, br19200, br38400, br56000,  br57600, br115200 );
  TByteSize=(bs5,bs6,bs7,bs8);
  TParity = (ptNONE,ptODD,ptEVEN,ptMARK,ptSPACE);
  TStopBits=(sb1BITS,sb1HALFBITS,sb2BITS);

  TCommDataAvailEvent=procedure(var BytesReadede:Dword;Const B) of Object;
  TSetBufOutEvent=procedure(var BytesToWrite:Dword;Const B) of Object;

  TComCryptM = class;

  TReadThread = class(TThread)
  protected
    FComPort: TComCryptM;
    FComHandle: THandle;
    FDelay: DWORD;
    FBytesReaded:dword;
    FROL: TOverlapped;
    procedure DoOnDataAvail;
    procedure DecryptData;
  protected
    procedure Execute; override;
  public
    constructor Create(ComPort: TComCryptM);
    destructor Destroy; override;
  end;
//>--------------------
  TWriteThread = class(TThread)
  protected
    FComPort: TComCryptM;
    FComHandle: THandle;
    FDelay: DWORD;
    FBytesToWrite: DWORD;
    FWOL: TOverlapped;
    Procedure DoSetBufOut;
    procedure EncryptData;
  protected
    procedure Execute; override;
  public
    constructor Create(ComPort: TComCryptM);
    destructor Destroy; override;
  end;
//<--------------------

  TComCryptM = class(TComponent)
  private
    { Private declarations }
    FComNumber  :Integer;

    FInBuffUsed: DWORD;
    FInBuffSize: DWORD;
    FReadReadyEvent: THandle;
    FReadEvent: THandle;
    FReadDelay: DWORD;
    FNumOfBytesRXPaket:Word;
    FNumOfBytesTXPaket:Word;
    FOnDataAvail: TCommDataAvailEvent;


    FWriteDelay: DWORD;
    FWriteThread: TWriteThread;
    FWriteEvent: THandle;
    FKillThreads: Boolean;
    FOnSetBufOut:TSetBufOutEvent;
    FWriteSection: TRTLCriticalSection;

    Function GetConnected:boolean;
    Procedure SetConnected(const VALUE:boolean);
    Procedure SetComNumber(const VALUE:Integer);
    Procedure SetBaudRate(const VALUE:TBaudRate);
    Procedure SetParity(const VALUE:TParity);
    Procedure SetStopBits(const VALUE:TStopBits);
    Procedure SetByteSize(const VALUE:TByteSize);
    Procedure SetReadActive(const VALUE:Boolean);
    Function  GetReadActive : Boolean;
    Procedure SetTimeOuts(const VALUE:Integer);

 protected
    { Protected declarations }
    FbaseAddres         : Word; //базовый адрес порта
    FBaudRate           : TbaudRate;
    FByteSize           : TbyteSize;
    FStopBits           : TStopBits;
    FParity             : TParity;
    FHandle             : THandle;
    FTimeOut            : Integer;
    FReadThread : TreadThread;

    Buf,Key:array[0..15]of byte;
    Rcon:byte;

    procedure DoOpenPort;        //открытие порта
    procedure DoClosePort;       //закрытие порта
    procedure ApplyComSettings; //установка параметров порта
    procedure ApplyComTimeOuts; //установка тайм-аутов порта
    //процедуры шифрования
    procedure D1a2sdqr_(var K);//декодирование принятого пакета
    procedure D1a2sdqr(var K: array of Byte);//декодирование принятого блока
    procedure Ea4z3x_(var K);  //кодирование отправляемого пакета
    procedure Ea4z3x(var K: array of Byte);  //кодирование отправляемого блока

    procedure Ckrft7qw;         //calc_s_table_based_values;
    procedure a_g_fdrw(var A1, A2, A3: byte);//calc_xtimes
    procedure poiewrn;          //Dec_key_schedule;
    procedure vn1kf6ow;         //Dec_shift_row;
    procedure prjhc34as;        //enc_key_schedule
    procedure cvbd35sk;         //enc_shift_row
    procedure alpqwe3d1;        //inv_mix_column
    procedure yt2fa1b6;

  public
    { Public declarations }
    NumOfLastReceived:DWORD;
    LastTimeReceived:Dword;
    LastTimeTransmitted:Dword;
    FInBuffer:array[0..1023] of byte;//временный буфер накопления принятых данных
    BufReceived: array[0..1023] of Byte;//буфер шифрованных данных принятых от адаптеров
    BuferIN:  array[0..1023] of Byte;//буфер расшифрованных данных, принятых от адаптеров
    Org_UPR:array[0..1023]of byte;//буфер матрицы

    Org_IND:array[0..1023]of byte;//буфер матрицы
    BuferOut: array[0..1023] of Byte;//буфер нешифрованных данных для передачи в адаптеры
    BufTransmitted: array[0..1023] of Byte;//буфер шифрованных данных отправленных адаптерам
    KeyNumberCode:LongWord;
    Constructor Create(AOwner:Tcomponent);override;
    Destructor  Destroy; override;
    procedure Open;
    procedure Close;
    Function Connect:boolean;
    Function GetState(var CodeError : Cardinal):TcomStat;//состояние порта
    Property ComNumber :integer read FcomNumber write SetComNumber;
    Property Connected :Boolean read GetConnected write SetConnected;
    Property BaudRate  :TBaudRate read FBaudRate write SetBaudRate;
    Property ByteSize  :TByteSize read FByteSize write SetByteSize;
    Property Parity  :TParity read FParity write SetParity;
    Property StopBits  :TStopBits read FStopBits write SetStopBits;
    property TimeOut: Integer read FTimeOut write SetTimeOuts;
    property WriteDelay: DWORD read FWriteDelay write FWriteDelay;
    property NumOfBytesRxPaket: WORD read FNumOfBytesRXPaket write FNumOfBytesRXPaket;
    property NumOfBytesTXPaket: WORD read FNumOfBytesTXPaket write FNumOfBytesTXPaket;
    Property OnSetBufOut : TSetBufOutEvent read FOnSetBufOut write FOnSetBufOut;
    property OnDataAvail: TCommDataAvailEvent read FOnDataAvail write FOnDataAvail;

  published
    { Published declarations }
  end;

  VAR BUF_OUT:array[1..512]of byte;
implementation

Const
  WindowsBaudRates : array[br110..br115200] of Dword= (
       cbr_110, cbr_300, cbr_600, cbr_1200, cbr_2400, cbr_4800,cbr_9600,
       cbr_14400, cbr_19200, cbr_38400, cbr_56000, cbr_57600,cbr_115200 );
  dcb_Binary              = $00000001;
  dcb_ParityCheck         = $00000002;
  dcb_OutxCtsFlow         = $00000004;
  dcb_OutxDsrFlow         = $00000008;
  dcb_DtrControlMask      = $00000030;
  dcb_DtrControlDisable   = $00000000;
  dcb_DtrControlEnable    = $00000010;
  dcb_DtrControlHandshake = $00000020;
  dcb_DsrSensivity        = $00000040;
  dcb_TXContinueOnXoff    = $00000080;
  dcb_OutX                = $00000100;
  dcb_InX                 = $00000200;
  dcb_ErrorChar           = $00000400;
  dcb_NullStrip           = $00000800;
  dcb_RtsControlMask      = $00003000;
  dcb_RtsControlDisable   = $00000000;
  dcb_RtsControlEnable    = $00001000;
  dcb_RtsControlHandshake = $00002000;
  dcb_RtsControlToggle    = $00003000;
  dcb_AbortOnError        = $00004000;
  dcb_Reserveds           = $FFFF8000;

Constructor TComCryptM.Create(AOwner:Tcomponent);
Begin
 Inherited Create(AOwner);
 KeyNumberCode:=KeyNumber;
 FHandle := INVALID_HANDLE_VALUE;
 FComNumber := 2;
 FBaudRate := br19200;
 FParity := ptNone;
 FStopBits := sb1BITS;
 FByteSize := bs8;
 FReadReadyEvent := CreateEvent(nil, False, False, nil);
 FWriteEvent := CreateEvent(nil, False, False, nil);
 FReadEvent := CreateEvent(nil, False, False, nil);
end;

Destructor TComCryptM.Destroy;
Begin
 DoClosePort;
 CloseHandle(FWriteEvent);
 CloseHandle(FReadEvent);
 CloseHandle(FReadReadyEvent);
 Inherited Destroy;
end;

Function TComCryptM.GetConnected:boolean;
begin
 Result:=(Fhandle<>INVALID_HANDLE_VALUE);
end;

Procedure TComCryptM.SetConnected(const Value:boolean);
begin
 IF value then DoOpenPort else DoClosePort;
end;

Function TComCryptM.Connect:boolean;
begin
 DoOpenPort;
 Result:=Connected;
end;

procedure TComCryptM.Open;
begin
 DoOpenPort;
end;

procedure TComCryptM.Close;
begin
 DoClosePort;
end;

Procedure TComCryptM.SetComNumber(const VALUE:Integer);
VAR Active:Boolean;
begin
 If FcomNumber = Value Then Exit;
 Active:=Connected;
 If Active then DoClosePort;
 FComNumber:=Value;
 If Active then DoOpenPort;
end;

procedure TComCryptM.DoOpenPort;        //открытие порта
VAR ComName:String;
begin
 If Connected Then Exit;
 ComName:=Format('\\.\COM%-d',[FComNumber]);
 Fhandle:=CreateFile(PChar(comName),
           GENERIC_READ or GENERIC_WRITE,
           0, // Not shared
           nil, // No security attributes
           OPEN_EXISTING,
           FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED, //синхронный режим доступа
           0 // No template
           ) ;
  IF Not Connected Then exit; //ошибка открытия порта
  ApplyCOMSettings;
  FKillThreads:=False;

  SetCommMask(FHandle, EV_BREAK or EV_CTS or EV_DSR or EV_ERR or
        EV_RING or EV_RLSD or EV_RXCHAR or EV_TXEMPTY);
 { Start and wait read thread }
  FReadThread := TReadThread.Create(Self);
  FReadThread.Resume;
  WaitForSingleObject(FReadEvent, 500);

  FWriteThread := TWriteThread.Create(Self);
  FWriteThread.Resume;
  WaitForSingleObject(FWriteEvent, 500);
  FWriteThread.FComHandle:=Fhandle;

  LastTimeReceived:=0;
  LastTimeTransmitted:=0;
  NumOfLastReceived:=0;
end;

procedure TComCryptM.DoClosePort;       //закрытие порта
begin
 FKillThreads := True;
 If not Connected then exit;
 SetReadActive(False);

 FWriteThread.Terminate;
 FWriteThread.WaitFor;
 FWriteThread.Free;
 FWriteThread := nil;

 FReadThread.Terminate;
// FReadThread.WaitFor;
 FReadThread.Free;
 FReadThread := nil;

 SetCommMask(FHandle, 0);
 CloseHandle(Fhandle);
 FHandle:=INVALID_HANDLE_VALUE;
end;

procedure TComCryptM.SetReadActive(const Value:Boolean);
begin
 If not Assigned(FReadThread) then exit;
 IF Value then begin
  IF FReadThread.Suspended then FReadThread.resume;
 end else  begin
  IF NOT FReadThread.Suspended then FReadThread.Suspend;
 end;
end;

Function TComCryptM.GetReadActive:Boolean;
begin
 Result:=False;
 If Assigned(FReadThread) then result:=NOT(FReadThread.Suspended);
end;


procedure TComCryptM.ApplyCOMSettings;
var dcb: TDCB;
begin
 If not Connected then exit;
 FillChar(dcb,SizeOf(dcb),0);
 dcb.DCBlength:=SizeOf(dcb);
 dcb.BaudRate:=WindowsBaudRates[FBaudRate];
 dcb.Flags:=dcb_Binary;
 dcb.ByteSize:=5+ord(FbyteSize);
 dcb.Parity:=ord(FParity);
 dcb.StopBits:=Ord(FStopBits);
 SetCommState(Fhandle,dcb);
 ApplyComTimeOuts;
end;

Procedure TComCryptM.SetTimeOuts(const VALUE:Integer);
begin
 If FTimeOut = Value then exit;
 FTimeOut:= Value;
 ApplyCOMTimeOuts;
end;

procedure TComCryptM.ApplyComTimeOuts;
VAR CT:TCommTimeOuts;
begin
 If not Connected then exit;
 CT.ReadIntervalTimeout:=FTimeOut;
 CT.ReadTotalTimeoutMultiplier:=FTimeOut;
 CT.ReadTotalTimeoutConstant:=0;
 CT.WriteTotalTimeoutMultiplier:=0;
 CT.WriteTotalTimeoutConstant:=0;
 SetCommTimeouts(FHandle,ct);
end;

Procedure TComCryptM.SetBaudRate(const VALUE:TBaudRate);
begin
 If FBaudRate = Value then exit;
 FBaudRate:= Value;
 ApplyCOMSettings;
end;

Procedure TComCryptM.SetByteSize(const VALUE:TByteSize);
begin
 If FByteSize = Value then exit;
 FByteSize:= Value;
 ApplyCOMSettings;
end;

Procedure TComCryptM.SetParity(const VALUE:TParity);
begin
 If FParity = Value then exit;
 FParity:= Value;
 ApplyCOMSettings;
end;

Procedure TComCryptM.SetStopBits(const VALUE:TStopBits);
begin
 If FStopBits = Value then exit;
 FStopBits:= Value;
 ApplyCOMSettings;
end;

Function TComCryptM.GetState(var CodeError : Cardinal):TcomStat;//состояние порта
begin
 ClearCommError(FHandle,CodeError,@Result);
end;

constructor TWriteThread.Create(ComPort: TComCryptM);
begin
  inherited Create(True);
  FComPort := ComPort;
  FComHandle := FComPort.FHandle;
  FDelay := ComPort.WriteDelay;
  FillChar(FWOL, SizeOf(FWOL), 0);
  FWOL.hEvent := CreateEvent(nil, True, False, nil);
end;

destructor TWriteThread.Destroy;
begin
  CloseHandle(FWOL.hEvent);
  inherited;
end;

procedure TWriteThread.Execute;
var
  BytesWritten: DWORD;
  lpErrors: DWORD;
  lpStat: TComStat;

begin
  repeat
    if FComPort.FKillThreads then Break;
    FBytesToWrite:=FComPort.FNumOfBytesTXPaket;
    Synchronize(DoSetBufOut);
    Move(FComPort.BuferOut,FComPort.BufTransmitted,FBytesToWrite);
    Synchronize(EnCryptData);
    ClearCommError(FComHandle, lpErrors, @lpStat);
    if FComPort.GetConnected and (FBytesToWrite > 0) and (not FComPort.FKillThreads) then begin
      if NOT WriteFile(FComHandle, FComPort.BufTransmitted, FBytesToWrite, BytesWritten, @FWOL)
      then if GetLastError = ERROR_IO_PENDING
           Then if GetOverlappedResult(FComHandle, FWOL, BytesWritten, True)
                then ResetEvent(FWOL.hEvent);
      FComPort.LastTimeTransmitted:=GetTickCount;
    end;
    Sleep(55);
  until FComPort.FKillThreads or Terminated;
end;

Procedure TWriteThread.DoSetBufOut;
Begin
  If assigned (FComPort.FOnSetBufOut)
  then FComPort.FOnSetBufOut(FBytesToWrite,FComPort.BuferOut)
  else FBytesToWrite:=0;
end;

Procedure TWriteThread.EnCryptData;
Begin
  FComPort.Ea4z3x_(FComPort.BufTransmitted);
end;

//<----------------------------------------------------
{ TReadThread }
procedure TReadThread.DoOnDataAvail;
begin
  FComPort.OnDataAvail(FBytesReaded,FComPort.FInBuffer);
end;
procedure TReadThread.DecryptData;
begin
  FComPort.D1a2sdqr_(FComPort.BuferIn);
end;

constructor TReadThread.Create(ComPort: TComCryptM);
begin
  inherited Create(True);
  FComPort := ComPort;
  FComHandle := FComPort.FHandle;
  FDelay := 1;
  FillChar(FROL, SizeOf(FROL), 0);
  FROL.hEvent := CreateEvent(nil, True, False, nil);
end;

destructor TReadThread.Destroy;
begin
  CloseHandle(FROL.hEvent);
  inherited;
end;

procedure TReadThread.Execute;
var
  BytesToRead: DWORD;
  lpErrors: DWORD;
  lpStat: TComStat;
begin
  repeat
    if FComPort.FKillThreads then Break;
    if Not FComPort.Connected then begin
      lpErrors := 0;
      FillChar(lpStat, SizeOf(LpStat), 0);
    end else begin
      ClearCommError(FComHandle, lpErrors, @lpStat);
      BytesToRead := 1023;
      if NOT ReadFile(FComHandle, FComPort.FInBuffer, BytesToRead, FBytesReaded, @FROL) then begin
        if GetLastError = ERROR_IO_PENDING then
        if GetOverlappedResult(FComHandle, FROL, FBytesReaded, True) then begin
          ResetEvent(FROL.hEvent);
          FComPort.NumOfLastReceived:=FBytesReaded;
          IF FBytesReaded>0 then begin
            Move(FComPort.FInBuffer,FComPort.BufReceived,FBytesReaded);
            FComPort.LastTimeReceived:=GetTickCount;
            IF (FComPort.FNumOfBytesRXPaket>0) then begin
              IF (FComPort.FNumOfBytesRXPaket+FComPort.FNumOfBytesRXPaket)=FBytesReaded then begin
                FBytesReaded:=FComPort.FNumOfBytesRXPaket;
                Move(FComPort.FInBuffer[FBytesReaded],FComPort.FInBuffer[0],FBytesReaded);
              end;
              IF (FComPort.FNumOfBytesRXPaket<>FBytesReaded) then FBytesReaded:=0;
            end;
          end;
          IF FBytesReaded>0 then begin
            Move(FComPort.FInBuffer,FComPort.BuferIN,FBytesReaded);
            Synchronize(DecryptData);
            IF Assigned(FComPort.FOnDataAvail) then Synchronize(DoOnDataAvail);
          end;
        end;
      end;
    end;
  until FComPort.FKillThreads or Terminated;
end;

//==============================================================================
VAR  S_TABLE:array[0..255]of byte=(
         $63,$7C,$77,$7B,$F2,$6B,$6F,$C5,$30,$01,$67,$2B,$FE,$D7,$AB,$76,
         $CA,$82,$C9,$7D,$FA,$59,$47,$F0,$AD,$D4,$A2,$AF,$9C,$A4,$72,$C0,
         $B7,$FD,$93,$26,$36,$3F,$F7,$CC,$34,$A5,$E5,$F1,$71,$D8,$31,$15,
         $04,$C7,$23,$C3,$18,$96,$05,$9A,$07,$12,$80,$E2,$EB,$27,$B2,$75,
         $09,$83,$2C,$1A,$1B,$6E,$5A,$A0,$52,$3B,$D6,$B3,$29,$E3,$2F,$84,
         $53,$D1,$00,$ED,$20,$FC,$B1,$5B,$6A,$CB,$BE,$39,$4A,$4C,$58,$CF,
         $D0,$EF,$AA,$FB,$43,$4D,$33,$85,$45,$F9,$02,$7F,$50,$3C,$9F,$A8,
         $51,$A3,$40,$8F,$92,$9D,$38,$F5,$BC,$B6,$DA,$21,$10,$FF,$F3,$D2,
         $CD,$0C,$13,$EC,$5F,$97,$44,$17,$C4,$A7,$7E,$3D,$64,$5D,$19,$73,
         $60,$81,$4F,$DC,$22,$2A,$90,$88,$46,$EE,$B8,$14,$DE,$5E,$0B,$DB,
         $E0,$32,$3A,$0A,$49,$06,$24,$5C,$C2,$D3,$AC,$62,$91,$95,$E4,$79,
         $E7,$C8,$37,$6D,$8D,$D5,$4E,$A9,$6C,$56,$F4,$EA,$65,$7A,$AE,$08,
         $BA,$78,$25,$2E,$1C,$A6,$B4,$C6,$E8,$DD,$74,$1F,$4B,$BD,$8B,$8A,
         $70,$3E,$B5,$66,$48,$03,$F6,$0E,$61,$35,$57,$B9,$86,$C1,$1D,$9E,
         $E1,$F8,$98,$11,$69,$D9,$8E,$94,$9B,$1E,$87,$E9,$CE,$55,$28,$DF,
         $8C,$A1,$89,$0D,$BF,$E6,$42,$68,$41,$99,$2D,$0F,$B0,$54,$BB,$16);
  SI_TABLE:array[0..255]of byte=(
         $52,$09,$6A,$D5,$30,$36,$A5,$38,$BF,$40,$A3,$9E,$81,$F3,$D7,$FB,
         $7C,$E3,$39,$82,$9B,$2F,$FF,$87,$34,$8E,$43,$44,$C4,$DE,$E9,$CB,
         $54,$7B,$94,$32,$A6,$C2,$23,$3D,$EE,$4C,$95,$0B,$42,$FA,$C3,$4E,
         $08,$2E,$A1,$66,$28,$D9,$24,$B2,$76,$5B,$A2,$49,$6D,$8B,$D1,$25,
         $72,$F8,$F6,$64,$86,$68,$98,$16,$D4,$A4,$5C,$CC,$5D,$65,$B6,$92,
         $6C,$70,$48,$50,$FD,$ED,$B9,$DA,$5E,$15,$46,$57,$A7,$8D,$9D,$84,
         $90,$D8,$AB,$00,$8C,$BC,$D3,$0A,$F7,$E4,$58,$05,$B8,$B3,$45,$06,
         $D0,$2C,$1E,$8F,$CA,$3F,$0F,$02,$C1,$AF,$BD,$03,$01,$13,$8A,$6B,
         $3A,$91,$11,$41,$4F,$67,$DC,$EA,$97,$F2,$CF,$CE,$F0,$B4,$E6,$73,
         $96,$AC,$74,$22,$E7,$AD,$35,$85,$E2,$F9,$37,$E8,$1C,$75,$DF,$6E,
         $47,$F1,$1A,$71,$1D,$29,$C5,$89,$6F,$B7,$62,$0E,$AA,$18,$BE,$1B,
         $FC,$56,$3E,$4B,$C6,$D2,$79,$20,$9A,$DB,$C0,$FE,$78,$CD,$5A,$F4,
         $1F,$DD,$A8,$33,$88,$07,$C7,$31,$B1,$12,$10,$59,$27,$80,$EC,$5F,
         $60,$51,$7F,$A9,$19,$B5,$4A,$0D,$2D,$E5,$7A,$9F,$93,$C9,$9C,$EF,
         $A0,$E0,$3B,$4D,$AE,$2A,$F5,$B0,$C8,$EB,$BB,$3C,$83,$53,$99,$61,
         $17,$2B,$04,$7E,$BA,$77,$D6,$26,$E1,$69,$14,$63,$55,$21,$0C,$7D);
(*Декодирование присланной матрицы размером 16 байт
  результат помещается в эту же матрицу*)
procedure TComCryptM.D1a2sdqr(VAR K:array OF Byte);
var I,J:integer;
procedure Prepare_DecKey;
begin
 KEY[00]:=KEYDEC_00;
 KEY[15]:=KEYDEC_15;
 KEY[01]:=KEYDEC_01;
 KEY[14]:=KEYDEC_14;
 KEY[02]:=KEYDEC_02;
 KEY[13]:=KEYDEC_13;
 KEY[03]:=KEYDEC_03;
 KEY[12]:=KEYDEC_12;
 KEY[04]:=KEYDEC_04;
 KEY[11]:=KEYDEC_11;
 KEY[05]:=KEYDEC_05;
 KEY[10]:=KEYDEC_10;
 KEY[06]:=KEYDEC_06;
 KEY[09]:=KEYDEC_09;
 KEY[07]:=KEYDEC_07;
 KEY[08]:=KEYDEC_08;
end;
begin
 MoveMemory(@BUF,@K,16);       //пересылаем присланную матрицу в рабочий буфер
 Prepare_DecKey;
// MoveMemory(@KEY,@KEY_DEC,16); //пересылаем ключ декодирования в рабочий буфер ключа
 Rcon:=$36;
 For J:=0 to 15 do BUF[J]:=BUF[J]XOR KEY[J];//key_addition
 For I:=1 to 10 do begin
  For J:=0 to 15 do BUF[J]:=SI_TABLE[BUF[J]];//substitution_SI
  vn1kf6ow;     //Dec_shift_row
  poiewrn;      //Dec_key_schedule;
  For J:=0 to 15 do BUF[J]:=BUF[J]XOR KEY[J];//key_addition
  IF I<10 then alpqwe3d1;//inv_mix_column;
 end;
 MoveMemory(@K,@BUF,16);        //перемещаем результат в присланную матрицу
end;


(*Кодирование присланной матрицы размером 16 байт
  результат помещается в эту же матрицу*)
procedure TComCryptM.Ea4z3x(VAR K:array OF Byte);
var I,J:integer;
procedure Prepare_EnCKey;
begin
 KEY[00]:=KEYENC_00;
 KEY[15]:=KEYENC_15;
 KEY[01]:=KEYENC_01;
 KEY[14]:=KEYENC_14;
 KEY[02]:=KEYENC_02;
 KEY[13]:=KEYENC_13;
 KEY[03]:=KEYENC_03;
 KEY[12]:=KEYENC_12;
 KEY[04]:=KEYENC_04;
 KEY[11]:=KEYENC_11;
 KEY[05]:=KEYENC_05;
 KEY[10]:=KEYENC_10;
 KEY[06]:=KEYENC_06;
 KEY[09]:=KEYENC_09;
 KEY[07]:=KEYENC_07;
 KEY[08]:=KEYENC_08;
end;

begin
 MoveMemory(@BUF,@K,16);       //пересылаем присланную матрицу в рабочий буфер
 Prepare_EnCKey;
 Rcon:=1;
 For J:=0 to 15 do BUF[J]:=BUF[J]XOR KEY[J];//key_addition
 For I:=1 to 10 do begin
  For J:=0 to 15 do BUF[J]:=S_TABLE[BUF[J]];//substitution_S
  cvbd35sk;     //enc_shift_row
  IF I<10 then yt2fa1b6;        //mix_column
  prjhc34as;//enc_key_schedule
  For J:=0 to 15 do BUF[J]:=BUF[J]XOR KEY[J]; //key_addition
 end;
 MoveMemory(@K,@BUF,16);       //перемещаем результат в присланную матрицу
end;


//enc_shift_row
procedure TComCryptM.cvbd35sk;
var A,A1:byte;
begin
  A:=BUF[01];BUF[01]:=BUF[05];BUF[05]:=BUF[09];BUF[09]:=BUF[13];BUF[13]:=A;
  A:=BUF[02];A1:=BUF[06];
  BUF[02]:=BUF[10];BUF[06]:=BUF[14];BUF[10]:=A;BUF[14]:=A1;
  A:=BUF[15];BUF[15]:=BUF[11];BUF[11]:=BUF[07];BUF[07]:=BUF[03];BUF[03]:=A;
end;

//Dec_shift_row
procedure TComCryptM.vn1kf6ow;
var A,A1:byte;
begin
  A:=BUF[13];BUF[13]:=BUF[09];BUF[09]:=BUF[05];BUF[05]:=BUF[01];BUF[01]:=A;
  A:=BUF[10];A1:=BUF[14];
  BUF[10]:=BUF[02];BUF[14]:=BUF[06];BUF[02]:=A;BUF[06]:=A1;
  A:=BUF[03];BUF[03]:=BUF[07];BUF[07]:=BUF[11];BUF[11]:=BUF[15];BUF[15]:=A;
end;

//mix_column
procedure TComCryptM.yt2fa1b6;
var A,A1,A2,A3:byte;
begin
 A1:=BUF[00] XOR BUF[01];
 A:=(A1 XOR BUF[02]) XOR BUF[03];
 A2:=BUF[01] XOR BUF[02];
 A3:=BUF[02] XOR BUF[03];
 a_g_fdrw(A1,A2,A3);//calc_xtimes
 BUF[00]:=(A XOR A1)XOR BUF[00];
 BUF[01]:=(A XOR A2)XOR BUF[01];
 BUF[02]:=(A XOR A3)XOR BUF[02];
 BUF[03]:=(((BUF[00] XOR BUF[01]) XOR BUF[02]) XOR A);

 A1:=BUF[04] XOR BUF[05];
 A:=(A1 XOR BUF[06]) XOR BUF[07];
 A2:=BUF[05] XOR BUF[06];
 A3:=BUF[06] XOR BUF[07];
 a_g_fdrw(A1,A2,A3);//calc_xtimes
 BUF[04]:=(A XOR A1)XOR BUF[04];
 BUF[05]:=(A XOR A2)XOR BUF[05];
 BUF[06]:=(A XOR A3)XOR BUF[06];
 BUF[07]:=(((BUF[04] XOR BUF[05]) XOR BUF[06]) XOR A);

 A1:=BUF[08] XOR BUF[09];
 A:=(A1 XOR BUF[10]) XOR BUF[11];
 A2:=BUF[09] XOR BUF[10];
 A3:=BUF[10] XOR BUF[11];
 a_g_fdrw(A1,A2,A3);//calc_xtimes
 BUF[08]:=(A XOR A1)XOR BUF[08];
 BUF[09]:=(A XOR A2)XOR BUF[09];
 BUF[10]:=(A XOR A3)XOR BUF[10];
 BUF[11]:=(((BUF[08] XOR BUF[09]) XOR BUF[10]) XOR A);

 A1:=BUF[12] XOR BUF[13];
  A:=(A1 XOR BUF[14]) XOR BUF[15];
 A2:=BUF[13] XOR BUF[14];
 A3:=BUF[14] XOR BUF[15];
 a_g_fdrw(A1,A2,A3);//calc_xtimes
 BUF[12]:=(A XOR A1)XOR BUF[12];
 BUF[13]:=(A XOR A2)XOR BUF[13];
 BUF[14]:=(A XOR A3)XOR BUF[14];
 BUF[15]:=(((BUF[12] XOR BUF[13]) XOR BUF[14]) XOR A);
end;

//inv_mix_column;
procedure TComCryptM.alpqwe3d1;
var D0,D1,D2,A,A1,A2,A3:byte;
begin
 A:= BUF[00] XOR BUF[01] XOR BUF[02] XOR BUF[03];
 A1:=BUF[00] XOR BUF[02];
 IF A1>127 then A1:=(A1 SHL 1) XOR $1B else A1:=A1 SHL 1;
 A2:=BUF[01] XOR BUF[03];
 IF A2>127 then A2:=(A2 SHL 1) XOR $1B else A2:=A2 SHL 1;
 A3:=A1 XOR A2;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 A3:=A XOR A3;
 D0:=BUF[00] XOR BUF[01] XOR A1;
 IF D0>127 then D0:=(D0 SHL 1) XOR $1B else D0:=D0 SHL 1;
 D1:=BUF[01] XOR BUF[02] XOR A2;
 IF D1>127 then D1:=(D1 SHL 1) XOR $1B else D1:=D1 SHL 1;
 D2:=BUF[02] XOR BUF[03] XOR A1;
 IF D2>127 then D2:=(D2 SHL 1) XOR $1B else D2:=D2 SHL 1;
 BUF[00]:=(D0 XOR A3)XOR BUF[00];
 BUF[01]:=(D1 XOR A3)XOR BUF[01];
 BUF[02]:=(D2 XOR A3)XOR BUF[02];
 BUF[03]:=(((BUF[00] XOR BUF[01]) XOR BUF[02]) XOR A);

 A:=((BUF[04] XOR BUF[05])XOR BUF[06])XOR BUF[07];
 A1:=BUF[04] XOR BUF[06];
 IF A1>127 then A1:=(A1 SHL 1) XOR $1B else A1:=A1 SHL 1;
 A2:=BUF[05] XOR BUF[07];
 IF A2>127 then A2:=(A2 SHL 1) XOR $1B else A2:=A2 SHL 1;
 A3:=A1 XOR A2;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 A3:=A XOR A3;
 D0:=BUF[04] XOR BUF[05] XOR A1;
 IF D0>127 then D0:=(D0 SHL 1) XOR $1B else D0:=D0 SHL 1;
 D1:=BUF[05] XOR BUF[06] XOR A2;
 IF D1>127 then D1:=(D1 SHL 1) XOR $1B else D1:=D1 SHL 1;
 D2:=BUF[06] XOR BUF[07] XOR A1;
 IF D2>127 then D2:=(D2 SHL 1) XOR $1B else D2:=D2 SHL 1;
 BUF[04]:=(D0 XOR A3)XOR BUF[04];
 BUF[05]:=(D1 XOR A3)XOR BUF[05];
 BUF[06]:=(D2 XOR A3)XOR BUF[06];
 BUF[07]:=(((BUF[04] XOR BUF[05]) XOR BUF[06]) XOR A);

 A:=((BUF[08] XOR BUF[09])XOR BUF[10])XOR BUF[11];
 A1:=BUF[08] XOR BUF[10];
 IF A1>127 then A1:=(A1 SHL 1) XOR $1B else A1:=A1 SHL 1;
 A2:=BUF[09] XOR BUF[11];
 IF A2>127 then A2:=(A2 SHL 1) XOR $1B else A2:=A2 SHL 1;
 A3:=A1 XOR A2;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 A3:=A XOR A3;
 D0:=BUF[08] XOR BUF[09] XOR A1;
 IF D0>127 then D0:=(D0 SHL 1) XOR $1B else D0:=D0 SHL 1;
 D1:=BUF[09] XOR BUF[10] XOR A2;
 IF D1>127 then D1:=(D1 SHL 1) XOR $1B else D1:=D1 SHL 1;
 D2:=BUF[10] XOR BUF[11] XOR A1;
 IF D2>127 then D2:=(D2 SHL 1) XOR $1B else D2:=D2 SHL 1;
 BUF[08]:=(D0 XOR A3)XOR BUF[08];
 BUF[09]:=(D1 XOR A3)XOR BUF[09];
 BUF[10]:=(D2 XOR A3)XOR BUF[10];
 BUF[11]:=(((BUF[08] XOR BUF[09]) XOR BUF[10]) XOR A);

 A:=((BUF[12] XOR BUF[13])XOR BUF[14])XOR BUF[15];
 A1:=BUF[12] XOR BUF[14];
 IF A1>127 then A1:=(A1 SHL 1) XOR $1B else A1:=A1 SHL 1;
 A2:=BUF[13] XOR BUF[15];
 IF A2>127 then A2:=(A2 SHL 1) XOR $1B else A2:=A2 SHL 1;
 A3:=A1 XOR A2;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
 A3:=A XOR A3;
 D0:=BUF[12] XOR BUF[13] XOR A1;
 IF D0>127 then D0:=(D0 SHL 1) XOR $1B else D0:=D0 SHL 1;
 D1:=BUF[13] XOR BUF[14] XOR A2;
 IF D1>127 then D1:=(D1 SHL 1) XOR $1B else D1:=D1 SHL 1;
 D2:=BUF[14] XOR BUF[15] XOR A1;
 IF D2>127 then D2:=(D2 SHL 1) XOR $1B else D2:=D2 SHL 1;
 BUF[12]:=(D0 XOR A3)XOR BUF[12];
 BUF[13]:=(D1 XOR A3)XOR BUF[13];
 BUF[14]:=(D2 XOR A3)XOR BUF[14];
 BUF[15]:=(((BUF[12] XOR BUF[13]) XOR BUF[14]) XOR A);
end;

//calc_xtimes
procedure TComCryptM.a_g_fdrw(VAR A1,A2,A3:byte);
begin
 IF A1>127 then A1:=(A1 SHL 1) XOR $1B else A1:=A1 SHL 1;
 IF A2>127 then A2:=(A2 SHL 1) XOR $1B else A2:=A2 SHL 1;
 IF A3>127 then A3:=(A3 SHL 1) XOR $1B else A3:=A3 SHL 1;
end;

//enc_key_schedule
procedure TComCryptM.prjhc34as;
begin
 Ckrft7qw;//calc_s_table_based_values
 Key[0]:=Key[0]XOR RCON;
 IF RCON=$80 then RCON:=$1B else RCON:=RCON SHL 1;
 KEY[04]:=KEY[00] XOR KEY[04];
 KEY[05]:=KEY[01] XOR KEY[05];
 KEY[06]:=KEY[02] XOR KEY[06];
 KEY[07]:=KEY[03] XOR KEY[07];
 KEY[08]:=KEY[04] XOR KEY[08];
 KEY[09]:=KEY[05] XOR KEY[09];
 KEY[10]:=KEY[06] XOR KEY[10];
 KEY[11]:=KEY[07] XOR KEY[11];
 KEY[12]:=KEY[08] XOR KEY[12];
 KEY[13]:=KEY[09] XOR KEY[13];
 KEY[14]:=KEY[10] XOR KEY[14];
 KEY[15]:=KEY[11] XOR KEY[15];
end;

//Dec_key_schedule;
procedure TComCryptM.poiewrn;
begin
 KEY[12]:=KEY[08] XOR KEY[12];
 KEY[13]:=KEY[09] XOR KEY[13];
 KEY[14]:=KEY[10] XOR KEY[14];
 KEY[15]:=KEY[11] XOR KEY[15];
 KEY[08]:=KEY[04] XOR KEY[08];
 KEY[09]:=KEY[05] XOR KEY[09];
 KEY[10]:=KEY[06] XOR KEY[10];
 KEY[11]:=KEY[07] XOR KEY[11];
 KEY[04]:=KEY[00] XOR KEY[04];
 KEY[05]:=KEY[01] XOR KEY[05];
 KEY[06]:=KEY[02] XOR KEY[06];
 KEY[07]:=KEY[03] XOR KEY[07];
 Key[0]:=Key[0]XOR RCON;
 IF (RCON=$1B) then Rcon:=$80 else Rcon:=Rcon SHR 1;
 Ckrft7qw; //calc_s_table_based_values
end;

//calc_s_table_based_values
procedure TComCryptM.Ckrft7qw;
begin
 KEY[00]:=S_TABLE[KEY[13]] XOR KEY[00];
 KEY[01]:=S_TABLE[KEY[14]] XOR KEY[01];
 KEY[02]:=S_TABLE[KEY[15]] XOR KEY[02];
 KEY[03]:=S_TABLE[KEY[12]] XOR KEY[03];
end;

procedure TComCryptM.D1a2sdqr_(VAR K);
Type TB=array[0..1023]of byte;
var B:^TB;
begin
 B:=@K;
 D1a2sdqr(B[1]);
 IF FReadThread.FBytesReaded>17 then D1a2sdqr(B[17]);
 IF FReadThread.FBytesReaded>33 then D1a2sdqr(B[33]);
 IF FReadThread.FBytesReaded>49 then D1a2sdqr(B[49]);
end;

procedure TComCryptM.Ea4z3x_(VAR K);
Type TB=array[0..1023]of byte;
var B:^TB;
begin
 B:=@K;
 Ea4z3x(B[1]);
 IF FWriteThread.FBytesToWrite>17 then Ea4z3x(B[17]);
 IF FWriteThread.FBytesToWrite>33 then Ea4z3x(B[33]);
 IF FWriteThread.FBytesToWrite>49 then Ea4z3x(B[49]);
end;
//=============================================================================

end.
