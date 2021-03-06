unit UnDrawExplos;

interface

uses
  dglOpenGL, UnOther, UnVarConstOpenGL,  UnBuildTexture, SysUtils;

var

  podryv_PTUR: boolean;
  Xdym_PTUR:real;
  Ydym_PTUR:real;
  Hdym_PTUR:real;
  V_Hdym_PTUR: real;
  oto_vzr_PTUR: word;
  Sca_dym_PTUR: real;

procedure Draw_Vzryv_PTUR;
procedure Build_Vzryv_PTUR;


implementation

uses
  UnDraw;
var
  SPRITE_VSP_PTUR: array[1..13] of integer;
  DYM_PTUR: integer;
  SPRITE_PYL_PTUR: integer;

  // ����� �������
procedure Draw_Vzryv_PTUR;
const P_vzr:array [0..3] of GLFloat =( 0.3, 0.25, 0.2, 1);
begin
  if podryv_PTUR then begin
    glPushMatrix;
      glTranslatef(Xdym_PTUR,Hdym_PTUR, Ydym_PTUR);
        P_vzr[3]:=1;//mat_vzr[n];
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_vzr);//������ ������������ ���������
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_vzr);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        inc(oto_vzr_PTUR);
        // �����
        case oto_vzr_PTUR of
          1:begin
            BMP[2].Start_Ptur:=false;
            V_Hdym_PTUR:=0;
            Sca_dym_PTUR:=0.3;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(SPRITE_VSP_PTUR[1]);
          end;
          2:begin
            Sca_dym_PTUR:=0.7;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(SPRITE_VSP_PTUR[2]);
          end;
          3:begin
            Sca_dym_PTUR:=1.5;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(SPRITE_VSP_PTUR[5]);
          end;
          4:begin
            Sca_dym_PTUR:=2.1;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(SPRITE_VSP_PTUR[10]);
          end;
          5:begin
            Sca_dym_PTUR:=7.5;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(DYM_PTUR);
            Sca_dym_PTUR:=0.33;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(SPRITE_VSP_PTUR[12]);
          end;
          6:begin
            Sca_dym_PTUR:=6;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(DYM_PTUR);
          end;
          7..8:begin
            Sca_dym_PTUR:=Sca_dym_PTUR*1.2;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(DYM_PTUR);
          end;
          9..35:begin
            V_Hdym_PTUR:=V_Hdym_PTUR+0.01;
            Sca_dym_PTUR:=Sca_dym_PTUR*1.03;
            glScalef(Sca_dym_PTUR,Sca_dym_PTUR,Sca_dym_PTUR);
            glCallList(DYM_PTUR);
            glScalef(0.4,-0.6,0.1);
            glTranslatef(0,-0.05,0);
            glCallList(SPRITE_PYL_PTUR);
          end;
          36:begin
            podryv_PTUR:=false;
          end;
          151..159:begin
            V_Hdym_PTUR:=0;
            if oto_vzr_PTUR=151 then begin
              BMP[2].Start_Ptur:=false;
            end;
            if oto_vzr_PTUR=159 then podryv_PTUR:=false;
            glCallList(SPRITE_VSP_PTUR[oto_vzr_PTUR-150]);
          end;
        end;
    glPopMatrix;
    Xdym_PTUR:=Xdym_PTUR+Dym_V_X;
    Ydym_PTUR:=Ydym_PTUR+Dym_V_Y;
    Hdym_PTUR:=Hdym_PTUR-V_Hdym_PTUR;
  end;
end;

procedure Build_Vzryv_PTUR;
const
  mat: array [0..3] of GLFloat = (1, 1, 1, 0.5);
var
  a: integer;
  z: real;
  y: real;
  x: real;
begin
  for a:=1 to 13 do begin
    SPRITE_VSP_PTUR[a]:=glGenLists(1);
    numTexture:=CreateTexture('Sprite\Vsp2\Vsp'+inttostr(a)+'.bmp',8, TEXTURE_FILTR_ON);//�������� �������������
    glNewList (SPRITE_VSP_PTUR[a], GL_COMPILE);
      glBindTexture(GL_TEXTURE_2D, numTexture);
      case a of
        1:z:=0.08;
        2:z:=0.12;
        3:z:=0.16;
        4:z:=0.20;
        else z:=0.23;
      end;
      y:=0.1;
      mat[3]:=1;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      glBegin(GL_QUADS);
        glTexCoord2f(0.0, 0.0);
        glVertex3f(-z, -z, y);
        glTexCoord2f( 0.0, 1.0);
        glVertex3f(-z, z, y);
        glTexCoord2f(1.0, 1.0);
        glVertex3f(z, z, y);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(z, -z, y);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
  z:=0.035;
  x:=0.09;

  DYM_PTUR:=glGenLists(1);
  numTexture:=CreateTexture('Vzryv\Vzryv2.bmp',6, TEXTURE_FILTR_ON);//�������� �������������
  glNewList (DYM_PTUR, GL_COMPILE);
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glBegin(GL_QUADS);            //��������������
      glTexCoord2f(0,0);
      glVertex3f(-x, 0-0.005,0);
      glTexCoord2f(1,0);
      glVertex3f(x, 0-0.005, 0);
      glTexCoord2f(1,1);
      glVertex3f(x, 2*x-0.005,0);
      glTexCoord2f(0,1);
      glVertex3f(-x, 2*x-0.005,0);
    glEnd;
  glEndList;
  x:=0.3;
  y:=0.3;
  z:=0.3;


  SPRITE_PYL_PTUR:=glGenLists(1);
  numTexture:=CreateTexture('Sprite\Pyl\pyl1.bmp',3, TEXTURE_FILTR_ON);//�������� �������������
  glNewList (SPRITE_PYL_PTUR, GL_COMPILE);
    glBindTexture(GL_TEXTURE_2D, numTexture);
    glBegin(GL_QUADS);            //��������������
      glTexCoord2f(0,0);
      glVertex3f(-x, y, z);
      glTexCoord2f(1,0);
      glVertex3f(x, y, z);
      glTexCoord2f(1,1);
      glVertex3f(x, -y, z);
      glTexCoord2f(0,1);
      glVertex3f(-x, -y, z);
    glEnd;
  glEndList;
end;

end.


