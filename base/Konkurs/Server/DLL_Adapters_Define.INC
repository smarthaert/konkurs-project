//описание функций библиотеки связи с адаптером 

  Procedure SetArraysOU(VAR IND_,OU_);STDCALL;                    external DLL_Name index  1;
  Procedure GetArraysOU(VAR IND_,OU_);STDCALL;                    external DLL_Name index  2;
  Procedure GetArrays_Corr(VAR IND_COR,OU_COR);STDCALL;           external DLL_Name index  3;
  Procedure GetArrays_Buffer(VAR IND_COR,OU_COR);STDCALL;         external DLL_Name index  4;
  Function  CheckBuffers(VAR BUF_OUT,BUF_INP):integer;STDCALL;    external DLL_Name index  5;
  Procedure SetCorrectionEnabled;STDCALL;                         external DLL_Name index  6;
  Procedure SetCorrectionDisabled;STDCALL;                        external DLL_Name index  7;
  Procedure SetObmenEnabled;STDCALL;                              external DLL_Name index  8;
  Procedure SetObmenDisabled;STDCALL;                             external DLL_Name index  9;
  Function  ADaptersGetLastError:integer;stdcall;                 external DLL_Name index 10;
  Function  CheckDataFromAdapter(VAR Org_IND,ORG):integer;STDCALL;external DLL_Name index 11;
  Function  Reconnect(NPort:integer):integer;STDCALL;             external DLL_Name index 12;
  Function  AdaptersGetKeyNumber(VAR IND_,OU_):integer;STDCALL;   external DLL_Name index 13;
  Procedure WriteIniTable;STDCALL;                                external DLL_Name index 14;
  Function  CheckLastReceivedTime:DWORD;STDCALL;                  external DLL_Name index 15;
  Function  CheckLastTransmitTime:Dword;STDCALL;                  external DLL_Name index 16;


