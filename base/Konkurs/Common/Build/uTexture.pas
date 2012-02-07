(*******************************************************************************
  Работа с текстурой
*******************************************************************************)
unit uTexture;

interface
uses
  SysUtils,  FreeImage, windows, dglOpenGL;

const
  GL_BGRA = $80E1;

type
  TTexture = class
  private
    pBMP       : PFIBITMAP;
    TranspType : Word;       // Тип получения прозрачности
    FileName   : String;
  protected
    procedure AddAlpha;
    function  GetFileFormat(f_name: string) : FREE_IMAGE_FORMAT;
    procedure ConvertTo32Bits(var vpBMP: PFIBITMAP);
  public
    constructor Create(f_name : string; transp_type : word = 1);
    destructor  Destroy; override;
    procedure Bind;
  end;

implementation

destructor  TTexture.Destroy;
begin
  FreeImage_Unload(pBMP);
  pBMP := nil;
end;

function TTexture.GetFileFormat(f_name: string) : FREE_IMAGE_FORMAT;
begin
  if Pos('.jpg', f_name) > 0 then
    Result := FIF_JPEG
  else
    Result := FIF_BMP;
end;

constructor TTexture.Create(f_name: string; transp_type : word = 1);
begin
  TranspType := transp_type;
  FileName   := f_name;
  if FileExists(f_name) then
    pBMP := FreeImage_Load(GetFileFormat(f_name), PAnsiChar(f_name))
  else
  begin
    //LogMsg('Файл ' + f_name + ' не найден!');
    raise Exception.Create('Файл ' + f_name + ' не найден!');
  end;
end;
{
function TTexture.GetData : Pointer;
begin
  Result := pData;
end;

function TTexture.GetWidth : Cardinal;
begin
  Result := Width;
end;

function TTexture.GetHeight : Cardinal;
begin
  Result := Height;
end;
}

procedure TTexture.AddAlpha;

var
  pPix       : PRGBQUAD;
  pPixMask   : PRGBQUAD;
  width,
  height : Cardinal;
  i      : Integer;
  pBMPMask : PFIBITMAP;
  MaskFileName : String;
  tempColor: byte;
begin
  if TranspType in [6, 7] then
  begin
    MaskFileName := ChangeFileExt(FileName, 'M' + ExtractFileExt(FileName));
    if not FileExists(MaskFileName) then
      exit;
    pBMPMask := FreeImage_Load(FIF_BMP, PAnsiChar(MaskFileName));
    //pBMPMask := FreeImage_ConvertTo32Bits(pBMPMask);
    ConvertTo32Bits(pBMPMask);
    pPixMask := PRGBQUAD(FreeImage_GetBits(pBMPMask));
  end;

  width  := FreeImage_GetWidth(pBMP);
  height := FreeImage_GetHeight(pBMP);
  pPix := PRGBQUAD(FreeImage_GetBits(pBMP));
    for i := 0 to height*width - 1  do
    begin
      tempColor:=pPix.rgbBlue;
      pPix.rgbBlue:=pPix.rgbRed;
      pPix.rgbRed:=tempColor;
        case  TranspType of
          1,10: begin                  // Прозрачности нет
            pPix.rgbReserved := 255;
          end;
          2: begin                     // Для дерева (Красный)
{            if (pPix.rgbBlue  < 80) and
               (pPix.rgbGreen < 80) and
               (pPix.rgbRed   > 100) then}
            if (pPix.rgbRed  < 80) and
               (pPix.rgbGreen < 80) and
               (pPix.rgbBlue   > 100) then
            begin
              pPix.rgbReserved :=  0;      // Обрезанные пиксели-серого цвета
              pPix.rgbBlue     := 70;
              pPix.rgbGreen    := 70;
              pPix.rgbRed      := 70;
            end else
              pPix.rgbReserved := 255;
          end;
        3: begin                                 // Для облака

//             pPix.rgbReserved := pPix.rgbRed;    //Прозрачность пропорциональна красной составляющей
             pPix.rgbReserved := pPix.rgbBlue;    //Прозрачность пропорциональна красной составляющей
             pPix.rgbBlue     := 255;
             pPix.rgbGreen    := 255;  //Цвет всех пикселей - белый
             pPix.rgbRed      := 255;
           end;
        4: begin                                  // Для прицела
             if(pPix.rgbBlue  > 170) and          // Если близкий к белому - то прозрачный
               (pPix.rgbGreen > 170) and
               (pPix.rgbRed   > 170) then
                 pPix.rgbReserved:=0
             else begin
               pPix.rgbBlue     := 255;
               pPix.rgbGreen    := 255;
               pPix.rgbRed      := 255;
               pPix.rgbReserved := 255;
             end;
           end;
        5: begin
             if(pPix.rgbBlue  < 20 ) and
               (pPix.rgbGreen < 20 ) and
               (pPix.rgbRed   < 20 ) then
                 pPix.rgbReserved := 0
             else
               pPix.rgbReserved := 255;
           end;
        6: begin  // Для маски
             if (pPixMask.rgbRed < 100) then
               pPix.rgbReserved := 0
               else pPix.rgbReserved := 255;
             Inc(pPixMask);
           end;
        7: begin  // Для маски- прозрачность пропорц. красной составл.
             pPix.rgbReserved := pPixMask.rgbRed;
             Inc(pPixMask);
           end;
        8: begin  // на чёрном фоне
             pPix.rgbReserved := pPix.rgbBlue;
           end;
        end;
      Inc(pPix);
    end;

   if TranspType in [6, 7] then
      FreeImage_Unload(pBMPMask);
   //FreeImage_Unload(pPix);
   pPix := nil;
   pPixMask := nil;
end;

procedure TTexture.ConvertTo32Bits(var vpBMP: PFIBITMAP);
var
  pBMPTmp : PFIBITMAP;
begin
    pBMPTmp := FreeImage_ConvertTo32Bits(vpBMP);
    FreeImage_Unload(vpBMP);
    vpBMP := pBMPTmp;
    pBMPTmp := nil;
end;

procedure TTexture.Bind;
begin
  // Картинка в формате BMP 256/128 хранится с палитрой.
  // Поэтому массив данных надо или вручную преобразовывать в RGB или
  // воспользоваться функцией конвертации
//  if FreeImage_GetBPP(pBMP) <= 8 then
    ConvertTo32Bits(pBMP);
    AddAlpha;
  // А формат BMP 24 хранит данные в RGB (3 байта на пиксель)
  // поэтому его надо перевести в RGBA (4 байта на пиксель)
  gluBuild2dMipmaps(GL_TEXTURE_2D, GL_RGBA,
                    FreeImage_GetWidth(pBMP), FreeImage_GetHeight(pBMP),
                       GL_RGBA, GL_UNSIGNED_BYTE,  FreeImage_GetBits(pBMP));
{  glTexImage2d(GL_TEXTURE_2D, 0, 4,
               FreeImage_GetWidth(pBMP), FreeImage_GetHeight(pBMP),
               0, GL_BGRA, GL_UNSIGNED_BYTE,
               FreeImage_GetBits(pBMP));}
end;

end.

