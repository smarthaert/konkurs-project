unit UnAction;

interface


uses
  Main, SysUtils,
  Windows, UnDraw,
  UnOther,Forms,
  Graphics, UnBuild,
  UnDrawExplos;

procedure ChangeServer(num: word);

implementation
procedure ChangeServer(num: word);
begin
  if BMP_Temp[num].Start_PTUR<>BMP[num].Start_PTUR then begin
    BMP_Temp[num].Start_PTUR:=BMP[num].Start_PTUR;
    if  BMP[num].Start_PTUR then begin
//      Vystrel_ini(num);
    end
    else begin
      podryv_PTUR:=true;
      Xdym_PTUR:=BMP[Num_BMP].X_PTUR;
      Ydym_PTUR:=BMP[Num_BMP].Y_PTUR;
      Hdym_PTUR:=BMP[Num_BMP].H_PTUR;
      case BMP[Num_BMP].podryvPTUR of
        PODRYV_PTUR_TERRAN: oto_vzr_PTUR:=0;
        PODRYV_PTUR_MISHEN: oto_vzr_PTUR:=151;
        6: begin
          oto_vzr_PTUR:=151;
          DeMont_Target[Num_BMP,BMP[Num_BMP].Num_destroy]:=true;
          Poraj[Num_BMP,BMP[Num_BMP].Num_destroy]:=true;
        end;
        7: begin
          oto_vzr_PTUR:=151;
        end;
      end;
    end;
  end;
end;

end.
