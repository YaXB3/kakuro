
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


procedure corners;
var
  l: integer;
begin
  randomize;
  if kakuro[2, 2].btype = 2 then if (kakuro[3, 2].btype = 1) and (kakuro[2, 3].btype = 1) then  
    begin
      l := random(3) + 1;
      case l of
        1: begin kakuro[3, 2].btype := 2; kakuro[size - 1, size].btype := 2; end;
        2: begin kakuro[2, 3].btype := 2; kakuro[size, size - 1].btype := 2; end;
        3: begin kakuro[2, 2].btype := 1; kakuro[size, size].btype := 1; end;
      end;    
    end;  
  if kakuro[2, size].btype = 2 then if (kakuro[3, size].btype = 1) and (kakuro[2, size - 1].btype = 1) then
    begin
      l := random(3) + 1;
      case l of 
        1: begin kakuro[3, size].btype := 2;kakuro[size - 1, 2].btype := 2;  end;
        2: begin kakuro[2, size - 1].btype := 2;kakuro[size, 3].btype := 2;  end; 
        3: begin kakuro[2, size].btype := 1;kakuro[size, 2].btype := 1; end;
      end;    
    end;  
end;

procedure sides_tb;
var
  j: integer; count: integer;
  l, d: integer;
begin
  for j := 3 to size - 1 do 
  begin
    count := 0;
    if kakuro[2, j].btype = 2 then begin
      if kakuro[2, j - 1].btype = 1 then count += 1;
      if kakuro[2, j + 1].btype = 1 then count += 1;
      if kakuro[3, j].btype = 1 then count += 1;
      if count >= 2 then begin
        l := random(2);
        d := 3;
        if l = 0 then begin kakuro[2, j].btype := 2;kakuro[size, size + 2 - j].btype := 2;  end;
        if l = 1 then while kakuro[d, j].btype <> 2 do 
          begin
            kakuro[d, j].btype := 2;
            kakuro[size + 2 - d, size - j + 2].btype := 2;
            d += 1;                
          end;
      end;
    end;
  end;
end;

procedure sides_lr;
var
  i: integer; count: integer;
  l, d: integer;
begin
  for i := 3 to size - 1 do 
  begin
    count := 0;
    if kakuro[i, 2].btype = 2 then begin
      if kakuro[i + 1, 2].btype = 1 then count += 1;
      if kakuro[i - 1, 2].btype = 1 then count += 1;
      if kakuro[i, 3].btype = 1 then count += 1;
      if count >= 2 then begin
        l := random(2);
        d := 3;
        if l = 0 then begin kakuro[i, 2].btype := 2;kakuro[size + 2 - i, size].btype := 2;  end;
        if l = 1 then while (kakuro[i, d].btype <> 2)  or (d < size div 2) do 
          begin
            kakuro[i, d].btype := 2;
            kakuro[size + 2 - i, size - d + 2].btype := 2;
            d += 1;                
          end;
      end;
    end; 
  end;
end;

procedure center;
var
  count: integer; 
  i, j: integer;
  l, d: integer;
begin
  for i := 2 to size - 1 do 
    for j := 2 to size - 1 do 
    begin
      count := 0;    
      if kakuro[i, j].btype = 2 then begin
        if kakuro[i, j - 1].btype = 1 then count += 1;
        if kakuro[i, j + 1].btype = 1 then count += 1;
        if kakuro[i - 1, j].btype = 1 then count += 1;   
        if kakuro[i + 1, j].btype = 1 then count += 1;   
        if count = 3 then begin
          l := random(3) - 1;
          d := random(3) - 1;
          kakuro[i + l, j + d].btype := 2;kakuro[size + 2 - i - l, size + 2 - j - d].btype := 2;                   
        end;
        if count = 4 then begin kakuro[i, j].btype := 1;kakuro[size + 2 - i, size + 2 - j].btype := 1; end;   
      end;
    end;
  l := ((size - 1) div 2);
  if ((size - 1) mod 2) = 0 then kakuro[l + 1, l + 1].btype := 2 else kakuro[l + 2, l + 2].btype := 2
end;

procedure generation;
var
  i, j: integer;
  mirrow: integer;
  count: integer;
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
  mirrow := size - 1 div 2; 
  for i := 2 to  mirrow do 
    repeat
      count := 0;
      for j := 2 to size do 
      begin
        kakuro[i, j].btype := random(2) + 1;
        if (kakuro[i, j].btype = 1) then count += 1;
        kakuro[size + 2 - i, size + 2 - j].btype := kakuro[i, j].btype;      
      end;
    until count < size div 2;   
  if size - 1 mod 2 = 1 then begin
    inc(mirrow);
    for j := 2 to size do 
    begin
      kakuro[mirrow, j].btype := random(2) + 1;
      kakuro[size + 2 - mirrow, size + 2 - j].btype := kakuro[mirrow, j].btype;      
    end;  
  end;
  for i := 1 to 3 do 
  begin
    corners;
    sides_tb;
    sides_lr;    
    center;  
  end;
  
end;


procedure generate_numbers;
type digit=1..9;
var  i,j,m,p:integer;
     s,o:set of digit;
     count:integer;
     f,q:boolean;
begin      
    for i:= 1 to size do for j:= 1 to size do
    if (kakuro[i,j].btype=1) or (kakuro[i,j].btype=0) then begin
      s:=[];
      count:=0;
      m:=j+1;
      f:=true;
      
      while (m<=size) and (count<9) and f do begin
        if ( kakuro[i,j].btype=0)  and (i=1) then f:=false else
        if (kakuro[i,m].btype=1) then f:=false 
        else begin
          o:=[];
          p:=i;
          q:=true;
          while (p>=1) and (q) do begin
          
            if (kakuro[p,m].btype=1) or (kakuro[i,j].btype=0)  then q:=false else
            begin
              o+=[kakuro[p,m].bvalue2];
              p-=1;
            end;
          end;
          repeat
            kakuro[i,m].bvalue2:=random(9)+1;
          until not (kakuro[i,m].bvalue2 in s) and not (kakuro[i,m].bvalue2 in o);
          s+=[kakuro[i,m].bvalue2];
          count+=1;
          m+=1;
        end;
      end;      
    end;        
end;



  procedure values_right;
  var i,j,m:integer;
      sum:integer;
  begin
    for i:= 1 to size do 
      for j := 1 to size do 
        if (kakuro[i,j].btype=1) or (kakuro[i,j].btype=0) then  begin
          sum:=0;
          m:=j+1;
          while (kakuro[i,m].btype<>1) and (m<=size) do begin
            sum+=kakuro[i,m].bvalue2;
            m+=1;
          end;
          kakuro[i,j].bvalue2:=sum;
        end;
  end;
  
  procedure values_down;
  var i,j,m:integer;
      sum:integer;
  begin
    for j:= 1 to size do 
      for i := 1 to size do 
        if (kakuro[i,j].btype=1) or (kakuro[i,j].btype=0) then  begin
          sum:=0;
          m:=i+1;
          while (kakuro[m,j].btype<>1) and (kakuro[m,j].btype<>0) and (m<=size) do begin
            sum+=kakuro[m,j].bvalue2;
            m+=1;
          end;
          kakuro[i,j].bvalue1:=sum;
        end;
  end;



begin
  crt.TextBackground(white);
  crt.TextColor(black);
  repeat
    repeat
      crt.ClrScr;
      write('ввести size- ');
      readln(size);
    until (size >= 4) and (size <= 10);
    generation; 
    generate_numbers;
    values_right;
    values_down;
    write_kakuro_info;
  until size < 0;
end.