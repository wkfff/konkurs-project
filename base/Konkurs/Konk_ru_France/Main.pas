unit Main;  //������� ���� ���������� ����������

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, StdCtrls, ComCtrls, Buttons, Menus,
    UnGeom;
const
  TIME_LINE=2;               // ��� ����� ������������� �����
  MAX_TYPE_TEX=10;           // ������������ ���������� ����� �������
  COL_MAX_MICH_TAK=30;       // ������������ ���������� ������� ��� �������
  COL_MAX_OBJEKT_TAK_TEX=15; // ������������ ���������� ������� ��� �������
  COL_MAX_POINTS_TAK=4;      // ������������ ���������� ����� �� �������� ��� �������
  COL_MAX_POINTS_TAK_TEX=15; // ������������ ���������� ����� �� �������� ��� �������(�������)

  // ��������� ������� ������� ��-�� ������������� ���������� �������
  POL_APA_H=0;            //��������� �������� �� � � ������� ��������
  POL_BTR_H=0.07;            //��������� ������� ��� �� � � ������� ��������
  POL_BMP_H=0.165;      //��������� ������� ��� �� � � ������� ��������

  POL_APA_Y=0;
  POL_BTR_Y=-0.33;
  POL_BMP_Y=0.032;

  POL_APA_X=0;
  POL_BTR_X=0.1125;
  POL_BMP_X=0.024;

  H_TARGET_GOR=2;             // ������ ������ ��� ������� �����
  H_TARGET_RAV=2;
  H_TARGET_TAK=-7;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Timer2: TTimer;
    Panel1: TPanel;
    Panel11: TPanel;
    Bevel9: TBevel;
    Label96: TLabel;
    Label97: TLabel;
    Image10: TImage;
    Panel17: TPanel;
    Bevel1: TBevel;
    Label82: TLabel;
    Label83: TLabel;
    Image11: TImage;
    Panel18: TPanel;
    Bevel12: TBevel;
    Label106: TLabel;
    Image15: TImage;
    Label107: TLabel;
    Label105: TLabel;
    Panel4: TPanel;
    Bevel3: TBevel;
    Image30: TImage;
    Image29: TImage;
    Label22: TLabel;
    Label23: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Panel21: TPanel;
    Bevel8: TBevel;
    Image35: TImage;
    Image12: TImage;
    Label91: TLabel;
    Label93: TLabel;
    Panel12: TPanel;
    Bevel14: TBevel;
    Label50: TLabel;
    Edit18: TEdit;
    Label38: TLabel;
    Image3: TImage;
    Panel3: TPanel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Label3: TLabel;
    Panel13: TPanel;
    Bevel20: TBevel;
    Label6: TLabel;
    Image13: TImage;
    Label42: TLabel;
    Image16: TImage;
    Label44: TLabel;
    Panel15: TPanel;
    Bevel19: TBevel;
    Label4: TLabel;
    Label11: TLabel;
    Panel14: TPanel;
    Bevel21: TBevel;
    Label5: TLabel;
    Label12: TLabel;
    Image14: TImage;
    Image31: TImage;
    Panel20: TPanel;
    Bevel22: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Panel22: TPanel;
    Bevel23: TBevel;
    Label49: TLabel;
    Panel5: TPanel;
    Bevel7: TBevel;
    Label32: TLabel;
    Image6: TImage;
    Label31: TLabel;
    Label35: TLabel;
    Bevel13: TBevel;
    Bevel15: TBevel;
    Edit23: TEdit;
    ProgressBar4: TProgressBar;
    Edit30: TEdit;
    Edit44: TEdit;
    Image2: TImage;
    Image17: TImage;
    Panel2: TPanel;
    Bevel24: TBevel;
    Label13: TLabel;
    Panel6: TPanel;
    Label14: TLabel;
    Image7: TImage;
    Label15: TLabel;
    Label16: TLabel;
    Edit24: TEdit;
    ProgressBar1: TProgressBar;
    Edit31: TEdit;
    Edit45: TEdit;
    Panel7: TPanel;
    Bevel28: TBevel;
    Label17: TLabel;
    Panel9: TPanel;
    Bevel29: TBevel;
    Bevel30: TBevel;
    Label18: TLabel;
    Image8: TImage;
    Label19: TLabel;
    Label20: TLabel;
    Bevel31: TBevel;
    Edit27: TEdit;
    ProgressBar2: TProgressBar;
    Edit9: TEdit;
    Edit46: TEdit;
    Edit39: TEdit;
    Edit38: TEdit;
    Edit25: TEdit;
    Edit1: TEdit;
    Panel23: TPanel;
    Label21: TLabel;
    Panel19: TPanel;
    Bevel16: TBevel;
    Image44: TImage;
    Label104: TLabel;
    Label98: TLabel;
    Edit22: TEdit;
    Panel10: TPanel;
    Bevel11: TBevel;
    Label94: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit4: TEdit;
    Panel8: TPanel;
    Bevel10: TBevel;
    Label95: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label81: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Label86: TLabel;
    Image26: TImage;
    Label87: TLabel;
    Label88: TLabel;
    Image27: TImage;
    Image1: TImage;
    Image4: TImage;
    Label7: TLabel;
    Image5: TImage;
    Label8: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Panel16: TPanel;
    Bevel2: TBevel;
    Label26: TLabel;
    Image9: TImage;
    Label28: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image12MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image13MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image13MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image16MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image16MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image14MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image14MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image29MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image29MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image30MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image30MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image31MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image31MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image17MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure Image35MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image35MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image33MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button8Click(Sender: TObject);
    procedure Image44MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image44MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
  protected
    procedure idle_TKN(Sender: TObject; var done:boolean);
    procedure SetTaskIsxPol;
  public
    File_Name_Vedom: string;
    /// ������ �� ���������
    VoenCh: string;
    Rota: string;
    Vzvod: string;
    Zvanie,Name:array[1..3,1..3] of string;
    TargetName: array[1..30] of  string;         // ����� ������ (��������� ��������)
    procedure Init_var;
    procedure OtobrPanel(Num: integer);
    procedure Ris_task;
    procedure Read_ini(FileName: string);  // ������ ����� �������������
    procedure ReBuild_All;
    procedure LampGotovn(num: integer; pre: boolean);
    procedure Isx_pol;
    procedure Count_scene2;
    procedure SaveMoto;
    function IntToStrTime(t: integer): string;
    procedure RebootSystem;
    procedure Creat_Lamp;
    procedure Init_Data_Vedom;
    procedure Set_Panels;

    procedure Set_Day(a: word);
    procedure Set_Ceson(a: word);
    procedure Set_Mestn(a: word);

    procedure Set_Directris;
    procedure TransmitionViewer(n:word);

end;

const
  TIME_ZAR_MODEL=6;           //����� ����� �������� (���������) ����� ����������
  R_REAK_MODEL=40;            //������ ������� �����
  TIK_SEK=18;
  MAX_COL_PODRYV=15;
  COL_MAX_TCHK_MiCH=30;

  MASHT_RIS=100;      // ����������� :   ������(��)/������ �� ������ 0,1 � - 1 ��
  DDD=10;             // ��� �������� � ������
  ANGL_PADEN=270;     // ���� ��������� �������

  MIN_DALN_ORIENT=600;  // ����������� ��������� �� ����������

  NONE=0;
  UPRAV_SNAR=4;

var
   Form1: TForm1;
   Lamp_num: array[1..4] of TBitmap;// �������� �� ������(1-����, 2-���������, 3-������
                                   //                 4-������)
   Perekl: array[1..4] of TBitmap;// �������������
   Lamp_Red_On:TBitmap;
   Lamp_Red_Off:TBitmap;
   Lamp_Green_On:TBitmap;
   Knopka_red_off: TBitmap;// ������
   Knopka_red_on: TBitmap;// ������
   Knopka_green_off: TBitmap;// ������
   Knopka_green_on: TBitmap;// ������
   Knopka_braun_off: TBitmap;// ������
   Knopka_braun_on: TBitmap;// ������

   TimerId : uint;  // ������������� �������
   Variant: integer;
   Num_BMP_Temp: integer;
   Time_Rassylka: word;
   lamps: array[1..3,0..12] of byte;
   /// �������
   Koord_poraj_X: array[1..3,1..5] of  word;
   Koord_poraj_Y: array[1..3,1..5] of  word;
   MotoTime,TikMoto: integer;
   mode_off: word;    //����� ����������  0-������� ���������, 1-���� ��, 2-�����������
   Signal: boolean;
   Time_Sek: boolean;
   TaskName: string;                                     // ������������ ������
   TargetName: array[1..10] of  string;                  // ������������ ������
   Kvit_Abonent: array[1..9] of byte;
   Tik_Time,Aktivnost: integer;
   Time_Off: word;
   Time_Secound: word;
   Start_Secound: boolean;
   SpeedMetr : array[1..6] of TLabel;
   Col_Model: word;
   buttonRassylkaTask: boolean;
   time_Upr: word;
   Begin_upr: boolean;
   Missile_Start_old: boolean;

implementation

uses UnClose, UnVybor, UnPogoda, UnEkip, UnEdit, MMSystem,
     UnVed_Ta, UnTarTak, UnEd_Tak,  UnOther, UnModel, UnLVS, UnVedom, UnBuildServer,
     UnBuildSetka, UnBuildKoordObject, UnTask, UnOcenka,UnOtkaz, UnReadIni, UnLoadLang;

{$R *.DFM}

procedure TimeProc(uTimerID, uMessage: UINT;dwUser, dw1, dw2: DWORD) stdcall;
begin
  With Form1 do begin
    if stop_prog then exit;
    Count_scene2;
    LVS.Trans_Model;
  end;
end;

{*********�������� �����********}
procedure TForm1.FormCreate(Sender: TObject);
var a: integer;
begin
  stop_prog:=true;
  // ���������� ������� �����������
  if FileExists('\Base\Base.shp') then dirBase:='\Base\' else dirBase:='..\';
  // ��������� ��������� ������ ���������
  if Findwindow('TForm1','RMI')<>0 then  Application.Terminate;
  Caption:='RMI';
  LoadIniTables;
//  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS); //������� ������� ������������
  Creat_Lamp;
  Init_var;
  Load_Task(false);
  InitSetka;
  application.onidle:=idle_TKN;       {����������, ���������� � ����}
  TimerID := timeSetEvent (55, 0, @TimeProc, 0, TIME_PERIODIC);
  Label6.Caption:=TaskName;
  Variant:=Task.m_index mod 100;
  if Task.m_index<6000 then label6.Caption:=label6.Caption+'      Variante '+inttostr(Variant);
  Task.NumKvit:=GetTickCount and $ff;
  Init_Data_Vedom;
  stop_prog:=false;
  SetMain;
//  label50.Caption:=inttostr(sizeOf(TTTT))
//  label1.Caption:=inttostr(NumKvit);
end;


procedure TForm1.Init_Data_Vedom;
var
S: string;
begin
  S:='Data.txt';//
  FileSetAttr(S,$00000);
  AssignFile(File_Vedom,S);  {���������� ����� � ������}
  Rewrite(File_Vedom);
  CloseFile(File_Vedom);
end;

{********������� ������������ �������********}
procedure TForm1.idle_TKN(Sender: TObject; var done:boolean);
begin                                           {���� ��� ����� �}
  while begO<>endO do begin   {���� �� �������� �������}
    case potok[begO,1] of
      1: LVS.Send_IPX( potok[begO,3],begO );
      7: Close;
    end;
    inc(begO);
    begO := begO and $3f;
  end;
  done:=True;
end;

{************������������� ����������*************}
procedure TForm1.Init_var;
var a:integer;
begin
  Read_ini('res\Konkurs.ini');   // ������ ����� �������������
  SetDimensionDirectris(Task.Ceson,Task.Mestn);
  Mode_off:=0;                //����� ����������
  File_Name_Vedom:=dirBase+'res/data.txt';
end;

{*************������� �������*****************}
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (Key=VK_F12) and (SSShift in Shift) then begin
    KommandTr[1]:=POWER_PK;
    KommandTr[2]:=POWER_CLOSE;
    LVS.Trans_kom;
    Close;
    exit;
  end;
  case Key of
    109: begin
      TransmitionViewer(VIEWER_SCALE_MINUS);
    end;
    107: begin
      TransmitionViewer(VIEWER_SCALE_PLUS);
    end;
    33: begin
      TransmitionViewer(VIEWER_DALN_PLUS);
    end;
    34: begin
      TransmitionViewer(VIEWER_DALN_MINUS);
    end;
    38: begin
      TransmitionViewer(VIEWER_UP);
    end;
    40: begin
      TransmitionViewer(VIEWER_DOUN);
    end;
    37: begin
      TransmitionViewer(VIEWER_LEFT);
    end;
    39: begin
      TransmitionViewer(VIEWER_RIGHRT);
    end;
  end;
end;

{************����� ������ ***********}
procedure TForm1.FormDestroy(Sender: TObject);
begin
  timeKillEvent(TimerID);
  SaveMoto;
  RebootSystem;
end;

// ������� �� �����������
procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Set_directris;
end;

// ����- ����
procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  if Task.Temp=DAY then begin
    Task.Temp:=NIGHT;
  end
  else begin
    Task.Temp:=DAY;
  end;
  Load_Task(false);
end;

// ���� -����
procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  if (Task.m_index=2900) then exit;
  if Task.Ceson=SUMMER then begin
     Task.Ceson:=WINTER;
     if Task.m_tv>2 then Task.m_tv:=-10;
   end
   else begin
     Task.Ceson:=SUMMER;
     if Task.m_tv<5 then Task.m_tv:=15;
   end;
end;

// ���������
procedure TForm1.BitBtn8Click(Sender: TObject);
begin
  if (Task.m_index=2900) then exit;
  case Task.Mestn of
    RAVNINA:begin
      if Task.m_index>6000 then begin
        Task.Mestn:=BOLOTO;
      end
      else begin
        Task.Mestn:=GORA;
      end;
    end;
    GORA:begin
      Task.Mestn:=BOLOTO;
    end;
    BOLOTO:begin
      Task.Mestn:=PUSTYN;
    end;
    PUSTYN:begin
      Task.Mestn:=RAVNINA;
    end;
    else begin
      Task.Mestn:=RAVNINA;
    end;
  end;
  Load_Task(false);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var a,c: word;
kvit: boolean;
begin
  inc(Tik_Time);
  if Tik_Time>10 then  begin
    Tik_Time:=0;
    inc(TikMoto); if TikMoto>5 then begin
      TikMoto:=0;
      inc(MotoTime);
      Edit18.Text:=InttoStrTime(MotoTime);
    end;
  end;
  if Start_Secound then begin
    inc(Time_Secound);
    Edit4.Text:=inttostr(Time_Secound div 60)+' min'+inttostr(Time_Secound mod 60)+' sec';
  end;
  // ��������� ������� ��������� � ����
  kvit:=false;
  for a:=0 to COL_ABONENT-1 do begin
    if Preparation[a]>0 then begin
       LampGotovn(a,True);
       // �������� ��������� � ������ ������ � ���������
       if numKvit[a]<>Task.NumKvit then begin
         kvit:=true;
       end;
       dec(Preparation[a]);
    end
    else begin
      LampGotovn(a,false);
    end;
  end;
  if kvit then LVS.Trans_Isx_pol;
end;

procedure TForm1.Count_scene2;
var a,n: integer;
begin
  // ��������, ������ � ��������� �������
  if Begin_upr then begin
    if Task.m_index <5000 then Move_Michen_Tik
                          else CountParamModel_Tik;
  end;
end;

procedure TForm1.OtobrPanel(Num: integer);
begin
  Num:=2;
  label15.Font.Color:=clBlack;
  ProgressBar1.Max:=Task.Bk.Col_Upr;
  ProgressBar1.Position:=Boek[Num].Col_Upr;
  Edit31.Text:=inttostr(Boek[Num].Col_Upr);
  Edit31.Font.Color:=label15.Font.Color;
end;

procedure TForm1.Ris_task;
var a,d,n,f: integer;
s: string;
begin
  d:=95;
  with Image2.Canvas do begin
    Font.Color:=clFuchsia;
    Brush.Color:=clBlack;
    Rectangle(0,0,width,height);
    if (TaskName='')or((Task.m_index>3000)and (Task.m_index<4000))or
                      (Task.m_index>5000) then begin
      f:=Font.Size;
      Font.Size:=12;
      S:='Non exercice';
      if (Task.m_index>3000) and (Task.m_index<4000) then begin
        Variant:=Task.m_index mod 100;
        s:='���������� � ����������������������.      ������� '+inttostr(Variant);
      end;
      if (Task.m_index>5000)then begin
        s:=TaskName;
      end;
      TextOut(250,25,s);
      Font.Size:=f;
    end
    else begin
      Brush.Color:=clBlack;
      Rectangle(0,0,width,height);
      Brush.Color:=clFuchsia;
      for a:=1 to Task.Col_targ do begin             //�������� ��������
        LoadTarget(Task.Target[1][a].Num,a);
        Ris_target(a,(d*(a-1)+40),27,10,1);
      end;
      Font.Color:=clFuchsia;
      Brush.Color:=clBlack;
      Pen.Color:=clFuchsia;
      for a:=1 to Task.Col_targ do begin
        MoveTo(d*(a-1)+40-15,30);
        LineTo(d*(a-1)+40+45,30);
        s:=Name_Target_rus(Task.Target[1][a].Num);        ///����� ������
        if s='12b' then s:='12�';
        if s='17b' then s:='17�';
        TextOut(d*(a-1)+40-35,25,s);
        s:=inttostr(Task.Target[1][a].Tst)+' -- '+inttostr(Task.Target[1][a].Tend);
        TextOut(d*(a-1)+40-10,35,s);                     ///����� ������
        s:=inttostr(Task.Target[2][a].Ytek[0]);
        TextOut(d*(a-1)+40+20,13,s);                     //��������� �� ������
      end;
    end;
  end;
end;

procedure TForm1.ReBuild_All;
begin
  FreeSetka;
  InitSetka;
  OtobrPanel(1);
end;

procedure TForm1.LampGotovn(num: integer; pre: boolean);
begin
  case num of
    RM_RUKOVOD: if pre then Image1.Canvas.Draw(0,0,Lamp_Green_On) else Image1.Canvas.Draw(0,0,Lamp_Red_On);
    RM_NAVOD_PTU: if pre then Image4.Canvas.Draw(0,0,Lamp_Green_On) else Image4.Canvas.Draw(0,0,Lamp_Red_On);
    RM_SERVER: if pre then Image5.Canvas.Draw(0,0,Lamp_Green_On) else Image5.Canvas.Draw(0,0,Lamp_Red_On);
  end;
end;

procedure TForm1.Isx_pol;
var a,b,c: integer;
begin
  Isx_Pol_GM;
  signal:=false;
  Begin_upr:=false;
  Timer2.Enabled:=false;
  Count_Target;
  Isx_Model;
  Isx_Pol_Scene;
  Isx_Pol_Target;
end;


function TForm1.IntToStrTime(t: integer): string;
begin
  if (t mod 60)<10 then  result:=inttostr(t div 60)+':0'+inttostr(t mod 60)
                   else  result:=inttostr(t div 60)+':'+inttostr(t mod 60);
end;

//��������� ����������� WINDOWS �� �����-���������
procedure TForm1.RebootSystem;
var
handle, ph: THandle;
pid: DWORD;
luid: TLargeInteger;
dummy, priv: TOKEN_PRIVILEGES;
ver: TOSVERSIONINFO;
begin
  ver.dwOSVersionInfoSize := Sizeof(ver);
  GetVersionEx(ver);
  if ver.dwPlatformId=VER_PLATFORM_WIN32_NT then begin
    pid := GetCurrentProcessId;
    ph := OpenProcess(PROCESS_ALL_ACCESS, false, pid);
    if OpenProcessToken(ph, TOKEN_ADJUST_PRIVILEGES, handle) then
    if LookupPrivilegeValue(nil, 'SeShutdownPrivilege', luid) then begin
      priv.PrivilegeCount := 1;
      priv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      priv.Privileges[0].Luid := luid;
      AdjustTokenPrivileges(handle, false, priv, 0, dummy, pid);
    end;
  end;
  if Mode_off=2 then begin
    ExitWindowsEx(EWX_REBOOT, 0);
  end
  else if Mode_off=1 then begin
    ExitWindowsEx(EWX_SHUTDOWN ,0);
  end;
end;

(*********** ���������� ************)

procedure TForm1.Read_ini(FileName: string);  // ������ ����� �������������
var  F: TextFile;
     S: String;
     a,b: word;
begin
  S:=dirBase+FileName;//
  if not FileExists(s) then begin
//    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    Task.Temp:=DAY;
    Task.Ceson:=SUMMER;
    Task.Mestn:=RAVNINA;
    Task.m_index:=1111;
  end
  else begin
    AssignFile(F,S);  {���������� ����� � ������}
    try
      Reset(F);
      ReadLn(F, S);
      MotoTime:=strtoint(copy(S,1,Pos(' ',s)-1));  // ��������
      Edit18.Text:=InttoStrTime(MotoTime);
      ReadLn(F, S);
      Task.m_index:=strtoint(copy(S,1,Pos(' ',s)-1));  // ��������� ������
      for a:=1 to 3 do begin  // ����� �������
        for b:=1 to 3 do begin// ����� �������
          ReadLn(F, S);
          Zvanie[a][b]:=S;
          ReadLn(F, S);
          Name[a][b]:=S;
        end;
      end;
      ReadLn(F, S);
      VoenCh:=S;
      ReadLn(F, S);
      Rota:=S;
      ReadLn(F, S);
      Vzvod:=S;
      ReadLn(F, S);  // ������
      Task.m_t:=strtoint(copy(S,1,Pos(' ',s)-1));    //����������� ������
      ReadLn(F, S);
      Task.m_tv:=strtoint(copy(S,1,Pos(' ',s)-1));   //����������� �������
      ReadLn(F, S);
      Task.m_v:=strtoint(copy(S,1,Pos(' ',s)-1));    //�������� �����
      ReadLn(F, S);
      Task.m_az:=strtoint(copy(S,1,Pos(' ',s)-1));   //������ �����
      ReadLn(F, S);
      Task.m_pv:=strtoint(copy(S,1,Pos(' ',s)-1));   //��������
      ReadLn(F, S);
      Task.m_ks:=strtoint(copy(S,1,Pos(' ',s)-1));   //�����
      ReadLn(F, S);
      Task.m_inten_fog:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);    // ������ �������
      Task.Temp:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);    // ������ �������
      Task.Ceson:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);    // ������ �������
      Task.Mestn:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);    // ���������� �������
//      Aktivnost:=strtoint(copy(S,1,Pos(' ',s)-1));
    finally
    CloseFile(F);
    end;
  end;
  Label6.Caption:=TaskName;
  Edit1.Text:=Zvanie[2][2];
  Edit45.Text:=Name[2][2];

  if (Task.m_index<5000)and(Task.m_index<>2900) then Label6.Caption:=Label6.Caption+'      Variante '+inttostr(Variant);
//  if (Task.m_index<5000)and(Task.m_index<>2900) then Label24.Caption:=Label24.Caption+'      ������� '+inttostr(Variant);
  case Task.Mestn of
    RAVNINA: ;
    GORA:;
    BOLOTO:;
    PUSTYN:;
    else begin
      Task.Temp:=DAY;
      Task.Ceson:=SUMMER;
      Task.Mestn:=RAVNINA;
      Task.m_index:=1111;
      Label6.Caption:=Label6.Caption+'      Variante '+inttostr(Variant);
    end;
  end;
  Set_Day(Task.Temp);
  Set_Ceson(Task.Ceson);
  Set_Mestn(Task.Mestn);
end;


procedure TForm1.SaveMoto;
var  F: TextFile;
     S: String;
     a,b: word;
begin
  S:=dirBase+'res/Konkurs.ini';//
  FileSetAttr(S,$00000);
  AssignFile(F,S);  {���������� ����� � ������}
  Rewrite(F);
  S:=IntToStr(MotoTime)+' ';  // ���������
  writeLn(F,S);
  S:=IntToStr(Task.m_index)+' ';  // ��������� ������
  writeLn(F,S);
  for a:=1 to 3 do begin
    for b:=1 to 3 do begin
      S:=Zvanie[a][b];
      writeLn(F,S);
      S:=Name[a][b];  // ��������� ������
      writeLn(F,S);
    end;
  end;
  S:=VoenCh;
  writeLn(F,S);
  S:=Rota;
  writeLn(F,S);
  S:=Vzvod;
  writeLn(F,S);
  S:=IntToStr(Task.m_t)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_tv)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_v)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_az)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_pv)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_ks)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.m_inten_fog)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.Temp)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.Ceson)+' ';
  writeLn(F,S);
  S:=IntToStr(Task.Mestn)+' ';
  writeLn(F,S);
  S:=IntToStr(Aktivnost)+' '; // ���������� �������
  writeLn(F,S);
  CloseFile(F);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var a,c,b: word;
begin
  if Begin_upr then begin
    inc(Time_upr);
    if Task.m_index <5000 then Move_Michen_Sek
                          else CountParamModel_Sek;
    if Time_Sek then begin/// ���������� ����� � ���/���
      Edit22.Text:=inttostr(Time_upr)+' sec';
    end
    else begin
      Edit22.Text:=inttostr(Time_upr div 60)+' min'+inttostr(Time_upr mod 60)+' sec';
    end;
    if (Time_Upr>Task.Tstr)and(Time_Upr<=Task.Tstr+2) then begin
      KommandTr[1]:=ZADACHA;
      KommandTr[2]:=ZAD_END_UPR;
      LVS.Trans_kom;
      // �������� ��� ������
      for a:=1 to Task.Col_targ do begin
        for c:=1 to 3 do  DeMont_Target[c,a]:=true;
      end;
      for a:=1 to TaskRec_TAK.Col_targ do DeMont_Target_TAK[a]:=true;
      for a:=1 to Col_Model do  Model[a].Typ:=0;
      if (Task.m_index <5000)and signal then for a:=1 to 3 do Formir_Oc(a);
      signal:=false;
    end;
    if Time_Upr>Task.Tstr+2 then begin
      Begin_upr:=false;
      Timer2.Enabled:=false;
      Edit22.Text:='';
      Isx_pol;
      KommandTr[1]:=ZADACHA;
      KommandTr[2]:=ZAD_ISX_POL;
      LVS.Trans_kom;
    end;
  end;
end;

// ������� ���������� ������
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
//  Aktivnost:=ComboBox1.ItemIndex;
end;

procedure TForm1.Set_directris;
var a: word;
begin
  stop_prog:=true;
  inc(Task.NumKvit);                   // ����� ���������
  if Task.NumKvit>252 then Task.NumKvit:=1;
  ReBuild_All;
  Count_Orientir;
  Isx_pol;
  Isx_Ocenka;
  for a:=1 to 3 do begin
    Boek[a].Col_Upr:=Task.Bk.Col_Upr;
    OtobrPanel(a);
  end;
  LVS.Trans_Isx_pol;                    // ��������� �������� ���������
  stop_prog:=false;
end;

procedure TForm1.Creat_Lamp;
var a: word;
begin
  for a:=1 to 4 do begin
    Perekl[a]:=TBitmap.Create;
    Perekl[a].LoadFromFile(DirBase+'bmp\Interf\Perekl_'+inttostr(a)+'.bmp');
  end;
  Lamp_Red_On:=TBitmap.Create;
  Lamp_Red_On.LoadFromFile(DirBase+'bmp\Interf\Lamp_red.bmp');
  Lamp_Red_Off:=TBitmap.Create;
  Lamp_Red_Off.LoadFromFile(DirBase+'bmp\Interf\Lamp_Off.bmp');
  Lamp_Green_On:=TBitmap.Create;
  Lamp_Green_On.LoadFromFile(DirBase+'bmp\Interf\Lamp_Gre.bmp');

  Knopka_red_off:=TBitmap.Create;
  Knopka_red_off.LoadFromFile(DirBase+'bmp\Interf\Kn_Off_R.bmp');
  Knopka_red_on:=TBitmap.Create;
  Knopka_red_on.LoadFromFile(DirBase+'bmp\Interf\Kn_On_R.bmp');
  Knopka_green_off:=TBitmap.Create;
  Knopka_green_off.LoadFromFile(DirBase+'bmp\Interf\Kn_Off_G.bmp');
  Knopka_green_on:=TBitmap.Create;
  Knopka_green_on.LoadFromFile(DirBase+'bmp\Interf\Kn_On_G.bmp');
  Knopka_braun_off:=TBitmap.Create;
  Knopka_braun_off.LoadFromFile(DirBase+'bmp\Interf\Kn_Off.bmp');
  Knopka_braun_on:=TBitmap.Create;
  Knopka_braun_on.LoadFromFile(DirBase+'bmp\Interf\Kn_On.bmp');
end;


(********* ����� ������*********)
procedure TForm1.Image13MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image13.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image13MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetTaskIsxPol;
  Image13.Canvas.Draw(0,0,Knopka_braun_off);
  Application.CreateForm(TOKBottomDlg1, OKBottomDlg1);
  if OKBottomDlg1.ShowModal=mrOk then begin
    if OKBottomDlg1.TreeView1.Selected<>nil then
    if OKBottomDlg1.TreeView1.Selected.SelectedIndex>1000 then begin
      Task.m_index:=OKBottomDlg1.TreeView1.Selected.SelectedIndex;
      Variant:=Task.m_index mod 100;
      Load_Task(false);
      label6.Caption:=TaskName;
      if Task.m_index<6000 then label6.Caption:=label6.Caption+'      Variante '+inttostr(Variant);
      if (Task.m_index>5000) and (Task.m_index<6000) then Set_Mestn(RAVNINA);
    end;
    buttonRassylkaTask:=false;
  end;
  OKBottomDlg1.Free;
end;

procedure TForm1.Image16MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image16.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image16MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
s: string;
begin
  SetTaskIsxPol;
  Image16.Canvas.Draw(0,0,Knopka_braun_off);
  if (Task.m_index>3000) and( Task.m_index <4000) then exit;
  if Task.m_index <5000 then begin
    Application.CreateForm(TOKBottomDlg4, OKBottomDlg4);
    OKBottomDlg4.Edit_Task:=@Task;
    OKBottomDlg4.Orient:=@Task.Orient;
    OKBottomDlg4.Init;
    s:='';
    if Task.m_index<2000 then begin
      if Task.Mestn=RAVNINA then s:='  terrain accidente,'
                            else s:='  pais montagneux,';
      if Task.Temp=DAY then s:=s+' le jour.'
                       else s:=s+' la nuit.';
    end;
    s:=s+' Variante '+inttostr(Variant);
    OKBottomDlg4.Caption:='Redacteur des exercices.'+'  '+TaskName+s;
    OKBottomDlg4.ShowModal;
    Load_Task(false);
    OKBottomDlg4.Free;
  end
  else begin
    if Task.m_index <6000 then begin
      Application.CreateForm(TEdit_Tak, Edit_Tak);
      Edit_Tak.TaskRec_TAK:=@TaskRec_TAK;
      Edit_Tak.Orient:=@Task.Orient;
      Edit_Tak.Init;
      Edit_Tak.ShowModal;
      Load_Task(false);
      Edit_Tak.Free;
    end;
  end;
  buttonRassylkaTask:=false;
end;

(*********** ����� �������**************)
procedure TForm1.Image14MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image14.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image14MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image14.Canvas.Draw(0,0,Knopka_braun_off);
  Application.CreateForm(TOKBottomDlg3, OKBottomDlg3);
//  OKBottomDlg3.Edit7.Text:=Name[2][1];
  OKBottomDlg3.Edit5.Text:=Name[2][2];
//  OKBottomDlg3.Edit9.Text:=Name[2][3];
//  OKBottomDlg3.ComboBox4.Text:=Zvanie[2][1];
  OKBottomDlg3.ComboBox2.Text:=Zvanie[2][2];
//  OKBottomDlg3.ComboBox6.Text:=Zvanie[2][3];
  OKBottomDlg3.Edit1.Text:=VoenCh;
  OkBottomDlg3.Edit2.Text:=Rota;
  OKBottomDlg3.Edit3.Text:=Vzvod;
  if OKBottomDlg3.ShowModal=mrOk then begin;
//    Name[2][1]:=OKBottomDlg3.Edit7.Text;
    Name[2][2]:=OKBottomDlg3.Edit5.Text;
//    Name[2][3]:=OKBottomDlg3.Edit9.Text;
//    Zvanie[2][1]:=OKBottomDlg3.ComboBox4.Text;
    Zvanie[2][2]:=OKBottomDlg3.ComboBox2.Text;
//    Zvanie[2][3]:=OKBottomDlg3.ComboBox6.Text;
    VoenCh:=OKBottomDlg3.Edit1.Text;
    Rota:=OKBottomDlg3.Edit2.Text;
    Vzvod:=OkBottomDlg3.Edit3.Text;
  end;
  OKBottomDlg3.Free;
  Edit1.Text:=Zvanie[2][2];
  Edit45.Text:=Name[2][2];
end;

{*******���������� ��������*******}
procedure TForm1.Image29MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image29.Canvas.Draw(0,0,Knopka_red_on);
end;

procedure TForm1.Image29MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image29.Canvas.Draw(0,0,Knopka_red_off);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  OKBottomDlg.Label1.Caption:='Le debranchement du simulateur';
  if OKBottomDlg.ShowModal=mrOk then begin
    Mode_off:=1;// ��������� ��
    KommandTr[1]:=POWER_PK;
    KommandTr[2]:=Mode_off;
    LVS.Trans_Kom;
    Potok[endO,1]:=6; inc(endO); endO:=endO and $3f;// �����
    Potok[endO,1]:=7; inc(endO); endO:=endO and $3f;// ��������
  end;
  OKBottomDlg.Free;
end;

procedure TForm1.Image30MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image30.Canvas.Draw(0,0,Knopka_red_on);
end;

procedure TForm1.Image30MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image30.Canvas.Draw(0,0,Knopka_red_off);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  OKBottomDlg.Label1.Caption:='Vous voulez recharger simulateur?';
  if OKBottomDlg.ShowModal=mrOk then begin
    Mode_off:=2;// ������������� ��
    KommandTr[1]:=POWER_PK;
    KommandTr[2]:=Mode_off;
    LVS.Trans_Kom;
    Potok[endO,1]:=6; inc(endO); endO:=endO and $3f;// �����
    Potok[endO,1]:=7; inc(endO); endO:=endO and $3f;// ��������
  end;
  OKBottomDlg.Free;
end;

(***************������****************)
procedure TForm1.Image31MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image31.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image31MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image31.Canvas.Draw(0,0,Knopka_braun_off);
  Application.CreateForm(TOKBottomDlg2, OKBottomDlg2);
  OKBottomDlg2.m_t:=Task.m_t;    //�����������
  OKBottomDlg2.m_v:=Task.m_v;    //�������� �����
  OKBottomDlg2.m_tv:=Task.m_tv;
  OKBottomDlg2.m_az:=Task.m_az;    //������ �����
  OKBottomDlg2.m_pv:=Task.m_pv;
  OKBottomDlg2.m_ks:=Task.m_ks;
  OKBottomDlg2.m_inten_fog:=Task.m_inten_fog;    // ��������� ������
  if OKBottomDlg2.ShowModal=mrOk then begin;
    Task.m_t:=OKBottomDlg2.m_t;    //�����������
    Task.m_v:=OKBottomDlg2.m_v;    //�������� �����
    Task.m_tv:=OKBottomDlg2.m_tv;
    Task.m_az:=OKBottomDlg2.m_az;    //������ �����
    Task.m_pv:=OKBottomDlg2.m_pv;
    Task.m_ks:=OKBottomDlg2.m_ks;
    Task.m_inten_fog:=OKBottomDlg2.m_inten_fog;    // ��������� ������
    Count_pogoda;
    buttonRassylkaTask:=false;
  end;
  OKBottomDlg2.Free;
end;

// ���������
procedure TForm1.Image17MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image17.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image17MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image17.Canvas.Draw(0,0,Knopka_braun_off);
  if (Task.m_index<2000)or
          ((Task.m_index>4000) and (Task.m_index<5000)) then begin
    Application.CreateForm(TVedom, Vedom);
    Vedom.ShowModal;
    Vedom.Free;
  end;
  if (Task.m_index>5000) and (Task.m_index<6000)then begin
    Application.CreateForm(TFVed_Ta, FVed_Ta);
    FVed_Ta.ShowModal;
    FVed_Ta.Free;
  end;
end;

// ���� ��������
procedure TForm1.Set_Panels;
begin
  exit;
end;
// ����- ����
procedure TForm1.Image11Click(Sender: TObject);
begin
  if Task.Temp=DAY then Set_Day(NIGHT) else Set_Day(DAY);
  buttonRassylkaTask:=false;
end;

procedure TForm1.Set_Day(a: word);
begin
  Task.Temp:=a;
  if a=DAY then begin
    Image11.Canvas.Draw(0,0,Perekl[1]);
  end
  else begin
    Image11.Canvas.Draw(0,0,Perekl[4]);
  end;
  Load_Task(false);
end;

// ���� -����
procedure TForm1.Image10Click(Sender: TObject);
begin
  if Task.Ceson=SUMMER then Set_Ceson(WINTER) else Set_Ceson(SUMMER);
  buttonRassylkaTask:=false;
end;

procedure TForm1.Set_Ceson(a: word);
begin
  Task.Ceson:=a;
  if a=SUMMER then begin
    Image10.Canvas.Draw(0,0,Perekl[1]);
    if Task.m_tv<0 then Task.m_tv:=15;
  end
  else begin
    Image10.Canvas.Draw(0,0,Perekl[4]);
    if Task.m_tv>0 then Task.m_tv:=-10;
  end;
end;

// ���������
procedure TForm1.Image15Click(Sender: TObject);
begin
  case Task.Mestn of
    RAVNINA:Set_Mestn(PUSTYN);
    PUSTYN:Set_Mestn(GORA);
    GORA:Set_Mestn(RAVNINA);
    else Set_Mestn(RAVNINA);
  end;
  buttonRassylkaTask:=false;
end;

procedure TForm1.Set_Mestn(a: word);
begin
  if (Task.m_index>5000) and (Task.m_index<6000) then   Task.Mestn:=RAVNINA
                                                 else  Task.Mestn:=a;
  case Task.Mestn of
    RAVNINA:begin
      Image15.Canvas.Draw(0,0,Perekl[1]);
    end;
    PUSTYN:begin
      Image15.Canvas.Draw(0,0,Perekl[2]);
    end;
    GORA:begin
      Image15.Canvas.Draw(0,0,Perekl[3]);
    end;
  end;
  SetDimensionDirectris(Task.Ceson,Task.Mestn);
  Load_Task(false);
end;

// ����������� �� ����������
procedure TForm1.Image33MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//  Image33.Canvas.Draw(0,0,Knopka_green_on);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Start_Secound:= true;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Start_Secound:=false;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Time_Secound:=0;
  Edit4.Text:=inttostr(Time_Secound div 60)+' min'+inttostr(Time_Secound mod 60)+' sec';
end;

procedure TForm1.Image44MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image44.Canvas.Draw(0,0,Knopka_Green_on);
end;

procedure TForm1.Image44MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a: word;
begin
  Image44.Canvas.Draw(0,0,Knopka_Green_off);
  if not buttonRassylkaTask then begin
    panel23.Visible:=true;
    panel23.Refresh;
    Label21.Refresh;
    Screen.Cursor:=crHourGlass;
    Set_Directris;
    Screen.Cursor:=crDefault;
    buttonRassylkaTask:=true;
    panel23.Visible:=false;
    exit;
  end;
  if TaskName<>'' then begin
    KommandTr[1]:=ZADACHA;
    if not signal then begin
      label104.Caption:='Commencer';
      Panel19.Color:=$00ADD3CA;
      signal:=true;
      Time_Upr:=0;
      Isx_Ocenka;
      KommandTr[2]:=ZAD_SIGNAL;
      for a:=1 to 3 do begin
        Boek[a].Col_Upr:=Task.Bk.Col_Upr;
        OtobrPanel(a);
      end;
    end
    else begin
      if not Begin_upr then begin
        label104.Caption:='Finir';
        Panel19.Color:=$0082FE70;
        KommandTr[2]:=ZAD_BEGIN_UPR;
        Begin_upr:=true;
        Timer2.Enabled:=true;
      end
      else begin
        SetTaskIsxPol;
      end;
    end;
    LVS.Trans_Kom;
  end;

end;

procedure TForm1.Image12MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image12.Canvas.Draw(0,0,Knopka_green_on);
end;

procedure TForm1.Image12MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image12.Canvas.Draw(0,0,Knopka_green_off);
  TransmitionViewer(RM_RUKOVOD);
end;

procedure TForm1.Image35MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image35.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image35MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image35.Canvas.Draw(0,0,Knopka_braun_off);
  TransmitionViewer(RM_NAVOD_PTU);
end;

procedure TForm1.TransmitionViewer(n:word);
begin
  KommandTr[1]:=VIEWER_MODE;
  KommandTr[2]:=n;
  LVS.Trans_Kom;
end;

procedure TForm1.SetTaskIsxPol;
begin
  Begin_upr:=false;
  label104.Caption:='Signal';
  Panel19.Color:=$008BB0FE;
  Timer2.Enabled:=false;
  KommandTr[2]:=ZAD_ISX_POL;
  Edit22.Text:='';
  Isx_pol;
end;


procedure TForm1.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image9.Canvas.Draw(0,0,Knopka_braun_on);
end;

procedure TForm1.Image9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image9.Canvas.Draw(0,0,Knopka_braun_off);
  Otkaz.ShowModal;
end;

end.
