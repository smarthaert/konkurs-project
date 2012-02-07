unit UnBuildServer;


interface

uses
  UnBuildSetka, UnOther, UnBuildKoordObject;

  procedure InitSetka;
  procedure FreeSetka;
  procedure InitArraysSetka;
  procedure FinalizeArraysSetka;

implementation

procedure InitSetka;
begin
  SetSizePatch(Task.m_index);
  InitArraysSetka;
  case Task.Mestn of
    RAVNINA: begin
      BuildSetka('res\St_leto_no_okop\St_Leto');
    end;
    GORA:begin
      BuildSetka('res\St_gora\St_gora');
    end;
    BOLOTO:begin
      BuildSetka('res\St_leto_no_okop\St_Leto');
    end;
    PUSTYN:begin
      BuildSetka('res\st_pust_no_okop\st_pust');
    end;
  end;
  SetDimensionDirectris(Task.Ceson,Task.Mestn);
  BuildKoordObj(Task.Ceson,Task.Mestn);
end;

procedure FreeSetka;
begin
  FinalizeArraysSetka;
end;

procedure InitArraysSetka;
begin
  SetLength(coy, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(coydop,colPatchX*(colTrianglX),colPatchY*(colTrianglY));
  SetLength(um_mestn, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(kren_mestn, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(Orient_Koord, (colPatchSurface+1)*levelTexture,(colTrianglX*colTrianglY+2),3);
  SetLength(Orient_Type, (colPatchSurface+1)*levelTexture,(colTrianglX*colTrianglY));
  SetLength(Orient_Col, (colPatchSurface+1)*levelTexture);
end;

procedure FinalizeArraysSetka;
begin
  if coy<>nil then finalize(coy);
  FreeMem(coy);
  FinalizeCoydop;
  if kren_mestn<>nil then finalize(kren_mestn);
  FreeMem(kren_mestn);
  if Um_mestn<>nil then finalize(Um_mestn);
  FreeMem(Um_mestn);
  if Orient_Koord<>nil then finalize(Orient_Koord);
  FreeMem(Orient_Koord);
  if Orient_Type<>nil then finalize(Orient_Type);
  FreeMem(Orient_Type);
  if Orient_Col<>nil then finalize(Orient_Col);
  FreeMem(Orient_Col);
end;

end.
