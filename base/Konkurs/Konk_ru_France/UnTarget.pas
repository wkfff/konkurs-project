unit UnTarget;   //������������ ������� �������

interface

uses
  Windows, SysUtils,
  Classes, Graphics,
  Forms, Controls,
  StdCtrls, Dialogs,
  Buttons, Main,
  ExtCtrls, Spin, UnOther;

type
  TOKBottomDlg6 = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    Image1: TImage;
    Label3: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure LoadTarget(Num: integer);
    procedure Ris_target(x,y: integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Oto_ris;
    function Name_Target_Full(Num: integer): string;
    procedure MyPaint;
  private
    { Private declarations }
  public
    Color_Mask: word;
  end;

var
  OKBottomDlg6: TOKBottomDlg6;
  Mich: array[0..1,1..COL_MAX_TCHK_MICH] of TPoint; // ���������� 20 �������
                                                    //�� 30 �����
  Km: integer;
  Rects,RectBtnFace: TRect;
implementation

uses UnColor;

{$R *.DFM}

procedure TOKBottomDlg6.FormCreate(Sender: TObject);
begin
  Km:=2;
  RectBtnFace.Left:=10;
  RectBtnFace.Top:=42;
  RectBtnFace.Right:=382;
  RectBtnFace.Bottom:=220;
end;

procedure TOKBottomDlg6.ComboBox1Change(Sender: TObject);
begin
  MyPaint;
end;

(*********�������� ������� ������*********)
procedure TOKBottomDlg6.LoadTarget(Num: integer);
var  F: TextFile;
     S: String;
     a,b: integer;
     c: real;
begin
  S:=dirBase+'res\Target\Targ_'+Name_Target(Num)+'.txt';
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  ReadLn(F, S);
  b:=strtoint(copy(S,1,Pos(' ',s)-1));//���������� ����� ������
  for a:=1 to b do begin
    ReadLn(F, S);         //���������� �����, ����������� ������ ������
    Mich[1][a].x:=strtoint(copy(S,1,Pos(' ',s)-1));
    delete(S,1,Pos(' ',s));
    Mich[1][a].y:=strtoint(copy(S,1,Pos(' ',s)-1));
  end;
  ReadLn(F, S);           //���������� ����� ������������ ��������������
  Rects.Right:=strtoint(copy(S,1,Pos(' ',s)-1));
  delete(S,1,Pos(' ',s));
  Rects.Bottom:=strtoint(copy(S,1,Pos(' ',s)-1));
  c:=Rects.Right;                           // �������� �������� ������������
  Rects.Right:=round(c/Km);                 // ��������������
  c:=Rects.Bottom;
  Rects.Bottom:=round(c/Km);
  CloseFile(F);
end;

(******** ��������� ������ *******)
procedure TOKBottomDlg6.Ris_target(x,y: integer);
var c: integer;
b: real;
begin
  Canvas.Rectangle(RectBtnFace);
  x:=x-Rects.Right div 2; //���������� ������� ���������
  y:=y-Rects.Bottom div 2; // c ������ �������� ������
  b:=Mich[1][1].x;
  Mich[0][1].x:=x+round(b/Km);
  b:=Mich[1][1].y;
  Mich[0][1].y:=y+round(b/Km);
  for c:=2 to COL_MAX_TCHK_MICH do begin
    b:=Mich[1][c].x;
    Mich[0][c].x:=Mich[0][c-1].x+round(b/Km);
    b:=Mich[1][c].y;
    Mich[0][c].y:=Mich[0][c-1].y+round(b/Km);
  end;
  Canvas.Brush.Color:=clBlack;
  Canvas.Polygon(Mich[0]);
  Canvas.Brush.Color:=clWhite;
end;

procedure TOKBottomDlg6.MyPaint;
var a: integer;
begin
  a:=ComboBox1.ItemIndex+10;
  LoadTarget(a);
  Ris_target(200,130);
  Label4.Caption:=Name_Target_Full(a);
end;

procedure TOKBottomDlg6.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then close;
end;

procedure TOKBottomDlg6.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TChangColor, ChangColor);
  ChangColor.Num_color:=Color_Mask;
  if ChangColor.ShowModal=mrOk then begin
    Color_Mask:=ChangColor.Num_color;
  end;
  MyPaint;
  Oto_ris;
end;

procedure TOKBottomDlg6.FormActivate(Sender: TObject);
begin
  MyPaint;
  Oto_ris;
end;

procedure TOKBottomDlg6.Oto_ris;
var Bit: TBitmap;
begin
  Bit:=TBitmap.Create;;
  if (Color_Mask>0)and(Color_Mask<10) then begin
    Bit.LoadFromFile(DirBase+'bmp\target\Maska'+inttostr(Color_Mask)+'.bmp');
  end
  else begin
    Bit.LoadFromFile(DirBase+'bmp\target\Maska10.bmp');
  end;
  Image1.Canvas.Draw(0,0,Bit);
  Bit.Free;
end;

function TOKBottomDlg6.Name_Target_Full(Num: integer): string;
begin
  result:='������� ������';
  case Num of
    M6: result:='������� ������';
    M7: result:='������� ������';
    M8: result:='�������� ������';
    M8A: result:='�������� ������';
    M9: result:='������ ��������������� ���������';
    M9A: result:='��������������� ��������� � �����';
    M9C: result:='������ ���� � �����';
    M10: result:='������ ������';
    M10A: result:='��������� ������';
    M11: result:='��������������� (�����������) ������';
    M12: result:='����';
    M12A: result:='����';
    M12B: result:='���� � �����';
    M13: result:='���������������';
    M13A: result:='���������������';
    M14: result:='������ ������ ������';
    M17: result:='����������� ������ �� ����������';
    M17A: result:='����������� ������ �� ����������';
    M17B: result:='����������� ������ �� ���������� � �����';
    M18: result:='���� �� ����������������';
    M19: result:='�������������� ������';
    M20: result:='���������� �������� ���������';
    M20A: result:='���������� �������� ��������� � ���.���������';
    M25: result:='�������';
  end;
end;
end.
