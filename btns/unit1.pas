unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure LabelBtnClick(Sender: TObject);
  private
    { private declarations }
    var point:integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.LabelBtnClick(Sender: TObject);
begin
Form1.Label1.Font.Color:=clwhite;
Form1.Label2.Font.Color:=clwhite;
Form1.Label3.Font.Color:=clwhite;
Form1.Label4.Font.Color:=clwhite;
Form1.Label5.Font.Color:=clwhite;
Form1.Label6.Font.Color:=clwhite;
Form1.Label7.Font.Color:=clwhite;
Form1.Label8.Font.Color:=clwhite;
Form1.Label9.Font.Color:=clwhite;
TLabel(sender).font.Color:=clred;
form1.point:=strtoint(Tlabel(sender).Caption);
Form1.Label10.Caption:=inttostr(form1.point);
end;

end.

