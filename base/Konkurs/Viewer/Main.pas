Unit Main;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls,
  Forms, Dialogs, UnOther,
  StdCtrls, MMSystem, UnBVT,
  ExtCtrls, UnBuildSetka,
  Unit1,dglOpenGL, NMUDP,
  ComCtrls,UnDrawEffect;

type
  TForm1 = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Timer1: TTimer;
    Panel4: TPanel;                         //������ ��������
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure GetDisplay;
    procedure idle_TKN(Sender: TObject; var done:boolean);
    procedure ReBuild_All;
    procedure RebootSystem;
  public
    procedure IsxPol;
  end;

  Tdisplay=record
    width: integer;
    height: integer;
  end;

var
  Form1       : TForm1;
  DC          : HDC;      // ���������� ������
  hrc         : HGLRC;   // ��������
  TimerId     : uint;  // ������������� �������
  posX        : real;
  posY        : real;
  posH        : real;
  posHvis     : real=0.2;
  anglX       : real;
  anglY       : real;
  anglH       : real;
  kratn       : real=1;
  angleVisual : real=15;
  stopProg    : boolean;
  ValTemp     : real;
  dAnglVis    : real;
  NumScene    : word=2;
  display     : Tdisplay;
  rot_Monitor : boolean;
  zerkalo_Monitor : boolean;
  zerkalo_Monitor_Vert  : boolean;
  sdvigX      : integer;
  sdvigY      : integer;


implementation

uses
  UnBuild,UnDraw,
  UnBuildSetting,
  UnReadIni, UnLVS;

{$R *.DFM}

procedure TimeProc(uTimerID, uMessage: UINT;dwUser, dw1, dw2: DWORD) stdcall;
begin
  With Form1 do begin
    if stopProg then exit;
    InvalidateRect(Handle, nil, False);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  stopProg  :=  true;
  // ���������� ����������� Base
  if FileExists('\Base\Base.shp') then dirBase:='\Base\' else dirBase:='..\';
  SetCursorPos(1048,0);
  GetDisplay;
  LoadIniTables;
   // ��������� �� ���������
  SettingTaskDefault;
  StartOpenGL;
  IsxPol;
  FormResize(nil);
  application.onidle:=idle_TKN;       {����������, ���������� � ����}//>>>>>>>>>
  TimerID         :=  timeSetEvent (55, 0, @TimeProc, 0, TIME_PERIODIC);
  Panel4.Visible  :=  false;      //������ � ����������� ������ ��������
  posX  :=  37.3;
  posY  :=  4.5;
  posH  :=  posHvis+CountHeight(posX, posY);
  stopProg  :=  false;
//  InitModels;
end;

procedure TForm1.WMPaint(var Msg: TWMPaint);
var
  ps : TPaintStruct;
begin
  BeginPaint(Form1.Handle, ps);
  case otobr_RM of
    RM_RUKOVOD:  DrawScene(anglX, anglH, anglY, posX, posH, posY, 1);
    RM_NAVOD_PTU: DrawScene(BMP[Num_BMP].UmBase+BMP[Num_BMP].UmPricel,
                            BMP[Num_BMP].AzBase+BMP[Num_BMP].AzPricel,
                            BMP[Num_BMP].Tangage,
                            BMP[Num_BMP].Xtek,
                            BMP[Num_BMP].Htek+0.1,
                            BMP[Num_BMP].Ytek, 1);
  end;
  SwapBuffers(DC);
  EndPaint(Form1.Handle, ps);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  StopOpenGL;
  RebootSystem;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  clientWH:   real;
  begX:    integer;
  begY:    integer;
  endX:    integer;
  endY:    integer;
begin
  // ��������� ���� ������
  case otobr_RM of
    RM_RUKOVOD:  AngleVisual:=20+dAnglVis;
//    RM_KOMAND_TKN: AngleVisual:=13;
//    RM_KOMAND_PZ:if BMP[Num_BMP].X4 then AngleVisual:=13 else AngleVisual:=30;
//    RM_NAVOD_BPK,RM_NAVOD_PNV: AngleVisual:=11;
    RM_NAVOD_PTU: AngleVisual:=6.7;
//    RM_MEXAN: if BMP[Num_BMP].PNV_MV then AngleVisual:=20 else AngleVisual:=28;
  end;
  case NumScene of
    0,1:begin
      begX:=0;
      endX:=1024;
      begY:=170;
      endY:=768;
    end;
    2: begin
      case real_RM of
        RM_RUKOVOD: begin
          case otobr_RM of
            RM_RUKOVOD: begin
              Panel1.Visible:=false;
              Panel2.Visible:=false;
              if display.height=1280 then begin
                begX:=0;
                endX:=1280;
                begY:=0;
                endY:=1024;
              end
              else begin
                begX:=0;
                endX:=1024;
                begY:=0;
                endY:=768;
              end;
//          Osveshenie(false,false);
            end;
            RM_KOMAND_TKN, RM_KOMAND_PZ, RM_NAVOD_BPK, RM_NAVOD_PTU: begin
              begX:=128;
              endX:=768;
              begY:=0;
              endY:=768;
              Panel1.Visible:=true;
              Panel2.Visible:=true;
              Panel1.Width:=128;
              Panel2.Width:=128;
            end;
          end;
        end;
        RM_KOMAND_TKN, RM_KOMAND_PZ, RM_NAVOD_BPK, RM_NAVOD_PTU, RM_NAVOD_PNV: begin
          if rot_Monitor then begin
            begX:=0+sdvigX;
            endX:=768;
            begY:=128+sdvigY;
            endY:=768;
            Panel1.Visible:=true;
            Panel2.Visible:=true;
            Panel1.Align:=alNone;
            Panel2.Align:=alNone;
            Panel1.Height:=128-sdvigY;
            Panel2.Height:=128+sdvigY;
            Panel1.Width:=768;
            Panel2.Width:=768;
            Panel1.Left:=0;
            Panel2.Left:=0;
            Panel1.Top:=0;
            Panel2.Top:=896-sdvigY;
          end
          else  begin
            begX:=128+sdvigX;
            endX:=768;
            begY:=0+sdvigY;;
            endY:=768;
            Panel1.Visible:=true;
            Panel2.Visible:=true;
            Panel1.Width:=128+sdvigX;
            Panel2.Width:=128-sdvigX;
          end;
//        Osveshenie(BMP[Num_BMP].PNV_kom,BMP[Num_BMP].Aktiv_PNV_kom);
        end;
        RM_MEXAN: begin
          glViewport(0, 0, 1024, 768);
          glMatrixMode (GL_PROJECTION);
          glLoadIdentity;
          gluPerspective(20, 1024/768, 0.049, 1000.0);
          Panel1.Visible:=false;
          Panel2.Visible:=false;
//               Osveshenie(BMP[Num_BMP].PNV_mv,BMP[Num_BMP].Fara_mv_n);
        end;
      end;
    end;
  end;

  SettingDayLight(task.temp, false, false,task.m_inten_fog);
  clientWH:=(endX)/(endY);
  // ����� ��������� ���������
  SettingViewport(angleVisual, clientWH, begX, endX, begY, endY);
  // ���������� ��������
  if zerkalo_Monitor then begin
    glScalef(-1,1,1);
    glFrontFace(GL_CW);
  end;
  // ���������� �������� ������� ��� X
  if zerkalo_Monitor_Vert then begin
    glScalef(1,-1,1);
    glFrontFace(GL_CW);
  end;
  BVT.SetViewAngl(angleVisual*0.75);
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
  case key of
    VK_ESCAPE : close;           //����� �� ���������
    83        : posX    :=  posX-0.3;
    65        : posX    :=  posX+0.3;
    90        : posY    :=  posY-0.3;
    87        : posY    :=  posY+0.3;
    38        : anglX   :=  anglX+1;
    40        : anglX   :=  anglX-1;
    37        : anglH   :=  anglH+1;
    39        : anglH   :=  anglH-1;
    107       : posHvis :=  posHvis+0.1;
    109       : posHvis :=  posHvis-0.1;
    VK_F1: begin
      otobr_RM:=RM_NAVOD_PTU;   // ��������� �� ��������� ���� F1
      FormResize(nil);
    end;
    VK_F2: begin
      otobr_RM:=RM_NAVOD_PTU;
      FormResize(nil);
    end;
    VK_F3: begin
      otobr_RM:=RM_NAVOD_PTU;
      FormResize(nil);
    end;
    VK_F4: begin
      otobr_RM:=RM_NAVOD_PTU;
      FormResize(nil);
    end;
    VK_F5: begin
      otobr_RM:=RM_RUKOVOD;
      FormResize(nil);
    end;
    VK_F6: begin
      aaaaa:=aaaaa+0.1;
      label1.Caption := floattostr(aaaaa);
    end;
    VK_F7: begin
      aaaaa:=aaaaa-0.1;
      label1.Caption := floattostr(aaaaa);
    end;

//    VK_F2: glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
//    VK_F3: glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
//    VK_F4: okopDraw:=not okopDraw;
    VK_F8: begin
      ValTemp:=ValTemp+0.001;
      label1.Caption := floattostr(ValTemp);
    end;
    VK_F9: begin
      ValTemp:=ValTemp-0.001;
      label1.Caption := floattostr(ValTemp);
    end;
    VK_F10  : InitModels;

  end;
  if anglH>=360 then anglH:=anglH-360
                else if anglH<0 then anglH:=anglH+360;
  posH:=posHvis+CountHeight(posX, posY);
//  label1.Caption := floattostr(angly);
end;

procedure TForm1.Label1Click(Sender: TObject);
var t: longint;
a: word;
begin
// �������� �������� �����
  StopProg:=true;
  t:= GetTickCount;
  for a:=1 to 50 do begin
    DrawScene(anglX, anglH, anglY, posX, posH, posY,1);
  end;
  label1.Caption := inttostr(GetTickCount-t);
  StopProg:=false;
end;

procedure TForm1.IsxPol;
begin
  anglX:=0;
  anglY:=0;
  anglH:=0;
  Isx_Pol_GM;
  posH:=posHvis+CountHeight(posX, posY);
  Count_pogoda;
end;

procedure TForm1.GetDisplay;
var
  hDCScreen: HDC;
begin
  hDCScreen := GetDC(0);
  display.height:=GetDeviceCaps(hDCScreen, HORZRES);
  display.width:= GetDeviceCaps(hDCScreen, VERTRES);
  ReleaseDC(0, hDCScreen);
end;

{********������� ������������ �������********}
procedure TForm1.idle_TKN(Sender: TObject; var done:boolean);// >>>>>>>>>>
begin                                           {���� ��� ����� �}
  while begO<>endO do begin   {���� �� �������� �������}
    case potok[begO,1] of
      5: ReBuild_All;
      7: Close;
    end;
    inc(begO); begO:=begO and $3f;
  end;
  done:=True;
end;

procedure TForm1.ReBuild_All;
begin
  panel4.Visible:=true;
  panel4.Refresh;
  stopProg:=true;
  StopOpenGL;
  StartOpenGL;
  IsxPol;
  FormResize(nil);
  stopProg:=false;
  panel4.Visible:=false;
  panel4.Refresh;
end;

procedure TForm1.RebootSystem;
var
  hToken: THandle;
  tkp: TTokenPrivileges;
  ReturnLength: Cardinal;
begin
  if Mode_off=2 then begin
   if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then begin
     LookupPrivilegeValue(nil, 'SeShutdownPrivilege',tkp.Privileges[0].Luid);
     tkp.PrivilegeCount:=1; // one privelege to set
     tkp.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
     if AdjustTokenPrivileges(hToken, False, tkp, 0, nil, ReturnLength)then
     ExitWindowsEx(EWX_REBOOT, 0);
   end;
  end
  else if Mode_off=1 then begin
    if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then  begin
      LookupPrivilegeValue(nil, 'SeShutdownPrivilege',tkp.Privileges[0].Luid);
      tkp.PrivilegeCount:=1; // one privelege to set
      tkp.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
      if AdjustTokenPrivileges(hToken, False, tkp, 0, nil, ReturnLength)then
      ExitWindowsEx(EWX_SHUTDOWN, 0);
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if stopProg then exit;
  KommandTr[1]:=SINCHRO+Real_RM;
  KommandTr[2]:=Task.NumKvit;
  LVS.Send_IPX(LVS_KOMAND);
end;


end.
