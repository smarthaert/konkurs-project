unit UnBuildObject;

interface

uses dglOpenGL,UnBuildIndex,UnVarConstOpenGL,UnOther,SysUtils, Dialogs,
     UnBuildTexture, UnGeom, Classes;

  procedure MontObject(FileName: string;var  Num: integer);
  // ���������� ��������
  procedure BuildNormal;
  procedure ReadFaceObject(var F_Name: TextFile);
  procedure ReadFaceTemp(var F_Name: TextFile);
  procedure SolidTorus(inr : GLfloat;  outR : GLfloat;  nsides : GLint;
                      rings : GLint);
  procedure BindTextObject(filename: string; num: word);
var
  xnm,ynm,znm: array[1..3] of real;//��� ���������� ��������
  Xnorm,Ynorm,Znorm: real;

implementation

procedure MontObject(FileName: string;var  Num: integer);
const
  mat: array[0..3] of glfloat= (0.7, 0.7, 0.7, 1);
  EMMISS: array[0..3] of glfloat= (1, 1, 1, 1);
var a,b,c,d: integer;
  xv,yv,zv: real;
  x,y,z,xt,yt: array[1..3] of real;
  F: TextFile;
  S, s1: String;
  POrient : PMestnik;
  Corner  : PKoord;
  File_Name_Old: string; // ����� ���������� �������� �� ��������� ��������� ���
  Contur_Old: word;
  emis: word;
begin
  Num:=glGenLists(1);
  emis:=0;
  File_Name_Old:='';
  Contur_Old:=0;
  S:=dirBase+FileName;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  BindTextObject(filename, num);
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  ReadLn(F, S);     //�������� ���
  ReadLn(F, S);     //���������� ��������
  ReadLn(F, S);
  a:=strtoint(S);
  glNewList (Num, GL_COMPILE);// ������ ������
  for b:=1 to a do begin
    glPushMatrix;
      ReadLn(F, S);     //��� �������
      ReadLn(F, S);
      ReadLn(F, S);     //�������
      ReadLn(F, S);
      xv:=strtofloat(S);
      ReadLn(F, S);
      yv:=strtofloat(S);
      ReadLn(F, S);
      zv:=strtofloat(S);
      if (xv<>0) or (yv<>0) or (zv<>0) then glTranslatef(xv,yv,zv);
      ReadLn(F, S);     //�������
      ReadLn(F, S);
      xv:=strtofloat(S);
      if xv>0 then  glRotatef(xv,1,0,0);
      ReadLn(F, S);
      yv:=strtofloat(S);
      if yv>0 then  glRotatef(yv,0,1,0);
      ReadLn(F, S);
      zv:=strtofloat(S);
      if zv>0 then  glRotatef(zv,0,0,1);
      ReadLn(F, S);     //���������������
      ReadLn(F, S);
      xv:=strtofloat(S);
      ReadLn(F, S);
      yv:=strtofloat(S);
      ReadLn(F, S);
      zv:=strtofloat(S);
      if (xv<>1) or (yv<>1) or (zv<>1) then glScalef(xv,yv,zv);
      ReadLn(F, S);     //��� ��������
      ReadLn(F, S);
      S1:=S;
      ReadLn(F, S);     //�������� �������� ��� ������ ���������
      S:=copy(S,1,1);

      // ���������� ��������
      if s='l' then emis:=11;//
      if s='t' then emis:=12;//
      if  (emis=11) and (Task.Temp=NIGHT) then begin
        EMMISS[0]:=0.8;EMMISS[1]:=0.8;EMMISS[2]:=0.8;EMMISS[3]:=1;
        glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@EMMISS);
      end;
      if  (emis=12) and (Task.Temp=NIGHT) then begin
        EMMISS[0]:=0.3;EMMISS[1]:=0.3;EMMISS[2]:=0.3;EMMISS[3]:=1;
        glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@EMMISS);
      end;
      c:=0;
      if (s='2')or(s='3')or(s='4')or(s='5')or(s='6')or(s='7')or(s='8') or (s='10')
                               then val(s,d,c)
                               else d:=1;
      // ���������� ��������
      glBindTexture(GL_TEXTURE_2D, texVarName[b]);
      ReadLn(F, S);     //����������
      ReadLn(F, S);
      mat[0]:=strtofloat(S);
      if mat[0]<>1 then begin
        ReadLn(F, S);
        mat[1]:=strtofloat(S);
        ReadLn(F, S);
        mat[2]:=strtofloat(S);
        ReadLn(F, S);
        mat[3]:=strtofloat(S);
        if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=0.2;
        mat[1]:=0.2;
        mat[2]:=0.2;
        mat[3]:=1;
      if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      end;
      ReadLn(F, S);       //���������
      ReadLn(F, S);
      mat[0]:=strtofloat(S);
      if mat[0]<>1 then begin
        ReadLn(F, S);
        mat[1]:=strtofloat(S);
        ReadLn(F, S);
        mat[2]:=strtofloat(S);
        ReadLn(F, S);
        mat[3]:=strtofloat(S);
        if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=0.3;
        mat[1]:=0.3;
        mat[2]:=0.3;
        mat[3]:=1;
      if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      end;

      ReadLn(F, S);        //���������
      ReadLn(F, S);
      mat[0]:=strtofloat(S);
      if mat[0]<>1 then begin
        ReadLn(F, S);
        mat[1]:=strtofloat(S);
        ReadLn(F, S);
        mat[2]:=strtofloat(S);
        ReadLn(F, S);
        mat[3]:=strtofloat(S);
        if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=1;
        mat[1]:=1;
        mat[2]:=1;
        mat[3]:=1;
      if emis=0 then glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      end;

      ReadLn(F, S);           //��� ���������
      ReadLn(F, S);
      c:=strtoint(S);
      case c of
        2: ReadFaceObject(F);
        3: begin
          glBegin(GL_TRIANGLE_STRIP);
            ReadLn(F, S);     //���������� ������
            ReadLn(F, S);
            d:=strtoint(S);
            ReadLn(F, S);     //�������
            for a:=1 to d+2 do begin
              x[3]:=x[2];         // ����������� �������� ��������� ������
              x[2]:=x[1];         // ��� ������� ��������
              y[3]:=y[2];
              y[2]:=y[1];
              z[3]:=z[2];
              z[2]:=z[1];
              xt[3]:=xt[2];
              xt[2]:=xt[1];
              yt[3]:=yt[2];
              yt[2]:=yt[1];
              if a<=d then begin     //��������� ������� �������� ��������
                ReadLn(F, S);  //����� �������
                ReadLn(F, S);
                x[1]:=strtofloat(S);
                ReadLn(F, S);
                y[1]:=strtofloat(S);
                ReadLn(F, S);
                z[1]:=strtofloat(S);

                ReadLn(F, S);
                xt[1]:=strtofloat(S);
                ReadLn(F, S);
                yt[1]:=strtofloat(S);
              end;
              if a>2 then begin // � ��������� �������� ��������� �������
                if (a>2)and(a mod 2=1) then begin  // ��� 1-�� ������������ ������� ���������
                  xnm[1]:=x[3];    //������ ������� �������
                  xnm[2]:=x[2];
                  xnm[3]:=x[1];
                  ynm[1]:=y[3];
                  ynm[2]:=y[2];
                  ynm[3]:=y[1];
                  znm[1]:=z[3];
                  znm[2]:=z[2];
                  znm[3]:=z[1];
                end
                else begin    // ��� ��������� ������������� �� �������
                  xnm[1]:=x[1];
                  xnm[2]:=x[2];
                  xnm[3]:=x[3];
                  ynm[1]:=y[1];
                  ynm[2]:=y[2];
                  ynm[3]:=y[3];
                  znm[1]:=z[1];
                  znm[2]:=z[2];
                  znm[3]:=z[3];
                end;
                if a<=d then BuildNormal;  // ��� 2-� ��������� ������ ��� ����������� �����
                glTexCoord2f(xt[3], yt[3]);
                glNormal3f(Xnorm, Ynorm, Znorm);
                glVertex3f(x[3], y[3], z[3]);
              end;
            end;
          glEnd;
        end;
        5:begin
          glBegin(GL_QUADS);            //��������������
            ReadLn(F, S);
          glEnd;
        end;
        6: glBegin(GL_POLYGON);          //�������
        7:  begin                 //����
          ReadLn(F, S);  //���������� ������
          ReadLn(F, S);
          x[1]:=strtofloat(S);
          ReadLn(F, S);  //������� ������
          ReadLn(F, S);
          y[1]:=strtofloat(S);
          gluDisk(Quadric,x[1],y[1],12,2);
        end;
        8: begin                 //�������
          ReadLn(F, S);  //������  ������
          ReadLn(F, S);
          x[1]:=strtofloat(S);
          ReadLn(F, S);  //������� ������
          ReadLn(F, S);
          y[1]:=strtofloat(S);
          ReadLn(F, S);  //������
          ReadLn(F, S);
          z[1]:=strtofloat(S);
          gluCylinder(Quadric,x[1],y[1],z[1],12,2);
        end;
        9:  begin                 //�����
          ReadLn(F, S);  //���������� ������
          ReadLn(F, S);
          x[1]:=strtofloat(S);
          ReadLn(F, S);  //������� ������
          ReadLn(F, S);
          y[1]:=strtofloat(S);
          gluSphere(Quadric,y[1],12,12);
        end;
        10: begin                   // ���
          ReadLn(F, S);  //���������� ������
          ReadLn(F, S);
          x[1]:=strtofloat(S);
          ReadLn(F, S);  //������� ������
          ReadLn(F, S);
          y[1]:=strtofloat(S);
          SolidTorus(x[1],y[1],12,12);
        end;
      end;
      if  emis>0 then begin
        glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
        emis:=0;
      end;
    glPopMatrix;
  end;
  glEndList;
  New(POrient);
  POrient^.Num:=Num;
  POrient^.Curver:=TList.Create;
  if not Eof(F) then begin
    ReadLn(F, S);            // ������� "������� �������"
    ReadLn(F, S);            //������� ������� 1- �����, 2-����, 3-�������-� , 4-�������
    POrient^.Type_Objekt:=strtoint(S);
    ReadLn(F, S);            // ������� "������� ����������"
    ReadLn(F, S);            //������� ���������� 1- ������, 2-������, 3-����������
    POrient^.Type_Action:=strtoint(S);
    ReadLn(F, S);            //������� "���������� �������������� �����"
    ReadLn(F, S);            //���������� �������������� �����
    POrient^.Col_Points_Objekt:=strtoint(S);
    ReadLn(F, S);            //������� "����������"
    for a:=1 to POrient^.Col_Points_Objekt do begin
      New(Corner);
      ReadLn(F, S);            // X
      Corner^.X:=strtofloat(S);
      ReadLn(F, S);            // Y
      Corner^.Y:=strtofloat(S);
      POrient^.Curver.Add(Corner);
    end;
  end
  else begin
    POrient^.Type_Objekt:=1;
    POrient^.Type_Action:=0;
    POrient^.Col_Points_Objekt:=1;
    New(Corner);
    Corner^.X:=0;
    Corner^.Y:=0;
    POrient^.Curver.Add(Corner);
  end;
  TypesOfOrient.Add(POrient);
  CloseFile(F);
end;


procedure SolidTorus(inr : GLfloat;  outR : GLfloat;  nsides : GLint;
                      rings : GLint);
var
  i, j : integer;
  a,theta, phi, theta1, phi1 : GLfloat;
  DrawType :GLenum;
  p0, p1, p2, p3,
  n0, n1, n2, n3 : array[0..2] of GLfloat;
begin { Doughnut }
  DrawType:= GL_QUADS;
  for i := 0 to rings - 1 do
  begin
    theta := i *2.0 * PI / rings;
    theta1 := (i + 1) * 2.0 * PI / rings;
    for j := 0 to nsides - 1 do
    begin
      phi := j *2.0 * PI / nsides;
      phi1 := (j + 1) * 2.0 * PI / nsides;

		p0[0] := cos(theta) * (outR + inr * cos(phi));
      p0[1] := -sin(theta) * (outR + inr * cos(phi));
      p0[2] := inr * sin(phi);

		p1[0] := cos(theta1) * (outR + inr * cos(phi));
      p1[1] := -sin(theta1) * (outR + inr * cos(phi));
      p1[2] := inr * sin(phi);

		p2[0] := cos(theta1) * (outR + inr * cos(phi1));
      p2[1] := -sin(theta1) * (outR + inr * cos(phi1));
      p2[2] := inr * sin(phi1);

      p3[0] := cos(theta) * (outR + inr * cos(phi1));
      p3[1] := -sin(theta) * (outR + inr * cos(phi1));
      p3[2] := inr * sin(phi1);

      n0[0] := cos(theta) * (cos(phi));
      n0[1] := -sin(theta) * (cos(phi));
      n0[2] := sin(phi);

      n1[0] := cos(theta1) * (cos(phi));
      n1[1] := -sin(theta1) * (cos(phi));
      n1[2] := sin(phi);

      n2[0] := cos(theta1) * (cos(phi1));
      n2[1] := -sin(theta1) * (cos(phi1));
      n2[2] := sin(phi1);

      n3[0] := cos(theta) * (cos(phi1));
      n3[1] := -sin(theta) * (cos(phi1));
      n3[2] := sin(phi1);
      A:=nsides;
      a:=(outR+inr)*2;//a;
      glBegin(DrawType);
      glTexCoord2f(p3[0]/a, p3[1]/a);
      glNormal3fv(@n3);
      glVertex3fv(@p3);
      glTexCoord2f(p2[0]/a, p2[1]/a);
      glNormal3fv(@n2);
      glVertex3fv(@p2);
      glTexCoord2f(p1[0]/a, p1[1]/a);
      glNormal3fv(@n1);
      glVertex3fv(@p1);
      glTexCoord2f(p0[0]/a, p0[1]/a);
      glNormal3fv(@n0);
      glVertex3fv(@p0);
      glEnd();
    end;
  end;
end; { Doughnut }

// ������ ������ ���� ��������� 2 (GL_TRIANGLES)
procedure ReadFaceObject(var F_Name: TextFile);
var
  i,j: GLInt;
  S: string;
  vert_count, norm_count, tex_count, face_count : GLInt;
  vert_data : array of array of GLFloat;
  norm_data : array of array of GLFloat;
  tex_data  : array of array of GLFloat;
  face_data : array [0..2, 0..2] of GLInt;
begin
      ReadLn(F_Name, S);//���������� ������
      ReadLn(F_Name, S);
      vert_count := strtoint(S);
      SetLength(vert_data, vert_count, 3);
      ReadLn(F_Name, S);//�������
      for i:=0 to vert_count-1 do
      begin
        //���������� �������
        ReadLn(F_Name, S);
        vert_data[i][0]:=strtofloat(S);
        ReadLn(F_Name, S);
        vert_data[i][1]:=strtofloat(S);
        ReadLn(F_Name, S);
        vert_data[i][2]:=strtofloat(S);
      end;

      ReadLn(F_Name, S);//���������� ��������
      ReadLn(F_Name, S);
      norm_count:=strtoint(S);
      SetLength(norm_data, norm_count, 3);
      ReadLn(F_Name, S);//�������
      for i:=0 to norm_count-1 do
      begin
        // ���������� �������
        ReadLn(F_Name, S);
        norm_data[i][0]:=strtofloat(S);
        ReadLn(F_Name, S);
        norm_data[i][1]:=strtofloat(S);
        ReadLn(F_Name, S);
        norm_data[i][2]:=strtofloat(S);
      end;
      ReadLn(F_Name, S);//���������� ���������� ���������
      ReadLn(F_Name, S);
      tex_count:=strtoint(S);
      SetLength(tex_data, tex_count, 2);
      ReadLn(F_Name, S);//����������
      for i:=0 to tex_count-1 do
      begin
        // ���������� ��������
        ReadLn(F_Name, S);
        tex_data[i][0]:=strtofloat(S);
        ReadLn(F_Name, S);
        tex_data[i][1]:=strtofloat(S);
      end;
    ReadLn(F_Name, S);//���������� �������������
    ReadLn(F_Name, S);
    face_count :=strtoint(S);
    ReadLn(F_Name, S);//������������
    glEnable(GL_CULL_FACE);
    glBegin(GL_TRIANGLES);
      for i:=0 to face_count-1 do begin
        //������ �������
        ReadLn(F_Name, S);
        face_data[0,0]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[0,1]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[0,2]:=strtoint(S);
        //������ ��������
        ReadLn(F_Name, S);
        face_data[1,0]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[1,1]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[1,2]:=strtoint(S);
        //������ ���������� ���������
        ReadLn(F_Name, S);
        face_data[2,0]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[2,1]:=strtoint(S);
        ReadLn(F_Name, S);
        face_data[2,2]:=strtoint(S);
        	for j := 2 downto 0 do begin
  	        glTexCoord2fv(@tex_data[face_data[2,j]][0]);
       	    glNormal3fv(@norm_data[face_data[1,j]][0]);
      	    glVertex3fv(@vert_data[face_data[0,j]][0]);
        	end;
    end;
  glEnd;
  glDisable(GL_CULL_FACE);
  finalize(vert_data);
  finalize(norm_data);
  finalize(tex_data);
end;

// ������ ������ ���� ��������� 2 (GL_TRIANGLES)
procedure ReadFaceTemp(var F_Name: TextFile);
var
  i,j: GLInt;
  S: string;
  vert_count, norm_count, tex_count, face_count : GLInt;
begin
  ReadLn(F_Name, S);//���������� ������
  ReadLn(F_Name, S);
  vert_count := strtoint(S);
  ReadLn(F_Name, S);//�������
  for i:=0 to vert_count-1 do  begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//���������� ��������
  ReadLn(F_Name, S);
  norm_count:=strtoint(S);
  ReadLn(F_Name, S);//�������
  for i:=0 to norm_count-1 do begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//���������� ���������� ���������
  ReadLn(F_Name, S);
  tex_count:=strtoint(S);
  ReadLn(F_Name, S);//����������
  for i:=0 to tex_count-1 do  begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
  ReadLn(F_Name, S);//���������� �������������
  ReadLn(F_Name, S);
  face_count :=strtoint(S);
  ReadLn(F_Name, S);//������������
  for i:=0 to face_count-1 do begin
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
    ReadLn(F_Name, S);
  end;
end;

procedure BindTextObject(filename: string; num: word);
var
 f: textfile;
 s,s1: string;
 a, b, c, d: integer;
begin
  S:=dirBase+filename;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+S, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  ReadLn(F, S);     //�������� ���
  ReadLn(F, S);     //���������� ��������
  ReadLn(F, S);
  a:=strtoint(S);
  for b:=1 to a do begin
    ReadLn(F, S);     //��� �������
    ReadLn(F, S);
    ReadLn(F, S);     //�������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //�������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //���������������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);     //��� ��������
    ReadLn(F, S);
    S1:=S;
    ReadLn(F, S);     //�������� �������� ��� ������ ���������
    S:=copy(S,1,1);
    // ���������� ��������
    c:=0;
    if (s='2')or(s='3')or(s='4')or(s='5')or(s='6')or(s='7')or(s='8') or (s='10')
                              then val(s,d,c)
                              else d:=1;
    texVarName[b]:=CreateTexture(s1, d, TEXTURE_FILTR_ON);//�������� �������������
    ReadLn(F, S);     //����������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);       //���������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);        //���������
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);
    ReadLn(F, S);           //��� ���������
    ReadLn(F, S);
    c:=strtoint(S);
    case c of
      2: ReadFaceTemp(F);
      3: begin
        ReadLn(F, S);     //���������� ������
        ReadLn(F, S);
        d:=strtoint(S);
        ReadLn(F, S);     //�������
        for a:=1 to d+2 do begin
          if a<=d then begin     //��������� ������� �������� ��������
            ReadLn(F, S);  //����� �������
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
            ReadLn(F, S);
          end;
        end;
      end;
      5:begin
        ReadLn(F, S);
      end;
      7:  begin                 //����
        ReadLn(F, S);  //���������� ������
        ReadLn(F, S);
        ReadLn(F, S);  //������� ������
        ReadLn(F, S);
      end;
      8: begin                 //�������
        ReadLn(F, S);  //������  ������
        ReadLn(F, S);
        ReadLn(F, S);  //������� ������
        ReadLn(F, S);
        ReadLn(F, S);  //������
        ReadLn(F, S);
      end;
      9:  begin                 //�����
        ReadLn(F, S);  //���������� ������
        ReadLn(F, S);
        ReadLn(F, S);  //������� ������
        ReadLn(F, S);
      end;
      10: begin                   // ���
        ReadLn(F, S);  //���������� ������
        ReadLn(F, S);
        ReadLn(F, S);  //������� ������
        ReadLn(F, S);
      end;
    end;
  end;
  CloseFile(F);
end;


procedure BuildNormal;
var ax,ay,az,bx,by,bz: real;
begin
  ax:=xnm[3]-xnm[2];
  bx:=xnm[1]-xnm[2];
  ay:=ynm[3]-ynm[2];
  by:=ynm[1]-ynm[2];
  az:=znm[3]-znm[2];
  bz:=znm[1]-znm[2];
  Xnorm:=ay*bz-az*by;
  Ynorm:=az*bx-ax*bz;
  Znorm:=ax*by-ay*bx;
  ax:=sqrt(Xnorm*Xnorm+Ynorm*Ynorm+Znorm*Znorm);
  if ax=0 then ax:=0.00001;
  Xnorm:=Xnorm/ax;
  Ynorm:=Ynorm/ax;
  Znorm:=Znorm/ax;
end;


end.
