unit UnBuildModel3Dmax;

interface

uses dglOpenGL,SysUtils, Dialogs, UnBuildTexture, UnOther;

const
  MAX_COL_POINTS=10000;   // ������������ ���������� ����� � �������
  MAX_COL_DETAY=1000;      // ������������ ���������� ���������

type
  TVector=record
    x: glFloat;
    y: glFloat;
    z: glFloat;
  end;
  TObj=record          // ��������� � ����������� �� ������������ ��������
    mov: array[0..2] of GLfloat; // �����������
    rot: array[0..2] of GLfloat; // ��������
    sca: array[0..2] of GLfloat; // ���������������
    typ: GLInt;                  // ��� ���������
    num_obj: GLInt;
    num_array: GLInt;
    col_point: GLInt;            // ���������� ����� ���������
    col_norm: GLInt;             // ���������� ��������
    col_tex: GLInt;             // ���������� ���������� ������
    col_face: GLInt;             // ���������� ������ ���������
    col_face_texture: GLInt;     // ���������� ���������� ������ ���������
    vert_point: array[0..MAX_COL_POINTS] of TVector; // ���������� �����
    norm_point: array[0..MAX_COL_POINTS] of TVector; // ���������� �������
    norm_point_ASE: array[0..MAX_COL_POINTS,0..2] of TVector; // ���������� �������
    text_point: array[0..MAX_COL_POINTS,0..2] of GLfloat; // ���������� ��������
    Type_text: word;// ������ ��������� ��������
    num_vertex: array [0..MAX_COL_POINTS,0..2] of word;
    num_vertex_texture: array [0..MAX_COL_POINTS,0..2] of word;
  end;

  procedure MakObject3Dmax(FileName: string;var Num: integer);
  procedure LoadObject3Dmax(FileName: string);
  procedure BuildObject3Dmax(var Num: integer);
  procedure BuildTextureObject3Dmax(var Num: integer);

implementation

var

  Mater_Ambien: array[1..MAX_COL_DETAY,0..3]of GLFloat;
  Mater_Specul: array[1..MAX_COL_DETAY,0..3]of GLFloat;
  Mater_Diffus: array[1..MAX_COL_DETAY,0..3]of GLFloat;
  Mater_Emissi: array[1..MAX_COL_DETAY,0..3]of GLFloat;
  Mater_Shinin: array[1..MAX_COL_DETAY] of GLFloat;
  ModeMaterial: array[1..MAX_COL_DETAY] of word; // Fr, Ba, Fr+Ba

  Name_elem:array[0..MAX_COL_DETAY] of string;
  Name_texture:array[0..MAX_COL_DETAY] of string;
  col_obj: integer;
  Obj: array of TObj;

procedure MakObject3Dmax(FileName: string; var Num: integer);
begin
  LoadObject3Dmax(FileName);
  BuildTextureObject3Dmax(Num);
  BuildObject3Dmax(Num);
  if Obj<>nil then Finalize(Obj);
end;

procedure LoadObject3Dmax(FileName: string);
var a,b,c: integer;
  S: String;
  F_Name:TextFile;
begin
  S:=dirBase+FileName;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F_Name,S);  {���������� ����� � ������}
  Reset(F_Name);
  ReadLn(F_Name, S);     //��������
  ReadLn(F_Name, S);     //���������� ��������
  if s<>'Ver2' then begin
    CloseFile(F_Name);
    exit
  end;
  ReadLn(F_Name, S);     //'���������� ���������';
  ReadLn(F_Name, S);     //'���������� ���������';
  col_obj:=strtoint(s);
  SetLength(Obj, (col_obj+3));
  for a:=1 to col_obj do begin
    ReadLn(F_Name, S);     //��� �������
    ReadLn(F_Name, S);     //��� �������
    Name_elem[a]:=s;
    ReadLn(F_Name, S);     //�������'
    ReadLn(F_Name, S);     //�������'
    Obj[a].mov[0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������'
    Obj[a].mov[1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������'
    Obj[a].mov[2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������'
    ReadLn(F_Name, S);     //�������'
    Obj[a].rot[0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������'
    Obj[a].rot[1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������'
    Obj[a].rot[2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //���������������
    ReadLn(F_Name, S);     //���������������
    Obj[a].sca[0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //���������������
    Obj[a].sca[1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //���������������
    Obj[a].sca[2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //��� ��������
    ReadLn(F_Name, S);     //��� ��������
    Name_texture[a]:=s;
    ReadLn(F_Name, S);     //������ ��������� ��������
    ReadLn(F_Name, S);     //������ ��������� ��������
    Obj[a].Type_text:=strtoint(s);
    ReadLn(F_Name, S);     //�������� ����������
    ReadLn(F_Name, S);     //�������� ����������
    Mater_Specul[a,0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ����������
    Mater_Specul[a,1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ����������
    Mater_Specul[a,2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ����������
    Mater_Specul[a,3]:=Strtofloat(s);

    ReadLn(F_Name, S);     //�������� ���������
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Ambien[a,0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Ambien[a,1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Ambien[a,2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Ambien[a,3]:=Strtofloat(s);

    ReadLn(F_Name, S);     //�������� ���������
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Diffus[a,0]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Diffus[a,1]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Diffus[a,2]:=Strtofloat(s);
    ReadLn(F_Name, S);     //�������� ���������
    Mater_Diffus[a,3]:=Strtofloat(s);
    ReadLn(F_Name, S);     //��� ���������
    ReadLn(F_Name, S);     //��� ���������
    Obj[a].typ:=strtoint(s);
    ReadLn(F_Name, S);     // Front, Back, Front and Back
    ReadLn(F_Name, S);
    ModeMaterial[a]:=StrToInt(S);
    ReadLn(F_Name, S);     // Shinin
    ReadLn(F_Name, S);
    Mater_Shinin[a]:=StrToFloat(S);

    ReadLn(F_Name, S);     // Emissi
    ReadLn(F_Name, S);
    Mater_Emissi[a,0]:=StrToFloat(S);
    ReadLn(F_Name, S);
    Mater_Emissi[a,1]:=StrToFloat(S);
    ReadLn(F_Name, S);
    Mater_Emissi[a,2]:=StrToFloat(S);
    ReadLn(F_Name, S);
    Mater_Emissi[a,3]:=StrToFloat(S);

    ReadLn(F_Name, S);     //  ���������� ������
    ReadLn(F_Name, S);
    Obj[a].col_point:=StrToInt(S);
    for b:=0 to Obj[a].col_point-1 do begin
      ReadLn(F_Name, S);
      Obj[a].vert_point[b].x:=StrToFloat(S);
      ReadLn(F_Name, S);
      Obj[a].vert_point[b].y:=StrToFloat(S);
      ReadLn(F_Name, S);
      Obj[a].vert_point[b].z:=StrToFloat(S);
    end;
    ReadLn(F_Name, S);    // ����� � ������ ������
    ReadLn(F_Name, S);
    Obj[a].col_face:=StrToInt(S);
    for b:=0 to Obj[a].col_face-1 do begin
      ReadLn(F_Name, S);
      Obj[a].num_vertex[b,0]:=StrToInt(S);
      ReadLn(F_Name, S);
      Obj[a].num_vertex[b,1]:=StrToInt(S);
      ReadLn(F_Name, S);
      Obj[a].num_vertex[b,2]:=StrToInt(S);
    end;
    ReadLn(F_Name, S);   // ���������� ����������
    ReadLn(F_Name, S);
    Obj[a].col_tex:=StrToInt(S);
    if (Obj[a].col_tex>0) then begin
      for b:=0 to Obj[a].col_tex-1 do begin
        ReadLn(F_Name, S);
        Obj[a].text_point[b,0]:=StrToFloat(S);
        ReadLn(F_Name, S);
        Obj[a].text_point[b,1]:=StrToFloat(S);
        ReadLn(F_Name, S);
        Obj[a].text_point[b,2]:=StrToFloat(S);
      end;
    end;
    ReadLn(F_Name, S);   // ����� � ������ ������ ���������� ���������
    ReadLn(F_Name, S);
    Obj[a].col_face_texture:=StrToInt(S);
    if (Obj[a].col_face_texture>0) then begin
      for b:=0 to Obj[a].col_face_texture-1 do begin
        ReadLn(F_Name, S);
        Obj[a].num_vertex_texture[b,0]:=StrToInt(S);
        ReadLn(F_Name, S);
        Obj[a].num_vertex_texture[b,1]:=StrToInt(S);
        ReadLn(F_Name, S);
        Obj[a].num_vertex_texture[b,2]:=StrToInt(S);
      end;
    end;
    ReadLn(F_Name, S);   // ������� ��� ���� ������ ������
    ReadLn(F_Name, S);
    Obj[a].col_norm:=StrToInt(S);
    for b:=0 to Obj[a].col_norm-1 do begin
      for c:=0 to 2 do begin
        ReadLn(F_Name, S);
        Obj[a].norm_point_ASE[b,c].x:=StrToFloat(S);
        ReadLn(F_Name, S);
        Obj[a].norm_point_ASE[b,c].y:=StrToFloat(S);
        ReadLn(F_Name, S);
        Obj[a].norm_point_ASE[b,c].z:=StrToFloat(S);
      end;
    end;
  end;
  CloseFile(F_Name);
end;

procedure BuildObject3Dmax(var Num: integer);
const
  mat_a : array [0..3] of GLFloat = (1, 1, 1, 1); //
  mat_s : array [0..3] of GLFloat = (1, 1, 1, 1); //
  mat_d : array [0..3] of GLFloat = (1, 1, 1, 1); //
var
  a,b: integer;
  x,y,z,xt,yt: array[1..3] of real;
begin
  Num:=glGenLists(1);
  glNewList (Num, GL_COMPILE);// ������ ������
    for a:=1 to col_obj do begin
      glPushMatrix;
        if (Obj[a].mov[0]<>0) or     //�����������
             (Obj[a].mov[1]<>0) or
                (Obj[a].mov[2]<>0) then
                    glTranslatef(Obj[a].mov[0],Obj[a].mov[1],Obj[a].mov[2]);
        if Obj[a].rot[0]<>0 then  glRotatef(Obj[a].rot[0],1,0,0); //�������
        if Obj[a].rot[1]<>0 then  glRotatef(Obj[a].rot[1],0,1,0);
        if Obj[a].rot[2]<>0 then  glRotatef(Obj[a].rot[2],0,0,1);
        if (Obj[a].sca[0]<>1) or     // ���������������
             (Obj[a].sca[1]<>1) or
                (Obj[a].sca[2]<>1) then
                    glScalef(Obj[a].sca[0],Obj[a].sca[1],Obj[a].sca[2]);
        // ���������� ��������
        if (Obj[a].Type_text<>11) then glBindTexture(GL_TEXTURE_2D, texVarName[a])
                                  else glDisable(GL_TEXTURE_2D);
        mat_a[0]:=Mater_Ambien[a,0];mat_a[1]:=Mater_Ambien[a,1];mat_a[2]:=Mater_Ambien[a,2];mat_a[3]:=Mater_Ambien[a,3];
        mat_s[0]:=Mater_Specul[a,0];mat_s[1]:=Mater_Specul[a,1];mat_s[2]:=Mater_Specul[a,2];mat_s[3]:=Mater_Specul[a,3];
        mat_d[0]:=Mater_Diffus[a,0];mat_d[1]:=Mater_Diffus[a,1];mat_d[2]:=Mater_Diffus[a,2];mat_d[3]:=Mater_Diffus[a,3];
        case  ModeMaterial[a] of
          0: begin
            glMaterialfv(GL_FRONT, GL_DIFFUSE,@mat_d);
            glMaterialfv(GL_FRONT, GL_AMBIENT,@mat_a);
            glMaterialfv(GL_FRONT, GL_SPECULAR,@mat_s);
          end;
          1: begin
            glMaterialfv(GL_BACK, GL_DIFFUSE,@mat_d);
            glMaterialfv(GL_BACK, GL_AMBIENT,@mat_a);
            glMaterialfv(GL_BACK, GL_SPECULAR,@mat_s);
          end;
          2: begin
            glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);
            glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_a);
            glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_s);
          end;
        end;
        glBegin(GL_TRIANGLES);
          for b:=0 to Obj[a].col_face-1 do begin
            if Obj[a].col_face_texture>0 then begin
              glTexCoord2f(Obj[a].text_point[Obj[a].num_vertex_texture[b,0]][0],
                           Obj[a].text_point[Obj[a].num_vertex_texture[b,0]][1]);
             end;
             glNormal3f(Obj[a].norm_point_ASE[b,0].x,
                        Obj[a].norm_point_ASE[b,0].y,
                        Obj[a].norm_point_ASE[b,0].z);
             glVertex3f(Obj[a].vert_point[Obj[a].num_vertex[b,0]].X,
                        Obj[a].vert_point[Obj[a].num_vertex[b,0]].y,
                        Obj[a].vert_point[Obj[a].num_vertex[b,0]].z);

             if Obj[a].col_face_texture>0 then begin
               glTexCoord2f(Obj[a].text_point[Obj[a].num_vertex_texture[b,1]][0],
                            Obj[a].text_point[Obj[a].num_vertex_texture[b,1]][1]);
             end;
             glNormal3f(Obj[a].norm_point_ASE[b,1].x,
                        Obj[a].norm_point_ASE[b,1].y,
                        Obj[a].norm_point_ASE[b,1].z);
        	   glVertex3f(Obj[a].vert_point[Obj[a].num_vertex[b,1]].X,
                        Obj[a].vert_point[Obj[a].num_vertex[b,1]].y,
                        Obj[a].vert_point[Obj[a].num_vertex[b,1]].z);
             if Obj[a].col_face_texture>0 then begin
               glTexCoord2f(Obj[a].text_point[Obj[a].num_vertex_texture[b,2]][0],
                            Obj[a].text_point[Obj[a].num_vertex_texture[b,2]][1]);
             end;
             glNormal3f(Obj[a].norm_point_ASE[b,2].x,
                        Obj[a].norm_point_ASE[b,2].y,
                        Obj[a].norm_point_ASE[b,2].z);
             glVertex3f(Obj[a].vert_point[Obj[a].num_vertex[b,2]].X,
                        Obj[a].vert_point[Obj[a].num_vertex[b,2]].y,
                        Obj[a].vert_point[Obj[a].num_vertex[b,2]].z);
           end;
        glEnd;
        if (Obj[a].Type_text=11) then glEnable(GL_TEXTURE_2D);
      glPopMatrix;
    end;
  glEndList;// ������ ������
end;

procedure BuildTextureObject3Dmax(var Num: integer);
var
  a: integer;
begin
  for a:=1 to col_obj do begin
    if (Obj[a].Type_text<>11) then begin
      texVarName[a]:=CreateTexture(Name_texture[a], 1, TEXTURE_FILTR_ON);//�������� �������������
    end;
  end;
end;
end.
