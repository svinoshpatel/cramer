type
  Matrix = Array[1..5, 1..5] of Real;
  Vector = Array[1..5] of Real;

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
  mi, mj, i, j, k : Integer;
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
      mi := 0;
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

procedure show(system : Vector; n : Integer);
var
  i: Integer;
begin
  for i := 1 to n do
  begin
    write(system[i]:0:2, ' ');
  end;
end;

function sub(system : Matrix; ans : Vector; n : Integer; p : Integer) : Matrix;
var
  i, j : Integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      if j = p then
        system[i, j] := ans[i];
  sub := system;
end;

function crm(system : Matrix; ans : Vector; n : Integer) : Vector;
var
  d : Real;
  p : Integer;
  sublist : Matrix;
begin
  d := det(system, n);
  if d < 1e-7 then
  begin
    writeln('Determinant equals zero');
    exit;
  end;
  for p := 1 to n do
  begin
    sublist := sub(system, ans, n, p);
    crm[p] := det(sublist, n) / d;
  end;
end;

var
  n, i, j : Integer;
  A : Matrix;
  B : Vector;

begin
  write('Enter matrix size [1 - 5] -> ');
  readln(n);
  writeln('Insert ', n, ' values in a row:');
  for i := 1 to n do
    for j := 1 to n do
      read(A[i, j]);

  writeln('Insert 1 value in a row (right side of equation)');
  for i := 1 to n do
    readln(B[i]);

  write('Roots: ');
  show(crm(A, B, n), n);
end.
