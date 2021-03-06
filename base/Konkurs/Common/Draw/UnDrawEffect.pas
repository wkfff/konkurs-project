unit UnDrawEffect;

interface
uses
 dglOpenGL, UnOther, UnBuildEffect, UnVarConstOpenGL;

  procedure Draw_Pyl(n: integer);
  procedure Draw_Pyl_Black(n: integer);
  procedure Draw_Dym_Black(n: integer);
  procedure Draw_Oblako;

const
  COL_PYL=25;
  COL_DYM=10;

var
   aaaaa: real=20;
   Pyl_Angle: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Delta_Pyl_Angle: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_X: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_Y: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_H: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_Mat: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_Sca: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Delta_Pyl_Sca: array[1..COL_TEXNIKA_MODEL+3,0..COL_PYL] of real;//...
   Pyl_Begin_Index: array[1..COL_TEXNIKA_MODEL+3] of word;//...

   Dym_Angle: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Delta_Dym_Angle: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_X: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_Y: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_H: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_Mat: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_Sca: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Delta_Dym_Sca: array[1..COL_TEXNIKA_MODEL+3,0..COL_DYM] of real;//...
   Dym_Begin_Index: array[1..COL_TEXNIKA_MODEL+3] of word;//...

   Fire_X: array[1..COL_TEXNIKA_MODEL+3] of real;//...
   Fire_Y: array[1..COL_TEXNIKA_MODEL+3] of real;//...
   Fire_H: array[1..COL_TEXNIKA_MODEL+3] of real;//...
   Fire_Index: array[1..COL_TEXNIKA_MODEL+3] of word;//...

   Period_pyl: array[1..COL_TEXNIKA_MODEL+3] of word;//...
   Period_pyl_int: array[1..COL_TEXNIKA_MODEL+3] of word;//...
   Period_dym: array[1..COL_TEXNIKA_MODEL+3] of word;//...

implementation
uses
  UnDraw;

// ���� �� �������
procedure Draw_Pyl(n: integer);
const  P_pyl:array [0..3] of GLFloat =( 1, 0.8, 0.6, 1);
var a,num: integer;
T:array[0..3] of glfloat;
begin
  if Model[n].Start then begin
    if Pyl_Begin_Index[n]>COL_PYL then Pyl_Begin_Index[n]:=2;
    Pyl_X[n,Pyl_Begin_Index[n]]:=Model[n].Xtek;
    if Model[n].Typ=MODEL_BMP1 then Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.7
                               else Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.4;
    Pyl_H[n,Pyl_Begin_Index[n]]:=Model[n].Htek-0.1;
    Delta_Pyl_Angle[n,Pyl_Begin_Index[n]]:=Model[n].Skorost/8-random(100)/20;
    Pyl_Mat[n,Pyl_Begin_Index[n]]:=Model[n].Skorost/30;
//    if Pyl_Mat[n,Pyl_Begin_Index[n]]>1 then
    Pyl_Mat[n,Pyl_Begin_Index[n]]:=0.2;
    Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.8;
    Delta_Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.06-random(3)/100;
    Pyl_Angle[n,Pyl_Begin_Index[n]]:=Pyl_Angle[n,1];
    inc(Pyl_Begin_Index[n]);
  end;
  for a:=1 to COL_PYL do begin
    if Pyl_Mat[n,a]>0.02 then begin
      glPushMatrix;
        //������ ������������ ���������
        P_pyl[3]:=Pyl_Mat[n,a];
        if Pyl_Mat[n,a]>0.2 then Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.023
                            else Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.2;
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_pyl);
        // �������, ���������� � ����������� ����
        glTranslatef(Pyl_X[n,a],Pyl_H[n,a],-Pyl_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glScalef(Pyl_Sca[n,a],Pyl_Sca[n,a]/2,Pyl_Sca[n,a]);
        glRotatef (-Pyl_Angle[n,a], 0.0, 0.0, 1.0);
        glCallList(SPRITE_PYL);
        Pyl_Angle[n,a]:=Pyl_Angle[n,a]+Delta_Pyl_Angle[n,a];
        if Pyl_Angle[n,a]>=360 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]-360;
        if Pyl_Angle[n,a]<0 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]+360;
        Pyl_H[n,a]:=Pyl_H[n,a]+0.012;
        Pyl_Y[n,a]:=Pyl_Y[n,a]+Dym_V_Y;
        Pyl_X[n,a]:=Pyl_X[n,a]+Dym_V_X;
        Pyl_Sca[n,a]:=Pyl_Sca[n,a]+Delta_Pyl_Sca[n,a];
      glPopMatrix;
    end;
  end;
end;

// ׸���� ��� �� ���������
procedure Draw_Pyl_Black(n: integer);
const P_pyl:array [0..3] of GLFloat =( 0.1, 0.1, 0.1, 1);
var a: word;
begin
  if Model[n].Start then begin
    inc(Period_pyl[n]);
    if Period_pyl[n]>10 then begin
      Period_pyl[n]:=0;
      if Pyl_Begin_Index[n]>COL_PYL then Pyl_Begin_Index[n]:=1;
      Pyl_X[n,Pyl_Begin_Index[n]]:=Model[n].Xtek;
      if Model[n].Typ=MODEL_BMP1 then Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.4
                                 else Pyl_Y[n,Pyl_Begin_Index[n]]:=Model[n].Ytek+0.2;
      Pyl_H[n,Pyl_Begin_Index[n]]:=Model[n].Htek;
      Pyl_Mat[n,Pyl_Begin_Index[n]]:=0.2;
      Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.1;
      Delta_Pyl_Angle[n,Pyl_Begin_Index[n]]:=0.5-random(100)/100;
      Delta_Pyl_Sca[n,Pyl_Begin_Index[n]]:=0.015-random(75)/10000;
      inc(Pyl_Begin_Index[n]);
    end;
  end;
  for a:=1 to COL_PYL do begin
    if Pyl_Mat[n,a]>0.01 then begin
      glPushMatrix;
        //������ ������������ ���������
        P_pyl[3]:=Pyl_Mat[n,a];
        Pyl_Mat[n,a]:=Pyl_Mat[n,a]/1.13;
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_pyl);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_pyl);
        // �������, ���������� � ����������� ����
        glTranslatef(Pyl_X[n,a],Pyl_H[n,a],-Pyl_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glRotatef (-Pyl_Angle[n,a], 0.0, 0.0, 1.0);
        glScalef(Pyl_Sca[n,a],Pyl_Sca[n,a],Pyl_Sca[n,a]);
        glCallList(SPRITE_PYL);
        Pyl_Angle[n,a]:=Pyl_Angle[n,a]+Delta_Pyl_Angle[n,a];
        if Pyl_Angle[n,a]>=360 then Pyl_Angle[n,a]:=Pyl_Angle[n,a]-360;
        Pyl_Sca[n,a]:=Pyl_Sca[n,a]+Delta_Pyl_Sca[n,a];
      glPopMatrix;
    end;
  end;
end;

procedure Draw_Dym_Black(n: integer); //...
const P_Dym:array [0..3] of GLFloat =( 0.01, 0.01, 0.01, 1);
var a: word;
begin
  inc(Period_dym[n]);
  if Period_dym[n]>5 then begin
    Period_dym[n]:=0;
    if Dym_Begin_Index[n]>COL_Dym then Dym_Begin_Index[n]:=1;
    if n>COL_TEXNIKA_MODEL then begin
      Dym_X[n,Dym_Begin_Index[n]]:=BMP[n-COL_TEXNIKA_MODEL].Xtek;
      Dym_Y[n,Dym_Begin_Index[n]]:=BMP[n-COL_TEXNIKA_MODEL].Ytek;
      Dym_H[n,Dym_Begin_Index[n]]:=BMP[n-COL_TEXNIKA_MODEL].Htek+0.051;
      Fire_X[n]:=BMP[n-COL_TEXNIKA_MODEL].Xtek;
      Fire_Y[n]:=BMP[n-COL_TEXNIKA_MODEL].Ytek;
      Fire_H[n]:=BMP[n-COL_TEXNIKA_MODEL].Htek;
    end
    else begin
      Dym_X[n,Dym_Begin_Index[n]]:=Model[n].Xtek;
      Dym_Y[n,Dym_Begin_Index[n]]:=Model[n].Ytek;
      Dym_H[n,Dym_Begin_Index[n]]:=Model[n].Htek+0.051;
      Fire_X[n]:=Model[n].Xtek;
      Fire_Y[n]:=Model[n].Ytek;
      Fire_H[n]:=Model[n].Htek;
    end;
    Dym_Mat[n,Dym_Begin_Index[n]]:=1;
    Dym_Sca[n,Dym_Begin_Index[n]]:=0.2;
    Delta_Dym_Angle[n,Dym_Begin_Index[n]]:=1.7-random(200)/100;
    Delta_Dym_Sca[n,Dym_Begin_Index[n]]:=0.08-random(32)/1600;
    inc(Dym_Begin_Index[n]);
  end;
  for a:=1 to COL_Dym do begin
    if Dym_Mat[n,a]>0.004 then begin
      glPushMatrix;
        //������ ������������ ���������
        P_Dym[3]:=Dym_Mat[n,a];
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@P_Dym);
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@P_Dym);
        Dym_Mat[n,a]:=Dym_Mat[n,a]/1.07;
        // �������, ���������� � ����������� ����
        glTranslatef(Dym_X[n,a],Dym_H[n,a],-Dym_Y[n,a]);
        glRotatef (-az_result, 0.0, 1.0, 0.0);
        glScalef(1+Dym_V_X*aaaaa,1,1+Dym_V_Y*aaaaa);
        glRotatef (-Dym_Angle[n,a], 0.0, 0.0, 1.0);
        glScalef(Dym_Sca[n,a],Dym_Sca[n,a],Dym_Sca[n,a]);
        glCallList(SPRITE_PYL);
        Dym_Angle[n,a]:=Dym_Angle[n,a]+Delta_Dym_Angle[n,a];
        if Dym_Angle[n,a]>=360 then Dym_Angle[n,a]:=Dym_Angle[n,a]-360;
        Dym_Y[n,a]:=Dym_Y[n,a]+Dym_V_Y;
        Dym_X[n,a]:=Dym_X[n,a]+Dym_V_X;
        Dym_H[n,a]:=Dym_H[n,a]+0.007;
        if Dym_Sca[n,a]>0.8 then Dym_Sca[n,a]:=Dym_Sca[n,a]+Delta_Dym_Sca[n,a]/3
                          else Dym_Sca[n,a]:=Dym_Sca[n,a]+Delta_Dym_Sca[n,a];
      glPopMatrix;
    end;
  end;
  // �����
  if Fire_Index[n]>22 then Fire_Index[n]:=2;
  glPushMatrix;
    glTranslatef(Fire_X[n], Fire_H[n],-Fire_Y[n]);
    glRotatef (-az_result, 0.0, 1.0, 0.0);
    glCallList(FIRE[Fire_Index[n]div 2] );
  glPopMatrix;
  inc(Fire_Index[n]);
end;

// ������
procedure Draw_Oblako;
var a: word;
b: word;
d: real;
begin
  // �������� ��������, ����� �� �������� �� ������������
  if Task.Temp=DAY then begin
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
    // ��������� �����, ����� �� �� ����� �� ���� �������
    glDisable(GL_FOG);
  end;
  // � ������� ������� ������
  if Task.Mestn=PUSTYN then b:=round(COL_MAX_OBL/3)
                       else b:=COL_MAX_OBL;
  for a:=1 to b do begin
    glPushMatrix;
      d:=sqrt(Coord_Obl[a].X*Coord_Obl[a].X+Coord_Obl[a].Y*Coord_Obl[a].Y);
      if d=0 then d:=0.0001;
      glScalef(1,Coord_Obl[a].H/d,1);
      glTranslatef(Coord_Obl[a].X, Coord_Obl[a].H-d*0.25, -Coord_Obl[a].Y);
      // ������������ ������ ����� � �����������
      glRotatef (-az_result, 0.0, 1.0, 0.0);
      if (Task.Mestn=GORA) and (Task.m_index>6000) then glScalef(100,200,1)  //@@@@@@
                                                   else glScalef(50,100,1);
      glCallList(OBLAKO[Coord_Obl[a].Typ]);
      glCallList(OBLAKO[1]);
    glPopMatrix;
    // �������� �������
    Coord_Obl[a].X:=Coord_Obl[a].X+Dym_V_X;
    Coord_Obl[a].Y:=Coord_Obl[a].Y+Dym_V_Y;
    // ��������� ������� �����
    if Dym_V_Y>0 then if Coord_Obl[a].Y>GRANICA_OBL then Coord_Obl[a].Y:=Coord_Obl[a].Y-GRANICA_OBL*2 else
                 else if Coord_Obl[a].Y<-GRANICA_OBL then Coord_Obl[a].Y:=Coord_Obl[a].Y+GRANICA_OBL*2;
    if Dym_V_X>0 then if Coord_Obl[a].X>GRANICA_OBL then Coord_Obl[a].X:=Coord_Obl[a].X-GRANICA_OBL*2 else
                 else if Coord_Obl[a].X<-GRANICA_OBL then Coord_Obl[a].X:=Coord_Obl[a].X+GRANICA_OBL*2;
  end;
  if Task.Temp=DAY then glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
  glEnable(GL_FOG);
end;

end.
