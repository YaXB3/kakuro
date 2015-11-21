unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TFormKakuro }

  TFormKakuro = class(TForm)
    EditGen: TEdit;
    ImageLevels: TImage;
    ImageHint: TImage;
    ImageExample: TImage;
    ImageRules: TImage;
    ImageMain: TImage;
    LabelBackToLavels: TLabel;
    LabelDif: TLabel;
    LabelDoGen: TLabel;
    LabelGenCancel: TLabel;
    LabelSize: TLabel;
    LabelEasy: TLabel;
    LabelNormal: TLabel;
    LabelHard: TLabel;
    LabelGeneration: TLabel;
    LabelBackMainMenu: TLabel;
    LabelHint: TLabel;
    LabelExample: TLabel;
    LabelBack: TLabel;
    LabelRules: TLabel;
    LabelExit: TLabel;
    LabelPlay: TLabel;
    MemoRules: TMemo;
    PanelChooseLvl: TPanel;
    PanelGeneration: TPanel;
    PanelLevels: TPanel;
    PanelRules: TPanel;
    PanelMainMenu: TPanel;
    ScrollBoxLvl: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure LabelBackClick(Sender: TObject);
    procedure LabelBackMainMenuClick(Sender: TObject);
    procedure LabelBackToLavelsClick(Sender: TObject);
    procedure LabelDIFClick(Sender: TObject);
    procedure LabelDoGenClick(Sender: TObject);

    procedure LabelExitClick(Sender: TObject);
    procedure LabelGenCancelClick(Sender: TObject);
    procedure LabelGenerationClick(Sender: TObject);
    procedure LabelPlayClick(Sender: TObject);
    procedure LabelRulesClick(Sender: TObject);

    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelMouseLeave(Sender: TObject);

    procedure PanelMove   (Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
    procedure PanelLeave(Sender:TObject);
    procedure LabelLvlClick(Sender: TObject);
    procedure PanelLvlClick(Sender: TObject);
  private
    { private declarations }
    var difficult:string;
        document:string;
        size:integer;
        LevelsPanel:array[1..10] of TPanel;
        LevelsInfo:array[1..10] of TLabel;
  public
    { public declarations }
  end;

var
  FormKakuro: TFormKakuro;

implementation

{$R *.lfm}

{ TFormKakuro }

{
создание формы
}
procedure TFormKakuro.FormCreate(Sender: TObject);
begin
     FormKakuro.ImageMain.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageLevels.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageRules.Picture.LoadFromFile('images/rules.jpg');
     FormKakuro.ImageHint.Picture.LoadFromFile('images/hint.gif');
     FormKakuro.ImageExample.Picture.LoadFromFile('images/example.gif');
     FormKakuro.MemoRules.Lines.LoadFromFile('files/rules.txt');

end;
{****f close rules
}
procedure TFormKakuro.LabelBackClick(Sender: TObject);
begin
     Formkakuro.PanelRules.Visible:=false;
end;
{ ****f back to main menu from levels
}
procedure TFormKakuro.LabelBackMainMenuClick(Sender: TObject);
begin
   FormKakuro.PanelLevels.Visible:=false;
end;
 {назад на выбор уровня сложности
 }
procedure TFormKakuro.LabelBackToLavelsClick(Sender: TObject);
var i:integer;
begin
   for i:= 1 to  10 do begin
       if FormKakuro.LevelsInfo[i]<>nil then begin FormKakuro.LevelsInfo[i].Free; FormKakuro.LevelsInfo[i]:=nil; end;
       if FormKakuro.LevelsPanel[i]<>nil then begin FormKakuro.LevelsPanel[i].Free; FormKakuro.LevelsPanel[i]:=nil; end;
    end;
  FormKakuro.PanelChooseLvl.Visible:=false;
  FormKakuro.difficult:='';
end;

{  нажатие кнопок easy med hard
}

procedure TFormKakuro.LabelDIFClick(Sender: TObject);
var path:string;
    Info:TSearchRec;
    i:integer;
    Cp:TPanel;
    Cl:TLabel;
begin
   case TLabel(sender).Tag of
   1:  FormKakuro.difficult:='easy';
   2:  FormKakuro.difficult:='normal';
   3: FormKakuro.difficult:='hard';
   end;

    path:='files\levels'+FormKakuro.difficult;
    for i:= 1 to  10 do begin
       if FormKakuro.LevelsInfo[i]<>nil then begin FormKakuro.LevelsInfo[i].Free; FormKakuro.LevelsInfo[i]:=nil; end;
       if FormKakuro.LevelsPanel[i]<>nil then begin FormKakuro.LevelsPanel[i].Free; FormKakuro.LevelsPanel[i]:=nil; end;
    end;
    i:=1;
  If  FindFirst(path+'\*.*', faAnyFile, Info) = 0  then
  begin
          Repeat
              If (Info.Attr and faAnyFile)=32 then  begin
                       cp:=TPanel.Create(self);
                     with cp do begin
                         align:=altop;
                         height:=50;
                         color:=clwhite;
                         onclick:=@PanelLvlClick;
                         onmousemove:=@PanelMove;
                         onmouseleave:=@panelleave;
                         caption:=info.Name;
                         parent:=FormKakuro.ScrollBoxLvl;
                     end;
                  FormKakuro.LevelsPanel[i]:=cp;

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
                     onclick:=@labelLvlclick;
                     onmousemove:=@LabelMouseMove;
                     onmouseleave:=@LabelMouseLeave;
                     Color:=$00FE637A;
                     caption:='i';
                     parent:=FormKakuro.LevelsPanel[i];
                 end;
                 FormKakuro.LevelsInfo[i]:=cl;
                      i+=1;
              end;
          Until (FindNext(info)<>0);
          FindClose(Info);
      end
  else showmessage('error');

   FormKakuro.LabelDif.Caption:=TLabel(sender).Caption;
   FormKakuro.PanelChooseLvl.Visible:=true;
end;
    {
 генерировать
    }
procedure TFormKakuro.LabelDoGenClick(Sender: TObject);
begin
   try
     if  strtoint(FormKakuro.EditGen.Text) in [4..13] then  begin
      FormKakuro.size:=strtoint(FormKakuro.EditGen.Text);
      showmessage(inttostr(FormKakuro.size));
      end
      else showmessage('ожидалось число в диапазоне 4-13');
   except
      on EConvertError do showmessage('ожидалось число в диапазоне 4-13');
   end;
end;

 {*****f TFormKakuro.LabelExitClick(Sender:TObject);
      close the form
}
procedure TFormKakuro.LabelExitClick(Sender: TObject);
begin
  self.Close;
end;

{
  отмена генерации
}
procedure TFormKakuro.LabelGenCancelClick(Sender: TObject);
begin
  FormKakuro.PanelGeneration.Visible:=false;
end;
  {
  окно генерации
}
procedure TFormKakuro.LabelGenerationClick(Sender: TObject);
begin
   FormKakuro.PanelGeneration.Visible:=true;
   Formkakuro.EditGen.Text:='';
end;

{****f goto panel levels

}
procedure TFormKakuro.LabelPlayClick(Sender: TObject);
begin
  Formkakuro.PanelLevels.Visible:=true;
end;
 {*****f подсветка кнопок при наведении
}
procedure TFormKakuro.LabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    TLabel(Sender).Font.Color:= RGBToColor(255, 136, 17);
    TLabel(Sender).Cursor:=crHandPoint;
end;
 {*****f убрать подсветку кнопок при снятии наведении
}
procedure TFormKakuro.LabelMouseLeave(Sender: TObject);
begin
     TLabel(Sender).Font.Color:=clwhite;
end;
{***show rules

}
procedure TFormKakuro.LabelRulesClick(Sender: TObject);
begin
    FormKakuro.PanelRules.Visible:=true;
end;

procedure TFormKakuro.PanelLeave(sender:TObject);
begin
  TLabel(Sender).Font.Color:=clblack;
end;

procedure TFormKakuro.PanelMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  TPanel(Sender).Cursor:=crHandPoint;
  TPanel(Sender).Font.Color:=RGBToColor(255, 136, 17);
end;

procedure TFormKakuro.LabelLvlClick(Sender: TObject);
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

procedure TFormKakuro.PanelLvlClick(Sender: TObject);
begin
     showmessage( TPanel(sender).Caption );
end;





end.

{
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




}

