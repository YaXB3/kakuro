
uses
  crt;

const
  maximum = 14;
  minimum = 4;
  blocksize = 30;

type
  blocks = record
    btype, bvalue1, bvalue2: integer;
  end;
  
  

var
  kakuro: array[1..maximum, 1..maximum] of blocks;
  size: integer;
  path: string;
  files:text;
  lo,jo:integer;
  a:string;
  
procedure write_kakuro_info;
var
  i, j: integer;
begin
  crt.ClrScr;  
  writeln('value-rigth');
  for i := 1 to size do  begin 
  writeln;
  for j := 1 to size do if (kakuro[i, j].btype = 1) then begin 
                          crt.TextBackground(crt.LightGray);
                          write(kakuro[i, j].bvalue2:3);
                          crt.TextBackground(white); 
                        end
                        else if (kakuro[i, j].btype = 0) then begin 
                          crt.TextBackground(crt.Yellow);
                          write(kakuro[i, j].bvalue2:3);
                          crt.TextBackground(white); 
                        end
                        else write(kakuro[i, j].bvalue2:3); end;
  
  
  writeln;
 writeln('value-down');
  for i := 1 to size do  begin 
  writeln;
  
  for j := 1 to size do if (kakuro[i, j].btype = 1) then begin 
                          crt.TextBackground(crt.LightGray);
                          write(kakuro[i, j].bvalue1:3);
                          crt.TextBackground(white); 
                        end
                        else if (kakuro[i, j].btype = 0) then begin 
                          crt.TextBackground(crt.Yellow);
                          write(kakuro[i, j].bvalue1:3);
                          crt.TextBackground(white); 
                        end
                        else write(kakuro[i, j].bvalue2:3); end; 
  
  writeln;   
  readkey;
end;



begin
crt.TextBackground(white);
crt.TextColor(black);
crt.ClrScr;
   assign(files,'hard\1.txt');
        reset(files);
          for lo:= 1 to 10 do begin
          readln(files,a);
          writeln(a);
          end;
          readln(files,a);
          size:=strtoint(a);
          writeln(size);
          
          for lo:= 1 to size do
            for jo:=1 to size do
              begin
                 readln(files,a); 
                 kakuro[lo,jo].btype:=strtoint(a);                            
              end;
              
          for lo:= 1 to size do
            for jo:=1 to size do
              begin
                readln(files,a); 
                kakuro[lo,jo].bvalue1:=strtoint(a);                             
              end;
          for lo:= 1 to size do
            for jo:=1 to size do
              begin
                readln(files,a); 
                kakuro[lo,jo].bvalue2:=strtoint(a);                             
              end;       
              
          
          
        close (files);


write_kakuro_info;
end.