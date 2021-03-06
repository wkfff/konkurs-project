// ��������� � ����������, ������� ������������ � ��� ��������, � ��� ���������� 3D
unit UnVarConstOpenGL;

interface

uses dglOpenGL;


const
  // ��������� ��������� ����� �1
  ISX_POL_LIGHT_X=75;
  ISX_POL_LIGHT_Y=23;
  ISX_POL_LIGHT_H=27;
  // ���� ���������� ��������
  LIGHT_EMMISS_ON: Array [0..3] of GLFloat = (1, 1, 1, 1);
  LIGHT_EMMISS_OFF: Array [0..3] of GLFloat = (0, 0, 0, 1);

var
  Quadric : PGLUquadricObj;
  // ��������� ��������� ����� �1
  lightPos : Array [0..3] of GLfloat=(ISX_POL_LIGHT_X,ISX_POL_LIGHT_H,
                                      ISX_POL_LIGHT_Y,1);
  // ����������� ��������� ����� �1
  lightDir : Array [0..2] of GLfloat=(-0.2,-1,-0.2);
  // ��������� ������� ����� ��� ���� �����
  pnvColorGreen: boolean;
  //����� ����� �� ������� ���������, ���� ��������- ��� ������ ���������
  //  patchDraw: array of array of array of word;
  colDegree: integer;// ���������� �������� � �������
  colSector: word;
  // ��������� ������������ � ������
  eyePos: array[0..3] of real;
  intensivLight:real=1.45;

  procedure InitVar;
implementation

procedure InitVar;
begin
  Quadric := gluNewQuadric;
  gluQuadricTexture (Quadric, TRUE);
end;

end.
