unit UnBuildTexture;

interface

uses Windows, Dialogs, Graphics, SysUtils, dglOpenGL, UnOther,uTexture;

const
  MAX_COL_TEXTURE = 500;
  TEXTURE_FILTR_OFF = 1;
  TEXTURE_FILTR_ON = 2;

var
  mipMap: boolean;
  numTexture: integer;
  texVarName: array [ 0..MAX_COL_TEXTURE ] of TGLint;
  otherTexture: word;


  function CreateTexture(bmap: string; typeApplic,  filtr: integer): cardinal;
  procedure MakeTexImage(bmap: string; typeApplic: integer);
  procedure PrepareImage(bmap: string; contur, numTexture: integer);

implementation

function CreateTexture(bmap: string; typeApplic,  filtr: integer): cardinal;
var
  texName:  TGLuint;
begin
  glActiveTextureARB(GL_TEXTURE0);
  glGenTextures(1, @texName);
  glBindTexture(GL_TEXTURE_2D,texName);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  case filtr of
    TEXTURE_FILTR_OFF: begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    end;
    TEXTURE_FILTR_ON: begin
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
//      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    end;
  end;
  mipMap:=true;
  MakeTexImage(bmap, typeApplic);
  result:=texName;
end;

procedure MakeTexImage(bmap: string; typeApplic: integer);
var
  Bitmap, Bitmap_Mask : TBitmap;
  Data,DataA,DataM: array of Byte;
  BMInfo : TBitmapInfo;
  Temp : Byte;
  MemDC : HDC;
  I, ImageSize : longint;
  S: string;
  Texture : TTexture;
begin
  if (otherTexture>0)  then begin // Если могут быть разные текстуры
    S:='bmp\'+(copy(bmap,1,Pos('.',bmap)-1))+inttostr(otherTexture)+'.bmp';
  end
  else begin
    S:='bmp\'+bmap;
  end;
  S:=dirBase+S;
  if not FileExists(s) then begin
    MessageDlg('Нет файла '+s, mtInformation,[mbOk], 0);
    exit;
  end;

  Texture := TTexture.Create(S, typeApplic);
  Texture.Bind;
  Texture.Free;

{  Bitmap := TBitmap.Create;
  Bitmap.LoadFromFile (s);
  with BMinfo.bmiHeader do begin
    FillChar (BMInfo, SizeOf(BMInfo), 0);
    biSize := sizeof (TBitmapInfoHeader);
    biBitCount := 24;
    biWidth := Bitmap.Width;
    biHeight := Bitmap.Height;
    ImageSize := biWidth * biHeight;
    biPlanes := 1;
    biCompression := BI_RGB;
    MemDC := CreateCompatibleDC (0);
    SetLength(Data, (ImageSize+2) * 3);
    SetLength(DataA, (ImageSize+2) * 4);
    try
      GetDIBits(MemDC,Bitmap.Handle,0,biHeight,Data,BMInfo,DIB_RGB_COLORS);
      if (typeApplic=6)or(typeApplic=7)  then begin
        Bitmap_Mask := TBitmap.Create;
        S:=(copy(bmap,1,Pos('.',bmap)-1));
        S:='bmp\'+S+'M'+'.bmp';
        S:=dirBase+S;
        if not FileExists(s) then begin
          MessageDlg('Нет файла '+s, mtInformation,[mbOk], 0);
          exit;
        end;
        Bitmap_Mask.LoadFromFile (S);
        SetLength(DataM, (ImageSize+1) * 3);
        GetDIBits(MemDC,Bitmap_Mask.Handle,0,biHeight,DataM,BMInfo,DIB_RGB_COLORS);
      end;
      for I := 0 to ImageSize - 1 do begin
        Temp := Data [I * 3];
        Data [I * 3] := Data [I * 3 + 2];
        Data [I * 3 + 2] := Temp;
      end;
      for I := 0 to ImageSize - 1 do begin
        DataA [I * 4] := Data [I * 3];
        DataA [I * 4 + 1] := Data [I * 3 + 1];
        DataA [I * 4 + 2] := Data [I * 3 + 2];
        case  typeApplic of
          1,10: begin
            DataA [I * 4 + 3] := 255;
          end;
          2: begin  // Для дерева (Красный)
            if (Data[I*3+2]<80)and(Data[I*3+1]<80)and(Data[I*3]>100)then begin
              DataA [I * 4 + 3] := 0;      // Обрезанные пиксели-серого цвета
              DataA [I * 4 + 2] := 70;
              DataA [I * 4 + 1] := 70;
              DataA [I * 4 ] := 70;
            end
            else DataA[I*4+3]:=255;
          end;
          3: begin
            DataA [I * 4 + 3] := DataA [I * 4];   ///Прозрачность пропорциональна красной составляющей
            DataA [I * 4 + 2]:=255;  // Для облака
            DataA [I * 4 + 1]:=255;  //Цвет всех пикселей - белый
            DataA [I * 4 ]:=255;
          end;
          4: begin   // Для прицела
            if(Data[I*3+2]>170)and(Data[I*3+1]>170)and(Data[I*3]>170)then DataA[I*4+3]:=0
            else begin
              DataA [I * 4 + 0] := 255;
              DataA [I * 4 + 1] := 255;
              DataA [I * 4 + 2] := 255;
              DataA [I * 4 + 3] := 255;
            end;
          end;
          5: begin
            if(Data[I*3+2]<20)and(Data[I*3+1]<20)and(Data[I*3]<20)then DataA[I*4+3]:=0
                                               else DataA [I * 4 + 3] := 255;
          end;
          6: begin  // Для маски
            if (DataM [I*3] < 100) then DataA [I * 4 + 3] := 0
                                   else DataA [I * 4 + 3] := 255;
          end;
          7: begin  // Для маски- прозрачность пропорц. красной составл.
            DataA [I * 4 + 3] :=DataM [I*3];
          end;
          8: begin  // на чёрном фоне
            DataA[I*4+3]:=Data[I*3];
          end;
        end;
      end;

      if   mipMap then gluBuild2dMipmaps(GL_TEXTURE_2D, GL_RGBA, biWidth,
                       biHeight, GL_RGBA, GL_UNSIGNED_BYTE, DataA)
                  else glTexImage2d(GL_TEXTURE_2D, 0, GL_RGBA, biWidth,
                       biHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, DataA);
    finally
      if (typeApplic=6)or(typeApplic=7) then Finalize(DataM);
      Finalize(DataA);
      Finalize(Data);
      DeleteDC (MemDC);
      if (typeApplic=6)or(typeApplic=7) then Bitmap_Mask.Free;
      Bitmap.Free;
    end;
  end;}
end;

{***********Загрузка текстуры***************}
procedure PrepareImage(bmap: string;contur, numTexture: integer);
begin
  CreateTexture(bmap, contur, TEXTURE_FILTR_ON);
end;

end.


