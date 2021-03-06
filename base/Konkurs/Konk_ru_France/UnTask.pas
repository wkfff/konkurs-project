unit UnTask;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
    ExtCtrls, StdCtrls, ComCtrls, UnGeom, UnOther, UnBuildSetka,
    main, UnBuildKoordObject, UnModel, UnEdit;

type
  // ��������
  TTargetR=record                       // �������� ������
    Xtek:array[1..3,0..COL_MAX_POINTS] of real;      // ���������� ������� �����
    Ytek:array[1..3,0..COL_MAX_POINTS] of real;
    Htek:array[1..3,0..COL_MAX_POINTS] of real;      //
    Htek_const:array[1..3,0..COL_MAX_POINTS] of real;      //
    Skor:array[0..COL_MAX_POINTS] of real;       // C������� �������� �� ��������
    Vxtek:array[0..COL_MAX_POINTS] of real;
    Vytek:array[0..COL_MAX_POINTS] of real;
    Vhtek:array[0..COL_MAX_POINTS] of  real;      // ��� ��������� �����
    Time_stop:array[0..COL_MAX_POINTS] of  integer;   //����� ��������� � �����
    Time_mov:array[0..COL_MAX_POINTS] of  integer;   //����� �������� �� ��������� �����
    PointTek: word;
  end;
    ///��������� ��� ����������, ����������� ��� ��������
  TOriRec=record
    Col_orient: byte;
    Typ_orient:array[1..MAX_COL_ORIENT] of byte;
    Xorient:array[1..MAX_COL_ORIENT] of word;      // ���������� ������� �����
    Yorient:array[1..MAX_COL_ORIENT] of word;
  end;

  TTaskRec_TAK=record                         // ��������� �����
    m_t: integer;           //����������� ������  4
    m_tv: integer;          //����������� ������� 4
    m_v: word;           //�������� ����� 4
    m_az: word;          //������ �����    4
    m_pv: word;          //�������� �������
    m_ks: word;          //����� ������ ������
    m_inten_fog: word;      // ��������� ������
    Tstr: word;             // ����� �� ��������
    Col_targ: word;         // ���������� �������
    Bk: TBk;                // �����������
    Temp: byte;             //����� �����      4
    Ceson: byte;            //����� ����        4
    Mestn: byte;            //���������          4
    NumKvit:byte;           // ����� ���������
    m_fog: boolean;         // ��������� ������
    OriRec: TOriRec;
    TarRec: array[1..COL_MAX_MICH_TAK] of TTarRec_TAK;   // �������� �������
    m_index: word;          //������ ������
    Rez1: word;          //������ ������
    Rez2: word;          //������ ������
    Rez3: word;          //������ ������
    Rez4: word;          //������ ������
    Rez5: word;          //������ ������
    Rez6: word;          //������ ������
  end;
    // �������
  TTargetR_TAK=record                       // �������� ������
    Xtek:array[0..COL_MAX_POINTS_TAK] of real;      // ���������� ������� �����
    Ytek:array[0..COL_MAX_POINTS_TAK] of real;
    Htek:array[0..COL_MAX_POINTS_TAK] of real;
    Tstop:array[0..COL_MAX_POINTS_TAK] of word;        // ����� ��������� � �����
    Skor:array[0..COL_MAX_POINTS_TAK] of real;      // C������� �������� �� ��������
    Visible:array[0..COL_MAX_POINTS_TAK] of boolean;   // ��������� �� �������
    Vxtek:array[0..COL_MAX_POINTS] of real;
    Vytek:array[0..COL_MAX_POINTS] of real;
    Vhtek:array[0..COL_MAX_POINTS] of  real;         // ��� ��������� �����
    Time_stop:array[0..COL_MAX_POINTS] of  integer;  //����� ��������� � �����
    Time_mov:array[0..COL_MAX_POINTS] of  integer;   //����� �������� �� ��������� �����
    PointTek: word;
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
  end;
  // ������ ��� �������� ��������
  TTarRec_TAK_real=record                       // �������� ������
    Xtek:array[0..COL_MAX_POINTS_TAK] of real;      // ���������� ������� �����
    Ytek:array[0..COL_MAX_POINTS_TAK] of real;
    Htek:array[0..COL_MAX_POINTS_TAK] of real;
    Tstop:array[0..COL_MAX_POINTS_TAK] of word;        // ����� ��������� � �����
    Skor:array[0..COL_MAX_POINTS_TAK] of real;      // C������� �������� �� ��������
    Visible:array[0..COL_MAX_POINTS_TAK] of boolean;   // ��������� �� �������
    Vxtek:array[0..COL_MAX_POINTS] of real;
    Vytek:array[0..COL_MAX_POINTS] of real;
    Vhtek:array[0..COL_MAX_POINTS] of  real;         // ��� ��������� �����
    Time_stop:array[0..COL_MAX_POINTS] of  integer;  //����� ��������� � �����
    Time_mov:array[0..COL_MAX_POINTS] of  integer;   //����� �������� �� ��������� �����
    PointTek: word;
    Htek_const:array[0..COL_MAX_POINTS_TAK] of real;
  end;

    procedure Isx_Pol_Target;
    procedure Move_Michen_Sek;
    procedure Move_Michen_Tik;
    function Count_dX(n: integer): integer;
    procedure Count_Target;
    procedure LoadTarget(Num,Np: integer);
    procedure Load_Task(stan: boolean);
    procedure Save_Task;

var
  // ��������� ��� ������� �������� ��������� �������
  TargetR: array[1..COL_MAX_MICH]of TTargetR;// ��������
  TaskRec_TAK:  TTaskRec_TAK;// ��������
  Poraj_TAK,Mont_Target_TAK,DeMont_Target_TAK: array[1..COL_MAX_MICH_TAK] of boolean;
  TargetR_TAK: array[1..COL_MAX_MICH_TAK]of TTarRec_TAK_real;
  dH_target:real;
   Angle_Paden: array[1..3,1..COL_MAX_MICH] of real;
   Angle_Paden_Tak: array[1..COL_MAX_MICH_TAK] of real;


implementation

procedure Isx_Pol_Target;
var
  a: word;
  b: word;
begin
  for a:=1 to COL_EKIP do begin
    for b:=1 to COL_MAX_MICH do begin
      targets[a,b].enableTarget:=false;
      targets[a,b].otobr:=false;
      targets[a,b].fire:=false;       // ������� ���������
    end;
  end;
  for a:=1 to TaskRec_TAK.Col_targ do begin
    targetsTaktika[a].enableTarget:=false;
    targetsTaktika[a].otobr:=true;
    targetsTaktika[a].fire:=false;       // ������� ���������
  end;
end;

procedure Move_Michen_Sek;
var a,b,c:word;
begin
    // �������� �������
    if Task.m_index <5000 then begin
      for a:=1 to Task.Col_targ do begin
        if (Task.Target[1][a].Mov) and (time_Upr>Task.Target[1][a].Tst) then begin
          if TargetR[a].Time_mov[TargetR[a].PointTek]>0 then begin
            dec(TargetR[a].Time_mov[TargetR[a].PointTek]);
            TargetR[a].Vxtek[0]:=TargetR[a].Vxtek[TargetR[a].PointTek];
            TargetR[a].Vytek[0]:=TargetR[a].Vytek[TargetR[a].PointTek];
            TargetR[a].Vhtek[0]:=TargetR[a].Vhtek[TargetR[a].PointTek];
          end
          else begin
            if TargetR[a].Time_stop[TargetR[a].PointTek]>0 then begin
              dec(TargetR[a].Time_stop[TargetR[a].PointTek]);
              TargetR[a].Vxtek[0]:=0;
              TargetR[a].Vytek[0]:=0;
              TargetR[a].Vhtek[0]:=0;
            end
            else begin
              if TargetR[a].PointTek<Task.Target[1][a].ColPoints then inc(TargetR[a].PointTek);
            end;
          end;
        end;
        //������ �������
        //������� ����� �������
        if (time_Upr>Task.Target[1][a].Tst) and (time_Upr<Task.Target[1][a].Tend)
                 and (Task.Target[1][a].Visible[TargetR[a].PointTek]) then begin
          //���� ������ �� ������� � �� ��������, �� �������
          for c:=1 to 3 do begin
            if(Angle_Paden[c,a]<360)and not Poraj[c,a]then begin
              Mont_Target[c,a]:=true;
            end;
          end;
        end;
        //   ���� ����� ����� � ������ ��� �� �����, �� ��������
        if (time_Upr>Task.Target[1][a].Tend)or(not Task.Target[1][a].Visible[TargetR[a].PointTek]) then begin
          for c:=1 to 3 do begin
            if Angle_Paden[c,a]>ANGL_PADEN then DeMont_Target[c,a]:=true;
          end;
        end;
      end;
{      for b:=1 to 3 do for a:=1 to Task.Col_targ do begin
        inc(vspy_time[b,a]);
        if (not vspy[1,b,a])and(vspy_time[b,a]>3) then begin
          vspy_time[b,a]:=0;
          vspy[1,b,a]:=true;
        end
        else if vspy[1,b,a] and(vspy_time[b,a]>2)then begin
          vspy_time[b,a]:=0;
          vspy[1,b,a]:=false;
        end;
      end;}
    end
    else begin
      for a:=1 to TaskRec_TAK.Col_targ do begin
        if (TaskRec_TAK.TarRec[a].Mov) and (time_Upr>TaskRec_TAK.TarRec[a].Tst) then begin
          if TargetR_TAK[a].Time_mov[TargetR_TAK[a].PointTek]>0 then begin
            dec(TargetR_TAK[a].Time_mov[TargetR_TAK[a].PointTek]);
            TargetR_TAK[a].Vxtek[0]:=TargetR_TAK[a].Vxtek[TargetR_TAK[a].PointTek];
            TargetR_TAK[a].Vytek[0]:=TargetR_TAK[a].Vytek[TargetR_TAK[a].PointTek];
            TargetR_TAK[a].Vhtek[0]:=TargetR_TAK[a].Vhtek[TargetR_TAK[a].PointTek];
          end
          else begin
            if TargetR_TAK[a].Time_stop[TargetR_TAK[a].PointTek]>0 then begin
              dec(TargetR_TAK[a].Time_stop[TargetR_TAK[a].PointTek]);
              TargetR_TAK[a].Vxtek[0]:=0;
              TargetR_TAK[a].Vytek[0]:=0;
              TargetR_TAK[a].Vhtek[0]:=0;
            end
            else begin
              if TargetR_TAK[a].PointTek<TaskRec_TAK.TarRec[a].ColPoints then inc(TargetR_TAK[a].PointTek);
            end;
          end;
        end;
        //������ �������
        //������� ����� �������
        if (time_Upr>TaskRec_TAK.TarRec[a].Tst) and (time_Upr<TaskRec_TAK.TarRec[a].Tend)
                         and (TaskRec_TAK.TarRec[a].Visible[TargetR_TAK[a].PointTek]) then begin
          //���� ������ �� ������� � �� ��������, �� �������
          if(Angle_Paden_TAK[a]<360)and not Poraj_TAK[a]then begin
            Mont_Target_TAK[a]:=true;
          end;
        end;
        // ���� ����� ����� � ������ ��� �� �����, �� ��������
        if (time_Upr>TaskRec_TAK.TarRec[a].Tend)or(not TaskRec_TAK.TarRec[a].Visible[TargetR_TAK[a].PointTek]) then
                                  if Angle_Paden_TAK[a]>ANGL_PADEN then DeMont_Target_TAK[a]:=true;
      end;
    end;
    if (Time_Upr>Task.Tstr)and(Time_Upr<=Task.Tstr+2) then begin
      // �������� ��� ������
      for a:=1 to Task.Col_targ do for c:=1 to 3 do  DeMont_Target[c,a]:=true;
      for a:=1 to TaskRec_TAK.Col_targ do DeMont_Target_TAK[a]:=true;
    end;
end;

procedure Move_Michen_Tik;
var a,b,n:word;
begin
  // ������
  if not Begin_upr then exit;
  if Task.m_index <5000 then begin
    for n:=1 to 3 do begin
      for a:=1 to Task.Col_targ do begin
        if Task.Target[N][a].Mov and (time_Upr>Task.Target[N][a].Tst)then begin// �������� �������
          TargetR[a].Xtek[N][0]:=TargetR[a].Xtek[N][0]+TargetR[a].Vxtek[0];
          TargetR[a].Ytek[N][0]:=TargetR[a].Ytek[N][0]+TargetR[a].Vytek[0];
          TargetR[a].Htek[n][0]:=TargetR[a].Htek_const[n][TargetR[a].PointTek]+
                 CountHeight(TargetR[a].Xtek[n][0],TargetR[a].Ytek[n][0]);
        end;
        //��������� � ������ �������
        if Mont_Target[N,a] and (Angle_Paden[N,a]<360)
                            then  Angle_Paden[N,a]:=Angle_Paden[N,a]+5
                            else Mont_Target[N,a]:=false;
        if DeMont_Target[N,a] and (Angle_Paden[N,a]>ANGL_PADEN)
                             then  Angle_Paden[N,a]:=Angle_Paden[N,a]-5
                             else DeMont_Target[N,a]:=false;
      end;
    end;
//    for a:=1 to 3 do begin
    begin
     a:=2;
      for b:=1 to COL_MAX_MICH do begin
        targets[a,b].xTek:=TargetR[b].Xtek[a][0];
        targets[a,b].yTek:=TargetR[b].Ytek[a][0];
        targets[a,b].hTek:=TargetR[b].Htek[a][0];
        targets[a,b].angleRotation:=Angle_Paden[a,b]; // ���� ������� ������
        if targets[a,b].angleRotation>271 then targets[a,b].enableTarget:=true
                                          else targets[a,b].enableTarget:=false;
        targets[a,b].otobr:=true;       // ������� ��� ��������� ����� ��������
        targets[a,b].fire:=false;       // ������� ���������
      end;
    end;
  end
  else begin
    for a:=1 to TaskRec_TAK.Col_targ do begin
      if TaskRec_TAK.TarRec[a].Mov and
          (time_Upr > TaskRec_TAK.TarRec[a].Tst) then begin// �������� �������
        TargetR_TAK[a].Xtek[0]:=TargetR_TAK[a].Xtek[0]+TargetR_TAK[a].Vxtek[0];
        TargetR_TAK[a].Ytek[0]:=TargetR_TAK[a].Ytek[0]+TargetR_TAK[a].Vytek[0];
        TargetR_TAK[a].Htek[0]:=TargetR_TAK[a].Htek_const[TargetR_TAK[a].PointTek]+
               CountHeight(TargetR_TAK[a].Xtek[0],TargetR_TAK[a].Ytek[0]);
      end;
      //��������� � ������ �������
      if Mont_Target_TAK[a] and (Angle_Paden_TAK[a] < 360)
                          then  Angle_Paden_TAK[a]:=Angle_Paden_TAK[a]+5
                          else Mont_Target_TAK[a]:=false;
      if DeMont_Target_TAK[a] and (Angle_Paden_TAK[a] > ANGL_PADEN)
                          then  Angle_Paden_TAK[a]:=Angle_Paden_TAK[a]-5
                          else DeMont_Target_TAK[a]:=false;
    end;
    for a:=1 to TaskRec_TAK.Col_targ do begin
      targetsTaktika[a].xTek:=TargetR_TAK[a].Xtek[0];
      targetsTaktika[a].yTek:=TargetR_TAK[a].Ytek[0];
      targetsTaktika[a].hTek:=TargetR_TAK[a].Htek[0];
      targetsTaktika[a].angleRotation:=Angle_Paden_TAK[a]; // ���� ������� ������
      if targetsTaktika[a].angleRotation>271 then targetsTaktika[a].enableTarget:=true
                                             else targetsTaktika[a].enableTarget:=false;
      targetsTaktika[a].otobr:=true;       // ������� ��� ��������� ����� ��������
      targetsTaktika[a].fire:=false;       // ������� ���������
    end;
  end;
end;

function Count_dX(n: integer): integer;
begin
  case n of
    1: result:=round(stolbLeft / DDD);
    2: result:=round((stolbDX1+stolbLeft) / DDD);
    3: result:=round((stolbDX1+stolbDX2+stolbLeft)/ DDD);
    else result:=round((stolbDX1+stolbLeft) / DDD);
  end
end;

(****�������� ������****)
procedure Count_Target;
var a,b,n: integer;
Tm,dal: real;
temp,dr,tr,xr,yr,vr: real;
begin
  if Task.mestn=GORA then dH_target:=H_TARGET_GOR
                     else dH_target:=H_TARGET_RAV;// ������ ������ ��� ������� �����
  for a:=1 to 3 do  for b:=1 to 5 do begin
    Koord_poraj_X[a][b]:=7;  // ���������� ��������� �������� ��������� �������
    Koord_poraj_Y[a][b]:=16*b;
  end;
  if Task.m_index <5000 then begin
    for a:=1 to Task.Col_targ do begin
      Task.typeTarget[a]:=Task.Target[1][a].Num;
      Task.Color_Mask[a]:=Task.Target[1][a].Color_Mask;
      LoadTarget(Task.Target[1][a].Num,a);
      for b:=1 to 3 do begin
        Poraj[b,a]:=false;
        Mont_Target[b,a]:=false;
        DeMont_Target[b,a]:=false;
        Angle_Paden[b,a]:=ANGL_PADEN;
      end;
      TargetR[a].PointTek:=0;
      for n:=1 to 3 do begin
        for b:=0 to Task.Target[n][a].ColPoints do begin
          TargetR[a].Xtek[n][b]:=Task.Target[n][a].Xtek[b]+Count_dX(n);
          TargetR[a].Ytek[n][b]:=Task.Target[n][a].Ytek[b]+(stolbBottom+STOLB_DY_R)/DDD;
          TargetR[a].Htek[n][b]:=Task.Target[n][a].Htek[b];
          TargetR[a].Xtek[n][b]:=TargetR[a].Xtek[n][b]*DDD/MASHT_RIS;
          TargetR[a].Ytek[n][b]:=TargetR[a].Ytek[n][b]*DDD/MASHT_RIS;
          TargetR[a].Htek_const[n][b]:=TargetR[a].Htek[n][b]*DDD/MASHT_RIS+dH_target/MASHT_RIS;
          TargetR[a].Htek[n][b]:=TargetR[a].Htek_const[n][b]+
                     CountHeight(TargetR[a].Xtek[n][b],TargetR[a].Ytek[n][b]);
          TargetR[a].Time_stop[b]:=Task.Target[n][a].Tstop[b];
          if b=0 then Task.Target[N][a].Tend:=Task.Target[N][a].Tst+Task.Target[N][a].Tstop[0]
          else begin
            dal:=sqrt(sqr(TargetR[a].Xtek[n][b]-TargetR[a].Xtek[n][b-1])+  //���������� ����� �������
                      sqr(TargetR[a].Ytek[n][b]-TargetR[a].Ytek[n][b-1]));
            TargetR[a].Skor[b]:=SkorostK(Task.Target[n][a].Skor[b]);
            if   TargetR[a].Skor[b]=0 then TargetR[a].Skor[b]:=0.000001;
            Tm:=dal/TargetR[a].Skor[b];      //����
            TargetR[a].Time_mov[b]:=round(Tm/TIK_SEK);
            if Tm=0 then Tm:=0.01;
            TargetR[a].Vxtek[b]:=(TargetR[a].Xtek[n][b]-TargetR[a].Xtek[n][b-1])/Tm;
            TargetR[a].Vytek[b]:=(TargetR[a].Ytek[n][b]-TargetR[a].Ytek[n][b-1])/Tm;
            TargetR[a].Vhtek[b]:=(TargetR[a].Htek[n][b]-TargetR[a].Htek[n][b-1])/Tm;
            xr:=Task.Target[N][a].Xtek[b]-Task.Target[N][a].Xtek[b-1];
            yr:=Task.Target[N][a].Ytek[b]-Task.Target[N][a].Ytek[b-1];
            dr:=sqrt(xr*xr+yr*yr);       // ���������� �� ����� �� �����
            vr:=Task.Target[N][a].Skor[b];
            vr:=vr*10/36;                //������� ��/��� � �/�
            tr:=dr/vr;                   // ����� �� �������
            // ����� ������� � �����
            Task.Target[N][a].Tend:=Task.Target[N][a].Tend+round(tr);
            Task.Target[N][a].Tend:=Task.Target[N][a].Tend+Task.Target[N][a].Tstop[b];
          end;
          TargetR[a].Vxtek[0]:=TargetR[a].Vxtek[1];
          TargetR[a].Vytek[0]:=TargetR[a].Vytek[1];
          TargetR[a].Vhtek[0]:=TargetR[a].Vhtek[1];
        end;
      end;
    end;
  end
  else begin
    for a:=1 to TaskRec_TAK.Col_targ do begin
      LoadTarget(TaskRec_TAK.TarRec[a].Num,a);
      Angle_Paden_TAK[a]:=ANGL_PADEN;
      Poraj_TAK[a]:=false;
      Mont_Target_TAK[a]:=false;
      DeMont_Target_TAK[a]:=false;
      TargetR_TAK[a].PointTek:=0;
      for b:=0 to TaskRec_TAK.TarRec[a].ColPoints do begin
        TargetR_TAK[a].Xtek[b]:=TaskRec_TAK.TarRec[a].Xtek[b];
        TargetR_TAK[a].Ytek[b]:=TaskRec_TAK.TarRec[a].Ytek[b]+(stolbBottom+STOLB_DY_R)/DDD;
        TargetR_TAK[a].Htek[b]:=TaskRec_TAK.TarRec[a].Htek[b];
        TargetR_TAK[a].Xtek[b]:=TargetR_TAK[a].Xtek[b]*DDD/MASHT_RIS;
        TargetR_TAK[a].Ytek[b]:=TargetR_TAK[a].Ytek[b]*DDD/MASHT_RIS;
        TargetR_TAK[a].Htek_const[b]:=TargetR_TAK[a].Htek[b]*DDD/MASHT_RIS+dH_target/MASHT_RIS;
        TargetR_TAK[a].Htek[b]:=TargetR_TAK[a].Htek_const[b]+
                   CountHeight(TargetR_TAK[a].Xtek[b],TargetR_TAK[a].Ytek[b]);
        TargetR_TAK[a].Time_stop[b]:=TaskRec_TAK.TarRec[a].Tstop[b];
        if b=0 then TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tst+TaskRec_TAK.TarRec[a].Tstop[0]
        else begin
          dal:=sqrt(sqr(TargetR_TAK[a].Xtek[b]-TargetR_TAK[a].Xtek[b-1])+  //���������� ����� �������
                    sqr(TargetR_TAK[a].Ytek[b]-TargetR_TAK[a].Ytek[b-1]));
          TargetR_TAK[a].Skor[b]:=SkorostK(TaskRec_TAK.TarRec[a].Skor[b]);
          if   TargetR_TAK[a].Skor[b]=0 then TargetR_TAK[a].Skor[b]:=0.000001;
          Tm:=dal/TargetR_TAK[a].Skor[b];      //����
          TargetR_TAK[a].Time_mov[b]:=round(Tm/TIK_SEK);
          if Tm=0 then Tm:=0.01;
          TargetR_TAK[a].Vxtek[b]:=(TargetR_TAK[a].Xtek[b]-TargetR_TAK[a].Xtek[b-1])/Tm;
          TargetR_TAK[a].Vytek[b]:=(TargetR_TAK[a].Ytek[b]-TargetR_TAK[a].Ytek[b-1])/Tm;
          TargetR_TAK[a].Vhtek[b]:=(TargetR_TAK[a].Htek[b]-TargetR_TAK[a].Htek[b-1])/Tm;
          xr:=TaskRec_TAK.TarRec[a].Xtek[b]-TaskRec_TAK.TarRec[a].Xtek[b-1];
          yr:=TaskRec_TAK.TarRec[a].Ytek[b]-TaskRec_TAK.TarRec[a].Ytek[b-1];
          dr:=sqrt(xr*xr+yr*yr);       // ���������� �� ����� �� �����
          vr:=TaskRec_TAK.TarRec[a].Skor[b];
          vr:=vr*10/36;                //������� ��/��� � �/�
          tr:=dr/vr;                   // ����� �� �������
          // ����� ������� � �����
          TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tend+round(tr);
          TaskRec_TAK.TarRec[a].Tend:=TaskRec_TAK.TarRec[a].Tend+TaskRec_TAK.TarRec[a].Tstop[b];
        end;
        TargetR_TAK[a].Vxtek[0]:=TargetR_TAK[a].Vxtek[1];
        TargetR_TAK[a].Vytek[0]:=TargetR_TAK[a].Vytek[1];
        TargetR_TAK[a].Vhtek[0]:=TargetR_TAK[a].Vhtek[1];
      end;
    end;
    for a:=1  to Col_Model do begin
      LoadTarget(Target_Model_Isx[a].Num,COL_MAX_MICH_TAK+a);
      case Target_Model_Isx[a].Num  of/// ��������� �� ������ ������� �������
        MODEL_BMP1: dH_target:=POL_BMP_H+0.037;
        MODEL_T72: dH_target:=0.1;
        MODEL_T55: dH_target:=POL_BMP_H-0.022;
        MODEL_BMP2: dH_target:=POL_BMP_H-0.048;
        MODEL_M113: dH_target:=0.1;
        else dH_target:=POL_BMP_H;
      end;
      Poraj_TAK_TEX[a]:=0;
      Target_Model_Tek[a].PointTek:=0; // ��������� ������� �����
      /// ���������� ������� �����
      Target_Model_Tek[a].ColPoints:=Target_Model_Isx[a].ColPoints;
      for b:=0 to Target_Model_Isx[a].ColPoints do begin
        Target_Model_Tek[a].Xtek[b]:=Target_Model_Isx[a].Xtek[b];
        Target_Model_Tek[a].Ytek[b]:=Target_Model_Isx[a].Ytek[b]+(stolbBottom+STOLB_DY_R)/DDD;
        Target_Model_Tek[a].Htek[b]:=Target_Model_Isx[a].Htek[b];
        Target_Model_Tek[a].Xtek[b]:=Target_Model_Tek[a].Xtek[b]*DDD/MASHT_RIS;
        Target_Model_Tek[a].Ytek[b]:=Target_Model_Tek[a].Ytek[b]*DDD/MASHT_RIS;
        Target_Model_Tek[a].Htek[b]:=Target_Model_Tek[a].Htek[b]*DDD/MASHT_RIS;
        Target_Model_Tek[a].Htek_const[b]:=Target_Model_Tek[a].Htek[b]+dH_target;
        Target_Model_Tek[a].Htek[b]:=Target_Model_Tek[a].Htek_const[b]+
             CountHeight(Target_Model_Tek[a].Xtek[b],Target_Model_Tek[a].Ytek[b]);
        Target_Model_Tek[a].Time_stop[b]:=Target_Model_Isx[a].Tstop[b];
        if b=0 then begin
          Target_Model_Tek[a].Tend:=Target_Model_Isx[a].Tst+Target_Model_Isx[a].Tstop[0];
          Target_Model_Tek[a].AzBase[1]:=180;
        end
        else begin
          dal:=sqrt(sqr(Target_Model_Tek[a].Xtek[b]-Target_Model_Tek[a].Xtek[b-1])+  //���������� ����� �������
                     sqr(Target_Model_Tek[a].Ytek[b]-Target_Model_Tek[a].Ytek[b-1]));
          Target_Model_tek[a].Skor[b]:=SkorostK(Target_Model_Isx[a].Skor[b]);
          if Target_Model_Tek[a].Skor[b]=0 then Target_Model_Tek[a].Skor[b]:=0.000001;
          Tm:=dal/Target_Model_Tek[a].Skor[b]; //���� ����� �������� �� ���������� ����� � �����������
//          Target_Model_Tek[a].Time_mov[b]:=round(Tm/TIK_SEK);
          Target_Model_Tek[a].Complited[b]:=false;
          if Tm=0 then Tm:=0.01;
          // ������������ ��������
          Target_Model_Tek[a].Vxtek[b]:=(Target_Model_Tek[a].Xtek[b]-Target_Model_Tek[a].Xtek[b-1])/Tm;
          Target_Model_Tek[a].Vytek[b]:=(Target_Model_Tek[a].Ytek[b]-Target_Model_Tek[a].Ytek[b-1])/Tm;
          Target_Model_Tek[a].Vhtek[b]:=(Target_Model_Tek[a].Htek[b]-Target_Model_Tek[a].Htek[b-1])/Tm;
          if Target_Model_Tek[a].Vytek[b]=0 then Target_Model_Tek[a].Vytek[b]:=0.00001;
          xr:=Target_Model_Tek[a].Xtek[b]-Target_Model_Tek[a].Xtek[b-1];
          yr:=Target_Model_Tek[a].Ytek[b]-Target_Model_Tek[a].Ytek[b-1];
          dr:=sqrt(xr*xr+yr*yr);       // ���������� �� ����� �� �����
          vr:=Target_Model_Isx[a].Skor[b];
          vr:=vr*10/36;                //������� ��/��� � �/�
          tr:=dr/vr;                   // ����� �� �������}
          // ����� ������������ ������
          Target_Model_Isx[a].Tend:=Target_Model_Isx[a].Tend+Target_Model_Isx[a].Tstop[b]+round(tr);
          /// ������ ����������� ��������
          Target_Model_tek[a].AzBase[b]:=
              ArcTan(Target_Model_Tek[a].Vxtek[b]/Target_Model_Tek[a].Vytek[b])*57.3;
              if Target_Model_Tek[a].Vytek[b]<0 then Target_Model_tek[a].AzBase[b]:=Target_Model_tek[a].AzBase[b]+180
                else if Target_Model_Tek[a].Vxtek[b]<0 then Target_Model_tek[a].AzBase[b]:=Target_Model_tek[a].AzBase[b]+360;
        end;
        Target_Model_Tek[a].Vxtek[0]:=Target_Model_Tek[a].Vxtek[1];
        Target_Model_Tek[a].Vytek[0]:=Target_Model_Tek[a].Vytek[1];
        Target_Model_Tek[a].Vhtek[0]:=Target_Model_Tek[a].Vhtek[1];
        Target_Model_Tek[a].AzBase[0]:=Target_Model_Tek[a].AzBase[1];
        Model[a].Xtek:=Target_Model_Tek[a].Xtek[0];
        Model[a].Ytek:=Target_Model_Tek[a].Ytek[0];
        Model[a].Htek:=Target_Model_Tek[a].Htek[0];
        Model[a].AzBase:=Target_Model_Tek[a].AzBase[0];
        Target_Model_Tek[a].Delta:=0.5;
      end;
    end;
  end;
end;

(*********�������� ������� ������*********)
procedure LoadTarget(Num,Np: integer);
var  F: TextFile;
     S: String;
     a: integer;
begin
  S:=dirBase+'res\Target\Targ_'+Name_Target(Num)+'.txt';
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  ReadLn(F, S);
  col_tch_targ[Np]:=strtoint(copy(S,1,Pos(' ',s)-1));//���������� ����� ������
  for a:=1 to col_tch_targ[Np] do begin
    ReadLn(F, S);         //���������� �����, ����������� ������ ������
    Mich[Np][a].x:=strtoint(copy(S,1,Pos(' ',s)-1));
    delete(S,1,Pos(' ',s));
    Mich[Np][a].y:=strtoint(copy(S,1,Pos(' ',s)-1));
  end;
  ReadLn(F, S);           //���������� ����� ������������ ��������������
  Rects[Np].Right:=strtoint(copy(S,1,Pos(' ',s)-1));
  delete(S,1,Pos(' ',s));
  Rects[Np].Bottom:=strtoint(copy(S,1,Pos(' ',s)-1));
  CloseFile(F);
end;

(********** ������ ������ **********)
procedure Save_Task;
var  F: TextFile;
     S: String;
     a,b,n: integer;
     FName: string;
begin
  if Task.m_index>6000 then exit;
  FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'A.txt';
  if Task.m_index<2000 then begin
    if Task.Mestn=GORA then begin
      if Task.Temp=DAY then FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'Ag.txt'
                  else FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'Agn.txt';
    end
    else begin
      if Task.Temp=DAY then FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'A.txt'
                  else FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'An.txt';
    end;
  end
  else begin
    if (Task.m_index>5000) and (Task.m_index<6000) then
        FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+'A.txt';
  end;
  S:=dirBase+FName;//
  FileSetAttr(S,$00000);
  AssignFile(F,S);  {���������� ����� � ������}
  Rewrite(F);
  S:='//// ������������ ������';
  writeLn(F,S);
  S:=TaskName;   //   ������������ ������
  writeLn(F,S);
  if Task.m_index<5000 then begin
    S:=IntToStr(Task.Tstr)+'                                  // ����� �� ��������';  // ����� �� ��������
    writeLn(F,S);
    S:=IntToStr(Task.Col_targ)+'                                    //���������� �������';
    writeLn(F,S);
    for n:=1 to 3 do begin
      for a:=1 to Task.Col_targ do begin
        S:='/// �������� ������ '+IntToStr(a);
        writeLn(F,S);
        S:=Name_Target(Task.Target[n][a].Num)+'                     // ����� ������';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Color_Mask)+'                 // ��������� ������';
        writeLn(F,S);
        if Task.Target[n][a].ColPoints=0 then Task.Target[n][a].Mov:=false
                                         else Task.Target[n][a].Mov:=true;
        if Task.Target[n][a].Mov then S:=IntToStr(1) else S:=IntToStr(0);
        S:=S+'                      // ���- �� ��������/��������';
        writeLn(F,S);
        if Task.Target[n][a].Air then S:=IntToStr(1) else S:=IntToStr(0);
        S:=S+'                      // ���- ��������/���������';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Tst)+'                      // ����� ���������';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Tend)+'                     // ����� ���������/����� ���������� � ����� N 0';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].ColPoints)+'                      // ���������� ������� �����';
        writeLn(F,S);
        S:='// ������� ����� 0';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Xtek[0])+'                    // ���������� ����� ���������';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Ytek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Htek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(Task.Target[n][a].Tstop[0])+'                      // ����� ��������� � �����';
        writeLn(F,S);
        for b:=1 to Task.Target[n][a].ColPoints do begin
          S:='// ������� ����� '+IntToStr(b);
          writeLn(F,S);
          S:=IntToStr(Task.Target[n][a].Xtek[b])+'                   // ���������� ������� �����';
          writeLn(F,S);
          S:=IntToStr(Task.Target[n][a].Ytek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(Task.Target[n][a].Htek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(Task.Target[n][a].Skor[b])+'                     // C������� �������� �� ������� �����';
          writeLn(F,S);
          S:=IntToStr(Task.Target[n][a].Tstop[b])+'                      // ����� ��������� � �����';
          writeLn(F,S);
          if Task.Target[n][a].Visible[b] then S:=IntToStr(1) else S:=IntToStr(0);
          S:=S+'                      // ���������  ������';
          writeLn(F,S);
        end;
      end;
    end;
  end
  else begin
    if Task.m_index<6000 then begin
      S:=IntToStr(TaskRec_TAK.Tstr)+'                                  // ����� �� ��������';  // ����� �� ��������
      writeLn(F,S);
      S:=IntToStr(TaskRec_TAK.Col_targ)+'                                    //���������� �������';
      writeLn(F,S);
      for a:=1 to TaskRec_TAK.Col_targ do begin
        S:='/// �������� ������ '+IntToStr(a);
        writeLn(F,S);
        S:=Name_Target(TaskRec_TAK.TarRec[a].Num)+'                     // ����� ������';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Color_Mask)+'                 // ��������� ������';
        writeLn(F,S);
        if TaskRec_TAK.TarRec[a].ColPoints=0 then TaskRec_TAK.TarRec[a].Mov:=false
                                         else TaskRec_TAK.TarRec[a].Mov:=true;
        if TaskRec_TAK.TarRec[a].Mov then S:=IntToStr(1) else S:=IntToStr(0);
        S:=S+'                      // ���- �� ��������/��������';
        writeLn(F,S);
//        if TaskRec_TAK.TarRec[a].Air then S:=IntToStr(1) else S:=IntToStr(0);
        S:=IntToStr(1);
        S:=S+'                      // ���- ��������/���������';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Tst)+'                      // ����� ���������';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Tend)+'                     // ����� ���������/����� ���������� � ����� N 0';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].ColPoints)+'                      // ���������� ������� �����';
        writeLn(F,S);
        S:='// ������� ����� 0';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Xtek[0])+'                    // ���������� ����� ���������';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Ytek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Htek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(TaskRec_TAK.TarRec[a].Tstop[0])+'                      // ����� ��������� � �����';
        writeLn(F,S);
        for b:=1 to TaskRec_TAK.TarRec[a].ColPoints do begin
          S:='// ������� ����� '+IntToStr(b);
          writeLn(F,S);
          S:=IntToStr(TaskRec_TAK.TarRec[a].Xtek[b])+'                   // ���������� ������� �����';
          writeLn(F,S);
          S:=IntToStr(TaskRec_TAK.TarRec[a].Ytek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(TaskRec_TAK.TarRec[a].Htek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(TaskRec_TAK.TarRec[a].Skor[b])+'                     // C������� �������� �� ������� �����';
          writeLn(F,S);
          S:=IntToStr(TaskRec_TAK.TarRec[a].Tstop[b])+'                      // ����� ��������� � �����';
          writeLn(F,S);
          if TaskRec_TAK.TarRec[a].Visible[b] then S:=IntToStr(1) else S:=IntToStr(0);
          S:=S+'                      // ���������  ������';
          writeLn(F,S);
        end;
      end;
    end;
  end;
  S:='// ���������';
  writeLn(F,S);
  S:=inttostr(Task.Orient.Col_orient)+' ';// ���������� ����������
  writeLn(F,S);
  for a:=1 to Task.Orient.Col_orient do begin
    S:=inttostr(Task.Orient.Typ_orient[a])+'     /// ��� ���������';
    writeLn(F,S);
    S:=inttostr(round(Task.Orient.Xorient[a]))+'     ///  ����������';
    writeLn(F,S);
    S:=inttostr(round(Task.Orient.Yorient[a]))+'     ///  ����������';
    writeLn(F,S);
    S:=inttostr(round(Task.Orient.Horient[a]))+'     ///  ����������';
    writeLn(F,S);
  end;
  S:='/// �����������';
  writeLn(F,S);
  S:=IntToStr(Task.Bk.Col_Upr)+'                      // ���������� �����������';
  writeLn(F,S);
  /// �����, ���, ��������
  if (Task.m_index>5000) and (Task.m_index<6000) then begin
    S:=IntToStr(Col_Model)+'                                    // ��������';
    writeLn(F,S);
    for a:=1 to Col_Model do begin
      S:='/// �������� ������� '+IntToStr(a);
      writeLn(F,S);
//      S:=Name_Target(Target_Model_Isx[a].Num)+'                     // ����� �������';
      S:=IntToStr(Target_Model_Isx[a].Num)+'                     // ����� �������';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Color_Mask)+'               // ��������� �������';
        writeLn(F,S);
        if Target_Model_Isx[a].ColPoints=0 then Target_Model_Isx[a].Mov:=false
                                       else Target_Model_Isx[a].Mov:=true;
        if Target_Model_Isx[a].Mov then S:=IntToStr(1) else S:=IntToStr(0);
        S:=S+'                      // ���- �� ��������/��������';
        writeLn(F,S);
//        if TaskRec_TAK.TarRec[a].Air then S:=IntToStr(1) else S:=IntToStr(0);
        S:=IntToStr(1);
        S:=S+'                      // ���- ��������/���������';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Tst)+'                      // ����� ���������';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Tend)+'                     // ����� ���������/����� ���������� � ����� N 0';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].ColPoints)+'                      // ���������� ������� �����';
        writeLn(F,S);
        S:='// ������� ����� 0';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Xtek[0])+'                    // ���������� ����� ���������';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Ytek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Htek[0])+' ';
        writeLn(F,S);
        S:=IntToStr(Target_Model_Isx[a].Tstop[0])+'                      // ����� ��������� � �����';
        writeLn(F,S);
        for b:=1 to Target_Model_Isx[a].ColPoints do begin
          S:='// ������� ����� '+IntToStr(b);
          writeLn(F,S);
          S:=IntToStr(Target_Model_Isx[a].Xtek[b])+'                   // ���������� ������� �����';
          writeLn(F,S);
          S:=IntToStr(Target_Model_Isx[a].Ytek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(Target_Model_Isx[a].Htek[b])+' ';
          writeLn(F,S);
          S:=IntToStr(Target_Model_Isx[a].Skor[b])+'                     // C������� �������� �� ������� �����';
          writeLn(F,S);
          S:=IntToStr(Target_Model_Isx[a].Tstop[b])+'                      // ����� ��������� � �����';
          writeLn(F,S);
          if Target_Model_Isx[a].Visible[b] then S:=IntToStr(1) else S:=IntToStr(0);
          S:=S+'                      // ���������  ������';
          writeLn(F,S);
        end;
      end;
    end;
  CloseFile(F);
end;

(**********������ ������**********)
procedure Load_Task(stan: boolean);
var  F: TextFile;
     FName: string;
     S: String;
     a,b,n: integer;
begin
  if stan then S:='' else S:='A';
  FName:='res\Task_Konk\Task'+inttostr(Task.m_index)+S+'.txt';
  S:=dirBase+FName;//
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
    exit;
  end;
  AssignFile(F,S);  {���������� ����� � ������}
  Reset(F);
  ReadLn(F, S);   //   //������������ ������
  ReadLn(F, S);
  TaskName:=S;   //   ������������ ������
  if (Task.m_index<5000) or (Task.m_index>6000) then begin
    ReadLn(F, S);
    Task.Tstr:=strtoint(copy(S,1,Pos(' ',s)-1));  // ����� �� ��������
    ReadLn(F, S);
    Task.Col_targ:=strtoint(copy(S,1,Pos(' ',s)-1));   // ���������� �������
    for n:=1 to 3 do begin
      for a:=1 to Task.Col_targ do begin
        ReadLn(F, S);   //   /// �������� ������ 1
        ReadLn(F, S);
        TargetName[a]:=copy(S,1,Pos(' ',S)-1);// ����� ���� ������
        Task.Target[n][a].Num:=Num_Target(TargetName[a]);
        ReadLn(F, S);
        Task.Target[n][a].Color_Mask:=strtoint(copy(S,1,Pos(' ',s)-1));// ���� ������
        ReadLn(F, S);                      // ���- �� ��������/��������
        if strtoint(copy(S,1,Pos(' ',s)-1))=0 then Task.Target[n][a].Mov:=false
                                              else Task.Target[n][a].Mov:=true;
        ReadLn(F, S);                      // ���- ��������/���������
        if strtoint(copy(S,1,Pos(' ',s)-1))=0 then Task.Target[n][a].Air:=false
                                              else Task.Target[n][a].Air:=true;
        ReadLn(F, S);                      // ����� ���������
        Task.Target[n][a].Tst:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ����� ��������
        Task.Target[n][a].Tend:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ���������� ������� �����
        Task.Target[n][a].ColPoints:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      //   // ������� ����� 0
        ReadLn(F, S);                      // X
        Task.Target[n][a].Xtek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // Y
        Task.Target[n][a].Ytek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // H
        Task.Target[n][a].Htek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ����� ��������� � �����
        Task.Target[n][a].Tstop[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        Task.Target[n][a].Visible[0]:=true; // ��������� �� ������� ������
        for b:=1 to Task.Target[n][a].ColPoints do begin
          ReadLn(F, S);                      //    // ������� �����
          ReadLn(F, S);                      // Y
          Task.Target[n][a].Xtek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // Y
          Task.Target[n][a].Ytek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // H
          Task.Target[n][a].Htek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // C������� �������� �� ��������
          Task.Target[n][a].Skor[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // ����� ��������� � �����
          Task.Target[n][a].Tstop[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // ��������� �� �������
          if strtoint(copy(S,1,Pos(' ',s)-1))=1 then Task.Target[n][a].Visible[b]:=true
                                                else Task.Target[n][a].Visible[b]:=false;
        end;
      end;
    end;
  end
  else begin
    if Task.m_index<6000 then begin
      ReadLn(F, S);
      TaskRec_TAK.Tstr:=strtoint(copy(S,1,Pos(' ',s)-1));  // ����� �� ��������
      Task.Tstr:=TaskRec_TAK.Tstr;
      ReadLn(F, S);
      TaskRec_TAK.Col_targ:=strtoint(copy(S,1,Pos(' ',s)-1));   // ���������� �������
      for a:=1 to TaskRec_TAK.Col_targ do begin
        ReadLn(F, S);   //   /// �������� ������ 1
        ReadLn(F, S);
        TargetName[a]:=copy(S,1,Pos(' ',S)-1);// ����� ���� ������
        TaskRec_TAK.TarRec[a].Num:=Num_Target(TargetName[a]);
        ReadLn(F, S);
        TaskRec_TAK.TarRec[a].Color_Mask:=strtoint(copy(S,1,Pos(' ',s)-1));// ���� ������
        ReadLn(F, S);                      // ���- �� ��������/��������
        if strtoint(copy(S,1,Pos(' ',s)-1))=0 then TaskRec_TAK.TarRec[a].Mov:=false
                                              else TaskRec_TAK.TarRec[a].Mov:=true;
        ReadLn(F, S);                      // ���- ��������/���������
        ReadLn(F, S);                      // ����� ���������
        TaskRec_TAK.TarRec[a].Tst:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ����� ��������
        TaskRec_TAK.TarRec[a].Tend:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ���������� ������� �����
        TaskRec_TAK.TarRec[a].ColPoints:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      //   // ������� ����� 0
        ReadLn(F, S);                      // X
        TaskRec_TAK.TarRec[a].Xtek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // Y
        TaskRec_TAK.TarRec[a].Ytek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // H
        TaskRec_TAK.TarRec[a].Htek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ����� ��������� � �����
        TaskRec_TAK.TarRec[a].Tstop[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
        TaskRec_TAK.TarRec[a].Visible[0]:=true; // ��������� �� ������� ������
        for b:=1 to TaskRec_TAK.TarRec[a].ColPoints do begin
          ReadLn(F, S);                      //    // ������� �����
          ReadLn(F, S);                      // Y
          TaskRec_TAK.TarRec[a].Xtek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // Y
          TaskRec_TAK.TarRec[a].Ytek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // H
          TaskRec_TAK.TarRec[a].Htek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // C������� �������� �� ��������
          TaskRec_TAK.TarRec[a].Skor[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // ����� ��������� � �����
          TaskRec_TAK.TarRec[a].Tstop[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
          ReadLn(F, S);                      // ��������� �� �������
          if strtoint(copy(S,1,Pos(' ',s)-1))=1 then TaskRec_TAK.TarRec[a].Visible[b]:=true
                                                else TaskRec_TAK.TarRec[a].Visible[b]:=false;
        end;
      end;
    end;
  end;
  ReadLn(F, S);                          // ��������s�
  ReadLn(F, S);                          // ���������� ����������
  Task.Orient.Col_orient:=strtoint(copy(S,1,Pos(' ',s)-1));
  for a:=1 to Task.Orient.Col_orient do begin
    ReadLn(F, S);                          /// ��� ���������
    Task.Orient.Typ_orient[a]:=strtoint(copy(S,1,Pos(' ',s)-1));
    ReadLn(F, S);                          // ����������
    Task.Orient.Xorient[a]:=strtoint(copy(S,1,Pos(' ',s)-1));
    ReadLn(F, S);
    Task.Orient.Yorient[a]:=strtoint(copy(S,1,Pos(' ',s)-1));
    ReadLn(F, S);
    Task.Orient.Horient[a]:=strtoint(copy(S,1,Pos(' ',s)-1));
  end;
  ReadLn(F, S);                          //  /// ����������� �� ������
  ReadLn(F, S);                          // ���������� ����������� � ����� �
  Task.Bk.Col_Upr:=strtoint(copy(S,1,Pos(' ',s)-1));
  /// �����, ���, ��������
  if (Task.m_index>5000) and (Task.m_index<6000) then begin
    ReadLn(F, S);
    Col_Model:=strtoint(copy(S,1,Pos(' ',s)-1));   // ���������� �������
    for a:=1 to Col_Model do begin
      ReadLn(F, S);   //   /// �������� ������ 1
      ReadLn(F, S);
      TargetName[a]:=copy(S,1,Pos(' ',S)-1);// ����� ���� ������
//      Target_Model_Isx[a].Num:=Num_Target(TargetName[a]);
      Target_Model_Isx[a].Num:=StrToInt(TargetName[a]);
      ReadLn(F, S);
      Target_Model_Isx[a].Color_Mask:=strtoint(copy(S,1,Pos(' ',s)-1));// ���� ������
      ReadLn(F, S);                      // ���- �� ��������/��������
      if strtoint(copy(S,1,Pos(' ',s)-1))=0 then Target_Model_Isx[a].Mov:=false
                                            else Target_Model_Isx[a].Mov:=true;
      ReadLn(F, S);                      // ���- ��������/���������
      ReadLn(F, S);                      // ����� ���������
      Target_Model_Isx[a].Tst:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      // ����� ��������
      Target_Model_Isx[a].Tend:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      // ���������� ������� �����
      Target_Model_Isx[a].ColPoints:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      //   // ������� ����� 0
      ReadLn(F, S);                      // X
      Target_Model_Isx[a].Xtek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      // Y
      Target_Model_Isx[a].Ytek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      // H
      Target_Model_Isx[a].Htek[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
      ReadLn(F, S);                      // ����� ��������� � �����
      Target_Model_Isx[a].Tstop[0]:=strtoint(copy(S,1,Pos(' ',s)-1));
      Target_Model_Isx[a].Visible[0]:=true; // ��������� �� ������� ������
      for b:=1 to Target_Model_Isx[a].ColPoints do begin
        ReadLn(F, S);                      //    // ������� �����
        ReadLn(F, S);                      // Y
        Target_Model_Isx[a].Xtek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // Y
        Target_Model_Isx[a].Ytek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // H
        Target_Model_Isx[a].Htek[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // C������� �������� �� ��������
        Target_Model_Isx[a].Skor[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ����� ��������� � �����
        Target_Model_Isx[a].Tstop[b]:=strtoint(copy(S,1,Pos(' ',s)-1));
        ReadLn(F, S);                      // ��������� �� �������
        if strtoint(copy(S,1,Pos(' ',s)-1))=1 then Target_Model_Isx[a].Visible[b]:=true
                                              else Target_Model_Isx[a].Visible[b]:=false;
      end;
    end;
  end;
  CloseFile(F);
  for a:=1 to 3 do begin
    Boek[a].Col_Upr:=Task.Bk.Col_Upr;
    BMP[a].Col_Upr:=Boek[a].Col_Upr;
    Form1.OtobrPanel(a);
  end;
  Form1.Ris_task;
end;


end.
