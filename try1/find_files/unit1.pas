unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    procedure ButtonClick(Sender: TObject);
    procedure LabelClick(Sender: TObject);
    procedure PanelClick(Sender: TObject);
  private
    { private declarations }
      bp:array[1..10] of TPanel;
      bl,bb,bi:array[1..10] of TLabel;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.ButtonClick(Sender: TObject);

var a:string;Info : TSearchRec;
    i:integer;
    cp:TPanel;
    Cl:TLabel;
begin
  case TButton(Sender).Tag of
   1:Form1.Label1.Caption:='easy';
   2:Form1.Label1.Caption:='normal';
   3:Form1.Label1.Caption:='hard';
  end;
  a:='levels'+Form1.Label1.Caption;
  for i:= 1 to  10 do begin
      if form1.bp[i]<>nil then begin form1.bp[i].Free; form1.Bp[i]:=nil; end;
      if form1.bl[i]<>nil then begin form1.bl[i].Free; form1.Bl[i]:=nil; end;
      if form1.bb[i]<>nil then begin form1.bb[i].Free; form1.Bb[i]:=nil; end;
      if form1.bi[i]<>nil then begin form1.bi[i].Free; form1.Bi[i]:=nil; end;
  end;
  i:=1;
  If  FindFirst(a+'\*.*', faAnyFile, Info) = 0  then
  begin

          Repeat
              If (Info.Attr and faAnyFile)=32 then  begin
                       cp:=TPanel.Create(self);
                     with cp do begin
                         align:=altop;
                         height:=50;
                         color:=clwhite;
                         onclick:=@PanelClick;
                         caption:=info.Name;
                         parent:=Form1.scrollbox1;
                     end;
                  form1.bp[i]:=cp;

                  cl:=Tlabel.Create(self);
                 with cl do begin
                     left:=2;
                     top:=2;
                     width:=45;
                     height:=46;
                     alignment:=tacenter;
                     font.Color:=clwhite;
                     font.Size:=24;
                     autosize:=false;
                     onclick:=@labelclick;
                     Color:=$00FE637A;
                     caption:='i';
                     parent:=form1.bp[i];
                 end;
                 form1.bl[i]:=cl;
                      i+=1;
              end;
          Until (FindNext(info)<>0);
          FindClose(Info);
      end
  else showmessage('error');



end;

procedure TForm1.LabelClick(Sender: TObject);
var  players:array[1..10] of string=(
    'lolik1 12:34:25',
    'lolik2 12:34:25',
    'lolik3 12:34:25',
    'lolik4 12:34:25',
    'lolik5 12:34:25',
    'lolik6 12:34:25',
    'lolik7 12:34:25',
    'lolik8 12:34:25',
    'lolik9 12:34:25',
    'lolik0 12:34:25'
    );

begin
  showmessage(players[1]+#13+players[2]+#13+players[3]+#13+players[4]+#13+players[5]+#13+players[6]+#13+players[7]+#13+players[8]+#13+players[9]+#13+players[10]);
end;

procedure TForm1.PanelClick(Sender: TObject);
var a:string;
    filelvl:file;
    i:integer;

begin
    a:=TPanel(sender).Caption;
     showmessage(a);
end;







end.


