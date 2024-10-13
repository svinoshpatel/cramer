type
  Matrix = Array[1..5, 1..5] of Real;
  Vector = Array[1..5] of Real;

var
  n, i, j, p : Integer;
  list, sublist : Matrix;
  y : Vector;
  d : Real;

function sign(k : Integer) : Real;
begin
  if (k + 1) mod 2 = 0 then
    sign := 1
  else
    sign := -1;
end;

function det(system : Matrix; n : Integer) : Real;
var 
  minor : Matrix;
  mi, mj, k : Integer;
  num, sum, a : Real;
begin
  mi := 0;
  mj := 0;
  sum := 0;

  if n = 1 then
    det := system[n, n];
  if n = 2 then
    det := system[1, 1] * system[2, 2] - system[1, 2] * system[2, 1];
  if n = 3 then
    det := system[1, 1] * system[2, 2] * system[3, 3] 
         + system[1, 2] * system[2, 3] * system[3, 1] 
         + system[1, 3] * system[2, 1] * system[3, 2]
         - system[1, 3] * system[2, 2] * system[3, 1]
         - system[1, 1] * system[2, 3] * system[3, 2]
         - system[1, 2] * system[2, 1] * system[3, 3];
  if n > 3 then
  begin
    for k := 1 to n do
    begin
      a := system[1, k];
      for i := 2 to n do
      begin
        mi := mi + 1;
        mj := 0;
        for j := 1 to n do
        begin
          if j <> k then
          begin
            mj := mj + 1;
            minor[mi, mj] := system[i, j];
          end
        end
      end;
      num := a * det(minor, n-1) * sign(k);
      sum := sum + num;
    end;
    det := sum;
  end;
end;

procedure show(system : Matrix; n : Integer);
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(system[i, j]:0:2, ' ');
    writeln
  end;
end;

function sub(system : Matrix; ans : Vector; n : Integer; p : Integer) : Matrix;
begin
  for i := 1 to n do
    for j := 1 to n do
      if j = p then
        system[i, j] := ans[i];
  sub := system;
end;

begin
  write('Enter matrix size [1 - 5] -> ');
  readln(n);
  writeln('Insert ', n, ' values in a row:');
  for i := 1 to n do
    for j := 1 to n do
      read(list[i, j]);

  writeln('Insert 1 value in a row (right side of equation)');
  for i := 1 to n do
    readln(y[i]);

  d := det(list, n);

  for p := 1 to n do
  begin
    sublist := sub(list, y, n, p);
    write('Roots: ', det(sublist, n) / d);
  end;

  show(list, n);

end.
