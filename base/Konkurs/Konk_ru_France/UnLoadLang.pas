unit UnLoadLang;   //������������ �������� ���������

interface

uses
  Main, UnOther, SysUtils, Dialogs;

procedure SetMain;

implementation

const
  LANG='Rus';//'Rus'; 'Angl'; 'Fra';

procedure SetMain;
var
    F : TextFile;
    S : String;
begin
  if LANG='Fra'then S:='France.txt';//
  if LANG='Rus'then S:='Russia.txt';//
  if not FileExists(s) then begin
    MessageDlg('��� ����� '+s, mtInformation,[mbOk], 0);
  end
  else begin
    AssignFile(F,S);  {���������� ����� � ������}
    Reset(F);
    ReadLn(F, S);
    Form1.Label38.Caption:=S;
    ReadLn(F, S);
    Form1.Label3.Caption:=S;
    ReadLn(F, S);
    Form1.Label42.Caption:=S;
    ReadLn(F, S);
    Form1.Label44.Caption:=S;
    Close(F);
  end;
end;

end.
