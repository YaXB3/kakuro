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
    procedure LabelBtnsClick(Sender: TObject);
    procedure LabelDIFClick(Sender: TObject);
    procedure LabelDoGenClick(Sender: TObject);
    procedure LabelExitClick(Sender: TObject);
    procedure LabelGenCancelClick(Sender: TObject);
    procedure LabelGenerationClick(Sender: TObject);
    procedure LabelPlayClick(Sender: TObject);
    procedure LabelRulesClick(Sender: TObject);
    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure LabelMouseLeave(Sender: TObject);
    procedure PanelMove   (Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure PanelLeave(Sender:TObject);
    procedure LabelLvlClick(Sender: TObject);
    procedure PanelLvlClick(Sender: TObject);

    procedure generate_components;


  private
    { private declarations }
    const
     maximum = 14;
     minimum = 4;
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
        components_for_game:array[1..maximum,1..maximum] of TLabel;

        players:array[1..10] of string;
        point:integer;
        was_generated:boolean;
        path:string;
  public
    { public declarations }
  end;

var
  FormKakuro: TFormKakuro;

implementation

{$R *.lfm}

{ TFormKakuro }

//создание формы       доделать
procedure TFormKakuro.FormCreate(Sender: TObject);
var i:integer;
begin
   //----изображения
     FormKakuro.ImageMain.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageLevels.Picture.LoadFromFile('images/bg.jpg');
     FormKakuro.ImageRules.Picture.LoadFromFile('images/rules.jpg');
     FormKakuro.ImageHint.Picture.LoadFromFile('images/hint.gif');
     FormKakuro.ImageExample.Picture.LoadFromFile('images/example.gif');
   //----изображения
   //загрухка правил
     FormKakuro.MemoRules.Lines.LoadFromFile('files/rules.txt');
   //загрухка правил
   //начальные значения
   for i:= 1 to 10 do  FormKakuro.players[i]:='';
                    // обнулить какуро components
   FormKakuro.difficult:='';
   FormKakuro.size:=0;
   FormKakuro.was_generated:=false;
   Formkakuro.point:=0;
   FormKakuro.path:='';
   //начальные значения
end;
//создание формы










//выбор уровня
procedure TFormKakuro.LabelBackToLavelsClick(Sender: TObject);
var i:integer;
begin
   for i:= 1 to  10 do begin
       if FormKakuro.LevelsInfo[i]<>nil  then begin FormKakuro.LevelsInfo[i].Free;   FormKakuro.LevelsInfo[i]:=nil; end;
       if FormKakuro.LevelsPanel[i]<>nil then begin FormKakuro.LevelsPanel[i].Free; FormKakuro.LevelsPanel[i]:=nil; end;
    end;
  FormKakuro.PanelChooseLvl.Visible:=false;
  FormKakuro.difficult:='';
end;
procedure TFormKakuro.LabelLvlClick(Sender: TObject);
var
     line:string;
     i:integer;
     f:boolean;
begin
   FormKakuro.path:='files\levels'+FormKakuro.difficult+'\'+TLabel(Sender).Parent.Caption;


    {$I+}
    f:=true;
    i:=1;
    system.Assign(FormKakuro.document,FormKakuro.path);
    if IOResult = 0 then begin
          system.Reset(FormKakuro.document);
          If IOResult= 0 then
            while (f=true) and (not eof(FormKakuro.document)) and (i<11) do
           begin
               readln(FormKakuro.document,line);
               If IOResult=0 then
               FormKakuro.players[i]:=line
               else   f:=false;
               i+=1;
            end
          else begin showmessage('reset file error'); FormKakuro.Close; end;
          system.Close(FormKakuro.document);
          if IOResult <>0 then  begin showmessage('Close file error'); FormKakuro.Close; end;
          end
    else  begin showmessage('Assign  file error'); FormKakuro.Close; end;
    {$I-}



   showmessage(FormKakuro.players[1]+#13+FormKakuro.players[2]+#13+FormKakuro.players[3]+#13+FormKakuro.players[4]+#13+FormKakuro.players[5]+#13+FormKakuro.players[6]+#13+FormKakuro.players[7]+#13+FormKakuro.players[8]+#13+FormKakuro.players[9]+#13+FormKakuro.players[10]);
   for i:= 1 to 10 do  FormKakuro.players[i]:='';
end;
    //доделать
procedure TFormKakuro.PanelLvlClick(Sender: TObject);
var
     line:string;
     i,j:integer;
     f:boolean;
begin
    FormKakuro.path:='files\levels'+FormKakuro.difficult+'\'+TPanel(Sender).Caption;
    {$I+}


    f:=true;
    i:=1;
    system.Assign(FormKakuro.document,FormKakuro.path);
    if IOResult = 0 then begin
          system.Reset(FormKakuro.document);
          If IOResult= 0 then

           begin
           // статистика
            while f and (i<11) do begin
                 readln(FormKakuro.document,line);
                 If IOResult=0 then
                 FormKakuro.players[i]:=line
                 else   f:=false;
                 i+=1;
             end;
            //размер игрового поля
            if f  then begin
               readln(FormKakuro.document,line);
               If IOResult=0 then
                   FormKakuro.size:=strtoint(line)
               else   f:=false;
            end;
            //занесение в какуро  типа блоков
           i:=1;
           while (i<=FormKakuro.size) and f do begin
              j:=1;
              while (j<=FormKakuro.size)  and f do begin
                readln(FormKakuro.document,line);
                If IOResult=0 then
                    FormKakuro.kakuro[i,j].btype:=strtoint(line)
                else   f:=false;
                j+=1;
              end;
              i+=1;
           end;
          //заненсение в какуро занчение value1
           i:=1;
           while (i<=FormKakuro.size) and f do begin
               j:=1;
              while (j<=FormKakuro.size)  and f do begin
                readln(FormKakuro.document,line);
                If IOResult=0 then
                    FormKakuro.kakuro[i,j].bvalue1:=strtoint(line)
                else   f:=false;
                j+=1;
              end;
              i+=1;
           end;
           //заненсение в какуро занчение value2
           i:=1;
           while (i<=FormKakuro.size) and f do begin
              j:=1;
              while (j<=FormKakuro.size)  and f do begin
                readln(FormKakuro.document,line);
                If IOResult=0 then
                    FormKakuro.kakuro[i,j].bvalue2:=strtoint(line)
                else   f:=false;
                j+=1;
              end;
              i+=1;
           end;
           if f=false then showmessage('something''s wrong!!!');
           end
          else begin showmessage('reset file error'); FormKakuro.Close; end;
          system.Close(FormKakuro.document);
          if IOResult <>0 then  begin showmessage('Close file error'); FormKakuro.Close; end;
          end
    else  begin showmessage('Assign  file error'); FormKakuro.Close; end;
   {$I-}
  Formkakuro.point:=0;
  FormKakuro.generate_components;
  FormKakuro.PanelGame.Visible:=true;
end;
//выбор уровня




//игра
procedure TFormKakuro.LabelBtnsClick(Sender: TObject);
begin
    FormKakuro.LabelBtn1.Font.Color:=clwhite;
    FormKakuro.LabelBtn2.Font.Color:=clwhite;
    FormKakuro.LabelBtn3.Font.Color:=clwhite;
    FormKakuro.LabelBtn4.Font.Color:=clwhite;
    FormKakuro.LabelBtn5.Font.Color:=clwhite;
    FormKakuro.LabelBtn6.Font.Color:=clwhite;
    FormKakuro.LabelBtn7.Font.Color:=clwhite;
    FormKakuro.LabelBtn8.Font.Color:=clwhite;
    FormKakuro.LabelBtn9.Font.Color:=clwhite;

    TLabel(Sender).Font.Color:=RGBToColor(255, 136, 18);
    FormKakuro.point:=strtoint(Tlabel(sender).Caption);
end;
    //проверить
procedure TFormKakuro.LabelBackToChooseClick(Sender: TObject);
var i:integer;
begin
  //if FormKakuro.wasgenerated=false then save the progress?
  FormKakuro.PanelGame.Visible:=false;
  for i:= 1 to 10 do  FormKakuro.players[i]:='';
  //обнулить kakuro:mass
  //обнулить  components
  FormKakuro.was_generated:=false;
  FormKakuro.point:=0;
end;
//игра



// генерация
 procedure TFormKakuro.generate_components;
 var i,j:integer;
     fTop,fLeft:integer;
     block:TLabel;
     fwidth:integer;
     fheight:integer;
 begin
     for i:= 1 to FormKakuro.size do
     for j:= 1 to FormKakuro.size do
     if FormKakuro.components_for_game[i,j]<>nil then
       begin
            FormKakuro.components_for_game[i,j].Free;
            FormKakuro.components_for_game[i,j]:=nil;
       end;
     fheight:=(FormKakuro.PanelGame.Height-120) div FormKakuro.size-5;
     fwidth:=FormKakuro.PanelGame.Width div FormKakuro.size-5;
     fTop:=10;
     for i:= 1 to FormKakuro.size do  begin
      FLeft:=10;
      for j:= 1 to FormKakuro.size do  begin
        block:=TLabel.Create(self);
        with block do begin
             top:=fTop;
             left:=fLeft;
             width:=fwidth;
             height:=fheight;
             parent:=FormKakuro.PanelGame;
             font.size:=-fheight+fheight div 3;
             autosize:=false;
             alignment:=tacenter;
             if FormKakuro.kakuro[i,j].btype<>2 then
               begin
                   caption:=caption+inttostr(FormKakuro.kakuro[i,j].bvalue1);
                   caption:=caption+'\';
                   caption:=caption+inttostr(FormKakuro.kakuro[i,j].bvalue2);
                   color:=clwindowframe;
                   font.color:=clWhite;
                   enabled:=false;
               end
             else begin
                  caption:='   ';
                  color:=clwindowframe;
                  font.color:=clwhite;
                  Cursor:=crHandPoint;
                  //onlick:=@game_cell_click;
                  //onmousemove:=@game_cell_move;
                  //onmouseleave:=@game_cell_leave;
             end;
        end;
        FormKakuro.components_for_game[i,j]:=block;
        fLeft+=fwidth+2;
      end;
      fTop+=fheight+2;
     end;
 end;


//доделать генерацию
procedure TFormKakuro.LabelDoGenClick(Sender: TObject);
begin
   try
     if  strtoint(FormKakuro.EditGen.Text) in [FormKakuro.minimum..FormKakuro.maximum-1] then  begin
         FormKakuro.size:=strtoint(FormKakuro.EditGen.Text);
         //сделать генерацию

         FormKakuro.point:=0;
         FormKakuro.PanelGame.Visible:=true;
         FormKakuro.LabelInfo.Enabled:=false;
         FormKakuro.PanelGeneration.Visible:=false;
         FormKakuro.was_generated:=true;
      end
      else showmessage('ожидалось число в диапазоне '+inttostr(FormKakuro.minimum)+' '+inttostr(FormKakuro.maximum-1));
   except
      on EConvertError do showmessage('ожидалось число в диапазоне 4-13');
   end;
end;
procedure TFormKakuro.LabelGenCancelClick(Sender: TObject);
begin
  FormKakuro.PanelGeneration.Visible:=false;
end;
// генерация

// уровни  +
procedure TFormKakuro.LabelGenerationClick(Sender: TObject);
begin
   FormKakuro.PanelGeneration.Visible:=true;
   Formkakuro.EditGen.Text:='';
end;
procedure TFormKakuro.LabelBackMainMenuClick(Sender: TObject);
begin
   FormKakuro.PanelLevels.Visible:=false;
end;
   //проверки
procedure TFormKakuro.LabelDIFClick(Sender: TObject);
var
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

   FormKakuro.path:='files\levels'+FormKakuro.difficult;
   for i:= 1 to  10 do begin
       if FormKakuro.LevelsInfo[i]<>nil then begin FormKakuro.LevelsInfo[i].Free; FormKakuro.LevelsInfo[i]:=nil; end;
       if FormKakuro.LevelsPanel[i]<>nil then begin FormKakuro.LevelsPanel[i].Free; FormKakuro.LevelsPanel[i]:=nil; end;
   end;
   i:=1;
    If  FindFirst(FormKakuro.path+'\*.*', faAnyFile, Info) = 0  then
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
   FormKakuro.path:='';
end;
// уровни


// главное меню  +
procedure TFormKakuro.LabelPlayClick(Sender: TObject);
begin
  Formkakuro.PanelLevels.Visible:=true;
end;
procedure TFormKakuro.LabelRulesClick(Sender: TObject);
begin
    FormKakuro.PanelRules.Visible:=true;
end;
procedure TFormKakuro.LabelExitClick(Sender: TObject);
begin
  self.Close;
end;
// галвное меню




// правила +
procedure TFormKakuro.LabelBackClick(Sender: TObject);
begin
     Formkakuro.PanelRules.Visible:=false;
end;
// правила

// общее +
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
procedure TFormKakuro.LabelMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    if TLabel(Sender).Font.Color<>RGBToColor(255, 136, 18) then TLabel(Sender).Font.Color:= RGBToColor(255, 136, 17);
    TLabel(Sender).Cursor:=crHandPoint;
end;
procedure TFormKakuro.LabelMouseLeave(Sender: TObject);
begin
     if TLabel(Sender).Font.Color<>RGBToColor(255, 136, 18) then TLabel(Sender).Font.Color:=clwhite;
end;
// общее











end.



