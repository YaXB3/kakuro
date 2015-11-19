unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TFormKakuro }

  TFormKakuro = class(TForm)
    ImageLevels: TImage;
    ImageHint: TImage;
    ImageExample: TImage;
    ImageRules: TImage;
    ImageMain: TImage;
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
    PanelLevels: TPanel;
    PanelRules: TPanel;
    PanelMainMenu: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure LabelBackClick(Sender: TObject);
    procedure LabelBackMainMenuClick(Sender: TObject);

    procedure LabelExitClick(Sender: TObject);
    procedure LabelPlayClick(Sender: TObject);
    procedure LabelRulesClick(Sender: TObject);

    procedure LabelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabelMouseLeave(Sender: TObject);





  private
    { private declarations }  {
    const maximum=12;  //maximum size of area
          minimum=4;   //minimum size of area
          block_size=30; // size of block


   type
       players=record
            pname:string[30];
            ptime:string[8];
       end;

       blocks= record
            btype:integer;
            bvalue1,bvalue2:integer;
            bstatus:integer;
       end;

   var  best_players:array[1..10] of players;      //для отображения лучших 10 игроков
        components:array[1..maximum,1..maximum] of TEdit;                             // для создания динамических объектов для игры
        kakuro:array[1..maximum,1..maximum] of blocks;                                //для записи в массив данных на основе которых буддет строиться components
  }
  public
    { public declarations }
  end;

var
  FormKakuro: TFormKakuro;

implementation

{$R *.lfm}

{ TFormKakuro }

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
   Formkakuro.PanelLevels.Visible:=false;
end;


{*****f TFormKakuro.LabelExitClick(Sender:TObject);
      close the form
}
procedure TFormKakuro.LabelExitClick(Sender: TObject);
begin
  self.Close;
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

end.

