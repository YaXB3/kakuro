
uses
  crt;

const
  maximum = 12;
  minimum = 4;
  blocksize = 30;

type
  blocks = record
    btype, bvalue1, bvalue2: integer;
  end;

var
  kakuro: array[1..maximum, 1..maximum] of blocks;
  size: integer;



procedure write_kakuro_info;
var
  i, j: integer;
begin
  crt.ClrScr;
  writeln('type');
  for i := 1 to size do  begin writeln; for j := 1 to size do if(kakuro[i, j].btype=1) then begin crt.TextBackground(black); write(kakuro[i, j].btype:2); crt.TextBackground(white); end else write(kakuro[i, j].btype:2);  end;
  writeln;{
  writeln('value-rigth');
  for i := 1 to size do  begin writeln; for j := 1 to size do write(kakuro[i, j].bvalue2:2); end;
  writeln;
  writeln('value-down');
  for i := 1 to size do  begin writeln; for j := 1 to size do write(kakuro[i, j].bvalue1:2); end;
  writeln; }
  readkey;
end;


procedure bridge;
var count:integer; i,j:integer;
begin
  for i:= 1 to size do for j:= 1 to size do if kakuro[i,j].btype=1 then begin
    count:=0;
     
  end; 


end;


procedure generation;
var
  i, j: integer;
  mirrow: integer;
begin
  randomize;
  for i := 1 to size do 
  begin
    kakuro[1, i].btype := 0;
    kakuro[1, i].bvalue1 := 0;
    kakuro[1, i].bvalue2 := 0;
    kakuro[i, 1].btype := 0;
    kakuro[i, 1].bvalue1 := 0;
    kakuro[i, 1].bvalue2 := 0;
  end;  
  
  // size mod 2=0 
  mirrow := size div 2; 
    for i := 2 to  mirrow do 
      for j := 2 to size do 
      begin
        kakuro[i,j].btype:=random(2)+1;
        kakuro[size+2-i,size+2-j].btype:= kakuro[i,j].btype;      
      end;
      
     mirrow+=1;
    
  if size mod 2 =0 then begin     
      for j:= 2 to size div 2 do  begin kakuro[mirrow,j].btype:=random(2)+1;kakuro[mirrow,size+2-j].btype:=kakuro[mirrow,j].btype  end;
      kakuro[mirrow,j+1].btype:=random(2)+1;  
  end 
  else begin   
    for j:= 2 to size do  begin 
        kakuro[mirrow,j].btype:=random(2)+1;
        kakuro[size+2-mirrow,size+2-j].btype:= kakuro[mirrow,j].btype;
    end;
  end;
  
end;

begin
  crt.TextBackground(white);
  crt.TextColor(black);
  crt.ClrScr;
  write('ввести size- ');
  readln(size);
  write_kakuro_info;
  generation;
  write_kakuro_info;
  
  
end.