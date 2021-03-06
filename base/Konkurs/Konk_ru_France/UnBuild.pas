// ������� ����������� ������������ � Count_Tree_patch:

unit UnBuild;

interface

uses
  Windows, OpenGL, Dglut, Main, Graphics, SysUtils, classes, Dialogs, UnOther,
  UnGeom;
const
  COL_SECTOR=12;
  COL_DEGRE=30;
  X_COL_TRIANGL=41;  // ���������� ������������� �� �
  Y_COL_TRIANGL=41;  // ���������� ������������� �� Y
  SHAG_X_RAV=0.5; // ����� ������������� �� X
  SHAG_Y_RAV=0.5; // ����� ������������� �� Y
  COL_MAX_SPRITE=15;
  MAX_COL_PODRYV=15;

  // ���������� ������������ �� �������� � ��
{  VYCHKA_X_RAV=2200;
  VYCHKA_Y_RAV=950;
  VYCHKA_X_MV=8510;
  VYCHKA_Y_MV=720;
  VYCHKA_X_GOR=3580;
  VYCHKA_Y_GOR=1390;}

  BTR_SHIRINA_05=0;    //�������� ������ ���

  ISX_POL_BTR_Y_RAV=1670;    // �������� ��������� ��� �� Y
  ISX_POL_BTR_Y_GOR=1770;    // �������� ��������� ��� �� Y

  STOLB_BOTTOM_RAV=1780;      //     ���������� �� ������ ������ �����������
  STOLB_BOTTOM_GOR=1880;      //     ���������� �� ������ ������ �����������

  STOLB_SHIR=60;
  STOLB_LEFT_RAV=1800;         // ���������� �� ������ ����
  STOLB_DX1_RAV=1445;         //     ���������� �� 1 �� 2 �������
  STOLB_DX2_RAV=1525;         //     ���������� �� 2 �� 3 �������
  STOLB_LEFT_GOR=2930;         // ���������� �� ������ ����
  STOLB_DX1_GOR=980;         //     ���������� �� 1 �� 2 �������
  STOLB_DX2_GOR=980;         //     ���������� �� 2 �� 3 �������

  STOLB_DY_R=80;         //     ���������� �� ����� �� �������
  STOLB_DY_BL=6700;       //    ���������� �� ������� �� �������
  STOLB_DY_GRAN=14000;    //     ���������� �� ������� �� ������ ������� �������
  H_STOLB_GRAN=0.6;       //������ �������������� ������� � ������� �����������

  VYCHKA_X_RAV=STOLB_LEFT_RAV+STOLB_DX1_RAV-100;
  VYCHKA_Y_RAV=ISX_POL_BTR_Y_RAV;
  VYCHKA_X_GOR=STOLB_LEFT_GOR+STOLB_DX1_GOR-100;
  VYCHKA_Y_GOR=ISX_POL_BTR_Y_GOR;
  VYCHKA_X_MV=8510;
  VYCHKA_Y_MV=720;
type
//==============���������� ��������========================
  //C�������� ��� �������� �������
  TMont_Soldat=record
   Name: string;
   Index: word;         //
   Col_Ris: word;       //  ���������� ����������� ��������
   Contur: word;        //  ������ ��������� ��������
   Base_Name_Ris: string;   //  ������� ��� �������� �������
   Col_Kadr: word;      //  ���������� ��������������� ������
   X_Ris,Y_Ris: array[0..30] of real;//������ �������
   Line_Kadr: array[0..30] of word;// ������� ������
   Repet: boolean;      // ������� ����������
  end;
  Mestnik = record
              Num               : integer;  //����� ����� ���������� List
              Patch             : integer;  //����� �����
              X,Y,H,A           : glFloat;  //���������� � ���� �������� � �������� ������ � ��������
              Sc                : glFloat;  // ���������������
              Az_Paden          : glFloat;  //���� ������� � ��������
              Tg_Paden          : glFloat;  //������ ������� � ��������
              Type_Objekt       : integer;  //������� ������� 1- �����, 2-����, 3-�������-� , 4-������� �����
              Type_Action       : integer;  //������� ���������� 0- ���, 1- ������, 2-������, 3-����������
              Col_Points_Objekt : integer;  //���������� �������������� �����
              Curver            : TList;    //������ ���������
             end;
  PMestnik = ^Mestnik;

  TRegular = array[0..Round(SHAG_X_RAV*100),0..Round(SHAG_Y_RAV*100)] of GLfloat;
  PTRegular = ^TRegular;
  dopy  = record
           NetType : byte;      //��� ����� 0 - ����������
           regular : PTRegular;
           HBase   : real;
           HDelta  : real;
           BaseX   : integer;
           BaseY   : integer;
           irregular : TList;
          end;
  Pdopy = ^dopy;

  TZapis=record
   xnorm: GLfloat;   //
   ynorm: Glfloat;   //  ������ ��� ������ �������
   znorm: GLfloat;   //
  end;
  TVsp=record
    X_vsp, Y_vsp, H_vsp: real;
    Typ: word;
    Num: word;
    Pos: word;
  end;

  TMont_Spr=record
   Name: string;
   Index: word;         //
   Col_Ris: word;       //  ���������� ����������� ��������
   Contur: word;        //  ������ ��������� ��������
   Base_Name_Ris: string;   //  ������� ��� �������� �������
   Col_Kadr: word;      //  ���������� ��������������� ������
   Line_Kadr: array[1..100] of word;// ������� ������
   Repet: boolean;      // ������� ����������
  end;

  TShow_Spr=record
   X_show,Y_show,H_show,D_show: real;
   Type_spr: word;
   Pos_end: word;
   Pos_tek: word;
   Enable: boolean;
  end;

  TCoord_Obl = record
    Typ: word;
    Num: word;
    X,Y,H : glFloat;
  end;

  procedure Init_image_loading;
  procedure Creat_OpenGL;
  procedure Reset_OpenGL;
  procedure SetDCPixelFormat;
  procedure Init_OpenGL;
  procedure Init_arrays;
  procedure Build_3d;
  function Count_Tree_patch:boolean;
  // ������������
  procedure Build_T55;
//  procedure Build_Leo;
  procedure Build_Apach;
  procedure Build_BMP1;
  procedure Build_BMP2;
  procedure Build_M113;
  procedure Build_T80;
  //�����.�����. � ������ �������
  procedure Isx_Pol_Oborud;
  procedure Build_Scene;
  procedure Count_Scene;
  function Count_dX(n: integer): integer;
  procedure Build_Orientir;
  procedure Count_Orientir;
  procedure ReBuild_Patch(num_patch: word);
  procedure Build_Target;
  // ���� ��� ���������� ��������
  procedure Build_Table;
  // �������
  procedure Build_Sprite;
  function Load_Sprite(num: word; name: string): boolean;
  // ������� � ����
  procedure Build_Fire;
  procedure Build_vzryv;
  procedure Build_Nebo;
  procedure Build_Pyl;
  procedure Count_Nebo;
  // �����������
  procedure Build_Surface;
  procedure ReadPatch(s: string);
  procedure DrawStripSurf(filename: string; num,delta_x:integer);
  // �������� 3D ��������
  procedure MontObject(FileName: string; Num: integer);
  // ��������� �������
  procedure PrepareImage(bmap: string;contur: integer);
  // ���������� ��������
  procedure BuildNormal;
  function CountNorm(x1,y1,z1,x2,y2,z2,x3,y3,z3:real): TZapis;
  // ���������� ������ ����� �������
  function CountVertexYTri(X,Y: real): real;//  ��� ������ ���� � Y ������
  function CountPatch(Xi,Yi : real) : integer;
  procedure AddMestnik(Num,Patch : integer; x,y,h,a,Sc : real);
  procedure AddDinamic(Num : integer; x,y,a : GLdouble);
  // ���������
  procedure Osveshenie(pnv,akt: boolean);/// ��� ���/����, ���� �� ���/���� //&&&&&&&&&&
  // ��������
  procedure Build_Gorisont;
  // ���������� �����
  procedure Build_Pricel;
  procedure Build_Krug(num:word);
  procedure Build_Shtorka;
  procedure Build_Box;
  procedure Build_Diafragma;
  procedure Build_Filtr;
  procedure Isx_Pol_Scene;
  procedure Build_Trass_Ptur;
  procedure Build_Missile;
  procedure Build_Parade;
const
  ISX_POL_BTR_Y=870;          // �������� ��������� �-90 �� Y

//==============���������� ��������========================
  MAX_COL_SOLDAT=6;
  MAX_COL_TYPE_SOLD=20;
  COL_SECTOR_SOLDAT=8;
  COL_COLDAT_GRAD=6;

  MASHT_BMP=1;        //������� ���

  POL_TANK_H=0.15;      //��������� ������� ��� �� � � ������� ��������//---
  POL_APA_H=0;            //��������� �������� �� � � ������� ��������
  POL_LEO_H=0.159;            //��������� ������� ��� �� � � ������� ��������
  POL_BMP_H=0.165;      //��������� ������� ��� �� � � ������� ��������
  POL_M_113=0.086;      //��������� ������� ��� �� � � ������� ��������

  BMP_X_BASHN=0.1;
  BMP_H_BASHN=-0.014;
  BMP_Y_BASHN=0.05;
  BMP_X_STVOL=-0.084;
  BMP_H_STVOL=0.021;
  BMP_Y_STVOL=0;
  H_PRICEL_MV=0.06;              // �����a  ���������� ��
  H_PRIC_PKT=0;                 //����� ������� - ����� ���
  X_PRICEL=0.035;

  KOL_TYPE_TREE=20;
  KOL_TYPE_LES=4;
  KOL_TYPE_KUST=7;
  KOL_TYPE_HAUS_1=5;
  KOL_TYPE_HAUS_2=13;
  KOL_TYPE_HAUS_2_PUST=5;
  KOL_TYPE_HAUS_3=1;
  KOL_TYPE_BASH=2;
  KOL_TYPE_HAUS_TEX_1=3;
  KOL_TYPE_HAUS_TEX_2=1;
  KOL_TYPE_OBLAKO=5;
  COL_MAX_OBL=150;
  GRANICA_OBL=999;
  COL_OBL_SECTOR=10;
  SetOfRandom : array [1..15] of integer = (110,120,130,200,210,220,310,320,330,350,360,400,410,420,430);

  // 3D �������
  PATR_PUSHKA=1;
  PATR_PKT=2;
  PATR_PTUR=3;
  PATR_PTUR2=4;
  PATR_PTUR3=5;
  VZRYV_Pushka_1=6;
  VZRYV_Pushka_2=7;
  VZRYV_Pushka_3=8;
  VZRYV_Pushka_4=9;
  DYM_2=11;
  VSPYSH=12;
  ZAVESA=15;
  FIRE=20;  // +12


  // ���������
  OBLAKO=40;
  GORIZONT=60;
  GORIZONT2=61;
  ZVEZDA=62;
  NEBO=63;
  // ��� ������ ��� ������� ��������� ���������������
  ORIENTIR=70;
  //���������, ������� ������������ �������������
  MIN_NUM_ORIENTIR=70; //+ 29
  // ���������� �����
  PRICEL_PTUR=100;
  PRICEL_PTUR_MARKA=101;
  KRUG1=111;
  KRUG2=112;
  KRUG3=113;
  KRUG4=114;
  KRUG5=115;
  MARKA_DALNOMER1=116;
  MARKA_TPD_GOTOV=117;
  MARKA_IZM=118;
  MARKA_PPN_GOTOV=119;
  MARKA_PPN_NUIT=120;
  DIAFRAGMA=121;
  FILTR=122;
  SHTORKA=123;
  PRICEL_K_N=124;
  PRICEL_K_NM=125;
  PRICEL_K_DM=126;
  PRICEL_K_D=127;
  PRICEL_K_DD=128;
  LAMP_BR_R=130;
  LAMP_KU_R=131;
  LAMP_OS_R=132;
  LAMP_R_R=133;
  LAMP_S_R=134;
  PRICEL_N_DM=135;
  PRICEL_N_D=136;
  PRICEL_N_N=137;
  PRICEL_N_NM=138;
  FILTR1=139;
  FILTR2=140;
  FILTR3=141;

  // ���������
  RIS_PANTOGRAF=145;
  POINT_RED=146;
  POINT_GREEN=147;

  // ������ �������
  BMP1_KORPUS=151;
  BMP1_BASHNA=152;
  BMP1_STVOL=153;
  BMP1_VENEZ=154;
  BMP1_NAPR=155;
  BMP1_KOLESO=156;
  BMP1_GUSEN=157;
  BMP1_BAZA1=158;
  BMP1_BAZA2=159;
  BMP1_KONKURS =160;
  ROCKET =161;
  APACH_KORP=162;
  APACH_STAB=163;
  APACH_VINT=164;
  LEO_KORPUS=165;
  LEO_BASHNA=166;
  LEO_STVOL=167;
  LEO_BAZA1=168;
  LEO_BAZA2=169;

{  BTR_KORPUS=165;
  BTR_KOLESO_P=166;
  BTR_KOLESO_L=167;
  BTR_STVOL=168;
  BTR_BASHNA=169;
  BTR_KOLESO_P_TEK=170;
  BTR_KOLESO_L_TEK=171;}

  M113_KORPUS=172;
  M113_STVOL=173;
  M113_BAZA1=174;
  M113_BAZA2=175;

  TANK_KORPUS=182;
  TANK_BASHNA=183;
  TANK_STVOL=184;
  TANK_BAZA1=185;
  TANK_BAZA2=186;
  TANK_GABAR_ALL=187;
  TANK_GABAR_ARIER=188;
  TANK_FARA=189;
  TANK_KATOK_R1=190;
  TANK_KATOK_R2=191;
  TANK_KATOK_L1=192;
  TANK_KATOK_L2=193;
  TANK_KORPUS_TEN=194;
  TANK_BASHNA_TEN=195;
  TANK_STVOL_TEN=196;
  BMP2_KORPUS=197; 
  BMP2_BASHNA=198;
  BMP2_STVOL=199;
  BMP2_BAZA1=200;
  BMP2_BAZA2=201;

  // ������
  MIN_NUM_TARGET=250; // �� 50
  // �������           //�� 300
  SPRITE=300;
  SPRITE_PYL=400;
  SPRITE_VSP=401;      // 14
//  415
//==============���������� ��������========================
  SPHERA=488;
  SOLDAT=499;          // 100
  // �������� �����
  HAUS_1=600; // ���� ����� �� 100
  HAUS_2=630;
  HAUS_3=660;
  // ��������������
  DEREVO=700; // ���� �������� �� 40
  LES=740;    // ������ ���� �� 10
  KUST=750;   // ���� ������ �� 30
  TRAVA=780;  // ��������� ������
  // ������ �������
  BASH=800;
  HAUS_TEX_1=805;
  HAUS_TEX_2=815;
  CERCOV=820;
  STOLB_E=821;
  STOLB_V=822;
  BASH_KR=823;
  BASH_KV=824;
  ZABOR=830;  // ������ 18
  OKOP=849;
  OKOP_1=850;
  OKOP_2=851;
  OKOP_3=852;
  OKOP_10=853;  //��� � ��������
  OKOP_11=854;  //�������
  MOST_KOL1=855;
  MOST=856;
  VYCHKA=857;
  ASCARP=858;
  USTUP=859;
  PEREEZD=860;
  OZERO_TEMP=861;
  OZERO=862;
  NADOLB=863;
  BREVNO=864;
  VODA=865;
  OKOP_10_TEMP_VERCH=866;
  OKOP_10_TEMP=867;
  OKOP_11_TEMP_VERCH=868;
  OKOP_11_TEMP=869;
  VORONKA=870;
  VORONKA_TEMP=871;
  VORONKA_TEMP_VERCH=872;
  // ����� � ������
  ZNAK_STOP=950;
  ZNAK1=951;
  ZNAK2=952;
  ZNAK3=953;
  ZNAK4=954;
  ZNAK5=955;
  ZNAK6=956;
  ZNAK7=957;
  ZNAK8=958;
  ZNAK9=959;
  ZNAK10=960;
  ZNAK11=961;
  ZNAK12=962;
  ZNAK_R=970;
  ZNAK_L=971;
  ZNAK_G_D=972; // ���� "��������������� �������"
  ZNAK_MIN1=973;
  ZNAK_MIN2=974;

  FONAR_CENTR=980;
  FONAR_BOK=981;
  FONAR_RM=982;
  FONAR_WM=983;
  FONAR_BM=984;
  FONAR_JM=985;

  STOLB=990;
  STOLB_WHITE=991;
  STOLB_RED=992;
  STOLB_BLUE=993;
  STOLB_BLACK=994;
  STOLB_BLACK_05=995;

  // ����������� � ��������� � ��� ������� ��������
  SURFACE_BAZA=1000;
  SCENE_BAZA=3000;
  OKOP_BAZA=4000;

  GORIZONT_GORA=5000;//+32/

  LAMP_GREEN=5210;
  LAMP_YELLOW=5211;
  LAMP_RED=5212;
  LAMP_NOT=5213;
  LAMP_0=5214;
  LAMP_1=5215;
  LAMP_2=5216;
  LAMP_3=5217;
  LAMP_4=5218;
  LAMP_5=5219;
  LAMP_6=5220;
  LAMP_7=5221;
  LAMP_8=5222;
  LAMP_9=5223;
  LAMP_BR=5224;
  LAMP_KU=5225;
  LAMP_OS=5226;
  LAMP_UP=5227;
  LAMP_R=5228;
  LAMP_S=5229;
  LAMP_P=5230;
  PANEL=5231;
  PANEL_KOM=5232;
  MERA=5233;

  TRASSA_PTUR=10000;
  FIRE_PTUR=10030;
  MISSILE_PTUR=10040;
  BOX_T=10050;

  ISX_POL_LIGHT_X=75;
  ISX_POL_LIGHT_Y=23;
  ISX_POL_LIGHT_H=27;
  //��������� �����
  LightColAmb : Array [0..3] of GLFloat = (0.1, 0.1, 0.1, 1); //���� �������� ����������
  LightColAmb_Alt : Array [0..3] of GLFloat = (0.5, 0.5,0.5, 1); //���� �������� ����������
  LightColSpe : Array [0..3] of GLFloat = (0.5, 0.5, 0.5, 1); //���� �������� ����������
  LightColDif : Array [0..3] of GLFloat = (1, 1, 1, 1); //���� �������� ����������
  LightColDif_Alt : Array [0..3] of GLFloat = (0.2, 0.2, 0.2, 1); //���� �������� ����������

  // �������� ��������
  LIGHT_EMMISS_ON: Array [0..3] of GLFloat = (1, 1, 1, 1.0);
  LIGHT_EMMISS_OFF: Array [0..3] of GLFloat = (0, 0, 0, 1.0);
  LIGHT_EMMISS_: Array [0..3] of GLFloat = (0.3, 0.3, 0.3, 1.0);

  // ���� ��������� �������
  LightColA : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0); //�������
  LightColD : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0); //����
  LightColS : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0); //������
  LightTPDN : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0); //�������
  LightPric : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0); //�������
  LightCol_TPN : Array [0..3] of GLFloat = (1, 0.6, 0, 1.0); //�������
  // ���� ��������� ������� ����
  LightCol_PTUR : Array [0..3] of GLFloat = (1, 0.8, 0, 1.0);
  // ����� ����
  PosFaraI : Array [0..3] of GLFloat = (0, 0.1, 0, 1); //��������� ����������
  PosFaraMV : Array [0..3] of GLFloat = (0, 0.1, 0, 1); //��������� ����������
  NaprFaraI : Array [0..2] of GLFloat = (0, 0.001, -2); //�������
  NaprFarMV : Array [0..2] of GLFloat = (0, -0.2, -2); //�������

  mater_diafr:  Array [0..3] of GLFloat = (0, 0, 0, 0); // ���������

  mat_dym:  Array [1..MAX_COL_PODRYV,0..3] of GLFloat = ((1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),
  (1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),
  (1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0),(1, 1, 1, 0));
  mat_zav:  Array [1..3,1..8,0..3] of GLFloat =((( 1, 1, 1, 1),(1, 1, 1, 1),
  (1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1)),
  ((1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1),
  (1, 1, 1, 1),(1, 1, 1, 1)),
  ((1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1), (1, 1, 1, 1),(1, 1, 1, 1),
  (1, 1, 1, 1),(1, 1, 1, 1),(1, 1, 1, 1)));
  X_TRACK=370;//********
  Y_TRACK=420;

var
  Quadric : GLUquadricObj;
  Mestniks : array  of TList;
  TypesOfOrient, DinamicObj : TList;
  // ��������� � ����������� �������� ���������
  LightPos : Array [0..3] of GLfloat;
  L_Naprav : Array [0..2] of GLfloat;
  //����� ����� �� ������� ���������, ���� ��������,
  //������ ������(0- ���������� ������ � �������)
  Patch_Draw: array of array of array of word;
  Orient_Koord: array of array of array of real; //������ ��������� �����.�����.
  Orient_Type:  array of array of word; ////������ ����� �����.�����.
  Orient_Col: array of word; //���������� �����.�����. �� �����
  //������ �������� ������ Y
  coy : array of array of array of GLfloat;
  // ������ �������� ���������
  Kren_mestn, Um_mestn:  array of array of array of GLfloat;
  //������ ������ �� ���. ������ �����
  coydop : array of array of Pdopy;
  //������ ���������� ���������� ������ �������,
  // � ���������� ������� �������([3][4][5])
  vert : array[0..X_COL_TRIANGL, 0..Y_COL_TRIANGL,0..5] of GLfloat;
  xnm,ynm,znm: array[1..3] of real;//��� ���������� ��������
  Xnorm,Ynorm,Znorm: real;
  zap: TZapis;     //��������� � ������� ������������ ���������� ������� �������� CountNorm
  Num_Texture: word;//�������� ������ �������� ��� ��������,������� ����� ����� ������ ��������
  // ������� ����������� � ������
  Dlina_Surf_X,  Dlina_Surf_Y: real;  // ����� ����������� �� � � �� Y
  Dlina_Patch_X,  Dlina_Patch_Y: real;// ����� ����� �� � � �� Y
  Shag_x, Shag_y:real; // ����� ������������� �� X � �� Y
  Col_Patch, Col_Patch_X, Col_Patch_Y: word;// ���������� ������ �� � � �� Y
  // ������� ��� ���������� ��������
  Mont_Spr:array[1..COL_MAX_SPRITE] of TMont_Spr;
  Show_Spr:array[1..COL_MAX_SPRITE] of TShow_Spr;
  Track_Bar: array[1..16] of TBitmap;//������� ��������//********

  Urov_texture,Max_patch_mov: word;
  Vychka_X, Vychka_Y, Vychka_H: real;
  Vsp: TVsp;
  X_Left,X_Right, Y_Top,Y_Bottom: real;// �������������� ����� ��� ��������
  Coord_Obl: array[0..COL_MAX_OBL+1] of TCoord_Obl;
  Obl_Draw: array[0..COL_SECTOR,0..COL_OBL_SECTOR] of word;
  Dym_V_X,Dym_V_Y,Dym_Vtek,intensiv_fog: Real;
  PNV_off: boolean;
  Time_Sinchro: word;
  Start_Open_GL: boolean;
  num_patch_h,index_X,index_Y: word;
  Stolb_left: real;
  stolb_dX1, stolb_dX2: real;
  Stolb_bottom: real;
  isx_pol_po_Y: real;
  inten_fog: GLfloat;
  H_PRICEL: real=0.120;                  //2� /  ������ ����� �������

implementation

function ExtLetter : string;
begin
  if Task.m_index>6000 then begin
    Case Task.Mestn of
      RAVNINA : if Task.Ceson=LETO then ExtLetter:='' else ExtLetter:='w';
      PUSTYN  : ExtLetter:='p';
      GORA    : ExtLetter:='g';
      BOLOTO  : ExtLetter:='b';
    end;
  end;
end;

(************����������� OPEN_GL*********)
procedure Creat_OpenGL;
begin
  Form1.Canvas.Draw(X_TRACK,Y_TRACK,Track_Bar[2]);//********
  DC := GetDC(Form1.Handle);         // �������� ���������� ������
  SetDCPixelFormat;            // ���������� ������ �������
  hrc:=wglCreateContext(DC);   // ������� ��������
  wglMakeCurrent(DC, hrc);     // ������� �������� �������
  Start_Open_GL:=true;
end;

{**************������ ��������******************}
procedure SetDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);
end;

{**************�������� OPEN_GL******************}
procedure Reset_OpenGL;
begin
  Form1.Canvas.Draw(X_TRACK,Y_TRACK,Track_Bar[1]);//********
  if not Start_Open_GL then exit;
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Form1.Handle, DC);
  DeleteDC (DC);
end;

// ���������� ������ ��������� � ��������� �������� �����������
function Count_Tree_patch: boolean;
var a,b,c: word;
S: string;
F: TextFile;
begin
  Dlina_Patch_X:=20;   // ����� ��������� �� �
  Dlina_Patch_Y:=20;   // ����� ��������� �� Y
  Shag_x:=SHAG_X_RAV; // ����� ������������� �� X
  Shag_y:=SHAG_Y_RAV; // ����� ������������� �� Y
  if Task.m_index<5000 then begin
    S:='res\St_Tree_pat.shp';
    Col_Patch_X:=4;
    Col_Patch_Y:=20;
    Col_Patch:=Col_Patch_X*Col_Patch_Y;
    Dlina_Surf_X:=Dlina_Patch_X*Col_Patch_X;
    Dlina_Surf_Y:=Dlina_Patch_Y*Col_Patch_Y;
    Urov_texture:=3;
    X_Left:=5;                   // ����� �������
    X_Right:=Dlina_Surf_X-5;     // ������ �������
    Y_Top:=100;                  // ������� �������
    Y_Bottom:=5;                 // ������� �������
  end
  else begin
    if Task.m_index<6000 then begin      // �������
      S:='res\St_Tree_pat.shp';
      Col_Patch_X:=4;
      Col_Patch_Y:=20;
      Col_Patch:=Col_Patch_X*Col_Patch_Y;
      Dlina_Surf_X:=Dlina_Patch_X*Col_Patch_X;
      Dlina_Surf_Y:=Dlina_Patch_Y*Col_Patch_Y;
      Urov_texture:=3;
      X_Left:=5;                   // ����� �������
      X_Right:=Dlina_Surf_X-5;     // ������ �������
      Y_Top:=100;                  // ������� �������
      Y_Bottom:=5;                 // ������� �������
    end
    else begin
      S:='res\Tr_Tree_pat.shp';
      Col_Patch_X:=10;
      Col_Patch_Y:=10;
      Col_Patch:=Col_Patch_X*Col_Patch_Y;
      Dlina_Surf_X:=Dlina_Patch_X*Col_Patch_X;
      Dlina_Surf_Y:=Dlina_Patch_Y*Col_Patch_Y;
      Urov_texture:=1;
      X_Left:=5;                   // ����� �������
      X_Right:=Dlina_Surf_X-5;     // ������ �������
      Y_Top:=Dlina_Surf_Y-5;       // ������� �������
      Y_Bottom:=5;                 // ������� �������
    end;
  end;
  Count_Tree_patch:=true;
  S:=dir+S;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    Count_Tree_patch:=false;
    exit;
  end;
  AssignFile(F,S);
  Reset(F); //�������� �����
  Readln(F,Max_patch_mov);
  Readln(F,a);
  Readln(F,a);
  SetLength(Patch_Draw, (Max_patch_mov+2),(COL_SECTOR+1),(Col_Patch+1));
  for a:=1 to Max_patch_mov do begin
    for b:=1 to COL_SECTOR do begin
      Read(F,Patch_Draw[a,b,0]);
      for c:=1 to Patch_Draw[a,b,0] do begin
        Read(F,Patch_Draw[a,b,c]);
      end;
    end;
  end;
  if not EOF(f) then begin
    Read(F,a);
    Patch_Draw[Max_patch_mov+1,0,0]:=a;
    for a:=1 to Patch_Draw[Max_patch_mov+1,0,0] do begin
      Read(F,Patch_Draw[Max_patch_mov+1,0,a]);
    end;
  end;
  CloseFile(F);
  Init_arrays;                 // ������������� �������� ��� �����.�����. � ����� �����
end;

{***********������������� �������� ��� �����.�����. � ����� ����� **********}
procedure Init_arrays;
var a: word;
begin
  SetLength(Orient_Koord, (Col_Patch+1)*Urov_texture,(X_COL_TRIANGL*Y_COL_TRIANGL+2),3);
  SetLength(Orient_Type, (Col_Patch+1)*Urov_texture,(X_COL_TRIANGL*Y_COL_TRIANGL));
  SetLength(Orient_Col, (Col_Patch+1)*Urov_texture);
  SetLength(Mestniks, Col_Patch+1);
  SetLength(coy, (Col_Patch+2),(X_COL_TRIANGL+2), (Y_COL_TRIANGL+2));
  SetLength(Kren_mestn, (Col_Patch+2),(X_COL_TRIANGL+2), (Y_COL_TRIANGL+2));
  SetLength(Um_mestn, (Col_Patch+2),(X_COL_TRIANGL+2), (Y_COL_TRIANGL+2));
  SetLength(coydop,(Col_Patch_X+1)*(X_COL_TRIANGL+1),(COL_PATCH_Y+1)*(Y_COL_TRIANGL+1));
  // �������� ������ ������� ��������
  if TypesOfOrient<>nil then TypesOfOrient.Free;
  TypesOfOrient:=TList.Create;
  for a:=1 to Col_Patch do  begin
    if Mestniks[a]<>nil then Mestniks[a].Free;
    Mestniks[a]:=TList.Create;
  end;
  if DinamicObj<>nil then DinamicObj.Free;
  DinamicObj:=TList.Create;

  for a:=1 to COL_MAX_OBJEKT_TAK_TEX do AddDinamic(TANK_KORPUS,-5000,-5000,0);
end;

{************ ������������� OPEN_GL *************}
procedure Init_OpenGL;
const
  LightFara : Array [0..3] of GLFloat = (0.2, 0.4, 0.2, 1); //���� ����
begin
  Form1.Canvas.Draw(X_TRACK,Y_TRACK,Track_Bar[3]);//********
  Quadric := gluNewQuadric;
  gluQuadricTexture (Quadric, TRUE);
  // �������� 3D �������
  Build_3d;
  // ���� ��������� � ����
  Osveshenie(false,false);
  Form1.Canvas.Draw(X_TRACK,Y_TRACK,Track_Bar[16]);//********
end;

procedure Build_3d;
const
  mat_obl : Array [0..3] of GLFloat = (1,1,1,0.41); //
begin
  Isx_Pol_Oborud;
  Build_Scene;
  Build_Surface;                           // �������� �����������
  // ��������� ���������� ��� �������� ����
  Build_Target;
  // ������� ��������
  Count_Scene;
  // ���������, ������������ ������������� �������
  Build_Orientir;
  Count_orientir;
  // �������
//  Build_Leo;
  Build_T55;
  Build_Apach;
  Build_M113;
  Build_BMP1;
  Build_BMP2;
  Build_T80;
  Build_Parade;

end;

(***************������ � �������� �����������********************)
procedure Build_Surface;
var s : string;
begin
  // ������� ���� ��� ����� �������
  if Task.m_index<5000 then begin
    if Task.Ceson=LETO  then begin
      case Task.mestn of
        RAVNINA:ReadPatch('res\St_leto\St_leto');
        GORA:    ReadPatch('res\St_gora\St_gora');
        BOLOTO: ReadPatch('res\St_bolot\St_bolot');
        PUSTYN:  ReadPatch('res\St_pust\st_pust');
      end;
    end
    else begin
      case Task.mestn of
        RAVNINA:ReadPatch('res\St_Zima\St_Zima');
        GORA:    ReadPatch('res\St_gor_z\St_gor_z');
        BOLOTO: ReadPatch('res\St_Zima\St_Zima');
        PUSTYN:  ReadPatch('res\St_pust\st_pust');
      end;
    end;
  end
  else begin
    // ����������� ����
    if Task.m_index<6000 then begin
      if Task.Ceson=LETO  then begin
        case Task.mestn of
          RAVNINA:ReadPatch('res\St_Leto\St_leto');
          GORA:    ReadPatch('res\St_gora\St_gora');
          BOLOTO: ReadPatch('res\St_bolot\St_bolot');
          PUSTYN:  ReadPatch('res\St_pust\st_pust');
        end;
      end
      else begin
        case Task.mestn of
          RAVNINA:ReadPatch('res\St_Zima\St_Zima');
          GORA:    ReadPatch('res\St_gor_z\St_gor_z');
          BOLOTO: ReadPatch('res\St_Zima\St_Zima');
          PUSTYN:  ReadPatch('res\St_pust\st_pust');
        end;
      end;
    end
    else begin
      // ���� ��� ��������
      case Task.m_index of
      6101: s:='pu1\';
      6102: s:='pu2\';
      6103: s:='pu3\';
      6104: s:='pu4\';
      6201: s:='uu1a\';
      6202: s:='uu1b\';
      6203: s:='uu2a\';
      6301: s:='zu\';
      6401: s:='ku1\';
      6402: s:='ku2\';
      6901: s:='Izol\';
      else s:='Tr_leto'
      end;
      if ((Task.m_index=6201) or (Task.m_index=6203) or (Task.m_index=6301) or (Task.m_index=6401) or (Task.m_index=6402)) then Task.mestn:=RAVNINA;
      if Task.m_index=6202 then Task.mestn:=GORA;
      if (((Task.mestn=GORA) or (Task.mestn=BOLOTO)) and ((Task.m_index=6101) or (Task.m_index=6103) or (Task.m_index=6104))) then
      begin
       Task.m_index:=6102;
       if Task.mestn=GORA then Task.Ceson:=LETO;
      end;
      if Task.Ceson=LETO  then begin
        case Task.mestn of
          RAVNINA:ReadPatch('res\Tr_leto\'+s);
          GORA:    ReadPatch('res\Tr_gora\'+s);
          BOLOTO: ReadPatch('res\Tr_bolot\'+s);
          PUSTYN:  ReadPatch('res\tr_pust\'+s);
        end;
      end
      else begin
        case Task.mestn of
          RAVNINA:ReadPatch('res\Tr_Zima\'+s);
          GORA:    ReadPatch('res\Tr_gor_z\'+s);
          BOLOTO: ReadPatch('res\Tr_Zima\'+s);
          PUSTYN:  ReadPatch('res\tr_pust\'+s);
        end;
      end;
    end;
  end;
end;

procedure ReadPatch(s: string);
var a,b,c,t:word;
  r: real;
  f_orn,f_pole,f_dop,temp: TextFile;
  b1,b2,i,j,a1,a2,i1,j1,p : integer;
  b3,b4,b5,b6 : glFloat;
  wc : Char;
  x,y,hbase: real;
  s1: string;
  X_col: word;      // ���������� ������������� �� �
  Y_col: word;      // ���������� ������������� �� Y
  flo: GLfloat;//������������� ��������, ����������� ����������
  net : byte;
  Perim_point : PKoord;
  hDelta : real;
begin
  S:=dir+S;
  // C������� ������������ � �������� ����� �����
  t:=Col_Patch_Y div 10;
  r:=3+1/t;
  for a:=1 to Col_Patch_Y do begin
    Form1.Canvas.Draw(X_TRACK,Y_TRACK,Track_Bar[round(r)]);//********
    r:=r+1/t;
    for b:=1 to Col_Patch_X do begin
      c:=b+(a-1)*Col_Patch_X;
      x:=Dlina_Patch_X/2+Dlina_Patch_X*((b-1) mod Col_Patch_X);
      y:=-Dlina_Patch_Y/2-Dlina_Patch_Y*(a-1);
      /// 1 �������
      s1:=S+inttostr(c)+'.shp';
      glNewList (SURFACE_BAZA+c, GL_COMPILE);
        glPushMatrix;
          glTranslatef(x, 0, y);
          // C������� ����� � ����� ����� ��� ����
          DrawStripSurf(s1,c,0);
        glPopMatrix;
        // ���������� ��������� �� ����� res\Leto\letolittle.shp
        if FileExists(s+'little.shp') then begin
          AssignFile(f_orn,s+'little.shp');
          Reset(f_orn);
          readln(f_orn);
          while not EOF(f_orn) do begin
            read(f_orn,b1);
            if b1=c then begin
              read(f_orn,b2);
              read(f_orn,b3);
              read(f_orn,b4);
              read(f_orn,b5);
              readln(f_orn,b6);
              AddMestnik(b2,c,b3,b4,b5,b6,1);//***
            end
            else readln(f_orn);
          end;
          Close(f_orn);
        end;
      glEndList;
      // 2 �������
      if Urov_texture>1 then begin
        c:=c+COL_PATCH;
        s1:=S+inttostr(c)+'.shp';
        glNewList (SURFACE_BAZA+c, GL_COMPILE);
          glPushMatrix;
            glTranslatef(x, 0, y);
            DrawStripSurf(s1,c,0);
          glPopMatrix;
        glEndList;    //***
      end;
      // 3 �������
      if Urov_texture>2 then begin
        c:=c+COL_PATCH;
        s1:=S+inttostr(c)+'.shp';
        glNewList (SURFACE_BAZA+c, GL_COMPILE);
          glPushMatrix;
            glTranslatef(x, 0, y);
            DrawStripSurf(s1,c,0);
          glPopMatrix;
        glEndList;         //***
      end;
    end;
  end;
end;

procedure AddMestnik(Num,Patch : integer; x,y,h,a,Sc : real);
var p,pp : PMestnik;
    i : integer;
    c,d : PKoord;
    cosa,sina,xx,yy : real;
begin
  if TypesOfOrient.Count>0 then begin
    cosa:=cos(Pi*a/180);
    sina:=sin(Pi*a/180);
    i:=-1;
    repeat
      Inc(i);
      pp:=TypesOfOrient.Items[i];
    until((i=TypesOfOrient.Count-1) or (pp^.Num=Num));
    if pp^.Num=Num then begin
      New(p);
      p^.Num:=Num;
      p^.Patch:=Patch;
      p^.X:=x;
      p^.Y:=y;
      p^.H:=h;
      p^.A:=a;
      p^.Sc:=Sc;
      p^.Az_Paden:=-1;
      p^.Type_Objekt:=pp^.Type_Objekt;
      p^.Type_Action:=pp^.Type_Action;
      p^.Col_Points_Objekt:=pp^.Col_Points_Objekt;
      p^.Curver:=TList.Create;
      if p^.Type_Objekt>2 then begin
        for i:=0 to p^.Col_Points_Objekt-1 do  begin
          New(c);
          d:=pp^.Curver[i];
          xx:=d.X*cosa+d.Y*sina;
          yy:=d.Y*cosa-d.X*sina;
          c^.X:=x+xx;
          c^.Y:=y-yy;
          p^.Curver.Add(c);
        end;
      end
      else  begin
        New(c);
        d:=pp^.Curver[0];
        xx:=d.X*cosa+d.Y*sina;
        yy:=d.Y*cosa-d.X*sina;
        c^.X:=x+xx;
        c^.Y:=y-yy;
        p^.Curver.Add(c);
        if p^.Type_Objekt=2 then   begin
          New(c);
          d:=pp^.Curver[1];
          c^.X:=d.X;
          c^.Y:=d.Y;
          p^.Curver.Add(c);
        end;
      end;
      Mestniks[Patch].Add(p);
    end;
  end;
end;



function Count_dX(n: integer): integer;
begin
  result:=0;
  if (Task.m_index>1300)and(Task.m_index<1400)then begin
    result:=round((stolb_dX1+stolb_left) / DDD)
  end
  else begin
    case n of
      1: result:=round(stolb_left / DDD);
      2: result:=round((stolb_dX1+stolb_left) / DDD);
      3: result:=round((stolb_dX1+stolb_DX2+stolb_left)/ DDD);
    end;
  end;
end;

{***********�������� ��������***************}
procedure PrepareImage(bmap: string;contur: integer);
type
  PPixelArray = ^TPixelArray;
  TPixelArray = array [0..0] of Byte;
var
  Bitmap, Bitmap_Mask : TBitmap;
  Data,DataA,DataM  : PPixelArray;
  BMInfo : TBitmapInfo;
  Temp : Byte;
  MemDC : HDC;
  I, ImageSize : longint;
  S: string;
begin
  exit;
  if (Num_Texture>0) then begin // ���� ����� ���� ������ ��������
    S:='bmp\'+(copy(bmap,1,Pos('.',bmap)-1))+inttostr(Num_Texture)+'.bmp';
  end
  else begin
    S:='bmp\'+bmap;
  end;
  S:=dir+S;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  Bitmap := TBitmap.Create;
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
    GetMem (Data, (ImageSize+2) * 3);
    GetMem (DataA, (ImageSize+2) * 4);
    try
      GetDIBits(MemDC,Bitmap.Handle,0,biHeight,Data,BMInfo,DIB_RGB_COLORS);
      if (contur=6)or(contur=7)  then begin
        Bitmap_Mask := TBitmap.Create;
        S:=(copy(bmap,1,Pos('.',bmap)-1));
        S:='bmp\'+S+'M'+'.bmp';
        S:=dir+S;
        if not FileExists(s) then begin
          MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
          exit;
        end;
        Bitmap_Mask.LoadFromFile (S);
        GetMem (DataM, (ImageSize+1) * 3);
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
        case  contur of
          1,10: begin
            DataA [I * 4 + 3] := 255;
          end;
          2: begin  // ��� ������ (�������)
            if (Data[I*3+2]<80)and(Data[I*3+1]<80)and(Data[I*3]>100)then begin
              DataA [I * 4 + 3] := 0;      // ���������� �������-������ �����
              DataA [I * 4 + 2] := 70;
              DataA [I * 4 + 1] := 70;
              DataA [I * 4 ] := 70;
             end
             else DataA[I*4+3]:=255;
          end;
        3: begin
             DataA [I * 4 + 3] := DataA [I * 4];   ///������������ ��������������� ������� ������������
             DataA [I * 4 + 2]:=255;  // ��� ������
             DataA [I * 4 + 1]:=255;  //���� ���� �������� - �����
             DataA [I * 4 ]:=255;
           end;
        4: begin   // ��� �������
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
        6: begin  // ��� �����
             if (DataM [I*3] < 100) then DataA [I * 4 + 3] := 0
                                    else DataA [I * 4 + 3] := 255;
           end;
        7: begin  // ��� �����- ������������ �������. ������� �������.
             DataA [I * 4 + 3] :=DataM [I*3];
           end;
        8: begin  // �� ������ ����
             DataA[I*4+3]:=Data[I*3];
           end;
        end;
      end;
      glTexImage2d(GL_TEXTURE_2D, 0, 4, biWidth,
                   biHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, DataA);
    finally
      if (contur=6)or(contur=7) then FreeMem (DataM);
      FreeMem (DataA);
      FreeMem (Data);
      DeleteDC (MemDC);
      if (contur=6)or(contur=7) then Bitmap_Mask.Free;
      Bitmap.Free;
    end;
  end;
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

procedure MontObject(FileName: string; Num: integer);
const
  mat: array[0..3] of glfloat= (0.7, 0.7, 0.7, 1);
var a,b,c,d: integer;
  xv,yv,zv: real;
  x,y,z,xt,yt: array[1..3] of real;
  F: TextFile;
  S, s1: String;
  POrient : PMestnik;
  Corner  : PKoord;
  File_Name_Old: string; // ����� ���������� �������� �� ��������� ��������� ���
  Contur_Old: word;
begin
  File_Name_Old:='';
  Contur_Old:=0;
  S:=FileName;
  S:=dir+S;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
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
      if (xv<>1) or (yv<>1) or (zv<>1) then glScale(xv,yv,zv);
      ReadLn(F, S);     //��� ��������
      ReadLn(F, S);
      S1:=S;
      ReadLn(F, S);     //�������� �������� ��� ������ ���������
      S:=copy(S,1,1);
      c:=0;
      if (s='2')or(s='3')or(s='4')or(s='5')or(s='6')or(s='7')or(s='8')or (s='10')then val(s,d,c)
                                                             else d:=1;
        // ���� ���� ����� �� �� ���, �� ��� �� ���������
      if (File_Name_Old<>S1) or (Contur_Old<>d) then PrepareImage (S1,d);;
      File_Name_Old:=S1;
      Contur_Old:=d;
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
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=0.2;
        mat[1]:=0.2;
        mat[2]:=0.2;
        mat[3]:=1;
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
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
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=0.12;
        mat[1]:=0.12;
        mat[2]:=0.12;
        mat[3]:=1;
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
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
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      end
      else begin
        ReadLn(F, S);
        ReadLn(F, S);
        ReadLn(F, S);
        mat[0]:=1;
        mat[1]:=1;
        mat[2]:=1;
        mat[3]:=1;
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      end;

      ReadLn(F, S);           //��� ���������
      ReadLn(F, S);
      c:=strtoint(S);
      case c of
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
                if a=3 then begin  // ��� 1-�� ������������ ������� ���������
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
        10: begin                   // ���
          ReadLn(F, S);  //���������� ������
          ReadLn(F, S);
          x[1]:=strtofloat(S);
          ReadLn(F, S);  //������� ������
          ReadLn(F, S);
          y[1]:=strtofloat(S);
          glutSolidTorus(x[1],y[1],12,12);
        end;
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

procedure Build_Pyl;
var x,y,z: real;
begin
  x:=0.3;
  y:=0.3;
  z:=0.3;
  glNewList (SPRITE_PYL, GL_COMPILE);
    prepareImage ('Sprite\Pyl\pyl1.bmp',3);
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

procedure Build_vzryv;
const mat_d : Array [0..3] of GLFloat = (1,1,1,1); //
var x,z: real;
begin
  z:=0.035;
  x:=0.09;
  glNewList (DYM_2, GL_COMPILE);                       // �������� ���� ��� ������
    prepareImage ('Vzryv\Vzryv2.bmp',6);
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
    x:=0.015;
    z:=0.04;
    glNewList (VSPYSH, GL_COMPILE); // �����
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
       glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
       glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);
       glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
       prepareImage ('Vzryv\Ogon_1.bmp',2);
       glBegin(GL_QUADS);            //��������������
        glTexCoord2f(0,0);
        glVertex3f(-x, 0, 0);
        glTexCoord2f(1,0);
        glVertex3f(x, 0, 0);
        glTexCoord2f(1,1);
        glVertex3f(x, z, 0);
        glTexCoord2f(0,1);
        glVertex3f(-x, z, 0);
       glEnd;
       glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
   MontObject('res/Vzryv/Zavesa.shp',ZAVESA);
end;

procedure Build_Nebo;
var a: word;
begin
  MontObject('res/Nebo/Nebo.shp',NEBO);
  // �������� �������
  for a:=1 to KOL_TYPE_OBLAKO do begin
    MontObject('res/Oblaka/Oblako'+inttostr(a)+'.shp',OBLAKO+a);
  end;
  Count_Nebo;
end;

procedure Count_Nebo;
var a: word;
az, d: real;
begin
  // ����������� ������� �� ����
  RandSeed:=Task.NumKvit;// ����� ������� ��� ������ ��������
//  RandSeed:=3;// ����� ������� ��� ������ ��������
  for a:=1 to COL_MAX_OBL do begin
    if (Task.Mestn=GORA) and (Task.m_index>6000) then begin  
      if a<(COL_MAX_OBL-100) then begin
        Coord_Obl[a].X:=random(GRANICA_OBL )-GRANICA_OBL/2;
        Coord_Obl[a].Y:=random(GRANICA_OBL )-GRANICA_OBL/2;
        Coord_Obl[a].H:=random(30)+120;
      end
      else begin
        Coord_Obl[a].X:=GRANICA_OBL;
        Coord_Obl[a].Y:=GRANICA_OBL;
        Coord_Obl[a].H:=0;
      end;
    end
    else begin
      Coord_Obl[a].X:=random(GRANICA_OBL*2)-GRANICA_OBL;
      Coord_Obl[a].Y:=random(GRANICA_OBL*2)-GRANICA_OBL;
      Coord_Obl[a].H:=random(30)+80;
    end;
    Coord_Obl[a].Typ:=random(KOL_TYPE_OBLAKO)+1;
    Coord_Obl[a].X:=Coord_Obl[a].X+Dym_V_X*Model[1].Other;
    Coord_Obl[a].Y:=Coord_Obl[a].Y+Dym_V_Y*Model[1].Other;
  end;
//  Time_Sinchro:=Model[1].Other;
  // ������������� ������� �� �������� ���������
//  Obl_Draw: array[0..COL_SECTOR,0..COL_OBL_SECTOR] of word;
end;

//������� ������� �������, ������������ �������� ����������� ��������
function CountNorm(x1,y1,z1,x2,y2,z2,x3,y3,z3:real): TZapis;
var
  vx1,vx2,vy1,vy2,vz1,vz2,nx,ny,nz,wrki,xmy,ymy,zmy:glfloat;
begin
  vx1:=x1-x2;
  vy1:=y1-y2;
  vz1:=z1-z2;
  vx2:=x2-x3;
  vy2:=y2-y3;
  vz2:=z2-z3;
  nx:=vy1*vz2-vz1*vy2;
  ny:=vz1*vx2-vx1*vz2;
  nz:=vx1*vy2-vy1*vx2;
  wrki:=sqrt(nx*nx+ny*ny+nz*nz);
  If wrki = 0 then wrki :=1;
  xmy:=nx/wrki;
  ymy:=ny/wrki;
  zmy:=nz/wrki;
  countnorm.xnorm:=xmy;
  countnorm.ynorm:=ymy;
  countnorm.znorm:=zmy;
end;


// ���������� ����  ��� �������� ����������� ������ �������
procedure Build_Table;
var dX,dY: integer;// ���������� �����
n,b: word;
F: TextFile;
S: String;
begin
  S:='res/Table/Table.shp';// ��������� ����� � ���� �����
  S:=dir+S;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    Form1.Close;
  end;
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  // ����������� � ���������� ����
  Task.Col_targ:=8;
  glDeleteLists(MIN_NUM_TARGET,Task.Col_targ);
  glDeleteLists(MIN_NUM_TARGET+10,Task.Col_targ);
  // ��������� ������
  MontObject('res/Table/Vyverka.shp',MIN_NUM_TARGET+11);
  MontObject('res/Table/Table1.shp',MIN_NUM_TARGET+12);
  MontObject('res/Table/Table2.shp',MIN_NUM_TARGET+13);
  MontObject('res/Table/Table3.shp',MIN_NUM_TARGET+14);
  MontObject('res/Table/Table4.shp',MIN_NUM_TARGET+15);
  MontObject('res/Table/Table5.shp',MIN_NUM_TARGET+16);
  MontObject('res/Table/Znak.shp',MIN_NUM_TARGET+17);
  MontObject('res/Table/Znak.shp',MIN_NUM_TARGET+18);
  // ������ ��� ���������� �����
  b:=1;
  glNewList(MIN_NUM_TARGET+b, GL_COMPILE);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
    glRotatef (10, 0.0, 1.0, 0.0);
    glCallList(MIN_NUM_TARGET+b+10);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
  glEndList;
  for b:=2 to Task.Col_targ do begin
    glNewList(MIN_NUM_TARGET+b, GL_COMPILE);
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
      glCallList(MIN_NUM_TARGET+b+10);
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEndList;
  end;
  b:=1;
  for b:=2 to Task.Col_targ do begin
    ReadLn(F, S);
    dX:=strtoint(copy(S,1,Pos(' ',s)-1));
    ReadLn(F, S);
    dY:=strtoint(copy(S,1,Pos(' ',s)-1));
    for n:=1 to 3 do begin
      Angle_Paden[n,b]:=360;
      TargetR[b].Xtek[n][0]:=dX+Count_dX(n);
      TargetR[b].Xtek[n][0]:=TargetR[b].Xtek[n][0]*DDD/MASHT_RIS;
      TargetR[b].Ytek[n][0]:=dY+(Stolb_bottom+STOLB_DY_R)/DDD;
      TargetR[b].Ytek[n][0]:=TargetR[b].Ytek[n][0]*DDD/MASHT_RIS;
      TargetR[b].Htek[n][0]:=CountVertexYTri(TargetR[b].Xtek[n][0], TargetR[b].Ytek[n][0]);
    end;
  end;
  CloseFile(F);
end;

//===========================���������==============================

{procedure Build_Leo;
begin
  // ���� ����������//---
  MontObject('res/Leopard/Leo_baza.shp',LEO_KORPUS);
  MontObject('res/Leopard/Leo_Bash.shp',LEO_BASHNA);
  MontObject('res/Leopard/Leo_Stv.shp',LEO_STVOL);
  MontObject('res/Leopard/Leo_Dv1.shp',LEO_BAZA1);
  MontObject('res/Leopard/Leo_Dv2.shp',LEO_BAZA2);
end;}

procedure Build_T55;
begin
  // ���� ����������//---
  MontObject('res/T-55/T-55basa.shp',LEO_KORPUS);
  MontObject('res/T-55/T-55Bash.shp',LEO_BASHNA);
  MontObject('res/T-55/T-55Stv.shp',LEO_STVOL);
  MontObject('res/T-55/T-55Dv1.shp',LEO_BAZA1);
  MontObject('res/T-55/T-55Dv2.shp',LEO_BAZA2);
end;

procedure Build_Apach;
begin
  // �������
  MontObject('res/Apach/Apach.shp',APACH_KORP);
  MontObject('res/Apach/Ap_Stab.shp',APACH_STAB);
  MontObject('res/Apach/Ap_Vint.shp',APACH_VINT);
end;

procedure Build_M113;
var a: word;
begin
  // M113
  MontObject('res/M-113/Baza.shp',M113_KORPUS);
  MontObject('res/M-113/Pulem.shp',M113_STVOL);
  MontObject('res/M-113/Dv1.shp',M113_BAZA1);
  MontObject('res/M-113/Dv2.shp',M113_BAZA2);
end;

procedure Build_BMP1;
var a: word;
begin
    // ���-1
    MontObject('res/BMP_1/BMP_1.shp',BMP1_KORPUS);
    MontObject('res/BMP_1/BMP_Bash.shp',BMP1_BASHNA);
    MontObject('res/BMP_1/BMP_Stv.shp',BMP1_STVOL);
    MontObject('res/BMP_1/BMP_kole.shp',BMP1_KOLESO);
    MontObject('res/BMP_1/BMP_vene.shp',BMP1_VENEZ);
    MontObject('res/BMP_1/BMP_napr.shp',BMP1_NAPR);
    MontObject('res/BMP_1/BMP_gus.shp',BMP1_GUSEN);
    MontObject('res/BMP_1/BMP_konk.shp',BMP1_KONKURS);
    MontObject('res/BMP_1/BMP_Rock.shp',ROCKET);
    glNewList (BMP1_BAZA1, GL_COMPILE);
      glPushMatrix;
        glTranslatef(-0.13,-0.17,0.1497);
        glScale(1,1,-1);
         for a:= 1 to 6 do begin
          glCallList(BMP1_KOLESO);
          glTranslatef(0.09,0.0,0.0);
        end;
      glPopMatrix;
      glPushMatrix;
        glTranslatef(-0.13,-0.17,-0.275);
        for a:= 1 to 6 do begin
          glCallList(BMP1_KOLESO);
          glTranslatef(0.09,0.0,0.0);
        end;
      glPopMatrix;
      glPushMatrix;
        glTranslatef(0.38,-0.122,0.1257);
        glCallList(BMP1_NAPR);
        glTranslatef(0.0,0.0,-0.4);
        glCallList(BMP1_NAPR);
      glPopMatrix;
      glPushMatrix;
        glTranslatef(-0.214,-0.124,0.1257);
        glCallList(BMP1_VENEZ);
        glTranslatef(0.0,0.0,-0.4);
        glCallList(BMP1_VENEZ);
      glPopMatrix;
      glCallList(BMP1_GUSEN);
    glEndList;

    glNewList (BMP1_BAZA2, GL_COMPILE);
      glPushMatrix;
        glTranslatef(-0.13,-0.17,0.1497);
        glScale(1,1,-1);
        for a:= 1 to 6 do begin
          glPushMatrix;
          glRotatef (36, 0.0, 0, 1.0);
          glCallList(BMP1_KOLESO);
          glPopMatrix;
          glTranslatef(0.09,0.0,0.0);
        end;
      glPopMatrix;
      glPushMatrix;
        glTranslatef(-0.13,-0.17,-0.275);
        for a:= 1 to 6 do begin
          glPushMatrix;
          glRotatef (36, 0.0, 0, 1.0);
          glCallList(BMP1_KOLESO);
          glPopMatrix;
          glTranslatef(0.09,0.0,0.0);
        end;
      glPopMatrix;
      glPushMatrix;
        glTranslatef(0.38,-0.122,0.1257);
        glRotatef (36, 0.0, 0, 1.0);
        glCallList(BMP1_NAPR);
        glTranslatef(0.0,0.0,-0.4);
        glCallList(BMP1_NAPR);
      glPopMatrix;
      glPushMatrix;
        glTranslatef(-0.214,-0.124,0.1257);
        glRotatef (36, 0.0, 0, 1.0);
        glCallList(BMP1_VENEZ);
        glTranslatef(0.0,0.0,-0.4);
        glCallList(BMP1_VENEZ);
      glPopMatrix;
      glCallList(BMP1_GUSEN);
    glEndList;
end;

procedure Build_BMP2;
var a: word;
begin
  MontObject('res/BMP_2/bm2_basa.shp',BMP2_KORPUS);
  MontObject('res/BMP_2/bm2_stv.shp',BMP2_STVOL);
  MontObject('res/BMP_2/bm2_bash.shp',BMP2_BASHNA);
  MontObject('res/BMP_2/bm2_dv1.shp',BMP2_BAZA1);
  MontObject('res/BMP_2/bm2_dv2.shp',BMP2_BAZA2);
end;

procedure Build_T80;
begin
  // ���� �-72
  MontObject('res/T-80/T-80bas.shp',TANK_KORPUS);
  MontObject('res/T-80/T-80Bash.shp',TANK_BASHNA);
  MontObject('res/T-80/T-80Dvig.shp',TANK_BAZA1);
  MontObject('res/T-80/T-80Dvig2.shp',TANK_BAZA2);
  MontObject('res/T-80/T-80Stv.shp',TANK_STVOL);
//MontObject('res/T-80/T-80Gab1.shp',TANK_GABAR_ALL);
//  MontObject('res/T-72v2/T_72Gab2.shp',TANK_GABAR_ARIER);
//  MontObject('res/T-72v2/T_72Far.shp',TANK_FARA);
//  MontObject('res/T-72v2/Katok_R1.shp',TANK_KATOK_R1);
//  MontObject('res/T-72v2/Katok_R2.shp',TANK_KATOK_R2);
//  MontObject('res/T-72v2/Katok_L1.shp',TANK_KATOK_L1);
//  MontObject('res/T-72v2/Katok_L2.shp',TANK_KATOK_L2);
//  MontObject('res/T-72v2/T_72basat.shp',TANK_KORPUS_TEN);
//  MontObject('res/T-72v2/T_72Basht.shp',TANK_BASHNA_TEN);
//MontObject('res/T-80/T-80Stvt.shp',TANK_STVOL_TEN);
end;

procedure Build_Fire;
const  mat: array [0..3] of GLFloat = (1, 1, 1, 0.5);
var a: word;
x,y,z: real;
begin
  glNewList (PATR_PKT, GL_COMPILE);                       // ������� ���
    prepareImage ('patron\PATR_PKT.bmp',1);
    glPointSize(2);
    glBegin(GL_Points);
      glTexCoord2f(0.5, 0.5);
      glVertex3f(0, 0, 0);
    glEnd;
  glEndList;
  glNewList (PATR_PUSHKA, GL_COMPILE);                       // ������� A_42
    prepareImage ('patron\Patr_KPV.bmp',1);
    gluDisk(Quadric, 0, 0.0004,6,5);
  glEndList;
  glNewList (PATR_PTUR, GL_COMPILE);                       // ������� ����
    prepareImage ('patron\PatrPTUR.bmp',1);
    gluDisk(Quadric, 0, 0.0004,12,5);
  glEndList;
  glNewList (PATR_PTUR2, GL_COMPILE);                       // ������� ����
    prepareImage ('patron\PatrPTUR2.bmp',1);
    gluDisk(Quadric, 0, 0.0004,12,5);
  glEndList;
  glNewList (PATR_PTUR3, GL_COMPILE);                       // ������� ����
    prepareImage ('patron\PatrPTUR3.bmp',1);
    gluDisk(Quadric, 0, 0.0004,12,5);
  glEndList;
    if Task.Temp=NUIT then begin
    glNewList (FONAR_JM, GL_COMPILE);
       glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
       prepareImage ('patron\PATR_PKT.bmp',1);
       gluDisk(Quadric, 0, 0.015,12,5);                    //������� ������
       glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEndList;
    glNewList(ZVEZDA, GL_COMPILE);                       //
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);
      for a:=1 to 30 do begin
        glPushMatrix;
          x:=-50+random(200);//
          y:=4+random(100)*0.4;
          z:=100+random(100);//
          glTranslatef(x, y, -z);
          glScale(5,5,1);
          glCallList(FONAR_WM);
        glPopMatrix;  //
      end;
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEndList;
  end;
  for a:=1 to 12 do begin
    glNewList (FIRE+a, GL_COMPILE);
      z:=0.23;
      y:=0;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      prepareImage ('Fire\Fire'+inttostr(a)+'.bmp',8);
      glBegin(GL_QUADS);
        glTexCoord2f(0.0, 0.0);
        glVertex3f(-z, y, 0);
        glTexCoord2f( 0.0, 1.0);
        glVertex3f(-z, y+z/1.2, 0);
        glTexCoord2f(1.0, 1.0);
        glVertex3f(z, y+z/1.2, 0);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(z, y, 0);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
  for a:=1 to 13 do begin
    glNewList (SPRITE_VSP+a, GL_COMPILE);
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
      prepareImage ('Sprite\Vsp2\Vsp'+inttostr(a)+'.bmp',8);
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
  glNewList (MERA, GL_COMPILE);
    prepareImage ('common_BMP\green.bmp',1);
    z:=0.65;
    y:=-15;
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
  glEndList;

end;

// �������
procedure Build_Sprite;
begin
  Load_Sprite(6,'Vsp6.spr');
end;

function Load_Sprite(num: word; name: string): boolean;
var
S: string;
F: TextFile;
a: word;
r: real;
begin
  S:=dir+'res\sprite\'+name;
  Load_Sprite:=true;
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);//Dialogs
    Load_Sprite:=false;
    exit;
  end;
  AssignFile(F,S);
  Reset(F); //�������� �����
  Readln(F,Mont_Spr[num].Name);//��������
  Readln(F,Mont_Spr[num].Col_Ris);//���������� ������. �������
  Readln(F,Mont_Spr[num].Base_Name_Ris);//������� ��� ��������
  Readln(F,Mont_Spr[num].Contur);//������ ��������� ��������
  Readln(F,Mont_Spr[num].Col_Kadr);//������c��� ������
  CloseFile(F);

  Mont_Spr[num].Index:=num;
//   Line_Kadr: array[1..100] of word;// ������� ������
//   Repet: boolean;      // ������� ����������
  Show_Spr[num].Pos_end:=Mont_Spr[num].Col_Ris;

  r:=0.9;
  for a:=1 to Mont_Spr[num].Col_Ris do begin
    glNewList (SPRITE+Mont_Spr[num].Index+a, GL_COMPILE);
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      prepareImage ('sprite\'+Mont_Spr[num].Base_Name_Ris+inttostr(a)+'.bmp',Mont_Spr[num].Contur);
      glBegin(GL_QUADS);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(-r, -r, 0);
        glTexCoord2f( 1.0, 1.0);
        glVertex3f(-r, r, 0);
        glTexCoord2f(0.0, 1.0);
        glVertex3f(r, r, 0);
        glTexCoord2f(0.0, 0.0);
        glVertex3f(r, -r, 0);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
end;

// �������� ������� ���������
procedure Build_Scene;
var a: word;
    b : string;
    POrient : PMestnik;
begin
  b:='';
  // �������� �����.�����.
  if Task.Ceson=LETO then b:='';
  if Task.Ceson=IVER then b:='w';
  for a:=1 to KOL_TYPE_LES do MontObject('res/Les/Les'+inttostr(a)+b+'.shp',LES+a);
  if Task.Mestn=PUSTYN then b:='p';
  for a:=1 to KOL_TYPE_TREE do MontObject('res/Tree/Tree'+inttostr(a)+b+'.shp',DEREVO+a);
  for a:=1 to KOL_TYPE_KUST do MontObject('res/Kust/Kust'+inttostr(a)+b+'.shp',KUST+a);
  MontObject('res/Okop/Okop1.shp',OKOP_1);
  MontObject('res/Okop/Okop2.shp',OKOP_2);
  // ������ ��� ���������
  for a:=1 to KOL_TYPE_HAUS_1 do begin
    MontObject('res/Haus/Haus'+inttostr(a)+'.shp',HAUS_1+a);
  end;
  // ����������� ���������
  if Task.Mestn=PUSTYN then begin
    for a:=1 to KOL_TYPE_HAUS_2_PUST do begin
      MontObject('res/Haus/Haus'+inttostr(a)+'p.shp',HAUS_2+a);
    end;
  end
  else begin
    for a:=1 to KOL_TYPE_HAUS_2 do begin
      MontObject('res/Haus/Haus'+inttostr(10+a)+'.shp',HAUS_2+a);
    end;
  end;
  // ����������� ���������
  for a:=1 to KOL_TYPE_HAUS_3 do begin
    MontObject('res/Haus/Haus'+inttostr(30+a)+'.shp',HAUS_3+a);
  end;
  // ���. � ���. ���������
  for a:=1 to KOL_TYPE_HAUS_TEX_1 do begin
    MontObject('res/Building/Build'+inttostr(a)+'.shp',HAUS_TEX_1+a);
  end;
  for a:=1 to KOL_TYPE_HAUS_TEX_2 do begin
    MontObject('res/Building/Build'+inttostr(10+a)+'.shp',HAUS_TEX_2+a);
  end;
//  MontObject('res/Oborud/Vychka3.shp',VYCHKA);
  MontObject('res/Oborud/Nadolb.shp',NADOLB);
  MontObject('res/Oborud/Brevno.shp',BREVNO);
  MontObject('res/Building/Bash_Kr.shp',BASH);
  MontObject('res/Building/Bash_Kv.shp',BASH+1);
  MontObject('res/Building/cercov.shp',CERCOV);
  MontObject('res/Building/Stolb_E.shp',STOLB_E);
  MontObject('res/Building/Stolb_V.shp',STOLB_V);
  MontObject('res/Building/ZaborB1_.shp',ZABOR+0);
  MontObject('res/Building/ZaborB1.shp',ZABOR+1);
  MontObject('res/Building/ZaborD1_.shp',ZABOR+2);
  MontObject('res/Building/ZaborD1.shp',ZABOR+3);
  MontObject('res/Building/ZaborD2_.shp',ZABOR+4);
  MontObject('res/Building/ZaborD2.shp',ZABOR+5);
  MontObject('res/Pereezd/Pereezd.shp',PEREEZD);
  MontObject('res/Pereezd/Zn_g_d.shp',ZNAK_G_D);
  MontObject('res/Most/MostKol1.shp',MOST_KOL1);
  MontObject('res/Okop/Okop3'+ExtLetter+'.shp',OKOP_3);
  MontObject('res/Okop/okop6'+ExtLetter+'.shp',USTUP);
  MontObject('res/Okop/okop7'+ExtLetter+'.shp',ASCARP);

  MontObject('res/Okop/Okop10.shp',OKOP_10);
  MontObject('res/Okop/Okop10.shp',OKOP_10_TEMP);
  MontObject('res/Okop/Okop10t.shp',OKOP_10_TEMP_VERCH);
  glDeleteLists(OKOP_10,1);
  glNewList (OKOP_10, GL_COMPILE);
    glCallList(OKOP_10_TEMP);
    glDisable(GL_ALPHA_TEST);
    glCallList(OKOP_10_TEMP_VERCH);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  MontObject('res/Okop/Okop11.shp',OKOP_11);
  MontObject('res/Okop/Okop11.shp',OKOP_11_TEMP);
  MontObject('res/Okop/Okop11t.shp',OKOP_11_TEMP_VERCH);
  glDeleteLists(OKOP_11,1);
  glNewList (OKOP_11, GL_COMPILE);
    glCallList(OKOP_11_TEMP);
    glDisable(GL_ALPHA_TEST);
    glCallList(OKOP_11_TEMP_VERCH);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  MontObject('res/Okop/Voronka.shp',VORONKA);
  MontObject('res/Okop/Voronka.shp',VORONKA_TEMP);
  MontObject('res/Okop/Voronkat.shp',VORONKA_TEMP_VERCH);
  glDeleteLists(VORONKA,1);
  glNewList (VORONKA, GL_COMPILE);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
    glCallList(VORONKA_TEMP);
    glCullFace(GL_BACK);
    glDisable(GL_CULL_FACE);
    glDisable(GL_ALPHA_TEST);
    glCallList(VORONKA_TEMP_VERCH);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  MontObject('res/ozero/ozero.shp',OZERO_TEMP);
  glNewList (OZERO, GL_COMPILE);
    glDisable(GL_ALPHA_TEST);
      glCallList(OZERO_TEMP);
    glEnable(GL_ALPHA_TEST);
  glEndList;
  // ����, ��������� ������
  MontObject('res/ozero/Voda.shp',VODA);

end;

// ����������� ������� ���������
procedure Count_Scene;
var a,b,n,n_haus: word;
x,h,y,t: real;
InSetRandom : boolean;
i : integer;
begin
  t:=1;
  n_haus:=0;
  RandSeed:=1;// ����� ������� ��� ������ ��������
  // ����������� �����.�����.
  for a:=1 to Col_Patch do begin
      for b:=1 to Orient_Col[a] do begin
          InSetRandom:=false;
          for i:=1 to 15 do if Orient_Type[a,b]=SetOfRandom[i] then InSetRandom:=true;
          if InSetRandom then t:=(Random(40)-20)/100 else t:=0;
          x:=Orient_Koord[a][b][1]+t;
          if InSetRandom then t:=(Random(40)-20)/100 else t:=0;
          y:=Orient_Koord[a][b][2]+t;
          h:=CountVertexYTri(x,y)-0.02;
          case Orient_Type[a,b] of
            23: AddMestnik(STOLB_WHITE,a,x,y,h,0,t);//������ �������
            24: AddMestnik(STOLB_RED,a,x,y,h,0,t);  //������� �������
            25: AddMestnik(STOLB_BLUE,a,x,y,h,0,t); //������� �������
           // �������
            110,120,130: begin
              t:=1+Random(5)/8;
              n:=Random(KOL_TYPE_TREE)+1;
              AddMestnik(DEREVO+n,a,x,y,h,0,t);
            end;
            124: AddMestnik(VYCHKA,a,x,y,h,0,t); //�����
            // ������� ����
            150..153: begin
              t:=0.81+Random(5)/8;
              AddMestnik(LES+Orient_Type[a,b]-150+1,a,x,y,h-0.15,0,t);
            end;
            193: AddMestnik(ZNAK4,a,x,y,h,0,t);
            194: AddMestnik(ZNAK1,a,x,y,h,0,t); //���� 1
            195: AddMestnik(ZNAK2,a,x,y,h,0,t); //���� 2
            196: AddMestnik(ZNAK3,a,x,y,h,0,t); //���� 3
            197: AddMestnik(ZNAK_STOP,a,x,y,h,0,t); //���� ����
            198: AddMestnik(STOLB_BLACK,a,x,y,h,0,t); //������ �������
            200: AddMestnik(ZNAK5,a,x,y,h,0,t);
            201: AddMestnik(ZNAK6,a,x,y,h,0,t);
            202: AddMestnik(ZNAK7,a,x,y,h,0,t);
            203: AddMestnik(ZNAK8,a,x,y,h,0,t);
            204: AddMestnik(ZNAK9,a,x,y,h,0,t);
            205: AddMestnik(ZNAK10,a,x,y,h,0,t);
            206: AddMestnik(ZNAK11,a,x,y,h,0,t);
            207: AddMestnik(ZNAK12,a,x,y,h,0,t);
            208: AddMestnik(ZNAK_R,a,x,y,h,0,t);
            209: AddMestnik(ZNAK_L,a,x,y,h,0,t);
            // ����
            210,220: begin
              t:=1+Random(5)/8;
              n:=Random(KOL_TYPE_KUST)+1;
              AddMestnik(KUST+n,a,x,y,h,0,t);
            end;
            // ��������
            310: begin
              n:=Random(KOL_TYPE_HAUS_3)+1;
              AddMestnik(HAUS_3+n,a,x,y,h,0,t);
            end;
            320: begin
              inc(n_haus);
              if n_haus>KOL_TYPE_HAUS_2 then n_haus:=1;
              n:=n_haus;
              AddMestnik(HAUS_2+n,a,x,y,h,0,t);
            end;
            330: begin
              n:=Random(KOL_TYPE_HAUS_1)+1;
              AddMestnik(HAUS_1+n,a,x,y,h,0,t);
            end;
            350: begin
              n:=Random(KOL_TYPE_HAUS_TEX_2)+1;
              AddMestnik(HAUS_TEX_2+n,a,x,y,h,0,t);
            end;
            360: begin
              n:=Random(KOL_TYPE_HAUS_TEX_1)+1;
              AddMestnik(HAUS_TEX_1+n,a,x,y,h,0,t);
            end;
            400: begin
              n:=Random(KOL_TYPE_BASH);
              AddMestnik(BASH+n,a,x,y,h,0,t);
            end;   //������������
            410: AddMestnik(CERCOV,a,x,y,h,0,t);   //�������
            430: AddMestnik(STOLB_V,a,x,y,h,0,t);  //����� �
            420: AddMestnik(STOLB_E,a,x,y,h,0,t);  //����� �
            450: AddMestnik(ZABOR,a,x,y,h,0,t);    //�����
            451: AddMestnik(ZABOR+1,a,x,y,h,0,t);  //�����
            460: AddMestnik(ZABOR+2,a,x,y,h,0,t);  //�����
            461: AddMestnik(ZABOR+3,a,x,y,h,0,t);  //�����
            462: AddMestnik(ZABOR+4,a,x,y,h,0,t);  //�����
            463: AddMestnik(ZABOR+5,a,x,y,h,0,t);  //�����
            800: AddMestnik(BASH,a,x,y,h,0,t);     //����
            801: AddMestnik(BASH+1,a,x,y,h,0,t);   //����
            851: AddMestnik(OKOP_2,a,x,y,h,0,t);   //����
            852: AddMestnik(OKOP_3,a,x,y,h,0,t);   //����
            853: AddMestnik(OKOP_10,a,x,y,h,0,t);   //����
            854: AddMestnik(OKOP_11,a,x,y,h,0,t);   //����
            855: AddMestnik(MOST_KOL1,a,x,y,h,0,t);//�������� ������
            860: AddMestnik(PEREEZD,a,x,y,h,0,t);  //�������
            861: AddMestnik(ZNAK_G_D,a,x,y,h,0,t); //���� �������
            862: AddMestnik(OZERO,a,x,y,h,0,t);    //�����
          end;
      end;
  end;
end;

// �������� ����������
procedure Build_Orientir;
var a: word;
begin
  a:=MIN_NUM_ORIENTIR;
  inc(a);
  MontObject('res/Building/Build12.shp',a);      //1
  inc(a);
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus3p.shp',a)
                             else MontObject('res/Haus/Haus5.shp',a);           //2
  inc(a);
  MontObject('res/Building/Stolb_E.shp',a);      //3
  inc(a);
  MontObject('res/Building/Stolb_V.shp',STOLB_V);//4
  inc(a);
  MontObject('res/Building/Bash_Kr.shp',a);      //5
  inc(a);
  MontObject('res/Building/Bash_Kv.shp',a);      //6
  inc(a);
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus5p.shp',a)
                             else MontObject('res/Haus/Haus15.shp',a);           //7
  inc(a);
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus1p.shp',a)
                             else MontObject('res/Haus/Haus11.shp',a);           //8
  inc(a);
  if Task.ceson=LETO then begin
    if Task.Mestn=PUSTYN then begin
      MontObject('res/Tree/Tree2p.shp',a);         //9
      inc(a);
      MontObject('res/Tree/Tree4p.shp',a);         //10
      inc(a);
      MontObject('res/Kust/Kust2p.shp',a);         //11
    end
    else begin
      MontObject('res/Tree/Tree11.shp',a);         //9
      inc(a);
      MontObject('res/Tree/Tree20.shp',a);         //10
      inc(a);
      MontObject('res/Kust/Kust2.shp',a);          //11
    end;
  end
  else begin
    MontObject('res/Tree/Tree6W.shp',a);         //9
    inc(a);
    MontObject('res/Tree/Tree2W.shp',a);         //10
    inc(a);
    MontObject('res/Kust/Kust2W.shp',a);         //11
  end;
  inc(a);
  if Task.Mestn=PUSTYN then MontObject('res/Haus/Haus2p.shp',a)
                             else MontObject('res/Haus/Haus12.shp',a);           //12
end;

// ����������� ���������� �� �������� ������
procedure Count_Orientir;
var a,patch: word;
x,y,h: real;
begin
  glNewList (ORIENTIR, GL_COMPILE);                       //
    for a:=1 to Task.Orient.Col_orient   do begin
      x:=Task.Orient.Xorient[a]*DDD/MASHT_RIS;
      y:=Task.Orient.Yorient[a]*DDD/MASHT_RIS;
      patch:=CountPatch(x,y);
      h:=CountVertexYTri(x,y);
      AddMestnik(Task.Orient.Typ_orient[a]+MIN_NUM_ORIENTIR,patch,x,y,h,0,1);
    end;
    // �����
    if Task.m_index<6000 then begin
      if Task.Mestn=GORA then begin
        Vychka_X:=VYCHKA_X_GOR/MASHT_RIS;
        Vychka_Y:=VYCHKA_Y_GOR/MASHT_RIS;
      end
      else begin
        Vychka_X:=VYCHKA_X_RAV/MASHT_RIS;
        Vychka_Y:=VYCHKA_Y_RAV/MASHT_RIS;
      end;
    end
    else begin
      Vychka_X:=VYCHKA_X_MV/MASHT_RIS;
      Vychka_Y:=VYCHKA_Y_MV/MASHT_RIS;
    end;
    Vychka_H:=CountVertexYTri(Vychka_X,Vychka_Y);
    patch:=CountPatch(Vychka_X,Vychka_Y);
    AddMestnik(VYCHKA,patch,Vychka_X,Vychka_Y,Vychka_H,0,1);
  glEndList;
end;

procedure DrawStripSurf(filename: string; num,delta_x:integer);
const
 mat_d : Array [0..3] of GLFloat = (0.91,0.91,0.91,1);
var
 p,i,j: integer;
 f: textfile;
 s: string;
 flo: GLfloat;//������������� ��������, ����������� ����������
 X_col: word;      // ���������� ������������� �� �
 Y_col: word;      // ���������� ������������� �� Y

begin
  if not FileExists(filename) then begin
    MessageDlg('��� ����� '+filename, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(f,filename);//����� ����� � �������� ����������
  Reset(f);              //�������� �����
  ReadLn(f,s);
  if(num>Col_Patch)or(num<Max_patch_mov)then PrepareImage(S,1);//�������� �������������
  ReadLn(f,s);           // �������� ����� �� X
  ReadLn(f,s);           // �������� ����� �� Z
  ReadLn(f,s);           // �������� ����� ��������� �� X
  X_col:=strtoint(s);
  ReadLn(f,s);           // �������� ����� ��������� �� Z
  Y_col:=strtoint(s);
  if (Task.m_index<3000)and (Task.Mestn=GORA)then begin
    if ((num>40) and (num<81))or
       ((num>120) and (num<161))or (num>200) then begin
      for i:=0 to Y_col-1 do begin
        for j:=0 to X_col-1 do begin
          ReadLn(f,s);
          Val(s,flo,p);
          if num<=Col_Patch then begin
            coy[num][j][i]:=flo;// �������� ����� ��� ����������� ������
          end;
        end;
      end;
      CloseFile(f);
      exit;
    end;
  end;
  for i:=0 to Y_col-1 do begin
    for j:=0 to X_col-1 do begin
      ReadLn(f,s);
      Val(s,flo,p);
      if num<=Col_Patch then begin
        coy[num][j][i]:=flo;// �������� ����� ��� ����������� ������
        vert[j][i][1]:=flo; // �������� ����� ��� ���������� ���������
      end
      else begin
        // ��������� ���������� ������ �� ������  � � ������ ������ � 2*2 ����
        if num<=(Col_Patch*2) then begin
          if (j mod 2 =0)and (i mod 2 =0)then vert[j div 2][i div 2][1]:=coy[num-Col_Patch][j][i];
        end
        else begin
          if (j mod 2 =0)and (i mod 2 =0)then vert[j div 2][i div 2][1]:=coy[num-Col_Patch*2][j][i];
        end;
      end;
    end;
  end;
  if num<=Col_Patch then begin
    for i:=0 to Y_col-1 do begin
      for j:=0 to X_col-1 do begin
        um_mestn[num][j][i]:=(arctan((coy[num][j][i+1]-coy[num][j][i])/SHAG_Y))*57.3;
        Kren_mestn[num][j][i]:=(arctan((coy[num][j+1][i]-coy[num][j][i])/SHAG_X))*57.3;
      end;
    end;
  end;
  // ������ ��������� �����.�����.
  if not EOF(f) then begin
    ReadLn(f,s); // '���������'
    Read(f,Orient_Col[num]); // ����������
    for i:=1 to Orient_Col[num] do begin
      Read(f,Orient_Koord[num][i][1]);
      Read(f,Orient_Koord[num][i][2]);
      Read(f,Orient_Type[num][i]); //
    end;
  end else Orient_Col[num]:=0;
  CloseFile(f);
 if(num<Col_Patch)and(num>Max_patch_mov)then exit;
  // ������ ���� �� ������ ������
  if num<=Col_Patch then begin
    for j:=0 to ((X_col-1) div 2)-1 do begin
      // ��������� �������� ������ ������ ������
      vert[j*2+1][0][1]:=(vert[j*2][0][1]+vert[j*2+2][0][1])/2;
      coy[num][j*2+1][0]:=vert[j*2+1][0][1];
      vert[j*2+1][Y_col-1][1]:=(vert[j*2][Y_col-1][1]+vert[j*2+2][Y_col-1][1])/2;
      coy[num][j*2+1][Y_col-1]:=vert[j*2+1][Y_col-1][1];
    end;
    for i:=0 to ((Y_col-1) div 2)-1 do begin
      vert[0][i*2+1][1]:=(vert[0][i*2+0][1]+vert[0][i*2+2][1])/2;
      coy[num][0][i*2+1]:=vert[0][i*2+1][1];
      vert[X_col-1][i*2+1][1]:=(vert[X_col-1][i*2+0][1]+vert[X_col-1][i*2+2][1])/2;
      coy[num][X_col-1][i*2+1]:=vert[X_col-1][i*2+1][1];
    end;
  end;
  vert[0][0][0]:=-Dlina_Patch_X/2;   // ��������� ��������� ��������� ��� ������ �����������
  vert[0][0][2]:=Dlina_Patch_Y/2;    // ...........
  // ������������  ������� ����������� ���������
  if num<=Col_Patch then begin
    for i:= 0 to Y_col-1 do begin
      for j:= 0 to X_col-1 do begin
        vert[j][i][0]:=vert[0][0][0]+j*SHAG_X;
        vert[j][i][2]:=vert[0][0][2]-i*SHAG_Y;
      end;
    end;
  end
  else begin
    X_col:=21;
    Y_col:=21;
    for i:= 0 to Y_col-1 do begin
      for j:= 0 to X_col-1 do begin
        vert[j][i][0]:=vert[0][0][0]+j*SHAG_X*2;
        vert[j][i][2]:=vert[0][0][2]-i*SHAG_Y*2;
      end;
    end;
  end;

  // ������ ���� �� ������ ������
  if num>Col_Patch *2 then begin
    // ��������� �������� ������ ������ ������ �������� �� ���� �� ������ ��������
    for j:=1 to ((X_col-1) div 2)-1 do begin
      vert[j*2][1][1]:=(vert[j*2-1][1][1]+vert[j*2+1][1][1])/2;
      vert[j*2][Y_col-2][1]:=(vert[j*2-1][Y_col-2][1]+vert[j*2+1][Y_col-2][1])/2;
    end;
    for i:=1 to ((Y_col-1) div 2)-1 do begin
      vert[1][i*2][1]:=(vert[1][i*2-1][1]+vert[1][i*2+1][1])/2;
      vert[X_col-2][i*2][1]:=(vert[X_col-2][i*2-1][1]+vert[X_col-2][i*2+1][1])/2;                          //
    end;
  end;
  mat_d[0]:=1;
  mat_d[1]:=1;
  mat_d[2]:=1;
  mat_d[3]:=1;
  glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);
  mat_d[0]:=0.3;
  mat_d[1]:=0.3;
  mat_d[2]:=0.3;
  mat_d[3]:=0.91;
  glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
  mat_d[0]:=0.6;
  mat_d[1]:=0.6;
  mat_d[2]:=0.6;
  mat_d[3]:=0.91;
  glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);

  // ������ ��������
  for i:= 0 to Y_col-2 do begin
    for j:= 0 to X_col-2 do begin
      zap:=countnorm(vert[j][i][0],vert[j][i][1],vert[j][i][2],
              vert[j][i+1][0],vert[j][i+1][1],vert[j][i+1][2],
              vert[j+1][i][0],vert[j+1][i][1],vert[j+1][i][2]);
      //���������� �� �  ������ vert
      vert[j][i][3]:=-zap.xnorm;
      vert[j][i][4]:=-zap.ynorm;
      vert[j][i][5]:=-zap.znorm;
    end;
    for j:=X_col-2 to X_col-1 do begin
      vert[j][i][3]:=-zap.xnorm;
      vert[j][i][4]:=-zap.ynorm;
      vert[j][i][5]:=-zap.znorm;
    end;
  end;
  // ������ �������� ��� ������� �����
  for i:=Y_col-2 to Y_col-1 do begin
    for j:= 0 to X_col-2 do begin
      zap:=countnorm(vert[j][i-1][0],vert[j][i-1][1],vert[j][i-1][2],
              vert[j][i][0],vert[j][i][1],vert[j][i][2],
              vert[j+1][i-1][0],vert[j+1][i-1][1],vert[j+1][i-1][2]);
      vert[j][i][3]:=-zap.xnorm;
      vert[j][i][4]:=-zap.ynorm;
      vert[j][i][5]:=-zap.znorm;
    end;
    for j:=X_col-2 to X_col-1 do begin
      vert[j][i][3]:=-zap.xnorm;
      vert[j][i][4]:=-zap.ynorm;
      vert[j][i][5]:=-zap.znorm;
    end;
  end;
  // ���������� ����������� 1 � 2 ������
  if num<=Col_Patch *2 then begin
    glBegin(GL_TRIANGLE_STRIP);
      for j:=0 to Round((Y_col-1)/2)-1 do begin
        for i:=0 to X_col-1 do begin   // ��� �����
          glNormal3f(vert[i][2*j+1][3],vert[i][2*j+1][4],vert[i][2*j+1][5]);
          glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+1)/(Y_col-1));
          glVertex3f(vert[i][2*j+1][0],vert[i][2*j+1][1],vert[i][2*j+1][2]);
          glNormal3f(vert[i][2*j][3],vert[i][2*j][4],vert[i][2*j][5]);
          glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j)/(Y_col-1));
          glVertex3f(vert[i][2*j][0],vert[i][2*j][1],vert[i][2*j][2]);
        end;
        for i:=X_col-1 downto 0 do begin
          glNormal3f(vert[i][2*j+1][3],vert[i][2*j+1][4],vert[i][2*j+1][5]);
          glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+1)/(Y_col-1));
          glVertex3f(vert[i][2*j+1][0],vert[i][2*j+1][1],vert[i][2*j+1][2]);
          glNormal3f(vert[i][2*j+2][3],vert[i][2*j+2][4],vert[i][2*j+2][5]);
          glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+2)/(Y_col-1));
          glVertex3f(vert[i][2*j+2][0],vert[i][2*j+2][1],vert[i][2*j+2][2]);
        end;
      end;
    glEnd;
  end
  // ���������� ����������� 3 ������
  else begin
//    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    // ��������� ������������� �������������� �����
    glBegin(GL_TRIANGLE_STRIP);
      j:=0;
      for i:=0 to X_col-1 do begin
        glNormal3f(vert[i][2*j+1][3],vert[i][2*j+1][4],vert[i][2*j+1][5]);
        glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+1)/(Y_col-1));
        glVertex3f(vert[i][2*j+1][0],vert[i][2*j+1][1],vert[i][2*j+1][2]);
        glNormal3f(vert[i][2*j][3],vert[i][2*j][4],vert[i][2*j][5]);
        glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j)/(Y_col-1));
        glVertex3f(vert[i][2*j][0],vert[i][2*j][1],vert[i][2*j][2]);
      end;
    glEnd;
    glBegin(GL_TRIANGLE_STRIP);
      j:=Round((Y_col-1)/2)-1;
      for i:=X_col-1 downto 0 do begin
        glNormal3f(vert[i][2*j+1][3],vert[i][2*j+1][4],vert[i][2*j+1][5]);
        glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+1)/(Y_col-1));
        glVertex3f(vert[i][2*j+1][0],vert[i][2*j+1][1],vert[i][2*j+1][2]);
        glNormal3f(vert[i][2*j+2][3],vert[i][2*j+2][4],vert[i][2*j+2][5]);
        glTexCoord2f(-1+(2*i)/(2*(X_col-1)),-1+(2*j+2)/(Y_col-1));
        glVertex3f(vert[i][2*j+2][0],vert[i][2*j+2][1],vert[i][2*j+2][2]);
      end;
    glEnd;
    // ��������� ������������� ������������ �����
//    glCullFace(GL_FRONT);
    glBegin(GL_TRIANGLE_STRIP);
      i:=0;
      for j:=1 to y_col-2 do begin
        glNormal3f(vert[i][j][3],vert[i][j][4],vert[i][j][5]);
        glTexCoord2f(i/(X_col-1),j/(Y_col-1));
        glVertex3f(vert[i][j][0],vert[i][j][1],vert[i][j][2]);
         glNormal3f(vert[i+1][j][3],vert[i+1][j][4],vert[i+1][j][5]);
        glTexCoord2f((i+1)/(X_col-1),j/(Y_col-1));
        glVertex3f(vert[i+1][j][0],vert[i+1][j][1],vert[i+1][j][2]);
      end;
    glEnd;
    glBegin(GL_TRIANGLE_STRIP);
      i:=X_col-2;
      for j:=1 to y_col-2 do begin
        glNormal3f(vert[i][j][3],vert[i][j][4],vert[i][j][5]);
        glTexCoord2f(i/(X_col-1),j/(Y_col-1));
        glVertex3f(vert[i][j][0],vert[i][j][1],vert[i][j][2]);
        glNormal3f(vert[i+1][j][3],vert[i+1][j][4],vert[i+1][j][5]);
        glTexCoord2f((i+1)/(X_col-1),j/(Y_col-1));
        glVertex3f(vert[i+1][j][0],vert[i+1][j][1],vert[i+1][j][2]);
      end;
    glEnd;
//    glCullFace(GL_BACK);
    // ��������� �������� ��������������
    glBegin(GL_TRIANGLE_STRIP);
      for j:=0 to ((Y_col-1)div 4)-1 do begin
        for i:=1 to (X_col-1)div 2 do begin
          glNormal3f(vert[i*2-1][4*j+3][3],vert[i*2-1][4*j+3][4],vert[i*2-1][4*j+3][5]);
          glTexCoord2f((2*i-1)/(X_col-1),(4*j+3)/(Y_col-1));
          glVertex3f(vert[i*2-1][4*j+3][0],vert[i*2-1][4*j+3][1],vert[i*2-1][4*j+3][2]);
          glNormal3f(vert[i*2-1][4*j+1][3],vert[i*2-1][4*j+1][4],vert[i*2-1][4*j+1][5]);
          glTexCoord2f((2*i-1)/(X_col-1),(4*j+1)/(Y_col-1));
          glVertex3f(vert[i*2-1][4*j+1][0],vert[i*2-1][4*j+1][1],vert[i*2-1][4*j+1][2]);
        end;
        // ��������� ������ � �������� ������� �� �������������
        if j<((Y_col-1)div 4)-1 then for i:=(X_col-1)div 2 downto 1 do begin
          glNormal3f(vert[i*2-1][4*j+3][3],vert[i*2-1][4*j+3][4],vert[i*2-1][4*j+3][5]);
          glTexCoord2f((2*i-1)/(X_col-1),(4*j+3)/(Y_col-1));
          glVertex3f(vert[i*2-1][4*j+3][0],vert[i*2-1][4*j+3][1],vert[i*2-1][4*j+3][2]);
          glNormal3f(vert[i*2-1][4*j+5][3],vert[i*2-1][4*j+5][4],vert[i*2-1][4*j+5][5]);
          glTexCoord2f((2*i-1)/(X_col-1),(4*j+5)/(Y_col-1));
          glVertex3f(vert[i*2-1][4*j+5][0],vert[i*2-1][4*j+5][1],vert[i*2-1][4*j+5][2]);
        end;
      end;
    glEnd;
//  glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
  end;
end;

function CountVertexYTri(X,Y: real): real;//  ��� ������ ���� � Y ������
var
  a1,a2,h1,h2,delta_x,delta_y: real;
  a,b: integer;
begin
    // ���� ����� ������� �� �������
    if X>=Dlina_Surf_X then X:=Dlina_Surf_X-0.01;
    if X<0 then X:=0.01;
    if Y>=Dlina_Surf_Y then Y:=Dlina_Surf_Y-0.01;
    if Y<0 then Y:=0.01;
    // ����������� ������ �����
    a:=trunc(X/Dlina_Patch_X);
    b:=trunc(Y/Dlina_Patch_Y);
    num_patch_h:=b*Col_Patch_X+a+1;

    delta_x:=X-(Dlina_Patch_X*a);  // ����������� ������� �� ������ ����� �� X
    delta_y:=Y-(Dlina_Patch_Y*b);  // ����������� ������� �� ������ ����� �� Y

    index_X:=trunc(delta_x/SHAG_X);  // ����������� ������ ��������������
    index_Y:=trunc(delta_y/SHAG_Y);

    a1:=delta_x-index_X*SHAG_X;  // ����������� ������� �� ������ ������� �� X
    a2:=delta_y-index_Y*SHAG_Y;  // ����������� ������� �� ������ ������� �� Y

   if a1>=a2 then CountVertexYTri:=coy[num_patch_h][index_X][index_Y]+
               (a1*(coy[num_patch_h][index_X+1][index_Y]-coy[num_patch_h][index_X][index_Y])+
               a2*(coy[num_patch_h][index_X+1][index_Y+1]-coy[num_patch_h][index_X+1][index_Y]))/SHAG_X
                 else CountVertexYTri:=coy[num_patch_h][index_X][index_Y]+
               (a1*(coy[num_patch_h][index_X+1][index_Y+1]-coy[num_patch_h][index_X][index_Y+1])+
               a2*(coy[num_patch_h][index_X][index_Y+1]-coy[num_patch_h][index_X][index_Y]))/SHAG_X;
end;

function CountPatch(Xi,Yi : real) : integer;
var a,b,n : integer;
begin
    a:=trunc(Xi/Dlina_Patch_X);
    b:=trunc(Yi/Dlina_Patch_Y);
    n:=b*COL_PATCH_X+a+1;
    if (n>COL_PATCH_X*COL_PATCH_Y) or (n<1) then CountPatch:=1
                                          else CountPatch:=n;
end;

procedure AddDinamic(Num : integer; x,y,a : GLdouble);
var p,pp : PMestnik;
    i : integer;
    c,d : PKoord;
    cosa,sina,xx,yy : real;
begin
  if TypesOfOrient.Count<=0 then exit;
  cosa:=cos(Pi*a/180);
  sina:=sin(Pi*a/180);
  i:=-1;
  repeat
    Inc(i);
    pp:=TypesOfOrient.Items[i];
  until((i=TypesOfOrient.Count-1) or (pp^.Num=Num));
  if pp^.Num=Num then begin
    New(p);
    p^.Num:=Num;
    p^.X:=x;
    p^.Y:=y;
    p^.A:=a;
    p^.Type_Objekt:=pp^.Type_Objekt;
    p^.Type_Action:=pp^.Type_Action;
    p^.Col_Points_Objekt:=pp^.Col_Points_Objekt;
    p^.Curver:=TList.Create;
    if p^.Type_Objekt>2 then for i:=0 to p^.Col_Points_Objekt-1 do  begin
      New(c);
      d:=pp^.Curver[i];
      xx:=d.X*cosa+d.Y*sina;
      yy:=d.Y*cosa-d.X*sina;
      c^.X:=x+xx;
      c^.Y:=y-yy;
      p^.Curver.Add(c);
    end
    else  begin
      New(c);
      d:=pp^.Curver[0];
      xx:=d.X*cosa+d.Y*sina;
      yy:=d.Y*cosa-d.X*sina;
      c^.X:=x+xx;
      c^.Y:=y-yy;
      p^.Curver.Add(c);
      if p^.Type_Objekt=2 then begin
        New(c);
        d:=pp^.Curver[1];
        c^.X:=d.X;
        c^.Y:=d.Y;
        p^.Curver.Add(c);
      end;
    end;
    DinamicObj.Add(p);
  end;
end;

// ���������
procedure Osveshenie(pnv,akt: boolean);/// ��� ���/����, ���� �� ���/���� //&&&&&&&&&&
const
 fogColor : Array [0..3] of GLFloat = (0.7, 0.7, 0.7, 0.10);
begin
  PNV_off:=pnv;                      // ������� ������, � UnDraw �� � ������ �����
  // ���������� ���� ����
  if Task.temp=DAY then begin  // ����
    if pnv then begin                // ������� ������
       // ����- ������
       glClearColor(0.4, 0.8, 0.4, 1.0);                           //���� ����
    end
    else case Task.m_inten_fog of         //  � ����������� �� ������ ������
      0: glClearColor(0.5, 0.8, 0.9, 1.0);                           //���� ����
      10: glClearColor(0.6, 0.8, 0.9, 1.0);                           //���� ����
      20..100: glClearColor(0.7, 0.7, 0.7, 1.0);                   //���� ����
    end;
  end
  else begin
    if pnv then glClearColor(0.1, 0.2, 0.1, 1.0)  // ����- ������, �����
           else glClearColor(0.1, 0.1, 0.2, 1.0);   // ����
  end;
  // ���������� ���� � ���� �������� ���������
  if pnv then begin
    // ���
    // ���������� ��������
    LIGHT_EMMISS_ON[0]:=0; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=0;
    fogColor[0]:=0; fogColor[1]:=0.1; fogColor[2]:=0;
    intensiv_fog:=10{Task.m_inten_fog}/600;
    if Task.temp=nuit then begin
      glClearColor(0, 0.1, 0, 1.0);
      // ��������� �����������
      LightColDif[0]:=0.15;LightColDif[1]:=0.2;LightColDif[2]:=0.15;
      LightColSpe[0]:=0.15;LightColSpe[1]:=0.2;LightColSpe[2]:=0.15;
      LightColAmb[0]:=0.15;LightColAmb[1]:=0.2;LightColAmb[2]:=0.15;
      // ��������� ������ ��������
      LightColDif_Alt[0]:=0.15;LightColDif_Alt[1]:=0.25;LightColDif_Alt[2]:=0.15;
      LightColAmb_Alt[0]:=0.15;LightColAmb_Alt[1]:=0.25;LightColAmb_Alt[2]:=0.15;
    end
    else begin
      glClearColor(0, 0.7, 0, 1.0);
      // ��������� �����������
      LightColDif[0]:=1;LightColDif[1]:=1;LightColDif[2]:=1;
      LightColSpe[0]:=1;LightColSpe[1]:=1;LightColSpe[2]:=1;
      LightColAmb[0]:=1;LightColAmb[1]:=1;LightColAmb[2]:=1;
      // ��������� ������ ��������
      LightColDif_Alt[0]:=1;LightColDif_Alt[1]:=1;LightColDif_Alt[2]:=1;
      LightColAmb_Alt[0]:=1;LightColAmb_Alt[1]:=1;LightColAmb_Alt[2]:=1;
      // ���������� ��������
    end;
  end
  else begin
    // ���������� ��������
    LIGHT_EMMISS_ON[0]:=1; LIGHT_EMMISS_ON[1]:=1; LIGHT_EMMISS_ON[2]:=1;
    if Task.temp=nuit then begin
      fogColor[0]:=0.1; fogColor[1]:=0.1; fogColor[2]:=0.2;
      intensiv_fog:=Task.m_inten_fog/1000;
      LightColAmb[0]:=0.001; LightColAmb[1]:=0.001; LightColAmb[2]:=0.001;
      LightColAmb_Alt[0]:=0.001; LightColAmb_Alt[1]:=0.001; LightColAmb_Alt[2]:=0.001;
      LightColDif[0]:=0.001; LightColDif[1]:=0.001; LightColDif[2]:=0.001;
      LightColDif_Alt[0]:=0.001; LightColDif_Alt[1]:=0.001; LightColDif_Alt[2]:=0.001;
      LightColSpe[0]:=0.00;LightColSpe[1]:=0.00;LightColSpe[2]:=0.00;
      glLightfv(GL_LIGHT0, GL_SPECULAR, @LightColSpe);
    end
    else begin
      fogColor[0]:=0.7; fogColor[1]:=0.7;  fogColor[2]:=0.7;
      intensiv_fog:=Task.m_inten_fog/5000;
      LightColAmb[0]:=0.1; LightColAmb[1]:=0.1; LightColAmb[2]:=0.1;
      if (Task.Ceson=IVER)then begin
        LightColAmb[0]:=1; LightColAmb[1]:=1; LightColAmb[2]:=1;
      end;
      LightColAmb_Alt[0]:=0.5; LightColAmb_Alt[1]:=0.5; LightColAmb_Alt[2]:=0.5;
      LightColDif[0]:=1; LightColDif[1]:=1; LightColDif[2]:=1;
      LightColDif_Alt[0]:=0.2; LightColDif_Alt[1]:=0.2; LightColDif_Alt[2]:=0.2;
      LightColSpe[0]:=0.5;LightColSpe[1]:=0.5;LightColSpe[2]:=0.5;
      glLightfv(GL_LIGHT0, GL_SPECULAR, @LightColSpe);
    end;
  end;
  if akt and (Task.temp=NUIT) then begin
    glEnable(GL_LIGHT4);
  end
  else  begin
    glDisable(GL_LIGHT4);
  end;
  glFogi (GL_FOG_MODE, GL_EXP);
  glFogf (GL_FOG_DENSITY, intensiv_fog);
  glFogfv (GL_FOG_COLOR, @fogColor);
end;

//======================================================
// ���������� ����� ��� ������ �� ������
procedure Build_Pricel;
var a,b,c: real;
  mat_d: array[0..3] of GLfloat;
  mat_a: array[0..3] of GLfloat;
  mat_s: array[0..3] of GLfloat;
begin
  LightColA[0]:=0;
  LightColA[1]:=0;
  LightColA[2]:=0;
  LightColA[3]:=1;
  glLightfv(GL_LIGHT2, GL_AMBIENT, @LightColA);

  mat_s[0]:=0; mat_s[1]:=0; mat_s[2]:=0.0; mat_s[3]:=1;
  mat_a[0]:=0; mat_a[1]:=0; mat_a[2]:=0.0; mat_a[3]:=1;
  mat_d[0]:=0; mat_d[1]:=0; mat_d[2]:=0.0; mat_d[3]:=1;
  // ����� ����
  glNewList (PRICEL_PTUR,GL_COMPILE);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_s);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_a);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);
    PrepareImage ('Pricel\Pric_PTR.bmp',4);
    a:=0.00175;
    a:=0.00216;
//    a:=Razm_pric;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.04996);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.04996);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.04996);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.04996);
    glEnd;
  glEndList;
  mat_s[0]:=0.9; mat_s[1]:=0.9; mat_s[2]:=0.0; mat_s[3]:=0.5;
  mat_a[0]:=0.9; mat_a[1]:=0.9; mat_a[2]:=0.0; mat_a[3]:=1.0;
  mat_d[0]:=1.0; mat_d[1]:=1.0; mat_d[2]:=0.0; mat_d[3]:=1.0;
  glNewList (PRICEL_PTUR_MARKA,GL_COMPILE);
    mat_s[0]:=0.9; mat_s[1]:=0.9; mat_s[2]:=0.0; mat_s[3]:=0.5;
    mat_a[0]:=0.9; mat_a[1]:=0.9; mat_a[2]:=0.0; mat_a[3]:=0.5;
    mat_d[0]:=1.0; mat_d[1]:=1.0; mat_d[2]:=0.0; mat_d[3]:=0.5;
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_s);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_a);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);
    PrepareImage ('Pricel\Pric_PTRMarka.bmp',4);
    a:=0.00108;
//    a:=Razm_pric;
    glBegin(GL_QUADS);
      glTexCoord2f(0, 0);
      glVertex3f(-a, -a, -0.0498);
      glTexCoord2f( 0, 1);
      glVertex3f(-a, a, -0.0498);
      glTexCoord2f(1, 1);
      glVertex3f(a, a, -0.0498);
      glTexCoord2f(1, 0);
      glVertex3f(a, -a, -0.0498);
    glEnd;
  glEndList;
  Build_Filtr;
  Build_Krug(KRUG1);
  Build_Krug(KRUG2);
  Build_Krug(KRUG3);
  Build_Krug(KRUG4);
  Build_Krug(KRUG5);
end;

procedure Build_Krug(num:word);
const
 mat_d : Array [0..3] of GLFloat = (1,1,1,1); //
 Level = 15;    // ������� �����������
 x=0.5;
 y=0.5;
var
 i : 0 .. Level - 1;
 d,r,radius: real;  // ������ ���������
begin
  d:=-0.0498;
  glNewList (num, GL_COMPILE);// ������ ������
    glDisable(GL_TEXTURE_2D);
    glColor3f(0.0, 0.0, 0.0);
    radius:= 0.5;
    glPushMatrix;
//    r:=Razm_pric;
    r:=0.00696;
      case num of
        KRUG1: begin
          radius:=0.3684;// 0.5;
          glScale(r,r,1);
        end;
        KRUG2: begin
          radius:= 0.4;
          glScale(0.007,0.007,1);
        end;
        KRUG3: begin
          radius:= 0.2;
          glScale(0.007,0.007,1);
        end;
        KRUG4: begin
          radius:= 0.43;
          glScale(0.0132,0.0132,1);
        end;
        KRUG5: begin
          radius:= 0.42;
          glScale(0.0176,0.0176,1);
        end;
      end;
      glBegin(GL_QUAD_STRIP);
        // ������� ��������
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) - Pi /4),
                    radius * cos (Pi * i / (2 * Level) - Pi /4), d);
          glVertex3f(i / Level - x, y, d);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) - Pi /4),
                      radius * cos (Pi * (i + 1) / (2 * Level) - Pi /4), d);
          glVertex3f((i + 1) / Level - x, y, d);
        end;
      glEnd;
      // ������ ��������
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) + Pi / 4),
                  radius * cos (Pi * i / (2 * Level) + Pi / 4), d);
          glVertex3f(x, y - i / Level, d);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) + Pi / 4),
                   radius * cos (Pi * (i + 1) / (2 * Level) + Pi / 4), d);
          glVertex3f(x, y - (i + 1)/ Level, d);
        end;
      glEnd;
      // ����� ��������
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) - 3 * Pi / 4 ),
                 radius * cos (Pi * i / (2 * Level) - 3 * Pi / 4), d);
          glVertex3f(-x, i / Level - y, d);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) - 3 * Pi / 4 ),
                 radius * cos (Pi * (i + 1) / (2 * Level) - 3 * Pi / 4), d);
          glVertex3f(-x, (i + 1) / Level - y, d);
        end;
      glEnd;
      // ������ ��������
      glBegin(GL_QUAD_STRIP);
        for i := 0 to Level - 1 do begin
          glVertex3f(radius * sin (Pi * i / (2 * Level) + 3 * Pi / 4 ),
                 radius * cos (Pi * i / (2 * Level) + 3 * Pi / 4), d);
          glVertex3f(x - i / Level, -y, d);
          glVertex3f(radius * sin (Pi * (i + 1) / (2 * Level) + 3 * Pi / 4),
                 radius * cos (Pi * (i + 1) / (2 * Level) + 3 * Pi / 4), d);
          glVertex3f(x - (i + 1) / Level, -y, d);
        end;
      glEnd;
    glPopMatrix;
    glColor3f(1.0, 1.0, 1.0);
    glEnable(GL_TEXTURE_2D);
  glEndList;
end;

procedure Build_Shtorka;
const
 mat_d : Array [0..3] of GLFloat = (0,0,0,1); //
begin
  glNewList (SHTORKA, GL_COMPILE);// ������ ������
    glDisable(GL_COLOR_MATERIAL);
    glDisable(GL_TEXTURE_2D);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);//������ ������������ ���������
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
    glPushMatrix;
      glBegin(GL_QUADS);
        glTexCoord2f(0,0);
        glVertex3f(-0.018, 0.007, -0.0502);
        glTexCoord2f(1,0);
        glVertex3f(0.018, 0.007, -0.0502);
        glTexCoord2f(1,1);
        glVertex3f(0.018, 0.03, -0.0502);
        glTexCoord2f(0,1);
        glVertex3f(-0.018, 0.03, -0.0502);
      glEnd;
    glPopMatrix;
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_COLOR_MATERIAL);
  glEndList ;// ������ ������
end;
procedure Build_Diafragma;
const
 mat_d : Array [0..3] of GLFloat = (0.1,0.1,0.1,0.9); //
begin
  glNewList (DIAFRAGMA, GL_COMPILE);// ������ ������
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_COLOR_MATERIAL);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);//������ ������������ ���������
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
    glPushMatrix;
      glTranslatef(0, 0, -0.0502);
      gluDisk(Quadric, 0, 0.008,16,1);
    glPopMatrix;
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
  glEndList ;// ������ ������
end;

procedure Build_Filtr;
const
 mat_d : Array [0..3] of GLFloat = (0.0,0.0,0.0,0.3); //
begin
  glNewList (FILTR1, GL_COMPILE);// ������ ������
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_COLOR_MATERIAL);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);//������ ������������ ���������
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
    glPushMatrix;
      glTranslatef(0, 0, -0.0501);
      gluDisk(Quadric, 0, 0.0055,16,1);
    glPopMatrix;
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
  glEndList ;// ������ ������
{  mat_d[0]:=1;mat_d[1]:=1;mat_d[2]:=0;mat_d[3]:=0.3;
  glNewList (FILTR2, GL_COMPILE);// ������ ������
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_COLOR_MATERIAL);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);//������ ������������ ���������
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
    glPushMatrix;
      glTranslatef(0, 0, -0.0501);
      gluDisk(Quadric, 0, 0.0055,16,1);
    glPopMatrix;
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
  glEndList ;// ������ ������
  mat_d[0]:=0;mat_d[1]:=1;mat_d[2]:=1;mat_d[3]:=0.5;
  glNewList (FILTR3, GL_COMPILE);// ������ ������
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_COLOR_MATERIAL);
    glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat_d);//������ ������������ ���������
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat_d);
    glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat_d);
    glPushMatrix;
      glTranslatef(0, 0, -0.0501);
      gluDisk(Quadric, 0, 0.008,16,1);
    glPopMatrix;
    glEnable(GL_COLOR_MATERIAL);
    glEnable(GL_TEXTURE_2D);
  glEndList ;// ������ ������}
end;

//============����� ���������� �����======================
procedure ReBuild_Patch(num_patch: word);
var b: word;
p : PMestnik;
h : GlFloat;
begin
  // �������� ������, ���� �� ����������
  if glIsList(SCENE_BAZA+num_patch) then glDeleteLists (SCENE_BAZA+num_patch,1);//***
  glNewList (SCENE_BAZA+num_patch, GL_COMPILE); // �������� ������ ������
    for b:=0 to Mestniks[num_patch].Count-1 do begin // ���������� ��������� �� �����
      p:=Mestniks[num_patch].Items[b];
      if (p^.Num<>OKOP_10)and
         (p^.Num<>OKOP_11)and
         (p^.Num<>VORONKA) then begin
        glPushMatrix;
          if p^.Az_Paden<>-1 then begin  // ���� ���� ������� �������, ��
           h:=CountVertexYTri(p^.x,p^.y);
           glTranslatef(p^.x,h,-p^.y);    //������������� ������� ������� �� �����������
          end
          else
           glTranslatef(p^.x,p^.h,-p^.y);    //������������� ������� ������� �� �����������
          if p^.A<>0 then glRotate(p^.A,0,1,0); // ������������ ���
          if p^.Az_Paden<>-1 then begin  // ���� ���� ������� �������, ��
            glRotate(p^.Az_Paden,0,1,0); // ������������ ��� � ����������� �������
            glRotate(p^.Tg_Paden,1,0,0);          // �������� ������� �� �����
          end;
           case p^.Num of  // ��������� �������� ����� ������ �������
            DEREVO..(DEREVO+39),LES..(LES+9),KUST..(KUST+29): glScale(p^.Sc,p^.Sc,p^.Sc);
          end;
          glCallList(p^.Num); // ������������� �������
        glPopMatrix;
      end;
    end;
  glEndList;
  // �������� ������, ���� �� ����������
  if glIsList(OKOP_BAZA+num_patch) then glDeleteLists (OKOP_BAZA+num_patch,1);//***
  glNewList (OKOP_BAZA+num_patch, GL_COMPILE); // �������� ������ ������
    for b:=0 to Mestniks[num_patch].Count-1 do begin // ���������� ��������� �� �����
      p:=Mestniks[num_patch].Items[b];
      if (p^.Num=OKOP_10) or
         (p^.Num=OKOP_11) or
         (p^.Num=VORONKA) then begin
        glPushMatrix;
          if p^.Az_Paden<>-1 then begin  // ���� ���� ������� �������, ��
           h:=CountVertexYTri(p^.x,p^.y);
           glTranslatef(p^.x,h,-p^.y);    //������������� ������� ������� �� �����������
          end
          else
          glTranslatef(p^.x,p^.h,-p^.y);    //������������� ������� ������� �� �����������
          if p^.A<>0 then glRotate(p^.A,0,1,0); // ������������ ���
          if p^.Az_Paden<>-1 then begin  // ���� ���� ������� �������, ��
            glRotate(p^.Az_Paden,0,1,0); // ������������ ��� � ����������� �������
            glRotate(p^.Tg_Paden,1,0,0);          // �������� ������� �� �����
          end;
          glCallList(p^.Num); // ������������� �������
        glPopMatrix;
      end;
    end;
  glEndList;
end;

procedure Isx_Pol_Scene;
var a,b: word;
p : PMestnik;
begin
  for a:=1 to Col_Patch do begin
    if Mestniks[a].Count>0 then begin//***
      for b:=0 to Mestniks[a].Count-1 do if Mestniks[a]<>nil then begin // ���������� ��������� �� �����
        p:=Mestniks[a].Items[b];
        p^.Az_Paden:=-1;  // �������������� ����� ��������
      end;
      ReBuild_Patch(a);    // �������������� �����
    end;
  end;
end;

procedure Init_image_loading;
var a: word;
begin
  for a:=1 to 16 do begin
    Track_Bar[a]:=TBitmap.Create;
    Track_Bar[a].LoadFromFile(Dir+'bmp\Track\load'+inttostr(a)+'.bmp');
  end;
end;

procedure Build_Gorisont;
var x,y: real;
a: word;
begin
  if Task.Mestn<>GORA then exit;
  if (Task.m_index<6000) then begin
  glNewList (GORIZONT_GORA, GL_COMPILE);
    prepareImage ('Nebo\Gora2.bmp',2);
    glBegin(GL_QUADS);            //��������������
      glTexCoord2f(0,0);
      glVertex3f(140, 0, 180);
      glTexCoord2f(1,0);
      glVertex3f(-70, 0, 180);
      glTexCoord2f(1,1);
      glVertex3f(-70, 50, 180);
      glTexCoord2f(0,1);
      glVertex3f(140, 50, 180);
    glEnd;
    prepareImage ('Nebo\Goriz_gor3.bmp',2);
    glBegin(GL_QUADS);            //��������������
      glTexCoord2f(0,0);
      glVertex3f(-220, 10, 0);
      glTexCoord2f(1,0);
      glVertex3f(20, 30, -400);
      glTexCoord2f(1,1);
      glVertex3f(20, 140, -400);
      glTexCoord2f(0,1);
      glVertex3f(-220, 20, 0);
    glEnd;
    glBegin(GL_QUADS);            //��������������
      glTexCoord2f(0,0);
      glVertex3f(340, -5, 100);
      glTexCoord2f(1,0);
      glVertex3f(70, 21, -200);
      glTexCoord2f(1,1);
      glVertex3f(70, 90, -200);
      glTexCoord2f(0,1);
      glVertex3f(340, 40, 100);
    glEnd;
  glEndList;
  end
  else begin
    for a:=1 to 12 do MontObject('res/Nebo/Gora_'+inttostr(a)+'.shp',GORIZONT_GORA+a+16);
    for a:=1 to 12 do begin
      glNewList (GORIZONT_GORA+a, GL_COMPILE);
        glDisable(GL_DEPTH_TEST);
        glPushMatrix;
          glScale(150,150,150);
          glTranslatef(0, -0.04, 0);
          glCallList(GORIZONT_GORA+a+16);
        glPopMatrix;
        glEnable(GL_DEPTH_TEST);
      glEndList;
    end;
  end;

end;
//==============���������� ��������========================

procedure Isx_Pol_Oborud;
begin
  if (Task.Mestn=GORA) or (Task.Ceson=IVER) then begin
    isx_pol_po_Y:=ISX_POL_BTR_Y_GOR;// �������� ��������� ��� �� Y
    Stolb_bottom:=STOLB_BOTTOM_GOR; // ���������� �� ������ ������ �����������
    Stolb_left:=STOLB_LEFT_GOR;
    stolb_dX1:=STOLB_DX1_GOR;
    stolb_dX2:=STOLB_DX2_GOR;
  end
  else begin
    isx_pol_po_Y:=ISX_POL_BTR_Y_RAV;    // �������� ��������� ��� �� Y
    Stolb_bottom:=STOLB_BOTTOM_RAV;      //     ���������� �� ������ ������ �����������
    Stolb_left:=STOLB_LEFT_RAV;
    stolb_dX1:=STOLB_DX1_RAV;
    stolb_dX2:=STOLB_DX2_RAV;
  end;
end;

(****�������� �������-�����*********)
procedure Build_Target;
var a,b,n: integer;
Tm,dal: real;
dr,tr,xr,yr,vr: real;
begin
  // ������ ������ ��� ������� �����
  if Task.mestn=RAVNINA then dH_target:=H_TARGET_RAV else dH_target:=H_TARGET_GOR;
  // �������: ��������� � �������
  if Task.m_index=5004 then dH_target:=H_TARGET_TAK;
  // ������
  if Task.m_index <5000 then begin
    for a:=1 to Task.Col_targ do begin
      // ��� ������������� ��������
      if Task.Ceson=IVER then Num_Texture:=5 else Num_Texture:=0;  // ����
      if Task.Mestn=PUSTYN then Num_Texture:=4 else Num_Texture:=0;// ����
      if Task.Target[1][a].Color_Mask>0 then Num_Texture:=Task.Target[1][a].Color_Mask;// �� ������
      // ������
      MontObject('res\Target\targ_'+Name_Target(Task.Target[1][a].Num) +'.shp', MIN_NUM_TARGET+a);
    end;
  end
  else begin
    // ��� ������������� ��������
    if Task.Ceson=IVER then Num_Texture:=5 else Num_Texture:=0;
    if Task.Mestn=PUSTYN then Num_Texture:=4 else Num_Texture:=0;
    // �������� ������
    MontObject('res\Target\targ_8.shp', MIN_NUM_TARGET+1);
  end;
  Num_Texture:=0;
end;

procedure Build_Missile;
begin
  MontObject('res/2c6/ZUR.shp',MISSILE_PTUR);
end;

procedure Build_Trass_Ptur;
const
  mat:  Array [0..3] of GLFloat = (1, 1, 1, 1);
var a: word;
x,y,z: real;
begin
  for a:=1 to 3 do begin
    glNewList (FIRE_PTUR+a, GL_COMPILE);
      x:=0.06;
      y:=0.06;
      z:=0;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_ON);
      glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT,@mat);
      glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE,@mat);
      prepareImage ('Fire\Fire_'+inttostr(a)+'.bmp',8);
      glBegin(GL_QUADS);
        glTexCoord2f(0.0, 0.0);
        glNormal3f(0,0,1);
        glVertex3f(-x, -y, z);
        glTexCoord2f( 0.0, 1.0);
        glVertex3f(-x, y, z);
        glTexCoord2f(1.0, 1.0);
        glVertex3f(x, y, z);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(x, -y, z);
      glEnd;
      glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION,@LIGHT_EMMISS_OFF);
    glEndList;
  end;
  for a:=1 to 20 do begin
    glNewList (TRASSA_PTUR+a, GL_COMPILE);
      z:=0.05;
      prepareImage ('Sprite\Vsp3\Vsp'+inttostr(a)+'.bmp',3);
      glBegin(GL_QUADS);
        glTexCoord2f(0.0, 0.0);
        glNormal3f(0,0,1);
        glVertex3f(-z, -z, 0);
        glTexCoord2f( 0.0, 1.0);
        glVertex3f(-z, z, 0);
        glTexCoord2f(1.0, 1.0);
        glVertex3f(z, z, 0);
        glTexCoord2f(1.0, 0.0);
        glVertex3f(z, -z, 0);
      glEnd;
    glEndList;
  end;
end;

procedure Build_Parade;
begin
  Box_Tank[1,1].x1_box:=-0.285;
  Box_Tank[1,1].h1_box:=-0.12;
  Box_Tank[1,1].y1_box:=-0.15;
  Box_Tank[1,1].x2_box:=0.28;
  Box_Tank[1,1].y2_box:=0.13;
  Box_Tank[1,1].h2_box:=0.01;

  Box_Tank[1,2].x1_box:=-0.14;
  Box_Tank[1,2].h1_box:=0.01;
  Box_Tank[1,2].y1_box:=-0.1;
  Box_Tank[1,2].x2_box:=0.13;
  Box_Tank[1,2].h2_box:=0.1;
  Box_Tank[1,2].y2_box:=0.1;

  Box_Tank[2,1].x1_box:=-0.27;
  Box_Tank[2,1].h1_box:=-0.18;
  Box_Tank[2,1].y1_box:=-0.21;
  Box_Tank[2,1].x2_box:=0.42;
  Box_Tank[2,1].h2_box:=-0.02;
  Box_Tank[2,1].y2_box:=0.11;

  Box_Tank[2,2].x1_box:=0.01;
  Box_Tank[2,2].h1_box:=-0.02;
  Box_Tank[2,2].y1_box:=-0.125;
  Box_Tank[2,2].x2_box:=0.19;
  Box_Tank[2,2].h2_box:=0.03;
  Box_Tank[2,2].y2_box:=0.04;

  Box_Tank[3,1].x1_box:=-0.44;
  Box_Tank[3,1].h1_box:=-0.09;
  Box_Tank[3,1].y1_box:=-0.14;
  Box_Tank[3,1].x2_box:=0.19;
  Box_Tank[3,1].h2_box:=0.05;
  Box_Tank[3,1].y2_box:=0.16;

  Box_Tank[3,2].x1_box:=-0.13;
  Box_Tank[3,2].h1_box:=0.05;
  Box_Tank[3,2].y1_box:=-0.11;
  Box_Tank[3,2].x2_box:=0.065;
  Box_Tank[3,2].h2_box:=0.11;
  Box_Tank[3,2].y2_box:=0.1;

  Box_Tank[4,1].x1_box:=-0.41;
  Box_Tank[4,1].h1_box:=-0.11;
  Box_Tank[4,1].y1_box:=-0.18;
  Box_Tank[4,1].x2_box:=0.23;
  Box_Tank[4,1].h2_box:=0.05;
  Box_Tank[4,1].y2_box:=0.17;

  Box_Tank[4,2].x1_box:=-0.2;
  Box_Tank[4,2].h1_box:=0.05;
  Box_Tank[4,2].y1_box:=-0.12;
  Box_Tank[4,2].x2_box:=0.03;
  Box_Tank[4,2].h2_box:=0.13;
  Box_Tank[4,2].y2_box:=0.12;

//  Build_Box;
end;

procedure Build_Box;
var a,b: word;
begin
  for a:=1 to 4 do begin
    glNewList (BOX_T+a, GL_COMPILE);
      prepareImage ('common_BMP\Black.bmp',1);
      for b:=1 to 2 do begin
        glBegin(GL_QUADS);
          glNormal3f(0,0,1);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glNormal3f(0,0,1);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glNormal3f(0,1,0);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glNormal3f(0,1,0);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
          glNormal3f(1,0,0);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x1_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
          glNormal3f(1,0,0);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y1_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h1_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y2_box);
          glVertex3f(Box_Tank[a,b].x2_box, Box_Tank[a,b].h2_box, Box_Tank[a,b].y1_box);
        glEnd;
      end;
    glEndList;
  end;
end;
end.


