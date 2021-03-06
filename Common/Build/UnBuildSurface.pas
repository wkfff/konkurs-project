unit UnBuildSurface;

interface
uses dglOpenGL, UnOther, UnBuildTexture, UnVarConstOpenGL,
     SysUtils, Dialogs, UnBuildSetka;

var
  SURFACE_BAZA: integer;

type
  SurfaceClass = class(TObject)
    constructor InitSuface(index,region : integer);
    destructor FreeSurface;
  private

    //������ ��� ���������� �����������
    vertex: array of array of TVector3f;
    normal: array of array of array of TVector3f;
    ColNorm: array of array of word;
    // ������ ���������� ���������
    texture: array of array of TVector3f;
    deltaXpatch: array of real;
    deltaYpatch: array of real;

    //������ ���. ������ �����
//    coydop : array of array of Pdopy;
    procedure InitArraysLandshaft;
    procedure FinalizeArraysLandshaft;
    procedure BuildSurface(fileName: string);
    procedure BuildPatchFirstLevel(num: integer);
    procedure BuildPatchLastLevel(num: integer);
    procedure CountPatchFirstLevel(num: integer; dX, dY: real; fileName: string);
    procedure CountVertexLastLevel(num: integer; dX, dY: real);
    procedure CountPatchLastLevel(num: integer; dX, dY: real);
    procedure CountNormalPatch(num, colX, colY: integer);
    procedure SetMaterialSurface;
    procedure CountVertexFirstLevel(num: integer; dX, dY: real);
    procedure ProcOrientFileLittle(fileName: string);

  public
    maxMovePatchSurface: word;// ������������ ����� ����� �� �������� ��� ����� ������
    function CountLevelPatch(posX,posY: real; patchOtobr: word): word;

  end;
var
  Surface: SurfaceClass;
  function Count_Normal(n1,n2,n3: TVector3f): TVector3f;

implementation

constructor SurfaceClass.InitSuface(index,region : integer);
begin
  SetSizePatch(Task.m_index);
  colSector:=12;
  colDegree:=360 div 12;
  maxMovePatchSurface:=80;
  InitArraysLandshaft;
  case region of
    RAVNINA: begin
      BuildSetka('res\St_leto_no_okop\St_Leto');
      BuildSurface('res\St_leto_no_okop\St_Leto');
    end;
    GORA:begin
      BuildSetka('res\St_gora\St_gora');
      BuildSurface('res\St_gora\St_gora');
    end;
    BOLOTO:begin
      BuildSetka('res\St_leto_no_okop\St_Leto');
      BuildSurface('res\St_leto_no_okop\St_Leto');
    end;
    PUSTYN:begin
      BuildSetka('res\st_pust_no_okop\st_pust');
      BuildSurface('res\st_pust_no_okop\st_pust');
    end;
  end;
  FinalizeArraysLandshaft;
end;


// ������������� ��������
procedure SurfaceClass.InitArraysLandshaft;
begin
  SetLength(coy, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(coydop,colPatchX*(colTrianglX),colPatchY*(colTrianglY));
//  SetLength(coydop,colPatchX*(colTrianglX-1),colPatchY*(colTrianglY-1));
  // ��������� �������
  SetLength(um_mestn, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(kren_mestn, colPatchSurface+1, (colTrianglX+1), (colTrianglY+1));
  SetLength(vertex, colTrianglX+1, colTrianglY+1);
  SetLength(normal, colTrianglX+1, colTrianglY+1, 6);// ������ ������� ����� ������������ ����. 6 �������������
  SetLength(colNorm, colTrianglX+1, colTrianglY+1);
  SetLength(texture, colTrianglX+1, colTrianglY+1);
  SetLength(deltaXpatch, colPatchX+1);
  SetLength(deltaYpatch, colPatchY+1);
  SetLength(Orient_Koord, (colPatchSurface+1)*levelTexture,(colTrianglX*colTrianglY+2),3);
  SetLength(Orient_Type, (colPatchSurface+1)*levelTexture,(colTrianglX*colTrianglY));
  SetLength(Orient_Col, (colPatchSurface+1)*levelTexture);
end;

procedure SurfaceClass.BuildSurface(fileName: string);
var
  x, y, lvl, num: integer;
begin
  // C������� ������������ � �������� ����� �����
    // ���������� �����������
  SURFACE_BAZA:=glGenLists(colPatchSurface*3);
  for y:=1 to colPatchY do begin
    for x:=1 to colPatchX do begin
      // ����� ������������ �����
      num:=(x+(y-1)*colPatchX);
      // �������� ����� ������������ ����� �������
      deltaXpatch[x]:=lenghtPatchX/2+lenghtPatchX*((x-1) mod colPatchX);
      deltaYpatch[y]:=-lenghtPatchY/2-lenghtPatchY*(y-1);
      // �������� ����� �����
      CountPatchFirstLevel(num, deltaXpatch[x], deltaYpatch[y], fileName);
      if not((num>maxMovePatchSurface)and(num<=colPatchSurface))  then begin
        // ���������� �����������
        BuildPatchFirstLevel(num);
      end;
    end;
  end;
  // C������� ������������ � �������� ����� �����
  if levelTexture>1 then for lvl:=2 to levelTexture do begin;
    for y:=1 to colPatchY do begin
      for x:=1 to colPatchX do begin
        // ����� ������������ �����
        num:=(x+(y-1)*colPatchX)+colPatchSurface*(lvl-1);
        // �������� ����� �����
        CountPatchLastLevel(num, deltaXpatch[x], deltaYpatch[y]);
        // ���������� �����������
        BuildPatchLastLevel(num);
      end;
    end;
  end;
  ProcOrientFileLittle(fileName);
end;



procedure SurfaceClass.CountPatchFirstLevel(num: integer; dX, dY: real; fileName: string);
var
  i, j: integer;
begin
  // �������� ����� �����
  LoadPatch(dirBase+fileName+inttostr(num)+'.shp',num);
  for i:=0 to colTrianglY do begin
    for j:=0 to colTrianglX do begin
      vertex[j][i][1]:=coy[num][j][i];// �������� ����� ��� ���������� ���������
     end;
  end;
  CountVertexFirstLevel(num, dX, dY);
  CountNormalPatch(num, colTrianglX, colTrianglY);
end;


procedure SurfaceClass.CountVertexFirstLevel(num: integer; dX, dY: real);
var
  i,j: integer;
begin
  // ������������ ���� �� ������ ������
  for j:=0 to (colTrianglX div 2)-1 do begin
    // ��������� �������� ������ ������ ������
    vertex[j*2+1][0][1]:=(vertex[j*2][0][1]+vertex[j*2+2][0][1])/2;
    coy[num][j*2+1][0]:=vertex[j*2+1][0][1];
    vertex[j*2+1][colTrianglY][1]:=(vertex[j*2][colTrianglY][1]+vertex[j*2+2][colTrianglY][1])/2;
    coy[num][j*2+1][colTrianglY]:=vertex[j*2+1][colTrianglY][1];
  end;
  for i:=0 to (colTrianglY div 2)-1 do begin
    vertex[0][i*2+1][1]:=(vertex[0][i*2+0][1]+vertex[0][i*2+2][1])/2;
    coy[num][0][i*2+1]:=vertex[0][i*2+1][1];
    vertex[colTrianglX][i*2+1][1]:=(vertex[colTrianglX][i*2+0][1]+vertex[colTrianglX][i*2+2][1])/2;
    coy[num][colTrianglX][i*2+1]:=vertex[colTrianglX][i*2+1][1];
  end;
  vertex[0][0][0]:=-lenghtPatchX/2+dX;   // ��������� ��������� ��������� ��� ������ �����������
  vertex[0][0][2]:=lenghtPatchY/2+dY;    // ...........
  // ������������  ������� ����������� ���������
  for i:= 0 to colTrianglY do begin
    for j:= 0 to colTrianglX do begin
      vertex[j][i][0]:=vertex[0][0][0]+j*lenghtTrianglX;
      vertex[j][i][2]:=vertex[0][0][2]-i*lenghtTrianglY;
    end;
  end;
end;

procedure SurfaceClass.CountPatchLastLevel(num: integer; dX, dY: real);
begin
  CountVertexLastLevel(num, dX, dY);
  CountNormalPatch(num, colTrianglXSecondLevel, colTrianglYSecondLevel);
end;

procedure SurfaceClass.CountVertexLastLevel(num: integer; dX, dY: real);
var
  i,j: integer;
begin
  for i:= 0 to colTrianglY do begin
    for j:= 0 to colTrianglX do begin
      vertex[j][i][0]:=0;
      vertex[j][i][2]:=0;
    end;
  end;

  for i:= 0 to colTrianglY do begin
    for j:= 0 to colTrianglX do begin
      // ��������� ���������� ������ �� ������  � � ������ ������ � 2*2 ����
      if num<=(colPatchSurface*2) then begin
        if (j mod 2 =0)and (i mod 2 =0)then vertex[j div 2][i div 2][1]:=coy[num-colPatchSurface][j][i];
      end
      else begin
        if (j mod 2 =0)and (i mod 2 =0)then vertex[j div 2][i div 2][1]:=coy[num-colPatchSurface*2][j][i];
      end;
    end;
  end;
  vertex[0][0][0]:=-lenghtPatchX/2+dX;   // ��������� ��������� ��������� ��� ������ �����������
  vertex[0][0][2]:=lenghtPatchY/2+dY;
  for i:= 0 to colTrianglYSecondLevel do begin
    for j:= 0 to colTrianglXSecondLevel do begin
      vertex[j][i][0]:=vertex[0][0][0]+j*lenghtTrianglX*2;
      vertex[j][i][2]:=vertex[0][0][2]-i*lenghtTrianglY*2;
    end;
  end;

  // ������ c������� �� ������ ������
  if num>colPatchSurface *2 then begin
    // ��������� �������� ������ ������ ������ �������� �� ���� �� ������ ��������
    for j:=1 to (colTrianglXSecondLevel div 2)-1 do begin
      vertex[j*2][1][1]:=(vertex[j*2-1][1][1]+vertex[j*2+1][1][1])/2;
      vertex[j*2][colTrianglYSecondLevel-1][1]:=(vertex[j*2-1][colTrianglYSecondLevel-1][1]+
                                               vertex[j*2+1][colTrianglYSecondLevel-1][1])/2;
    end;
    for i:=1 to (colTrianglYSecondLevel div 2)-1 do begin
      vertex[1][i*2][1]:=(vertex[1][i*2-1][1]+vertex[1][i*2+1][1])/2;
      vertex[colTrianglXSecondLevel-1][i*2][1]:=(vertex[colTrianglXSecondLevel-1][i*2-1][1]
                                              +vertex[colTrianglXSecondLevel-1][i*2+1][1])/2;
    end;
  end;
end;

procedure SurfaceClass.CountNormalPatch(num, colX, colY: integer);
var
  a,x,y: integer;
  v: TVector3f;
  vxyz: real;
begin
  for x:=0 to colX do begin
    for y:=0 to colY do begin
      colNorm[x, y]:=0;
      for a:=0 to 5 do begin
        Normal[x, y, a, 0]:=0;
        Normal[x, y, a, 1]:=0;
        Normal[x, y, a, 2]:=0;
      end;
    end;
  end;
  for y:= 0 to colY-1 do begin  // ������ ��������
    for x:= 0 to colX-1 do begin
      Normal[x,y,ColNorm[x,y]]:=Count_Normal(vertex[x][y+1],vertex[x][y],vertex[x+1][y]);
      Normal[x+1,y,ColNorm[x+1,y]]:=Normal[x,y,ColNorm[x,y]];
      Normal[x,y+1,ColNorm[x,y+1]]:=Normal[x,y,ColNorm[x,y]];

      inc(ColNorm[x,y]);
      inc(ColNorm[x+1,y]);
      inc(ColNorm[x,y+1]);

      Normal[x+1,y+1,ColNorm[x+1,y+1]]:=Count_Normal(vertex[x+1][y],vertex[x+1][y+1],vertex[x][y+1]);
      Normal[x,y+1,ColNorm[x,y+1]]:=Normal[x+1,y+1,ColNorm[x+1,y+1]];
      Normal[x+1,y,ColNorm[x+1,y]]:=Normal[x+1,y+1,ColNorm[x+1,y+1]];

      inc(ColNorm[x+1,y+1]);
      inc(ColNorm[x,y+1]);
      inc(ColNorm[x+1,y]);
    end;
  end;
  for y:=0 to colY do begin
    for x:=0 to colX do begin
      v[0]:=0;
      v[1]:=0;
      v[2]:=0;
      // �������� ��������
      for a:=0 to ColNorm[x,y]-1 do begin
        v[0]:=v[0]+Normal[x,y,a][0];
        v[1]:=v[1]+Normal[x,y,a][1];
        v[2]:=v[2]+Normal[x,y,a][2];
      end;
      // ����������
      if ColNorm[x,y]>0 then begin
        Normal[x,y,0][0]:=v[0]/ColNorm[x,y];
        Normal[x,y,0][1]:=v[1]/ColNorm[x,y];
        Normal[x,y,0][2]:=v[2]/ColNorm[x,y];
      end
      else begin
        Normal[x,y,0][0]:=0;
        Normal[x,y,0][1]:=0;
        Normal[x,y,0][2]:=0;
      end;
      // ������������
      vxyz:=sqrt(Normal[x,y,0][0]*Normal[x,y,0][0]+Normal[x,y,0][1]*Normal[x,y,0][1]+
             Normal[x,y,0][2]*Normal[x,y,0][2]);
      if vxyz=0 then vxyz:=0.00001;
      Normal[x,y,0][0]:=Normal[x,y,0][0]/vxyz;
      Normal[x,y,0][1]:=Normal[x,y,0][1]/vxyz;
      Normal[x,y,0][2]:=Normal[x,y,0][2]/vxyz;
    end;
  end;
end;

procedure SurfaceClass.SetMaterialSurface;
const
 mat : Array [0..3] of GLFloat = (0.91,0.91,0.91,1);
begin
  // �������� �����������
  mat[0]:=1;
  mat[1]:=mat[0]; mat[2]:=mat[0]; mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
  mat[0]:=0.3;
  mat[1]:=mat[0]; mat[2]:=mat[0]; mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
  mat[0]:=0.4;
  mat[1]:=mat[0]; mat[2]:=mat[0]; mat[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
  glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
end;

procedure SurfaceClass.BuildPatchFirstLevel(num: integer);
var
 i,j: integer;
begin
  glNewList (SURFACE_BAZA+num, GL_COMPILE);
    SetMaterialSurface;
    for j:=0 to colTrianglY-1 do begin
      glBegin(GL_TRIANGLES);
        for i:=0 to colTrianglX-1 do begin
          glNormal3fv(@normal[i][j][0]);
          glTexCoord2f(0+i/colTrianglX,0+j/colTrianglY);
          glvertex3fv(@vertex[i][j]);

          glNormal3fv(@normal[i+1][j][0]);
          glTexCoord2f(0+(i+1)/colTrianglX,0+j/colTrianglY);
          glvertex3fv(@vertex[i+1][j]);

          glNormal3fv(@normal[i][j+1][0]);
          glTexCoord2f(0+i/colTrianglX,0+(j+1)/colTrianglY);
          glvertex3fv(@vertex[i][j+1]);


          glNormal3fv(@normal[i+1][j][0]);
          glTexCoord2f(0+(i+1)/colTrianglX,0+j/colTrianglY);
          glvertex3fv(@vertex[i+1][j]);

          glNormal3fv(@normal[i+1][j+1][0]);
          glTexCoord2f(0+(i+1)/colTrianglX,0+(j+1)/colTrianglY);
          glvertex3fv(@vertex[i+1][j+1]);

          glNormal3fv(@normal[i][j+1][0]);
          glTexCoord2f(0+i/colTrianglX,0+(j+1)/colTrianglY);
          glvertex3fv(@vertex[i][j+1]);
        end;
      glEnd;
    end;
  glEndList;
end;

// ���������� ����������� 2 � 3 ������
procedure SurfaceClass.BuildPatchLastLevel(num: integer);
var
 i,j: integer;
begin
  glNewList (SURFACE_BAZA+num, GL_COMPILE);
    SetMaterialSurface;
    // 2 �������
    if num<=(colPatchSurface*2) then begin
      for j:=0 to Round((colTrianglYSecondLevel)/2)-1 do begin
        glBegin(GL_TRIANGLE_STRIP);
          for i:=0 to colTrianglXSecondLevel do begin   // ��� �����
            glNormal3fv(@normal[i][2*j+1][0]);
            glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+1)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i][2*j+1]);
            glNormal3fv(@normal[i][2*j][0]);
            glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i][2*j]);
          end;
        glEnd;
        glBegin(GL_TRIANGLE_STRIP);
          for i:=colTrianglXSecondLevel downto 0 do begin
            glNormal3fv(@normal[i][2*j+1][0]);
            glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+1)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i][2*j+1]);
            glNormal3fv(@normal[i][2*j+2][0]);
            glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+2)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i][2*j+2]);
          end;
        glEnd;
      end;
    end
    else begin
      // ��������� ������������� �������������� �����
      glBegin(GL_TRIANGLE_STRIP);
        j:=0;
        for i:=0 to colTrianglXSecondLevel do begin
          glNormal3fv(@normal[i][2*j+1][0]);
          glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+1)/(colTrianglYSecondLevel));
          glVertex3fv(@vertex[i][2*j+1]);
          glNormal3fv(@normal[i][2*j][0]);
          glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j)/(colTrianglYSecondLevel));
          glVertex3fv(@vertex[i][2*j]);
        end;
      glEnd;
      glBegin(GL_TRIANGLE_STRIP);
        j:=Round((colTrianglYSecondLevel)/2)-1;
        for i:=colTrianglXSecondLevel downto 0 do begin
          glNormal3fv(@normal[i][2*j+1][0]);
          glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+1)/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i][2*j+1]);
          glNormal3fv(@normal[i][2*j+2][0]);
          glTexCoord2f(-1+(2*i)/(2*(colTrianglXSecondLevel)),-1+(2*j+2)/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i][2*j+2]);
        end;
      glEnd;
      // ��������� ������������� ������������ �����
      glBegin(GL_TRIANGLE_STRIP);
        i:=0;
        for j:=1 to colTrianglYSecondLevel-1 do begin
          glNormal3fv(@normal[i][j][0]);
          glTexCoord2f(i/(colTrianglXSecondLevel),j/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i][j]);
          glNormal3fv(@normal[i+1][j][0]);
          glTexCoord2f((i+1)/(colTrianglXSecondLevel),j/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i+1][j]);
        end;
      glEnd;
      glBegin(GL_TRIANGLE_STRIP);
        i:=colTrianglXSecondLevel-1;
        for j:=1 to colTrianglYSecondLevel-1 do begin
          glNormal3fv(@normal[i][j][0]);
          glTexCoord2f(i/(colTrianglXSecondLevel),j/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i][j]);
          glNormal3fv(@normal[i+1][j][0]);
          glTexCoord2f((i+1)/(colTrianglXSecondLevel),j/(colTrianglYSecondLevel));
          glvertex3fv(@vertex[i+1][j]);
        end;
      glEnd;
      // ��������� �������� ��������������
      for j:=0 to ((colTrianglYSecondLevel)div 4)-1 do begin
        glBegin(GL_TRIANGLE_STRIP);
          for i:=1 to (colTrianglXSecondLevel)div 2 do begin
            glNormal3fv(@normal[i*2-1][4*j+3][0]);
            glTexCoord2f((2*i-1)/(colTrianglXSecondLevel),(4*j+3)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i*2-1][4*j+3]);
            glNormal3fv(@normal[i*2-1][4*j+1][0]);
            glTexCoord2f((2*i-1)/(colTrianglXSecondLevel),(4*j+1)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i*2-1][4*j+1]);
          end;
        glEnd;
        // ��������� ������ � �������� ������� �� �������������
        glBegin(GL_TRIANGLE_STRIP);
          if j<((colTrianglYSecondLevel)div 4)-1 then
                          for i:=(colTrianglXSecondLevel)div 2 downto 1 do begin
            glNormal3fv(@normal[i*2-1][4*j+3][0]);
            glTexCoord2f((2*i-1)/(colTrianglXSecondLevel),(4*j+3)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i*2-1][4*j+3]);
            glNormal3fv(@normal[i*2-1][4*j+5][0]);
            glTexCoord2f((2*i-1)/(colTrianglXSecondLevel),(4*j+5)/(colTrianglYSecondLevel));
            glvertex3fv(@vertex[i*2-1][4*j+5]);
          end;
        glEnd;
      end;
    end;
  glEndList;
end;

destructor SurfaceClass.FreeSurface;
begin
  if coy<>nil then finalize(coy);
  FreeMem(coy);
  FinalizeCoydop;
  if deltaXpatch<>nil then finalize(deltaXpatch);
  FreeMem(deltaXpatch);
  if deltaYpatch<>nil then finalize(deltaYpatch);
  FreeMem(deltaYpatch);
  if Orient_Koord<>nil then finalize(Orient_Koord);
  FreeMem(Orient_Koord);
  if Orient_Type<>nil then finalize(Orient_Type);
  FreeMem(Orient_Type);
  if Orient_Col<>nil then finalize(Orient_Col);
  FreeMem(Orient_Col);
  FinalizeArraysLandshaft;
end;

procedure SurfaceClass.FinalizeArraysLandshaft;
begin
  if vertex<>nil then finalize(vertex);
  FreeMem(vertex);
  if normal<>nil then finalize(normal);
  FreeMem(normal);
  if colNorm<>nil then finalize(colNorm);
  FreeMem(colNorm);
  if texture<>nil then finalize(texture);
  FreeMem(texture);
  if kren_mestn<>nil then finalize(kren_mestn);
  FreeMem(kren_mestn);
  if Um_mestn<>nil then finalize(Um_mestn);
  FreeMem(Um_mestn);
end;

//������� ������� �������
function Count_Normal(n1,n2,n3: TVector3f): TVector3f;
var
  vx1,vx2,vy1,vy2,vz1,vz2,nx,ny,nz,wrki:glfloat;
begin
  vx1:=n1[0]-n2[0];
  vy1:=n1[1]-n2[1];
  vz1:=n1[2]-n2[2];
  vx2:=n2[0]-n3[0];
  vy2:=n2[1]-n3[1];
  vz2:=n2[2]-n3[2];
  nx:=vy1*vz2-vz1*vy2;
  ny:=vz1*vx2-vx1*vz2;
  nz:=vx1*vy2-vy1*vx2;
  wrki:=sqrt(nx*nx+ny*ny+nz*nz);
  If wrki = 0 then wrki :=0.0001;
  count_normal[0]:=nx/wrki;
  count_normal[1]:=ny/wrki;
  count_normal[2]:=nz/wrki;
end;

function SurfaceClass.CountLevelPatch(posX,posY: real; patchOtobr: word): word;
var
  x: real;
  y: real;
begin
  CountLevelPatch:=patchOtobr;
  case levelTexture of
    1: CountLevelPatch:=patchOtobr;
    2: begin
      CountLevelPatch:=patchOtobr+colPatchSurface;
      x:=((patchOtobr-1) mod colPatchX) * lenghtPatchX-deltaXpatch[1];
      y:=(patchOtobr div colPatchX) * lenghtPatchY+deltaYpatch[1];
      if (abs(posX-x)<(3* lenghtPatchX)) and
         (abs(posY-Y)<(3* lenghtPatchY)) then begin
        CountLevelPatch:=patchOtobr;
      end;
    end;
    3:begin
      CountLevelPatch:=patchOtobr+2*colPatchSurface;
      x:=((patchOtobr-1) mod colPatchX) * lenghtPatchX-deltaXpatch[1];
      y:=(patchOtobr div colPatchX) * lenghtPatchY+deltaYpatch[1];

      if (abs(posX-x)<(2* lenghtPatchX)) and
         (abs(posY-Y)<(2* lenghtPatchY)) then begin
        CountLevelPatch:=patchOtobr;
      end
      else begin
        if (abs(posX-x)<(4* lenghtPatchX)) and
           (abs(posY-Y)<(4* lenghtPatchY)) then begin
          CountLevelPatch:=patchOtobr+colPatchSurface;
        end;
      end;
    end;
  end;
end;

procedure SurfaceClass.ProcOrientFileLittle(fileName: string);
var
  f: textfile;
  s: string;
begin
  colOrieLittle:=0;
  s:=dirBase+fileName+'little.shp';
  // ���������� ��������� �� ����� res\Leto\letolittle.shp
  if FileExists(s) then begin
    AssignFile(f,s);
    Reset(f);
    readln(f);
    while not EOF(f) do begin
      inc(colOrieLittle);
      read(f,orientFileLittle[colOrieLittle].patch);
      read(f,orientFileLittle[colOrieLittle].typ);
      read(f,orientFileLittle[colOrieLittle].x);
      read(f,orientFileLittle[colOrieLittle].y);
      read(f,orientFileLittle[colOrieLittle].h);
      readln(f,orientFileLittle[colOrieLittle].az);
    end;
    Close(f);
  end;
end;
end.

