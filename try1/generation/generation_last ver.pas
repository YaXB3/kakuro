uses crt;
type digit=1..9;
var a:array[1..6,1..6] of integer=(
  (10,10,10,10,10,10),
  (10,0,0,0,0,0),
  (10,0,0,0,0,0),
  (10,0,0,0,0,0),
  (10,0,0,0,0,0),
  (10,0,0,0,0,0)
);
i,j,m,p:integer;
s,o:set of digit;
 count:integer;
 f,q:boolean;

begin
  crt.TextColor(black);
  crt.TextBackground(white);
  crt.ClrScr;
  for i:= 1 to 6 do begin  for j:= 1 to 6 do write(a[i,j]:4); writeln end; 
  
    for i:= 1 to 6 do for j:= 1 to 6 do
    if a[i,j]=10 then begin
      s:=[];
      count:=0;
      m:=j+1;
      f:=true;
      
      while (m<=6) and (count<9) and f do begin
        if a[i,m]=10 then f:=false 
        else begin
          o:=[];
          p:=i;
          q:=true;
          while (p>=1) and (q) do begin
          
            if a[p,m]=10 then q:=false else
            begin
              o+=[a[p,m]];
              p-=1;
            end;
          end;
          repeat
            a[i,m]:=random(9)+1;
          until not (a[i,m] in s) and not (a[i,m] in o);
          s+=[a[i,m]];
          count+=1;
          m+=1;
        end;
      end;
      
    end;
    
  writeln;
  for i:= 1 to 6 do begin  for j:= 1 to 6 do write(a[i,j]:4); writeln end;
end.