unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, DateUtils;

type

  { TFormKakuro }

  TFormKakuro = class(TForm)
    EditGen: TEdit;
    ImageRules: TImage;
    ImageBgLevels: TImage;
    ImageBgMain: TImage;
    ImageLevels: TImage;
    ImageHint: TImage;
    ImageExample: TImage;
    ImageMain: TImage;
    LabelReset: TLabel;
    LabelSave: TLabel;
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
    MainMenuBar: TMainMenu;
    MemoRules: TMemo;
    MenuItemInfo: TMenuItem;
    PanelButtons: TPanel;
    PanelGame: TPanel;
    PanelChooseLvl: TPanel;
    PanelGeneration: TPanel;
    PanelLevels: TPanel;
    PanelRules: TPanel;
    PanelMainMenu: TPanel;
    ScrollBoxLvl: TScrollBox;
    TimerKakuro: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure LabelResetClick(Sender: TObject);
    procedure LabelSaveClick(Sender: TObject);
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
    procedure LabelHelpClick(Sender: TObject);
    procedure LabelInfoClick(Sender: TObject);
    procedure LabelPlayClick(Sender: TObject);
    procedure LabelRulesClick(Sender: TObject);
    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure LabelMouseLeave(Sender: TObject);
    procedure MenuItemInfoClick(Sender: TObject);
    procedure PanelMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure PanelLeave(Sender: TObject);
    procedure LabelLvlClick(Sender: TObject);
    procedure PanelLvlClick(Sender: TObject);
    procedure game_cell_move(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure game_cell_leave(Sender: TObject);
    procedure game_cell_click(Sender: TObject);
    procedure TimerKakuroTimer(Sender: TObject);
    procedure generate_components;
    procedure counters;
    procedure corners;
    procedure sides_top_bot;
    procedure sides_lef_rig;
    procedure generation;
    procedure values_right;
    procedure values_down;
    procedure generate_numbers;
    procedure complete;
    procedure save;
    procedure getpath;
    procedure getstatistic;
    procedure statistic_sort;
  private
    { private declarations }
  const
    maximum = 13;
    minimum = 4;
    type
    blocks = record
      btype, bvalue1, bvalue2: integer;
    end;


  var
    LevelsPanel: array[1..10] of TPanel;
    LevelsInfo: array[1..10] of TLabel;
    components_for_game: array[1..maximum, 1..maximum] of TLabel;
    btns: array[1..9] of TLabel;
    kakuro: array[1..maximum, 1..maximum] of blocks;
    times: array[1..11] of TDateTime;
    players: array[1..11] of string;
    difficult: (none, easy, normal, hard);
    document: Text;
    size: integer;
    point: integer;
    was_generated: boolean;
    path: string;
    Clocks_start: TDateTime;
    clock: TDateTime;
    status_of_game: integer;
  public
    { public declarations }
  end;

var
  FormKakuro: TFormKakuro;

implementation

{$R *.lfm}

{ TFormKakuro }

{****f* Unit1/TFormKakuro.FormCreate(Sender:TOnject)
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    заносит начальные значения в переменные
 ****}
procedure TFormKakuro.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //начальные значения
  for i := 1 to 11 do
    FormKakuro.players[i] := '';
  FormKakuro.difficult := none;
  FormKakuro.size := 0;
  FormKakuro.was_generated := False;
  Formkakuro.point := 0;
  FormKakuro.path := '';
  Formkakuro.btns[1] := FormKakuro.LabelBtn1;
  Formkakuro.btns[2] := FormKakuro.LabelBtn2;
  Formkakuro.btns[3] := FormKakuro.LabelBtn3;
  Formkakuro.btns[4] := FormKakuro.LabelBtn4;
  Formkakuro.btns[5] := FormKakuro.LabelBtn5;
  Formkakuro.btns[6] := FormKakuro.LabelBtn6;
  Formkakuro.btns[7] := FormKakuro.LabelBtn7;
  Formkakuro.btns[8] := FormKakuro.LabelBtn8;
  Formkakuro.btns[9] := FormKakuro.LabelBtn9;
  //начальные значения
end;

{****f* Unit1/TFormKakuro.LabelResetClick(Sender:TOnject)
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *   сброс времени игры и введенных значений уровня
 ****}
procedure TFormKakuro.LabelResetClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
      if FormKakuro.kakuro[i, j].btype = 2 then
      begin
        FormKakuro.components_for_game[i, j].Caption := '';
        FormKakuro.kakuro[i, j].bvalue1 := 0;
      end;
  FormKakuro.status_of_game := 0;
  Formkakuro.Clocks_start := now();
  FormKakuro.clock := strtotime('00:00:00');
  if not (FormKakuro.was_generated) then
    FormKakuro.save;
end;

 {****f* Unit1/TFormKakuro.LabelSaveClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    сохранение результата
 ****}
procedure TFormKakuro.LabelSaveClick(Sender: TObject);
begin
  FormKakuro.save;
end;

{****f* Unit1/TFormKakuro.LabelBackToLavelsClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    возврат в меню  уровней сложности и генерации
 ****}
procedure TFormKakuro.LabelBackToLavelsClick(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 10 do
  begin
    if FormKakuro.LevelsInfo[i] <> nil then
    begin
      FormKakuro.LevelsInfo[i].Free;
      FormKakuro.LevelsInfo[i] := nil;
    end;
    if FormKakuro.LevelsPanel[i] <> nil then
    begin
      FormKakuro.LevelsPanel[i].Free;
      FormKakuro.LevelsPanel[i] := nil;
    end;
  end;
  FormKakuro.PanelChooseLvl.Visible := False;
  FormKakuro.difficult := none;
end;

{****f* Unit1/TFormKakuro.LabelLvlClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *   вывод статистики уровня с загрузкой из файла
 ****}
procedure TFormKakuro.LabelLvlClick(Sender: TObject);
var
  i: integer;
begin
  FormKakuro.getpath;
  FormKakuro.path += '\' + TLabel(Sender).Parent.Caption;
  FormKakuro.getstatistic;
  ShowMessage(FormKakuro.players[1] + ' ' + timetostr(FormKakuro.times[1]) +
    #13 + FormKakuro.players[2] + ' ' + timetostr(FormKakuro.times[2]) +
    #13 + FormKakuro.players[3] + ' ' + timetostr(FormKakuro.times[3]) +
    #13 + FormKakuro.players[4] + ' ' + timetostr(FormKakuro.times[4]) +
    #13 + FormKakuro.players[5] + ' ' + timetostr(FormKakuro.times[5]) +
    #13 + FormKakuro.players[6] + ' ' + timetostr(FormKakuro.times[6]) +
    #13 + FormKakuro.players[7] + ' ' + timetostr(FormKakuro.times[7]) +
    #13 + FormKakuro.players[8] + ' ' + timetostr(FormKakuro.times[8]) +
    #13 + FormKakuro.players[9] + ' ' + timetostr(FormKakuro.times[9]) +
    #13 + FormKakuro.players[10] + ' ' + timetostr(FormKakuro.times[10]));
  for i := 1 to 10 do
    FormKakuro.players[i] := '';
end;

 {****f* Unit1/TFormKakuro.PanelLvlClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *   загрузка данных уровня, генерация его игрового поля, создание компонентов формы соответствующие игровому
 ****}
procedure TFormKakuro.PanelLvlClick(Sender: TObject);
var
  line: string;
  i, j: integer;
  logic: boolean;
begin
  FormKakuro.getpath;
  FormKakuro.path += '\' + TPanel(Sender).Caption;
  FormKakuro.was_generated := False;
    {$I-}
  logic := True;
  i := 1;
  system.Assign(FormKakuro.document, FormKakuro.path);
  if IOResult = 0 then
  begin
    system.Reset(FormKakuro.document);
    if IOResult = 0 then
    begin
      // статистика
      while logic and (i < 11) do
      begin
        readln(FormKakuro.document, line);
        if IOResult <> 0 then
          logic := False;
        readln(FormKakuro.document, line);
        if IOResult <> 0 then
          logic := False;
        i += 1;
      end;
      //размер игрового поля
      if logic then
      begin
        readln(FormKakuro.document, line);
        if IOResult = 0 then
          FormKakuro.size := StrToInt(line)
        else
          logic := False;
      end;
      //состояние playing =1 or not playing=0
      if logic then
      begin
        readln(FormKakuro.document, line);
        if IOResult = 0 then
          FormKakuro.status_of_game := StrToInt(line)
        else
          logic := False;
      end;
      //time
      if logic then
      begin
        readln(FormKakuro.document, line);
        if IOResult = 0 then
          FormKakuro.Clock := strtodatetime(line)
        else
          logic := False;
      end;
      //занесение в какуро  типа блоков
      i := 1;
      while (i <= FormKakuro.size) and logic do
      begin
        j := 1;
        while (j <= FormKakuro.size) and logic do
        begin
          readln(FormKakuro.document, line);
          if IOResult = 0 then
            FormKakuro.kakuro[i, j].btype := StrToInt(line)
          else
            logic := False;
          j += 1;
        end;
        i += 1;
      end;
      //заненсение в какуро занчение value1
      i := 1;
      while (i <= FormKakuro.size) and logic do
      begin
        j := 1;
        while (j <= FormKakuro.size) and logic do
        begin
          readln(FormKakuro.document, line);
          if IOResult = 0 then
            FormKakuro.kakuro[i, j].bvalue1 := StrToInt(line)
          else
            logic := False;
          j += 1;
        end;
        i += 1;
      end;
      //заненсение в какуро занчение value2
      i := 1;
      while (i <= FormKakuro.size) and logic do
      begin
        j := 1;
        while (j <= FormKakuro.size) and logic do
        begin
          readln(FormKakuro.document, line);
          if IOResult = 0 then
            FormKakuro.kakuro[i, j].bvalue2 := StrToInt(line)
          else
            logic := False;
          j += 1;
        end;
        i += 1;
      end;
      if logic = False then
        ShowMessage('something''s wrong!!!');
    end
    else
      ShowMessage('reset file error');
    system.Close(FormKakuro.document);
    if IOResult <> 0 then
      ShowMessage('Close file error');
  end
  else
    ShowMessage('Assign  file error');
   {$I+}
  FormKakuro.getstatistic;
  FormKakuro.PanelChooseLvl.Visible := False;
  FormKakuro.PanelGame.Visible := True;
  FormKakuro.generate_components;
  Formkakuro.LabelSave.Enabled := True;
  Formkakuro.Labelinfo.Enabled := True;
end;

{****f* Unit1/TFormKakuro.LabelBtnsClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    выбор значения FormKakuro.point для дальнейшего использования его в качестве вводимого значения
 ****}
procedure TFormKakuro.LabelBtnsClick(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 9 do
    FormKakuro.btns[i].Font.Color := clwhite;
  TLabel(Sender).Font.Color := RGBToColor(255, 136, 18);
  FormKakuro.point := StrToInt(Tlabel(Sender).Caption);
end;

{****f* Unit1/TFormKakuro.LabelBackToChooseClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *  возврат в меню выбора уровня
 ****}
procedure TFormKakuro.LabelBackToChooseClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to 10 do
    FormKakuro.players[i] := '';
  for i := 1 to FormKakuro.maximum do
    for j := 1 to FormKakuro.maximum do
      if FormKakuro.components_for_game[i, j] <> nil then
      begin
        FormKakuro.components_for_game[i, j].Free;
        FormKakuro.components_for_game[i, j] := nil;
      end;
  for i := 1 to FormKakuro.maximum do
    for j := 1 to FormKakuro.maximum do
    begin
      FormKakuro.kakuro[i, j].btype := 0;
      FormKakuro.kakuro[i, j].bvalue1 := 0;
      FormKakuro.kakuro[i, j].bvalue2 := 0;
    end;
  FormKakuro.was_generated := False;
  FormKakuro.point := 0;
  FormKakuro.LabelInfo.Enabled := True;
  FormKakuro.PanelGame.Visible := False;
  FormKakuro.TimerKakuro.Enabled := False;
  FormKakuro.LabelTimer.Caption := '';
end;

  {****f* Unit1/TFormKakuro.LabelInfoClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    Вывод статистики уровня
 ****}
procedure TFormKakuro.LabelInfoClick(Sender: TObject);
begin
  ShowMessage(FormKakuro.players[1] + ' ' + timetostr(FormKakuro.times[1]) +
    #13 + FormKakuro.players[2] + ' ' + timetostr(FormKakuro.times[2]) +
    #13 + FormKakuro.players[3] + ' ' + timetostr(FormKakuro.times[3]) +
    #13 + FormKakuro.players[4] + ' ' + timetostr(FormKakuro.times[4]) +
    #13 + FormKakuro.players[5] + ' ' + timetostr(FormKakuro.times[5]) +
    #13 + FormKakuro.players[6] + ' ' + timetostr(FormKakuro.times[6]) +
    #13 + FormKakuro.players[7] + ' ' + timetostr(FormKakuro.times[7]) +
    #13 + FormKakuro.players[8] + ' ' + timetostr(FormKakuro.times[8]) +
    #13 + FormKakuro.players[9] + ' ' + timetostr(FormKakuro.times[9]) +
    #13 + FormKakuro.players[10] + ' ' + timetostr(FormKakuro.times[10]));
end;

{****f* Unit1/TFormKakuro.generate_components;
 *
 * ARGUMENTS
 *    None
 * FUNCTION
 *  функция генерации компонентов формы соотетствующие игровому полю
 ****}
procedure TFormKakuro.generate_components;
var
  i, j: integer;
  fTop, fLeft: integer;
  block: TLabel;
  fwidth: integer;
  fheight: integer;
begin
  for i := 1 to FormKakuro.maximum do
    for j := 1 to FormKakuro.maximum do
      if FormKakuro.components_for_game[i, j] <> nil then
      begin
        FormKakuro.components_for_game[i, j].Free;
        FormKakuro.components_for_game[i, j] := nil;
      end;

  fheight := ((FormKakuro.PanelGame.Height - 120) div FormKakuro.size) - 6;
  fwidth := (FormKakuro.PanelGame.Width div FormKakuro.size) - 6;
  fTop := 10;
  for i := 1 to FormKakuro.size do
  begin
    FLeft := 10;
    for j := 1 to FormKakuro.size do
    begin
      block := TLabel.Create(self);
      with block do
      begin
        autosize := False;
        top := fTop;
        left := fLeft;
        Width := fwidth;
        Height := fheight;
        parent := FormKakuro.PanelGame;
        font.size := -fheight + fheight div 3;
        alignment := tacenter;

        if FormKakuro.kakuro[i, j].btype <> 2 then
        begin
          Caption := Caption + IntToStr(FormKakuro.kakuro[i, j].bvalue1);
          Caption := Caption + '\';
          Caption := Caption + IntToStr(FormKakuro.kakuro[i, j].bvalue2);
          color := clwindowframe;
          font.color := clWhite;
        end
        else
        begin
          if FormKakuro.kakuro[i, j].bvalue1 <> 0 then
            Caption := IntToStr(FormKakuro.kakuro[i, j].bvalue1)
          else
            Caption := '';
          //caption:=inttostr(FormKakuro.kakuro[i,j].bvalue2); для проверки чисел сгенерируемых
          color := clwindowframe;
          font.color := clwhite;
          Cursor := crHandPoint;
          onclick := @game_cell_click;
          onmousemove := @game_cell_move;
          onmouseleave := @game_cell_leave;
        end;
        Tag := i * 1000 + j;
      end;
      FormKakuro.components_for_game[i, j] := block;
      fLeft += fwidth + 3;
    end;
    fTop += fheight + 3;
  end;
  Formkakuro.point := 0;
  FormKakuro.Clocks_start := Now();
  if FormKakuro.was_generated = False then
    Formkakuro.Clocks_start -= Formkakuro.clock
  else
    Formkakuro.clock := FormKakuro.Clocks_start;
  // if   FormKakuro.was_generated=false then showmessage('clock  '+timetostr( Formkakuro.clock)+#13+ 'clock start  '+timetostr(FormKakuro.Clocks_start));
  if FormKakuro.was_generated = True then
    FormKakuro.LabelInfo.Enabled := False
  else
    FormKakuro.LabelInfo.Enabled := True;
  FormKakuro.TimerKakuro.Enabled := True;
end;

{****f* Unit1/TFormKakuro.counters;
 *
 * ARGUMENTS
 *    None
 * FUNCTION
 *   функция проверки длинны игрового блока
 *
 ****}
procedure TFormKakuro.counters;
var
  i, j, m: integer;
  Count: integer;
begin
  //--------rigth----------------
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 1) or (FormKakuro.kakuro[i, j].btype = 0) then
      begin
        Count := 0;
        m := j + 1;
        while (FormKakuro.kakuro[i, m].btype = 2) and (m <= FormKakuro.size) do
        begin
          Count += 1;
          m += 1;
        end;
        if Count > 9 then
        begin
          FormKakuro.kakuro[i, j + 1].btype := 1;
          FormKakuro.kakuro[FormKakuro.size + 1 - i, FormKakuro.size +
            1 - (j + 1)].btype := 1;
        end;
      end;

  //------------------------
  //--------down----------------
  for j := 1 to FormKakuro.size do
    for i := 1 to FormKakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 1) or (FormKakuro.kakuro[i, j].btype = 0) then
      begin
        Count := 0;
        m := i + 1;
        while (FormKakuro.kakuro[m, j].btype = 2) and (m <= FormKakuro.size) do
        begin
          Count += 1;
          m += 1;
        end;
        if Count > 9 then
        begin
          FormKakuro.kakuro[i + 1, j].btype := 1;
          FormKakuro.kakuro[FormKakuro.size + 1 - (i + 1), FormKakuro.size +
            1 - j].btype := 1;
        end;
      end;
  //------------------------
end;

 {****f* Unit1/TFormKakurocorners;
 *
 * ARGUMENTS
 *  NONE
 * FUNCTION
 *     функция проверки углов на соответсвие корректности генерации
 *
 ****}
procedure TFormKakuro.corners;
var
  l: integer;
begin
  randomize;
  if FormKakuro.kakuro[2, 2].btype = 2 then
    if (FormKakuro.kakuro[3, 2].btype = 1) and (FormKakuro.kakuro[2, 3].btype = 1) then
    begin
      l := random(3) + 1;
      case l of
        1:
        begin
          FormKakuro.kakuro[3, 2].btype := 2;
          FormKakuro.kakuro[FormKakuro.size - 1, FormKakuro.size].btype := 2;
        end;
        2:
        begin
          FormKakuro.kakuro[2, 3].btype := 2;
          FormKakuro.kakuro[FormKakuro.size, FormKakuro.size - 1].btype := 2;
        end;
        3:
        begin
          FormKakuro.kakuro[2, 2].btype := 1;
          FormKakuro.kakuro[FormKakuro.size, FormKakuro.size].btype := 1;
        end;
      end;
    end;
  if FormKakuro.kakuro[2, FormKakuro.size].btype = 2 then
    if (FormKakuro.kakuro[3, FormKakuro.size].btype = 1) and
      (FormKakuro.kakuro[2, FormKakuro.size - 1].btype = 1) then
    begin
      l := random(3) + 1;
      case l of
        1:
        begin
          FormKakuro.kakuro[3, size].btype := 2;
          FormKakuro.kakuro[FormKakuro.size - 1, 2].btype := 2;
        end;
        2:
        begin
          FormKakuro.kakuro[2, size - 1].btype := 2;
          FormKakuro.kakuro[FormKakuro.size, 3].btype := 2;
        end;
        3:
        begin
          FormKakuro.kakuro[2, FormKakuro.size].btype := 1;
          FormKakuro.kakuro[FormKakuro.size, 2].btype := 1;
        end;
      end;
    end;
end;

{****f* Unit1/TFormKakuro.sides_tb;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *   функия проверки верхней и нижней границ на соответсвие корректности генерации
 *
 ****}
procedure TFormKakuro.sides_top_bot;
var
  j: integer;
  Count: integer;
  l, d: integer;
begin
  for j := 3 to FormKakuro.size - 1 do
  begin
    Count := 0;
    if FormKakuro.kakuro[2, j].btype = 2 then
    begin
      if FormKakuro.kakuro[2, j - 1].btype = 1 then
        Count += 1;
      if FormKakuro.kakuro[2, j + 1].btype = 1 then
        Count += 1;
      if FormKakuro.kakuro[3, j].btype = 1 then
        Count += 1;
      if Count >= 2 then
      begin
        l := random(2);
        d := 3;
        if l = 0 then
        begin
          FormKakuro.kakuro[2, j].btype := 2;
          kakuro[FormKakuro.size, FormKakuro.size + 2 - j].btype := 2;
        end;
        if l = 1 then
          while FormKakuro.kakuro[d, j].btype <> 2 do
          begin
            FormKakuro.kakuro[d, j].btype := 2;
            FormKakuro.kakuro[FormKakuro.size + 2 - d, FormKakuro.size -
              j + 2].btype := 2;
            d += 1;
          end;
      end;
    end;
  end;
end;

{****f* Unit1/TFormKakuro.
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *  функия проверки правой и левой границ на соответсвие корректности генерации
 ****}
procedure TFormKakuro.sides_lef_rig;
var
  i: integer;
  Count: integer;
  l, d: integer;
begin
  for i := 3 to size - 1 do
  begin
    Count := 0;
    if FormKakuro.kakuro[i, 2].btype = 2 then
    begin
      if FormKakuro.kakuro[i + 1, 2].btype = 1 then
        Count += 1;
      if FormKakuro.kakuro[i - 1, 2].btype = 1 then
        Count += 1;
      if FormKakuro.kakuro[i, 3].btype = 1 then
        Count += 1;
      if Count >= 2 then
      begin
        l := random(2);
        d := 3;
        if l = 0 then
        begin
          FormKakuro.kakuro[i, 2].btype := 2;
          FormKakuro.kakuro[FormKakuro.size + 2 - i, FormKakuro.size].btype := 2;
        end;
        if l = 1 then
          while (FormKakuro.kakuro[i, d].btype <> 2) or (d < FormKakuro.size div 2) do
          begin
            FormKakuro.kakuro[i, d].btype := 2;
            FormKakuro.kakuro[FormKakuro.size + 2 - i, FormKakuro.size -
              d + 2].btype := 2;
            d += 1;
          end;
      end;
    end;
  end;
end;

{****f* Unit1/TFormKakuro.generation;
 * ARGUMENTS
 *   NONE
 * FUNCTION
 *   функция генерации игрового поля
 ****}
procedure TFormKakuro.generation;
var
  i, j: integer;
  mirrow: integer;
  Count: integer;
begin
  randomize;
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
    begin
      FormKakuro.kakuro[i, j].btype := 0;
      FormKakuro.kakuro[i, j].bvalue1 := 0;
      FormKakuro.kakuro[i, j].bvalue2 := 0;
    end;
  for i := 1 to FormKakuro.size do
  begin
    FormKakuro.kakuro[1, i].btype := 0;
    FormKakuro.kakuro[1, i].bvalue1 := 0;
    FormKakuro.kakuro[1, i].bvalue2 := 0;
    FormKakuro.kakuro[i, 1].btype := 0;
    FormKakuro.kakuro[i, 1].bvalue1 := 0;
    FormKakuro.kakuro[i, 1].bvalue2 := 0;
  end;
  mirrow := (FormKakuro.size - 1) div 2;
  for i := 2 to mirrow + 1 do
    repeat
      Count := 0;
      for j := 2 to FormKakuro.size do
      begin
        FormKakuro.kakuro[i, j].btype := random(2) + 1;
        if (FormKakuro.kakuro[i, j].btype = 1) then
          Count += 1;
        FormKakuro.kakuro[FormKakuro.size + 2 - i, FormKakuro.size + 2 - j].btype :=
          FormKakuro.kakuro[i, j].btype;
      end;
    until Count < FormKakuro.size div 2;

  if (FormKakuro.size - 1) mod 2 = 1 then
  begin
    Inc(mirrow);
    for j := 2 to (FormKakuro.size div 2) + (FormKakuro.size mod 2) + 1 do
    begin
      FormKakuro.kakuro[mirrow + 1, j].btype := random(2) + 1;
      FormKakuro.kakuro[mirrow + 1, size + 2 - j].btype :=
        FormKakuro.kakuro[mirrow + 1, j].btype;
    end;
  end;
  FormKakuro.corners;
  FormKakuro.sides_top_bot;
  FormKakuro.sides_lef_rig;
  FormKakuro.counters;
end;

{****f* Unit1/TFormKakuro.values_right;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *  функция предназначена для нахождения суммы сгенерированных цифр, для занесения в соответствующие координаты игрового поля
 ****}
procedure TFormKakuro.values_right;
var
  i, j, m: integer;
  sum: integer;
begin
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 1) or (FormKakuro.kakuro[i, j].btype = 0) then
      begin
        sum := 0;
        m := j + 1;
        while (FormKakuro.kakuro[i, m].btype <> 1) and (m <= FormKakuro.size) do
        begin
          sum += FormKakuro.kakuro[i, m].bvalue2;
          m += 1;
        end;
        FormKakuro.kakuro[i, j].bvalue2 := sum;
      end;
end;

 {****f* Unit1/TFormKakuro.values_down;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *  функция предназначена для нахождения суммы сгенерированных цифр, для занесения в соответствующие координаты игрового поля
 ****}
procedure TFormKakuro.values_down;
var
  i, j, m: integer;
  sum: integer;
begin
  for j := 1 to FormKakuro.size do
    for i := 1 to FormKakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 1) or (FormKakuro.kakuro[i, j].btype = 0) then
      begin
        sum := 0;
        m := i + 1;
        while (FormKakuro.kakuro[m, j].btype <> 1) and
          (FormKakuro.kakuro[m, j].btype <> 0) and (m <= FormKakuro.size) do
        begin
          sum += FormKakuro.kakuro[m, j].bvalue2;
          m += 1;
        end;
        FormKakuro.kakuro[i, j].bvalue1 := sum;
      end;
end;

 {****f* Unit1/TFormKakuro.generate_numbers;
 *
 * ARGUMENTS
 *   NONE
 * FUNCTION
 *   функция генерации цифр в созданном поле
 ****}
procedure TFormKakuro.generate_numbers;
type
  digit = 1..9;
var
  i, j, m, n: integer;
  s: set of digit;
  q: boolean;
begin
  for i := 2 to Formkakuro.size do
    for j := 2 to Formkakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 2) then
      begin
        s := [];
        m := i;
        while (kakuro[m, j].btype = 2) and (m >= 2) do
        begin
          if not (kakuro[m, j].bvalue2 in s) then
            s += [kakuro[m, j].bvalue2];
          m -= 1;
        end;
        m := j;
        while (kakuro[i, m].btype = 2) and (m >= 2) do
        begin
          if not (kakuro[i, m].bvalue2 in s) then
            s += [kakuro[i, m].bvalue2];
          m -= 1;
        end;
        repeat
          q := True;
          for n := 1 to 9 do
            if not (n in s) then
              q := False;
          if not (q) then
            kakuro[i, j].bvalue2 := random(9) + 1
          else
          begin
            FormKakuro.kakuro[i, j].btype := 1;
            FormKakuro.kakuro[FormKakuro.size + 2 - i, FormKakuro.size + 2 - j].btype := 1;
            q := True;
          end;
        until not (kakuro[i, j].bvalue2 in s) or q;
      end;
  s := [];
  FormKakuro.values_right;
  FormKakuro.values_down;
end;

{****f* Unit1/TFormKakuro.LabelDoGenClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция для подтверждения генерации головоломки с полем размеров NxN,  где N равен вводимому значению в    FormKakuro.EditGen
 ****}
procedure TFormKakuro.LabelDoGenClick(Sender: TObject);
begin
  try
    if StrToInt(FormKakuro.EditGen.Text) in
      [FormKakuro.minimum..FormKakuro.maximum - 1] then
    begin
      FormKakuro.size := StrToInt(FormKakuro.EditGen.Text);
      FormKakuro.was_generated := True;
      FormKakuro.generation;
      FormKakuro.generate_numbers;
      FormKakuro.PanelGeneration.Visible := False;
      FormKakuro.PanelGame.Visible := True;
      FormKakuro.generate_components;
      FormKakuro.LabelSave.Enabled := False;
    end
    else
      ShowMessage('ожидалось число в диапазоне 4-12');
  except
    on EConvertError do
      ShowMessage('ожидалось число в диапазоне 4-12');
  end;
end;

  {****f* Unit1/TFormKakuro.LabelGenCancelClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *   отменить генерацию головоломки
 ****}
procedure TFormKakuro.LabelGenCancelClick(Sender: TObject);
begin
  FormKakuro.PanelGeneration.Visible := False;
end;

{****f* Unit1/TFormKakuro.LabelGenerationClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция открытия диалогового окна для генерации головоломки
 ****}
procedure TFormKakuro.LabelGenerationClick(Sender: TObject);
begin
  FormKakuro.PanelGeneration.Visible := True;
  Formkakuro.EditGen.Text := '';
end;

{****f* Unit1/TFormKakuro.LabelHelpClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция для вывода подсказки
 *    при выводе подсказки игрок штрафуется на 30 секунд
 ****}
procedure TFormKakuro.LabelHelpClick(Sender: TObject);
var
  i, j: integer;
  Count: integer;
  numeric: integer;
begin
  randomize;
  Count := 0;
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 2) and
        (FormKakuro.kakuro[i, j].bvalue1 = 0) then
        Count += 1;
  numeric := random(Count) + 1;
  Count := 0;
  for i := 1 to formkakuro.size do
    for j := 1 to formkakuro.size do
      if (FormKakuro.kakuro[i, j].btype = 2) and
        (FormKakuro.kakuro[i, j].bvalue1 = 0) then
      begin
        Count += 1;
        if Count = numeric then
        begin
          FormKakuro.Clocks_start :=
            incsecond(FormKakuro.Clocks_start, -30);
          FormKakuro.components_for_game[i, j].Caption :=
            IntToStr(FormKakuro.kakuro[i, j].bvalue2);
          FormKakuro.kakuro[i, j].bvalue1 :=
            FormKakuro.kakuro[i, j].bvalue2;
          FormKakuro.complete;
        end;
      end;
end;

 {****f* Unit1/TFormKakuro.LabelBackMainMenuClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция возврата в главного меню
 ****}
procedure TFormKakuro.LabelBackMainMenuClick(Sender: TObject);
begin
  FormKakuro.PanelLevels.Visible := False;
end;

{****f* Unit1/TFormKakuro.LabelDIFClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция отображения всех уровней выбранного уровня сложности
 *    считывает из директории файлы *.kak и создает динамические компоненты
 ****}
procedure TFormKakuro.LabelDIFClick(Sender: TObject);
var
  Info: TSearchRec;
  i: integer;
  Created_panel: TPanel;
  Created_label: TLabel;
begin
  case TLabel(Sender).Tag of
    1: FormKakuro.difficult := easy;
    2: FormKakuro.difficult := normal;
    3: FormKakuro.difficult := hard;
  end;
  FormKakuro.getpath;
  for i := 1 to 10 do
  begin
    if FormKakuro.LevelsInfo[i] <> nil then
    begin
      FormKakuro.LevelsInfo[i].Free;
      FormKakuro.LevelsInfo[i] := nil;
    end;
    if FormKakuro.LevelsPanel[i] <> nil then
    begin
      FormKakuro.LevelsPanel[i].Free;
      FormKakuro.LevelsPanel[i] := nil;
    end;
  end;
  i := 1;
  if FindFirst(FormKakuro.path + '\*.kak', faAnyFile, Info) = 0 then
  begin
    repeat
      if (Info.Attr and faAnyFile) = 32 then
      begin
        Created_panel := TPanel.Create(self);
        with Created_panel do
        begin
          align := altop;
          Height := 50;
          color := clwhite;
          onclick := @PanelLvlClick;
          onmousemove := @PanelMove;
          onmouseleave := @panelleave;
          Caption := info.Name;
          parent := FormKakuro.ScrollBoxLvl;
        end;
        FormKakuro.LevelsPanel[i] := Created_panel;
        Created_label := Tlabel.Create(self);
        with Created_label do
        begin
          left := 2;
          top := 2;
          Width := 45;
          Height := 45;
          alignment := tacenter;
          font.Color := clwhite;
          font.Size := 24;
          autosize := False;
          onclick := @labelLvlclick;
          onmousemove := @LabelMouseMove;
          onmouseleave := @LabelMouseLeave;
          Color := $00FE637A;
          Caption := 'i';
          parent := FormKakuro.LevelsPanel[i];
        end;
        FormKakuro.LevelsInfo[i] := Created_label;
        i += 1;
      end;
    until (FindNext(info) <> 0);
    FindClose(Info);
  end
  else
    ShowMessage('error');
  FormKakuro.LabelDif.Caption := TLabel(Sender).Caption;
  FormKakuro.PanelChooseLvl.Visible := True;
  FormKakuro.path := '';
end;

{****f* Unit1/TFormKakuro.LabelPlayClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    переход в меню выбора уровня сложности или генерации из главного меню
 ****}
procedure TFormKakuro.LabelPlayClick(Sender: TObject);
begin
  Formkakuro.PanelLevels.Visible := True;
end;

{****f* Unit1/TFormKakuro.LabelRulesClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    показать правила игры
 ****}
procedure TFormKakuro.LabelRulesClick(Sender: TObject);
begin
  FormKakuro.PanelRules.Visible := True;
end;

{****f* Unit1/TFormKakuro.LabelExitClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    закрытие приложения
 ****}
procedure TFormKakuro.LabelExitClick(Sender: TObject);
begin
  self.Close;
end;

{****f* Unit1/TFormKakuro.LabelBackClick(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    закрытие правил игры
 ****}
procedure TFormKakuro.LabelBackClick(Sender: TObject);
begin
  Formkakuro.PanelRules.Visible := False;
end;

{****f* Unit1/TFormKakuro.PanelLeave(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция предназначена для графических эффектов при снятии наведения мыши
 ****}
procedure TFormKakuro.PanelLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clblack;
end;

{****f* Unit1/TFormKakuro.PanelMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *     функция предназначена для дополнительных графических отображений при наведении курсора мыши на объект
 *
 ****}
procedure TFormKakuro.PanelMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  TPanel(Sender).Cursor := crHandPoint;
  TPanel(Sender).Font.Color := RGBToColor(255, 136, 17);
end;

{****f* Unit1/TFormKakuro.LabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *     функция предназначена для дополнительных графических отображений при наведении курсора мыши на объект
 *
 ****}
procedure TFormKakuro.LabelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if TLabel(Sender).Font.Color <> RGBToColor(255, 136, 18) then
    TLabel(Sender).Font.Color := RGBToColor(255, 136, 17);
  TLabel(Sender).Cursor := crHandPoint;
end;

{****f* Unit1/TFormKakuro.LabelMouseLeave(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция предназначена для дополнительных графических отображений при снятии  наведении курсора мыши с объекта
 ****}
procedure TFormKakuro.LabelMouseLeave(Sender: TObject);
begin
  if TLabel(Sender).Font.Color <> RGBToColor(255, 136, 18) then
    TLabel(Sender).Font.Color := clwhite;
end;

procedure TFormKakuro.MenuItemInfoClick(Sender: TObject);
begin
  showmessage('автор -рогулев илья'+#13+'версия 1.0'+#13+'автор рисунков Kenny Louie'+#13+'https://www.flickr.com/photos/kwl/');
end;

{****f* Unit1/TFormKakuro.game_cell_move(Sender: TObject; Shift: TShiftState; X, Y: integer);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция предназначена для дополнительных графических отображений при наведении курсора мыши на объект
 *
 ****}
procedure TFormKakuro.game_cell_move(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  TLabel(Sender).Color := clwhite;
  TLabel(Sender).font.color := clwindowframe;
end;

 {****f* Unit1/TFormKakuro.game_cell_leave(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    функция предназначена для дополнительных графических отображений при снятии  наведении курсора мыши с объекта
 ****}
procedure TFormKakuro.game_cell_leave(Sender: TObject);
begin
  TLabel(Sender).Color := clwindowframe;
  TLabel(Sender).font.color := clwhite;
end;

{****f* Unit1/TFormKakuro.(Sender:TOnject)
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 * обработка нажатия на игровую панель
 ****}
procedure TFormKakuro.game_cell_click(Sender: TObject);
var
  i, j: integer;
begin
  i := 0;
  j := 0;
  if FormKakuro.point = 0 then
    ShowMessage('не выбрано число')
  else
  begin
    j := TLabel(Sender).tag mod 100;
    i := TLabel(Sender).tag div 1000;
    if FormKakuro.kakuro[i, j].bvalue2 = FormKakuro.point then
    begin
      TLabel(Sender).Caption := IntToStr(FormKakuro.point);
      FormKakuro.kakuro[i, j].bvalue1 := FormKakuro.kakuro[i, j].bvalue2;
    end
    else
      FormKakuro.Clocks_start := incsecond(FormKakuro.Clocks_start, -30);
  end;
  FormKakuro.complete;
end;

 {****f* Unit1/TFormKakuro.TimerKakuroTimer(Sender: TObject);
 *
 * ARGUMENTS
 *    Sender - источник события
 * FUNCTION
 *    обработка действий таймера
 ****}
procedure TFormKakuro.TimerKakuroTimer(Sender: TObject);
begin
  FormKakuro.Clock := Now() - FormKakuro.Clocks_start;
  FormKakuro.LabelTimer.Caption := timetostr(FormKakuro.Clock);
end;

{****f* Unit1/TFormKakuro.statistic_sort;
*
* ARGUMENTS
*    NONE
* FUNCTION
*    обновление статистики
****}
procedure TFormKakuro.statistic_sort;
var
  i, j: integer;
  logic: boolean;
  swp: TDateTime;
  person:string;
begin

      //сортировка
      logic := True;
      while logic do
      begin
        logic := False;
        for i := 11 downto 2 do
          if (Formkakuro.times[i] > FormKakuro.times[i - 1]) then
          begin
            logic := True;
            swp := FormKakuro.times[i];
            Formkakuro.times[i] := Formkakuro.times[i - 1];
            Formkakuro.times[i - 1] := swp;
            person := Formkakuro.players[i];
            Formkakuro.players[i] := Formkakuro.players[i - 1];
            Formkakuro.players[i - 1] := person;
          end;
      end;
      j := 1;
      for i := 1 to 11 do
        if FormKakuro.times[i] = strtotime('00:00:00') then
          j += 1;

      //находим кол-во не нулевых элементов и сортируем их по убыванию
      logic := True;
      while logic do
      begin
        logic := False;
        for i := 1 to 11 - j do
          if (Formkakuro.times[i] > FormKakuro.times[i + 1]) then
          begin
            logic := True;
            swp := FormKakuro.times[i];
            Formkakuro.times[i] := Formkakuro.times[i + 1];
            Formkakuro.times[i + 1] := swp;
            person:= Formkakuro.players[i];
            Formkakuro.players[i] := Formkakuro.players[i + 1];
            Formkakuro.players[i + 1] := person;
          end;
      end;

end;

{****f* Unit1/TFormKakuro.complete;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *    функция выявления завершения уровня
 ****}
procedure TFormKakuro.complete;
var
  i, j: integer;
  logic: boolean;
  name_of_player: string;
begin
  logic := True;
  //выявление выигрыша
  for i := 1 to FormKakuro.size do
    for j := 1 to FormKakuro.size do
      if FormKakuro.kakuro[i, j].btype = 2 then
        if FormKakuro.kakuro[i, j].bvalue1 <> FormKakuro.kakuro[i, j].bvalue2 then
          logic := False;
  //если выиграл то
  if logic then
  begin
    //остановка таймера   и вывод сообщения овыигрыше
    FormKakuro.TimerKakuro.Enabled := False;
    ShowMessage('you win!');
    //если это уровень то сохранить ли результат
    if FormKakuro.was_generated <> False then
      FormKakuro.PanelGame.Visible := False
    else
    if MessageDlg('', 'сохранить результат?', mtConfirmation, mbOKCancel, 0) =
      mrOk then
    begin
      name_of_player := 'no-name';
      if not InputQuery('Test program', 'Пожалуйста, укажите своё имя', name_of_player)
      then   ShowMessage('Пользователь прервал диалог');


      FormKakuro.getstatistic;
      //занесение результатов в дополнительный блок массива
      FormKakuro.times[11] := FormKakuro.clock;
      FormKakuro.players[11] := name_of_player;
      FormKakuro.statistic_sort;

      //вывод на экран результатов
      ShowMessage(FormKakuro.players[1] + ' ' + timetostr(FormKakuro.times[1]) +
        #13 + FormKakuro.players[2] + ' ' + timetostr(FormKakuro.times[2]) +
        #13 + FormKakuro.players[3] + ' ' + timetostr(FormKakuro.times[3]) +
        #13 + FormKakuro.players[4] + ' ' + timetostr(FormKakuro.times[4]) +
        #13 + FormKakuro.players[5] + ' ' + timetostr(FormKakuro.times[5]) +
        #13 + FormKakuro.players[6] + ' ' + timetostr(FormKakuro.times[6]) +
        #13 + FormKakuro.players[7] + ' ' + timetostr(FormKakuro.times[7]) +
        #13 + FormKakuro.players[8] + ' ' + timetostr(FormKakuro.times[8]) +
        #13 + FormKakuro.players[9] + ' ' + timetostr(FormKakuro.times[9]) +
        #13 + FormKakuro.players[10] + ' ' + timetostr(FormKakuro.times[10]));
      //обнуление часов и статуса
      FormKakuro.clock := strtotime('0:00:00');
      Formkakuro.status_of_game := 0;
     //обнуление игровых полей
      for i := 1 to FormKakuro.size do
        for j := 1 to FormKakuro.size do
          if (FormKakuro.kakuro[i, j].btype = 2) then
            FormKakuro.kakuro[i, j].bvalue1 := 0;
       //сохранение результата
      FormKakuro.save;
    end;
     FormKakuro.PanelGame.Visible := False;
  end;
end;

{****f* Unit1/TFormKakuro.save;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *   сохранение статистики и состояния уровня
 ****}
procedure TFormKakuro.save;
var
  i, j: integer;
  line: string;
  logic:boolean;
  num:string;
begin
  logic:=true;
  num:='';
    {$I-}
  system.Assign(FormKakuro.document, FormKakuro.path);
  if IOResult = 0 then
  begin
    system.Rewrite(FormKakuro.document);
    if IOResult = 0 then
    begin
      //статистика
      for i := 1 to 10 do
      begin
        line := FormKakuro.players[i];
        writeln(FormKakuro.document, line);
        if IOResult<>0 then  begin
           logic:=false;
           num:=' players';
         end;
        line := timetostr(FormKakuro.times[i]);
        writeln(FormKakuro.document, line);
         if IOResult<>0 then  begin
           logic:=false;
           num:=' times';
         end;
      end;
      //размер
      line := IntToStr(FormKakuro.size);
      writeln(FormKakuro.document, line);
       if IOResult<>0 then  begin
           logic:=false;
           num:=' size';
         end;
      //статус
      line := IntToStr(FormKakuro.status_of_game);
      writeln(FormKakuro.document, line);
       if IOResult<>0 then  begin
           logic:=false;
           num:=' status';
         end;
      //время
      line := timetostr(Formkakuro.clock);
      writeln(FormKakuro.document, line);
      if IOResult<>0 then  begin
           logic:=false;
           num:=' time';
         end;
      //занесение типов блока
      for i := 1 to FormKakuro.size do
        for j := 1 to FormKakuro.size do
        begin
          line := IntToStr(Formkakuro.kakuro[i, j].btype);
          writeln(FormKakuro.document, line);
           if IOResult<>0 then  begin
           logic:=false;
           num:=' type';
         end;
        end;
      //значение 1
      for i := 1 to FormKakuro.size do
        for j := 1 to FormKakuro.size do
        begin
          line := IntToStr(Formkakuro.kakuro[i, j].bvalue1);
          writeln(FormKakuro.document, line);
           if IOResult<>0 then  begin
           logic:=false;
           num:=' value1';
         end;
        end;
      //значение 2
      for i := 1 to Formkakuro.size do
        for j := 1 to FormKakuro.size do
        begin
          line := IntToStr(Formkakuro.kakuro[i, j].bvalue2);
          writeln(FormKakuro.document, line);
           if IOResult<>0 then  begin
           logic:=false;
           num:=' value2';
         end;
        end;
       if  logic=false then showmessage('error while writing in file'+num);
    end
    else
      ShowMessage('rewrite file error');
    system.Close(FormKakuro.document);
    if IOResult <> 0 then
      ShowMessage('Close file error');
  end
  else
    ShowMessage('Assign  file error');

     {$I+}
end;

{****f* Unit1/TFormKakuro.getpath
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *   выбор директории в зависимости от уровня сложности
 ****}
procedure TFormKakuro.getpath;
begin
  FormKakuro.path := 'files\levels';
  case FormKakuro.difficult of
    easy: FormKakuro.path += 'easy';
    normal: FormKakuro.path += 'normal';
    hard: FormKakuro.path += 'hard';
  end;
end;

{****f* Unit1/TFormKakuro.getstatic;
 *
 * ARGUMENTS
 *    NONE
 * FUNCTION
 *  получение статистики уровня
 ****}
procedure TFormKakuro.getstatistic;
var
  i: integer;
  logic: boolean;
  line: string;
begin
  {$I-}
  i := 1;
  logic := True;
  system.Assign(FormKakuro.document, FormKakuro.path);
  if IOResult = 0 then
  begin
    system.Reset(FormKakuro.document);
    if IOResult = 0 then
      while (logic) and (not EOF(FormKakuro.document)) and (i < 11) do
      begin
        readln(FormKakuro.document, line);
        if IOResult = 0 then
          FormKakuro.players[i] := line
        else
          logic := False;
        readln(FormKakuro.document, line);
        if IOResult = 0 then
        begin
          Formkakuro.times[i] := strtotime(line);
        end
        else
          logic := False;
        i += 1;
      end
    else
      ShowMessage('reset file error');
    system.Close(FormKakuro.document);
    if IOResult <> 0 then
      ShowMessage('Close file error');
  end
  else
    ShowMessage('Assign  file error');
 {$I+}
end;



end.
