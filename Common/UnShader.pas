unit UnShader;

interface

uses
  dglOpenGL, Dialogs, UnGLSL, UnBuildTexture,UnVarConstOpenGL, UnOther;

var

  vsShaderColor: string;
  frShaderColor: string;

  vsShaderTexture: string;
  frShaderTexture: string;

  vsShaderGrayScale: string;
  frShaderGrayScale: string;

  vsShaderNoise: string;
  frShaderNoise: string;

  vsShaderMask: string;
  frShaderMask: string;

  noiseMap1: word;
  noiseMap2: word;
  noiseMap3: word;
  noiseMap4: word;
  numberTexture: array[0..800] of word;
  patchShaderX: integer;
  patchShaderY: integer;

  procedure InitTextShader;
  procedure BuildShader(temp, ceson: word);
  procedure FreeShader;

implementation

procedure InitTextShader;
begin
//=============== Шейдер COLOR ================
// вершинный
  vsShaderColor:=
  'varying vec4 Clr; '+
  'void main (void)    '+
  '{                   '+
  '  Clr = vec4(0.0, 1.0, 0.0, 1.0);'+
  '  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;'+
  '}                   ';
// фрагментный
  frShaderColor:=
  'varying vec4 Clr; '+
  'void main (void)    '+
  '{                   '+
  '  gl_FragColor = Clr;'+
  '}                   ';

//=============== Шейдер Texture ================
// вершинный
  vsShaderTexture:=
  'varying vec4 Clr; '+
  'void main (void)    '+
  '{                   '+
  ' gl_TexCoord[0] =gl_MultiTexCoord0; '+
//  '  Clr = vec4 (0.0, 1.0, 0.0, 1.0);'+
  '  Clr = gl_Color;'+
  '  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;'+
  '}                   ';
// фрагментный
  frShaderTexture:=
  'varying vec4 Clr; '+
  'uniform sampler2D Texture001;   '+
  'void main (void)    '+
  '{                   '+
  '  vec3 lumen = vec3 ( 0.3, 0.59, 0.11 );'+
  '  vec4 lightColor =vec4 (texture2D(Texture001, gl_TexCoord[0].st));  '+
  '  gl_FragColor = lightColor ;'+
  '}                   ';
//=============== Шейдер Чёрно-бенлый ================

// вершинный
  vsShaderGrayScale:=
  'varying vec4 Clr; '+
  'void main (void)    '+
  '{                   '+
  '  gl_TexCoord[0] =gl_MultiTexCoord0; '+
  '  Clr = gl_Color;'+
  '  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;'+
  '}                   ';

// фрагментный
  frShaderGrayScale:=
  'varying vec4 Clr; '+
  'uniform sampler2D Texture001;   '+
  'void main (void)    '+
  '{                   '+
  '  vec3 lumen = vec3 ( 0.3, 0.59, 0.11 );'+
  '  vec4 lightColor =vec4 (texture2D(Texture001, gl_TexCoord[0].st));  '+
  '  gl_FragColor.rgb =  vec3 ( dot(lightColor.rgb, lumen )) ;'+
  '  gl_FragColor.a = lightColor.a ;'+
  '}    ';
//=============== Шейдер  шума ================

// вершинный
  vsShaderNoise:=
  'varying vec4 Clr; '+
  'varying bool shNoise; '+
  'varying vec2 TexCoord; '+
  'varying float d; '+
  'void main (void)    '+
  '{                   '+
  '  vec3 vrt = vec3 ( 0.0, 0.0, 0.0 );'+
  '  d = distance (vec3 (gl_ModelViewMatrix * gl_Vertex), vrt);'+
  '  if (d < 10) {shNoise = true;} '+
  '   vec2 vrt2=gl_MultiTexCoord0.st * 20;'+
  '  TexCoord =vrt2; '+
  '  if (shNoise) {gl_Vertex.t = gl_Vertex.t+0.001;} '+
  '  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;'+
  '}                   ';

// фрагментный
  frShaderNoise:=
  'varying vec4 Clr; '+
  'varying bool shNoise; '+
  'varying float d; '+
  'varying vec2 TexCoord; '+
  'uniform sampler2D noiseMap;'+

  'void main (void)    '+
  '{                   '+
  ' if (shNoise) {   '+
  '  vec3 lightColor = texture2D(noiseMap, TexCoord).stp;  '+
  '  gl_FragColor.rgb =  vec3 ( lightColor.rgb/2) ;'+
  '  gl_FragColor.a = 0.35 * (1 - d / 10);'+
  '  }'+
  ' else {'+
//  '  vec4 lightColor = vec4(texture2D(noiseMap, TexCoord).stp, 1);  '+
//  '  gl_FragColor = lightColor ;'+
  '  }'+
//  '  vec3 lightColor = texture2D(noiseMap, TexCoord).stp;  '+
//  '  gl_FragColor.rgb =  vec3 ( lightColor.rgb) ;'+
//  '  gl_FragColor.a = 1;'+

  '}    ';
//=============== Шейдер  текстуры от маски ================

// вершинный
  vsShaderMask:=
  'varying	float specular;'+
  'varying	float diffuse;'+
  'uniform	vec4	lightPos;'+
  'uniform	vec4	eyePos;'+
  'uniform	int	nPatchX;'+
  'uniform	int	nPatchY;'+

  'varying vec2 TexCoord; '+
  'varying vec2 TexCoordRoot; '+
  'varying vec2 TexCoordGen; '+

  'varying	float fog;'+
  'const	float LOG2E = 1.442695;'+

  'void main (void)    '+

  '{                   '+
  // вычисление освещения диффузного
	'vec3	ecPosition = vec3( gl_ModelViewMatrix * gl_Vertex );'+
	'vec3	lightVect = normalize ( vec3 ( lightPos ) - ecPosition );'+
	'vec3	tNorm = gl_NormalMatrix * gl_Normal; '+
        'diffuse = max(dot(lightVect, tNorm), 0.0);'+

  // вычисление освещения зеркального
	'vec3	viewVect = normalize ( vec3(eyePos)   - ecPosition );'+
	'vec3	reflectVect = reflect ( -lightVect, tNorm);'+
        'specular = 0.0;'+

        'if (diffuse > 0.0)'+
  '{'+
        'specular = max(dot(reflectVect, viewVect), 0.0);'+
        'specular = pow(specular, 16.0);'+
  '}'+
  // вычисление координат пикселей
  '  vec4 vrt4= gl_Vertex;'+
  '  vec2 vrt2= gl_MultiTexCoord0.st ;'+
  '  TexCoord =vrt2*20; '+ // 20 - плотность укладки текстуры
  '  TexCoordRoot =vrt2*10; '+
  '  TexCoordGen.x =vrt4.x/80; '+ // 80*400 - размер поверхности
  '  TexCoordGen.y =-vrt4.z/400; '+
  // учёт тумана
  '  gl_FogFragCoord = abs(ecPosition.z);'+
  '  fog = exp2(-gl_Fog.density * gl_FogFragCoord * LOG2E);'+
  '  fog = clamp(fog, 0.0, 1.0);'+

  '  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;'+
  '} ';

// фрагментный
  frShaderMask:=
  'varying	float specular;'+
  'varying	float diffuse;'+
  'varying vec2 TexCoord; '+
  'varying vec2 TexCoordRoot; '+
  'varying vec2 TexCoordGen; '+

  'uniform float     ctrlLight;'+
  'uniform sampler2D noise_Map1;'+
  'uniform sampler2D noise_Map2;'+
  'uniform sampler2D noise_Map3;'+
  'uniform sampler2D noise_Map4;'+

  'varying	float fog;'+

  'void main (void)    '+
  '{                   '+
  '  { '+
  //  Цвет пикселей текстуры
  '  vec3 lightColor1 = texture2D(noise_Map1, TexCoordGen).stp;  '+
  '  vec4 lightColor2 = texture2D(noise_Map2, TexCoordRoot) * lightColor1.b;  '+
  '  vec4 lightColor3 = texture2D(noise_Map3, TexCoord) * lightColor1.r;  '+
  '  vec4 lightColor4 = texture2D(noise_Map4, TexCoord) * lightColor1.g;  '+
  // расчёт освещения
  '  float intesity = (specular * 0.4 + diffuse * 1.0 + 0.6)*ctrlLight;'+
  '  lightColor2 = (vec4(lightColor2 + lightColor3 + lightColor4))*intesity; '+
  // учёт тумана
  '  lightColor2.rgb = mix(vec3( gl_Fog.color),vec3(lightColor2), fog);'+

  '  gl_FragColor = (vec4(lightColor2.rgb, 1)); '+
  '  }'+

  '}    ';
end;

procedure BuildShader(temp, ceson: word);
var
  errorShader: boolean;
begin
  InitTextShader;
  GLSL := GlslProgramm.InitGlslProgramm;
  GLSL.LoadShadersPas ( vsShaderMask, frShaderMask );
  case Task.Mestn of
    GORA: begin
      noiseMap1:=CreateTexture('noise\Gora\RaidMask3.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap2:=CreateTexture('noise\Gora\road3.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap3:=CreateTexture('noise\Gora\granite19.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap4:=CreateTexture('noise\Gora\grassDetail3.bmp', 1, TEXTURE_FILTR_ON);
    end;
    BOLOTO:;
    PUSTYN: begin
      noiseMap1:=CreateTexture('noise\Dessert1\RaidMask3.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap2:=CreateTexture('noise\Dessert1\road.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap3:=CreateTexture('noise\Dessert1\granite.bmp', 1, TEXTURE_FILTR_ON);
      noiseMap4:=CreateTexture('noise\Dessert1\grassDetail3.bmp', 1, TEXTURE_FILTR_ON);
    end;
    RAVNINA: begin
      if ceson=WINTER then begin
        noiseMap1:=CreateTexture('noise\RaidMask3.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap2:=CreateTexture('noise\winter\road.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap3:=CreateTexture('noise\winter\snow.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap4:=CreateTexture('noise\winter\grassDetail.bmp', 1, TEXTURE_FILTR_ON);
      end
      else begin
        noiseMap1:=CreateTexture('noise\RaidMask3.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap2:=CreateTexture('noise\road3.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap3:=CreateTexture('noise\granite19.bmp', 1, TEXTURE_FILTR_ON);
        noiseMap4:=CreateTexture('noise\grassDetail3.bmp', 1, TEXTURE_FILTR_ON);
      end;
    end;
  end;
{  else begin
    noiseMap1:=CreateTexture('noise\RaidMask3.bmp', 1, TEXTURE_FILTR_ON);
    noiseMap2:=CreateTexture('noise\autumn\road.bmp', 1, TEXTURE_FILTR_ON);
    noiseMap3:=CreateTexture('noise\autumn\granite.bmp', 1, TEXTURE_FILTR_ON);
    noiseMap4:=CreateTexture('noise\autumn\grassDetail2.bmp', 1, TEXTURE_FILTR_ON);
  end;}
  glActiveTextureARB(GL_TEXTURE1);
  glBindTexture(GL_TEXTURE_2D,noiseMap1);

  glActiveTextureARB(GL_TEXTURE2);
  glBindTexture(GL_TEXTURE_2D,noiseMap2);


  glActiveTextureARB(GL_TEXTURE3);
  glBindTexture(GL_TEXTURE_2D,noiseMap3);

  glActiveTextureARB(GL_TEXTURE4);
  glBindTexture(GL_TEXTURE_2D,noiseMap4);

  eyePos[0]:=0;
  eyePos[1]:=1;
  eyePos[2]:=0;
  eyePos[3]:=1;
  errorShader:=false;
  GLSL.Bind;
    if not GLSL.SetTextureA('noise_Map1', 1) then errorShader:=true;
    if not GLSL.SetTextureA('noise_Map2', 2) then errorShader:=true;
    if not GLSL.SetTextureA('noise_Map3', 3) then errorShader:=true;
    if not GLSL.SetTextureA('noise_Map4', 4) then errorShader:=true;
    if not GLSL.SetUniformVector4D('lightPos',@LightPos) then errorShader:=true;
    if not GLSL.SetUniformVector4D('eyePos',@eyePos) then errorShader:=true;
    if task.temp=NIGHT then intensivLight:=surfaceNight
                       else intensivLight:=1.45;
    if not GLSL.SetUniformFloat('ctrlLight',intensivLight) then errorShader:=true;
  GLSL.UnBind;
  if errorShader then MessageDlg('Ошибка в шейдере', mtInformation,[mbOk], 0);
end;

procedure FreeShader;
begin
  GLSL.FreeGlslProgramm;
end;

end.









