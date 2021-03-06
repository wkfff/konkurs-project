unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Math, ComCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure RebootSystem;
  protected
    procedure idle_TKN(Sender: TObject; var done:boolean);
  public
    procedure Read_ini;
    procedure Isx_pol;
    procedure ReBuild_All;
    procedure Isx_Pol_Target;
end;

  var
   Form1: TForm1;
   DC: HDC;
   hrc: HGLRC;
   TimerId : uint;                  // ������������� �������
   Tik_Tim1: integer;
   Razm_pric: real;
   Demonstr: boolean;//=true ;
   time_adapter: boolean;
   potok: array[0..64,1..6] of integer;    {������ ��� ���������� � �������}
   begO,endO: word;                           { �������� ��� ������������}
   stop_prog: boolean;
   Missile_Mode_old:word;

implementation

uses  MMSystem, UnBuildServer, UnOrgan, UnOther, UnLVS, UnGeom,
  UnMissile, UnBuildKoordObject,  UnPanel, UnReadIni, Unsound;

{$R *.DFM}

(*********** ��������� ������**********)
procedure TimeProc(uTimerID, uMessage: UINT;dwUser, dw1, dw2: DWORD) stdcall;
begin
  With Form1 do begin
    if stop_prog then exit;
    // ������ ��������� ����
    MoveMemory(@BuffTr[endO],@BMP[Num_BMP], LVS_SERVER_PTUR);
    Potok[endO,1]:=1; Potok[endO,2]:=1;
    inc(endO); endO:=endO and $3f;
    // ���������� � ������� ��������� ��������� ������
    Potok[endO,1]:=3; inc(endO); endO:=endO and $3f;
    label4.Caption:=floattostr(BMP[Num_BMP].UmPricel);
  end;
end;

{*********�������� �����********}
procedure TForm1.FormCreate(Sender: TObject);
begin
  stop_prog:=true; // ������ ���� �������
  SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS); //������� ������� ������������
  // ���������� ������� �����������
  if FileExists('\Base\Base.shp') then dirBase:='\Base\' else dirBase:='..\';
  IspravnostBMP;
  LoadIniTables;
  SettingTaskDefault;;        // �������� ��� ������
  Init_var;            // ������������� ���������� ����������
  InitSetka;
  SetBoxTank;
  application.onidle:=idle_TKN;       {����������, ���������� � ����}
  Read_ini;
  TimerID := timeSetEvent (55, 0, @TimeProc, 0, TIME_PERIODIC); //������������� ������
  Isx_pol;
  Load_Quadr_Task;// ��������� � ������� ��� ���������
  Init_Org;
  stop_prog:=false;
//  label5.Caption:=inttostr(sizeOf(BMP[1]));
  Form1.SendToBack;
end;

procedure TForm1.Read_ini;
var  F: TextFile;
     S: String;
begin
  S:='Konk.ini';//
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  try
    AssignFile(F,S);  {���������� ����� � ������}
    Reset(F);
    ReadLn(F, S);
    UM_PU:=strtoint(copy(S,1,Pos(' ',s)-1));  //
    ReadLn(F, S);
    H_PRICEL:=strtofloat(copy(S,1,Pos(' ',s)-1))/10;
    ReadLn(F, S);
    KOEFF_NAVED_UM:=strtofloat(copy(S,1,Pos(' ',s)-1));
  finally
    CloseFile(F);
  end;
end;


{************* � � � � � ***************}
{*************������� �������*****************}
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
          if stop_prog then Close;
          stop_prog:=true;
        end;
    111: BMP[Num_BMP].UmPricel:=BMP[Num_BMP].UmPricel-0.01;
    12: BMP[Num_BMP].UmPricel:=BMP[Num_BMP].UmPricel+0.01;

    37: BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel-0.41;
    39: BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel+0.41;

    35: BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel-0.01;
    34: BMP[Num_BMP].AzPricel:=BMP[Num_BMP].AzPricel+0.01;

    107: begin
         Razm_pric:=Razm_pric+0.001;
//         label2.Caption:=floattostr(Razm_pric);

         end;
    109: begin
         Razm_pric:=Razm_pric-0.001;
//         label2.Caption:=floattostr(Razm_pric);
         end;
    VK_F1:begin
      Form3.Visible:=not Form3.Visible;

    end;
    VK_F5: BMP[Num_BMP].Filtr:=not BMP[Num_BMP].Filtr;
    VK_F10: begin
      isx_pol;
      Vostan_BK;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if stop_prog then exit;
//  Form1.SetFocus;
  inc(Tik_Tim1);
  Obrabotka_Org_Sek;
  KommandTr[1]:=SINCHRO+Real_RM;
  KommandTr[2]:=Task.NumKvit;
  LVS.Send_IPX(LVS_KOMAND, endO);
end;

{********������� ������������ �������********}
procedure TForm1.idle_TKN(Sender: TObject; var done:boolean);
begin                                           {���� ��� ����� �}
  done:=false;
  while begO<>endO do begin   {���� �� �������� �������}
    case potok[begO,1] of
      1: LVS.Send_IPX(potok[begO,2],begO);
      2: LVS.Obrabotka_Komand;
      3: Count_scene;
      5: ReBuild_All;
    end;
    inc(begO); begO:=begO and $3f;
  end;
  done:=True;
end;

{************����� ������ ***********}
procedure TForm1.FormDestroy(Sender: TObject);
begin
  timeKillEvent(TimerID);
  Missile.Destruct;
  RebootSystem;
end;

{***********����� �����************}
procedure TForm1.Isx_pol;
begin
  dAngle:=0;
  Isx_Pol_GM;
  Isx_Pol_Scene;
  Isx_Pol_Target;
  Isx_Pol_Org;
  Vostan_BK;
end;

//��������� ����������� WINDOWS �� �����-���������
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

procedure TForm1.ReBuild_All;
begin
   stop_prog:=true;
   IspravnostBMP;
   FreeSetka;
   InitSetka;
   Vostan_BK;
   Isx_pol;
   Count_pogoda;
   Load_Quadr_Task;// ��������� � ������� ��� ���������
   stop_prog:=false;
end;

procedure TForm1.Isx_Pol_Target;
var
  a: word;
begin
  for a:=1 to COL_MAX_MICH do begin
    Poraj[Num_BMP,a]:=false;
  end;
  if Missile<>nil then EndMissile;
  BMP[Num_BMP].Start_PTUR:=false;
  BMP[Num_BMP].podryvPTUR:=PODRYV_PTUR_TERRAN;

end;

end.


