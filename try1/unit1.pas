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
    LabelTimer: TLabel;
    LabelBackToChoose: TLabel;
    LabelShowRules: TLabel;
    LabelHelp: TLabel;
    LabelInfo: TLabel;
    LabelBtn2: TLabel;
    LabelBtn3: TLabel;
    LabelBtn4: TLabel;
    LabelBtn5: TLabel;
    LabelBtn6: TLabel;
    LabelBtn7: TLabel;
    LabelBtn8: TLabel;
    LabelBtn9: TLabel;
    LabelBtn1: TLabel;
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
    PanelButtons: TPanel;
    PanelGame: TPanel;
    PanelChooseLvl: TPanel;
    PanelGeneration: TPanel;
    PanelLevels: TPanel;
    PanelRules: TPanel;
    PanelMainMenu: TPanel;
    ScrollBoxLvl: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure LabelBackClick(Sender: TObject);
    procedure LabelBackMainMenuClick(Sender: TObject);
    procedure LabelBackToChooseClick(Sender: TObject);
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
    procedure LabelShowRulesClick(Sender: TObject);

    procedure PanelMove   (Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
    procedure PanelLeave(Sender:TObject);
    procedure LabelLvlClick(Sender: TObject);
    procedure PanelLvlClick(Sender: TObject);
  private
    { private declarations }
    const
     maximum = 14;
     minimum = 4;
     blocksize = 30;
    type
        blocks = record
           btype, bvalue1, bvalue2: integer;
        end;
    var difficult:string;
        document:text;
        size:integer;
        LevelsPanel:array[1..10] of TPanel;
        LevelsInfo:array[1..10] of TLabel;
        kakuro: array[1..maximum, 1..maximum] of blocks;
        players:array[1..10] of string;
        point:integer;
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
var i:integer;
begin
     FormKakuro.ImageMain.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageLevels.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageRules.Picture.LoadFromFile('images/rules.jpg');
     FormKakuro.ImageHint.Picture.LoadFromFile('images/hint.gif');
     FormKakuro.ImageExample.Picture.LoadFromFile('images/example.gif');
     FormKakuro.MemoRules.Lines.LoadFromFile('files/rules.txt');
      for i:= 1 to 10 do  FormKakuro.players[i]:='';
      FormKakuro.difficult:='';
       FormKakuro.size:=0;
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

procedure TFormKakuro.LabelBackToChooseClick(Sender: TObject);
var i:integer;
begin
  //save the progress?
  FormKakuro.PanelGame.Visible:=false;
  for i:= 1 to 10 do  FormKakuro.players[i]:='';

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
                     height:=45;
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
 {show rules from game}
procedure TFormKakuro.LabelShowRulesClick(Sender: TObject);
begin
     Formkakuro.PanelRules.Visible:=true;
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
    {информация об уровне}
procedure TFormKakuro.LabelLvlClick(Sender: TObject);
var
     path,line:string;
     i,j:integer;
begin

   path:='files\levels'+FormKakuro.difficult+'\'+TLabel(Sender).Parent.Caption;
   system.assign(FormKakuro.document,path);
   system.reset(FormKakuro.document);
   for i:= 1 to 10 do begin
       readln(FormKakuro.document,line);
       FormKakuro.players[i]:=line;
   end;
   system.close(FormKakuro.document);
   showmessage(FormKakuro.players[1]+#13+FormKakuro.players[2]+#13+FormKakuro.players[3]+#13+FormKakuro.players[4]+#13+FormKakuro.players[5]+#13+FormKakuro.players[6]+#13+FormKakuro.players[7]+#13+FormKakuro.players[8]+#13+FormKakuro.players[9]+#13+FormKakuro.players[10]);
   for i:= 1 to 10 do  FormKakuro.players[i]:='';
end;
  {выбор уровня --- начало игры}
procedure TFormKakuro.PanelLvlClick(Sender: TObject);
var
     path,line:string;
     i,j:integer;
begin
   //  path:='files\levels'+FormKakuro.difficult+'\'+TPanel(Sender).Caption;
   //system.assign(FormKakuro.document,path);
   //system.reset(FormKakuro.document);
   //for i:= 1 to 10 do begin
   //    readln(FormKakuro.document,line);
   //    FormKakuro.players[i]:=line;
   //end;
   // запись данных в массив kakuro
   // динамическое создание компанентов
   //system.close(FormKakuro.document);
  FormKakuro.PanelGame.Visible:=true;
end;





end.



