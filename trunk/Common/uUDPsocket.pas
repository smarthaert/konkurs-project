unit uUDPsocket;

interface

uses
  Winsock, Classes, Sysutils, WinTypes, Messages, Forms;
const
   { Levels for reporting Status Messages}
  Status_None = 0;
  Status_Informational = 1;
  Status_Basic = 2;
  Status_Routines = 4;
  Status_Debug = 8;
  Status_Trace = 16;


  WM_ASYNCHRONOUSPROCESS = WM_USER + 101; {Message number for asynchronous socket messages}

const {protocol}
  Const_cmd_true = 'TRUE';

{$IFDEF NMF3}
resourcestring
{$ELSE}
const
{$ENDIF}
  Cons_Palette_Inet = 'Internet';
  Cons_Msg_Wsk = 'Initializing Winsock';
  Cons_Msg_Lkp = 'Host Lookup Canceled';
  Cons_Msg_Data = 'Sending Data';
  Cons_Msg_InvStrm = 'Invalid stream';
  Cons_Msg_Echk = 'Checking Error In Error Manager';
  Cons_Msg_Eno = 'Unknown Error No. ';
  Cons_Msg_ELkp = 'Looking Up Error Message';
  Cons_Err_Addr = 'Null Remote Address';
  Cons_Err_Buffer = 'Invalid buffer';

type

  UDPSockError = class(Exception);

   {Event Handlers}

  TOnErrorEvent = procedure(Sender: TObject; errno: word; Errmsg: string) of object;
  TOnStatus = procedure(Sender: TObject; status: string) of object;
  TOnReceive = procedure(Sender: TObject; NumberBytes: Integer; FromIP: string; Port: integer) of object;
  THandlerEvent = procedure(var handled: boolean) of object;
  TBuffInvalid = procedure(var handled: boolean; var Buff: array of AnsiChar; var length: integer) of object;
  TStreamInvalid = procedure(var handled: boolean; Stream: TStream) of object;

  TUDPSOCKET = class
  private
    IBuff: array[0..2048] of AnsiChar;
    IpBuf: array [0..127] of AnsiChar;
    IBuffSize: integer;
    FRemoteHost: string;
    FLocalIP: string;
    FRemotePort: integer;
    FLocalPort: integer; {Port at server to connect to}
    RemoteAddress, LocalAddress: TSockAddr; {Address of remote host}
    FSocketWindow: hwnd;
    Wait_Flag: boolean; {Flag to indicate if synchronous request completed or not}
    RemoteHostS, p: PHostEnt; {Entity to store remote host linfo from a Hostname request}
    Canceled: boolean; {Flag to indicate request cancelled}
    Succeed: boolean; {Flag for indicating if synchronous request succeded}
    MyWSAData: TWSADATA; {Socket Information}
    FOnStatus: TOnStatus; {} {Event handler on a status change}
    FReportLevel: integer; {Reporting Level}
    _status: string; {Current status}
    _ProcMsg: boolean; {Flag to supress or enable socket message processing}
    FLastErrorno: integer; {The last error Encountered}
    FOnErrorEvent: TOnErrorEvent; {} {Event handler for error nitification}
    FOnDataReceived: TOnReceive;
    FOnDataSend: TNotifyEvent;
    FOnInvalidHost: THandlerEvent;
    FOnStreamInvalid: TStreamInvalid;
    FOnBufferInvalid: TBuffInvalid;
    procedure WndProc(var message: TMessage);
    procedure ResolveRemoteHost;
    procedure SetLocalPort(NewLocalPort: integer);
    procedure ProcessIncomingdata;
  protected
    procedure StatusMessage(Level: byte; value: string);
    function ErrorManager(ignore: word): string;
    function SocketErrorStr(Errno: word): string;
    procedure Wait;
  public
    EventHandle: THandle;
    ThisSocket: TSocket;
    DefinedLocalIP   : string;
    constructor Create;
    destructor Destroy; override;
    procedure Loaded;
    procedure Cancel;
    procedure SendStream(DataStream: TStream; ISimple: Boolean); overload;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
    procedure SendStream(DataStream: TStream); overload;
    procedure SendBuffer(Buff: array of AnsiChar; length: integer); overload;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
    procedure SendBuffer(var Buff; length: integer); overload;
    procedure ReadStream(DataStream: TStream);
    procedure ReadBuffer(var Buff: array of AnsiChar; var length: integer); overload;
    procedure ReadBuffer(var Buff; length: integer); overload;
  published
    property RemoteHost: string read FRemoteHost write FRemoteHost; {Host Nmae or IP of remote host}
    property RemotePort: integer read FRemotePort write FRemotePort; {Port of remote host}
    property LocalPort: integer read FLocalPort write SetLocalPort; {Port of local host}
    property LocalIP:    string read FLocalIP write FLocalIP; {IP of local host}
    property ReportLevel: integer read FReportLevel write FReportLevel;
    property OnDataReceived: TOnReceive read FOnDataReceived write FOnDataReceived;
    property OnDataSend: TNotifyEvent read FOnDataSend write FOnDataSend;
    property OnStatus: TOnStatus read FOnStatus write FOnStatus;
    property OnInvalidHost: THandlerEvent read FOnInvalidHost write FOnInvalidHost;
    property OnStreamInvalid: TStreamInvalid read FOnStreamInvalid write FOnStreamInvalid;
    property OnBufferInvalid: TBuffInvalid read FOnBufferInvalid write FOnBufferInvalid;
  end;


implementation



procedure WaitforSync(Handle: THandle);
begin
  repeat
    if MsgWaitForMultipleObjects(1, Handle, False,
      INFINITE, QS_ALLINPUT)
      = WAIT_OBJECT_0 + 1
      then Application.ProcessMessages
    else BREAK;
  until True = False;
end;

procedure TUDPSOCKET.Cancel;
begin
  StatusMessage(Status_Debug, 'sPSk_Cons_msg_Cancel'); {Status Message}
  Canceled := True; {Set Cancelled to true}
  SetEvent(EventHandle);
end;


constructor TUDPSOCKET.Create;

begin
  _ProcMsg := FALSE; {Inhibit Event processing for socket}
   { Initialize memory }
  getmem(RemoteHostS, MAXGETHOSTSTRUCT); {Initialize memory for host address structure}
{$WARNINGS OFF}
  FSocketWindow := AllocateHWnd(WndProc); {Create Window handle to receive message notification}
{$WARNINGS ON}
   { Set Variables }
  FreportLevel := Status_Informational; {Set Default Reporting Level}
  FLocalIP:='0.0.0.0'; {Set Default local IP}
  Canceled := FALSE; {Cancelled flag off}
  EventHandle := CreateEvent(nil, True, False, '');
  StatusMessage(Status_debug, Cons_Msg_Wsk); {Status Message}
  if WSAStartUp($0101, MyWSADATA) = 0 then
  begin
  P := GetHostByName(@ipBuf);
  if P <> nil then DefinedLocalIp := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
    try
      ThisSocket := Socket(AF_INET, SOCK_DGRAM, 0); {Get a new socket}
      if ThisSocket = TSocket(INVALID_SOCKET) then
        ErrorManager(WSAEWOULDBLOCK); {If error handle error}
      setsockopt(ThisSocket, SOL_SOCKET, SO_DONTLINGER, Const_cmd_true, 4);
    except
      WSACleanup; {If error Cleanup}
      raise; {Pass exception to calling function}
    end
  end
  else
    ErrorManager(WSAEWOULDBLOCK); {Handle Statrtup error}
  _ProcMsg := true;
end;

{*******************************************************************************************
Destroy Power Socket
********************************************************************************************}

destructor TUDPSOCKET.Destroy;
begin
   {cancel; }
  freemem(RemoteHostS, MAXGETHOSTSTRUCT); {Free memory for fetching Host Entity}
{$WARNINGS OFF}
  DeAllocateHWnd(FSocketWindow); {Release window handle for Winsock messages}
{$WARNINGS ON}
  CloseHandle(EventHandle);
  WSACleanUp; {Clean up Winsock}
  inherited destroy; {Do inherited destroy method}
end;

procedure TUDPSOCKET.SetLocalPort(NewLocalPort: integer);
begin
  if ThisSocket <> 0 then closesocket(ThisSocket);
  WSAcleanup;
  if WSAStartUp($0101, MyWSADATA) = 0 then try
    ThisSocket := Socket(AF_INET, SOCK_DGRAM, 0); {Get a new socket}
    if ThisSocket = TSocket(INVALID_SOCKET) then
      ErrorManager(WSAEWOULDBLOCK); {If error handle error}
  except
    WSACleanup; {If error Cleanup}
    raise; {Pass exception to calling function}
  end
  else
    ErrorManager(WSAEWOULDBLOCK); {Handle Statrtup error}
  FLocalPort := NewLocalPort;
  Loaded;
////------------------------------------------------------------------------------
////------------------------------------------------------------------------------
  ResolveRemoteHost;
//  if RemoteAddress.sin_addr.S_addr = 0 then
//    raise UDPSockError.create(Cons_Err_Addr); {If Resolving failed raise exception}
  StatusMessage(Status_Basic, Cons_Msg_Data); {Inform status}
  RemoteAddress.sin_family := AF_INET; {Make connected true}
{$R-}
  RemoteAddress.sin_port := htons(FRemotePort); {If no proxy get port from Port property}
{$R+}
end;


procedure TUDPSOCKET.Loaded;
var
  buf: array[0..17] of AnsiChar;
begin
    LocalAddress.sin_addr.S_addr := Inet_Addr(strpcopy(buf, LocalIP));
    LocalAddress.sin_family := AF_INET; {Family = Internet address}
    LocalAddress.sin_port := htons(FLocalPort); {Set port to given port}
    wait_flag := FALSE; {Set flag to wait}
      {Bind Socket to given address}
    WinSock.bind(ThisSocket, LocalAddress, SizeOf(LocalAddress));
      {Direct reply message to WM_WAITFORRESPONSE handler}
    WSAAsyncselect(ThisSocket, FSocketWindow, WM_ASYNCHRONOUSPROCESS, FD_READ);
end;

{*******************************************************************************************
Resolve IP Address of Remote Host
********************************************************************************************}

procedure TUDPSOCKET.ResolveRemoteHost;
var
  BUF: array[0..127] of AnsiChar;
  CTry: integer;
  Handled: boolean;
begin
  remoteaddress.sin_addr.S_addr := Inet_Addr(strpcopy(buf, FRemoteHost));
  if remoteaddress.sin_addr.S_addr = SOCKET_ERROR then
  {If given name not an IP address already} begin
    CTry := 0;
    repeat
      Wait_Flag := FALSE; {Reset flag indicating wait over}
         {Resolve IP address}
      wsaasyncgethostbyname(FSocketWindow, WM_ASYNCHRONOUSPROCESS, Buf, PAnsiChar(remotehostS), MAXGETHOSTSTRUCT);
      repeat
        Wait;
      until Wait_Flag or Canceled; {Till host name resolved, Timed out or cancelled}
         {Handle errors}
      if Canceled then
        raise UDPSockError.create(Cons_Msg_Lkp);
      if Succeed = FALSE then begin
        if CTry < 1 then begin
          CTry := CTry + 1;
          Handled := FALSE;
          if assigned(FOnInvalidHost) then FOnInvalidHost(Handled);
          if not handled then UDPSockError.create(Cons_Msg_Lkp);
        end
        else   raise UDPSockError.create(Cons_Msg_Lkp);
      end
      else
            {Fill up remote host information with retreived results}
        with RemoteAddress.sin_addr.S_un_b do begin
          s_b1 := remotehostS.h_addr_list^[0];
          s_b2 := remotehostS.h_addr_list^[1];
          s_b3 := remotehostS.h_addr_list^[2];
          s_b4 := remotehostS.h_addr_list^[3];
        end;
    until Succeed = true;
  end;
end;

procedure TUDPSOCKET.SendStream(DataStream: TStream);
var
  Handled: boolean;
begin
  if DataStream.Size = 0 then begin
    if not assigned(FOnStreamInvalid) then
      raise Exception.create(Cons_Msg_InvStrm)
    else begin
      Handled := FALSE;
      FOnStreamInvalid(Handled, DataStream);
    end;
  end
  else if DataStream.Size > 1472 then
    raise Exception.create('1472');
  ResolveRemoteHost; {Resolve the IP address of remote host}
  if RemoteAddress.sin_addr.S_addr = 0 then
    raise UDPSockError.create(Cons_Err_Addr); {If Resolving failed raise exception}
  StatusMessage(Status_Basic, Cons_Msg_Data); {Inform status}
  RemoteAddress.sin_family := AF_INET; {Make connected true}
{$R-}
  RemoteAddress.sin_port := htons(FRemotePort); {If no proxy get port from Port property}
  WinSock.SendTo(ThisSocket, TMemoryStream(DataStream).Memory^, DataStream.size, 0, RemoteAddress, SizeOf(RemoteAddress));
end;

procedure TUDPSOCKET.SendBuffer(Buff: array of AnsiChar; length: integer);
var Ctry, i: integer;
  Handled: boolean;
begin
  CTry := 0;
  while length = 0 do
    if CTry > 0 then raise Exception.create(Cons_Err_Buffer)
    else
      if not assigned(FOnBufferInvalid) then raise Exception.create(Cons_Err_Buffer)
      else   begin
        Handled := FALSE;
        FOnBufferInvalid(Handled, Buff, length);
        if not Handled then raise Exception.create(Cons_Err_Buffer)
        else   CTry := CTry + 1;
      end;
  Canceled := FALSE; {Turn Canceled off}
  ResolveRemoteHost; {Resolve the IP address of remote host}
  if RemoteAddress.sin_addr.S_addr = 0 then
    raise UDPSockError.create(Cons_Err_Addr); {If Resolving failed raise exception}
  StatusMessage(Status_Basic, Cons_Msg_Data); {Inform status}
  RemoteAddress.sin_family := AF_INET; {Make connected true}
{$R-}
  RemoteAddress.sin_port := htons(FRemotePort); {If no proxy get port from Port property}
{$R+}
  i := SizeOf(RemoteAddress); {i := size of remoteaddress structure}
  WinSock.SendTo(ThisSocket, Buff, length, 0, RemoteAddress, i);
  if assigned(FOnDataSend) then FOnDataSend(self);
end;
{*******************************************************************************************
Handle Power socket error
********************************************************************************************}

function TUDPSOCKET.ErrorManager(ignore: word): string;
var
  slasterror: string;
begin
  StatusMessage(STATUS_TRACE, Cons_Msg_Echk); {Report Status}
  FLastErrorno := wsagetlasterror; {Set last error}
  if (FLastErrorno and ignore) <> ignore then
  {If the error is not the error to be ignored} begin
    slasterror := SocketErrorStr(FLastErrorno); {Get the description string for error}
    if assigned(fonerrorevent) then
         {If error handler present excecute it}
      FOnerrorEvent(Self, FLastErrorno, slasterror);
    raise UDPSockError.create(slasterror); {Raise exception}
  end;
  result := slasterror; {return error string}
end;

{*******************************************************************************************
Return Error Message Corresponding To Error number
********************************************************************************************}

function TUDPSOCKET.SocketErrorStr(ErrNo: word): string;
begin
  if ErrNo <> 0 then
   begin
      (*for x := 0 to 50 do                                {Get error string}
        if winsockmessage[x].errorcode = errno then
          Result := inttostr( winsockmessage[x].errorcode ) + ':' + winsockmessage[x].text; *)
    if Result = '' then {If not found say unknown error}
      Result := Cons_Msg_Eno + IntToStr(ErrNo);
  end;
  StatusMessage(Status_DEBUG, Cons_Msg_ELkp + result); {Status message}
end;

{*******************************************************************************************
Output a Status message: depends on current Reporting Level
********************************************************************************************}

procedure TUDPSOCKET.StatusMessage(Level: byte; value: string);
begin
  if level <= FReportLevel then
  {If level of error less than present report level} begin
    _status := value; {Set status to vale of error}
    if assigned(FOnStatus) then
      FOnStatus(self, _status); {If Status handler present excecute it}
  end;
end;

{*******************************************************************************************
Socket Message handler
********************************************************************************************}

procedure TUDPSOCKET.WndProc(var message: TMessage);
begin
  if _ProcMsg then
    with message do
      if msg = WM_ASYNCHRONOUSPROCESS then begin
        if lparamLo = FD_Read then
          ProcessIncomingdata
        else   begin
          wait_flag := TRUE;
          if lparamhi > 0 then
                  {If no error}
            Succeed := FALSE {Succed flag not set}
          else
            Succeed := TRUE;
        end;
        SetEvent(EventHandle);
      end
      else
        Result := DefWindowProc(FSocketWindow, Msg, wParam, lParam);
end;


procedure TUDPSOCKET.ProcessIncomingdata;
var
  From: TSockAddr;
  i: integer;
  s1: string;
  p1: u_short;

begin
  i := sizeof(From);
  IBuffSize := Winsock.RecvFrom(ThisSocket, IBuff, 2048, 0, From, i);
  if assigned(FOnDataReceived) then begin
    s1 := format('%d.%d.%d.%d', [ord(From.sin_addr.S_un_b.S_b1), ord(From.sin_addr.S_un_b.S_b2), ord(From.sin_addr.S_un_b.S_b3), ord(From.sin_addr.S_un_b.S_b4)]);
    p1 := ntohs(From.sin_port);
    FOnDataReceived(self, IBuffSize, s1, p1);
  end;
end;

procedure TUDPSOCKET.ReadStream(DataStream: TStream);
begin
  DataStream.WriteBuffer(IBuff, IBuffSize);
  DataStream.position := 0;
end;

procedure TUDPSOCKET.Wait;
begin
  WaitforSync(EventHandle);
  ResetEvent(EventHandle);
end;

procedure TUDPSOCKET.ReadBuffer(var Buff: array of AnsiChar; var length: integer);
begin
  Move(IBuff, Buff, IBuffSize);
  length := IBuffSize;
end;

procedure TUDPSOCKET.SendBuffer(var Buff; length: integer);
begin
  ResolveRemoteHost; {Resolve the IP address of remote host}
//  if RemoteAddress.sin_addr.S_addr = 0 then
 //   raise UDPSockError.create(Cons_Err_Addr); {If Resolving failed raise exception}
  StatusMessage(Status_Basic, Cons_Msg_Data); {Inform status}
  RemoteAddress.sin_family := AF_INET; {Make connected true}
{$R-}
  RemoteAddress.sin_port := htons(FRemotePort); {If no proxy get port from Port property}
  WinSock.SendTo(ThisSocket, Buff, length, 0, RemoteAddress, SizeOf(RemoteAddress));
end;

procedure TUDPSOCKET.ReadBuffer(var Buff; length: integer);
begin
  Move(IBuff, Buff, IBuffSize);
 // length := IBuffSize;
end;

procedure TUDPSOCKET.SendStream(DataStream: TStream; ISimple: Boolean);
var Ctry, i: integer;
  BUf: array[0..2047] of AnsiChar;
  Handled: boolean;
begin
  CTry := 0;
  while DataStream.size = 0 do
    if CTry > 0 then raise Exception.create(Cons_Msg_InvStrm)
    else
      if not assigned(FOnStreamInvalid) then raise Exception.create(Cons_Msg_InvStrm)
      else   begin
        Handled := FALSE;
        FOnStreamInvalid(Handled, DataStream);
        if not Handled then raise Exception.create(Cons_Msg_InvStrm)
        else   CTry := CTry + 1;
      end;
  Canceled := FALSE; {Turn Canceled off}
  ResolveRemoteHost; {Resolve the IP address of remote host}
  if RemoteAddress.sin_addr.S_addr = 0 then
    raise UDPSockError.create(Cons_Err_Addr); {If Resolving failed raise exception}
  StatusMessage(Status_Basic, Cons_Msg_Data); {Inform status}
  RemoteAddress.sin_family := AF_INET; {Make connected true}
{$R-}
  RemoteAddress.sin_port := htons(FRemotePort); {If no proxy get port from Port property}
{$R+}
  i := SizeOf(RemoteAddress); {i := size of remoteaddress structure}
   {Connect to remote host}
  DataStream.position := 0;
  DataStream.ReadBuffer(Buf, DataStream.size);
  WinSock.SendTo(ThisSocket, Buf, DataStream.size, 0, RemoteAddress, i);
  if assigned(FOnDataSend) then FOnDataSend(self);
end;

end.
