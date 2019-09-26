{Нахождение площади пересечения двух треугольников
Лукашевич А.Г.
Группа 52491}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Math, Spin, ComCtrls, Grids;
type
      TDot = record
        X: real;
        Y: real;
      end;

      Points = array [1..6] of TDot; //  тип: массив координат вершин

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    Label21: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    StringGrid1: TStringGrid;
    Label22: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    Button2: TButton;
    ts1: TTabSheet;
    Label23: TLabel;
    TrackBar1: TTrackBar;
    Label24: TLabel;
    GroupBox1: TGroupBox;
    Label25: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    Label26: TLabel;
    Button3: TButton;
    ColorDialog1: TColorDialog;
    Label27: TLabel;
    ColorDialog2: TColorDialog;
    Button4: TButton;
    GroupBox3: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    CheckBox3: TCheckBox;
    Label33: TLabel;
    Label34: TLabel;
    CheckBox5: TCheckBox;
    Label35: TLabel;
    Button5: TButton;
    ColorDialog3: TColorDialog;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    btn1: TButton;
    procedure Button1Click(Sender: TObject);

    procedure InputArrayPoint(var A: Points; var flag: boolean);
    function IntersectionPoints(p1, p2, p3, p4: TDot; var X: TDot):boolean;
    procedure OutputArrayPoints(B: Points ; count: Integer);
    function ProvSuch(A: Points): boolean;
    procedure ImageTriangle(A: Points; kof: integer);
    procedure ImagePoints(B: Points; count: Integer; kof: integer);
    procedure ViewImage();
    procedure STriangl(A, B, C: TDot; var S: real);
    procedure DeletRavnPoint(var B: Points; var count: integer);
    procedure ImageLinePeresech(B: Points; count, kof: Integer);
    procedure SortPoint(var B: Points; count: Integer);
    procedure SPeresech(B: Points; count: Integer; var S: Real);
    procedure DopPoint(A: Points; var B: Points; var count: Integer);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


var
    A: Points; // массив точек
    B: Points; // массив точек пересечений
    count: integer; // количество точек пересечения
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var flag: boolean;
    i, j, k, z: integer;
    X: TDot;
    S, S1, S2: Real;
begin
  Image1.Picture.Graphic:=nil;
  Label43.Caption:='';
  StringGrid1.Visible:=false;
  Label22.Visible:=False;
  InputArrayPoint(A, flag);
  if flag = False then
    Exit;
  if not(ProvSuch(A)) then
    begin
      ShowMessage('Один или два треугольника не существуют!!!');
      Label21.Visible:=True;
      Exit;
    end;
  count:=0;
  // нахождение точек пересечения
  for i:=1 to 3 do
    begin
      for j:=4 to 6 do
        begin
          if (i <> 3) then
            k:=i+1
          else
            k:=1;
          if (j <> 6) then
            z:=j+1
          else
            z:=4;
          if IntersectionPoints(A[i],A[k],A[j],A[z], X) then
            begin
              inc(count);
              B[count]:=X;
            end;
        end;
    end;
    //Label43.Caption:=FloatToStr(S);

    // удаление одинаковых точек
    DeletRavnPoint(B,count);
     if (count <3) then
      begin
        // находим внутреннею точку
        DopPoint(A, B, count);
      end;
    if (count = 0 ) then
      begin
        Label22.Visible:=True;
        Exit;
      end;
    // упорядочение точек пересечения (по часавой стрелке)
    if count = 6 then
      SortPoint(B, count);
    // вывод точек пересечения
    StringGrid1.Visible:=True;
    OutputArrayPoints(B,count);
    // нахождение площади треугольников
    STriangl(A[1],A[2],A[3], S1);
    STriangl(A[4],A[5],A[6], S2);
    Label37.Caption:=FloatToStr(S1);
    Label41.Caption:=FloatToStr(S2);
    // нахождение площади пересечения



    if count > 2 then
      begin
        SPeresech(B, count, S);
        Label43.Caption:=FloatToStr(S);
      end;

      
end;

procedure TForm1.Button2Click(Sender: TObject);
var kof: Integer;
begin
   Image1.Picture.Graphic:=nil;
   kof:=TrackBar1.Position;

   // рисуем сетку и оси
   ViewImage();

   Image1.Canvas.Pen.Color:=ColorDialog1.Color;
   Image1.Canvas.Pen.Width:=SpinEdit1.Value;

   // рисуем треугольники
   ImageTriangle(A,kof);

   Image1.Canvas.Pen.Color:=ColorDialog2.Color;
   Image1.Canvas.Brush.Color:=ColorDialog2.Color;
   // рисуем точки пересечения
   ImagePoints(B,count,kof);
   // рисуем линию пересечения
   Image1.Canvas.Pen.Color:=clRed;
   Image1.Canvas.Pen.Width:=1;
   ImageLinePeresech(B, count, kof);
end;

//  процедура считывания координат вершин
procedure TForm1.InputArrayPoint(var A: Points; var flag: boolean);
var index: integer;
begin
  flag:=true; // координыты считаны верно
  val(Edit1.Text,A[1].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки А - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit2.Text,A[1].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки A - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit4.Text,A[2].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки B - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit3.Text,A[2].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки B - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit6.Text,A[3].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки C - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit5.Text,A[3].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки C - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;

  val(Edit7.Text,A[4].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки А - неверная (второй треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit8.Text,A[4].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки A - неверная (второй треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit10.Text,A[5].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки B - неверная (второй треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit9.Text,A[5].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки B - неверная (первый треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit12.Text,A[6].X,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Х, точки C - неверная (второй треугольник)');
      flag:=false;
      exit;
    end;
  val(Edit11.Text,A[6].Y,index);
  if (index <> 0) then
    begin
      ShowMessage('Координата Y, точки C - неверная (второй треугольник)');
      flag:=false;
      exit;
    end;

end;

// функция проверки треугольников на существование
function TForm1.ProvSuch(A: Points): boolean;
begin
  result:=true;
  if ((A[2].X-A[1].X)*(A[3].Y-A[1].Y))=((A[2].Y-A[1].Y)*(A[3].X-A[1].X)) {or
     ((A[5].X-A[4].X)*(A[6].Y-A[4].Y))=((A[5].Y-A[4].Y)*(A[6].X-A[4].X)) }then
     Result:=False;
end;

//метод, проверяющий пересекаются ли 2 отрезка [p1, p2] и [p3, p4]
function TForm1.IntersectionPoints(p1, p2, p3, p4: TDot; var X: TDot):boolean;
var tmp: TDot;
    A1, b1, A2, b2: real;
begin
    //сначала расставим точки по порядку, т.е. чтобы было p1.x <= p2.x
    if (p2.x < p1.x) then
      begin

        tmp := p1;
        p1 := p2;
        p2 := tmp;
      end;
    //и p3.x <= p4.x
    if (p4.x < p3.x) then
    begin

        tmp := p3;
        p3 := p4;
        p4 := tmp;
    end;

    //проверим существование потенциального интервала для точки пересечения отрезков
    if (p2.x < p3.x)then
    begin
        result:= false; //ибо у отрезков нет взаимной абсциссы
        exit;
    end;

    //если оба отрезка вертикальные
    if((p1.x - p2.x = 0) and (p3.x - p4.x = 0))   then
    begin
        //если они лежат на одном X
        if(p1.x = p3.x)  then
        begin
            //проверим пересекаются ли они, т.е. есть ли у них общий Y
            //для этого возьмём отрицание от случая, когда они НЕ пересекаются
            if (Not((max(p1.y, p2.y) < min(p3.y, p4.y)) or
                    (min(p1.y, p2.y) > max(p3.y, p4.y)))) then
            begin
                if (p1.X = p3.X)and (p1.Y = p3.Y) then
                  X:=p1
                else
                  if (p2.X = p4.X)and (p2.Y = p4.Y) then
                    X:=p2
                  else
                    begin
                      result:= False;
                      exit;
                    end;
                result:= true;
                exit;
            end;
        end;

        result:= false;
        exit;
    end;

    //найдём коэффициенты уравнений, содержащих отрезки
    //f1(x) = A1*x + b1 = y
    //f2(x) = A2*x + b2 = y

    //если первый отрезок вертикальный
    if (p1.x - p2.x = 0) then
    begin

        //найдём X.X, X.Y - точки пересечения двух прямых
        X.X := p1.x;
        A2 := (p3.y - p4.y) / (p3.x - p4.x);
        b2 := p3.y - A2 * p3.x;
        X.Y := A2 * X.X + b2;

        if (p3.x <= X.X) and (p4.x >= X.X) and (min(p1.y, p2.y) <= X.Y) and
                (max(p1.y, p2.y) >= X.Y) then
        begin

            result := true;
            exit;
        end
        else
        begin
          result:= false;
          exit;
        end;
    end;

    //если второй отрезок вертикальный
    if (p3.x - p4.x = 0) then
      begin

        //найдём Xa, Ya - точки пересечения двух прямых
         X.X := p3.x;
         A1 := (p1.y - p2.y) / (p1.x - p2.x);
         b1 := p1.y - A1 * p1.x;
         X.Y := A1 * X.X + b1;

        if (p1.x <= X.X) and (p2.x >= X.X) and (min(p3.y, p4.y) <= X.Y) and
                (max(p3.y, p4.y) >= X.Y) then
        begin
            result:= true;
            exit;
        end
        else
          begin
            result:= false;
            exit;
          end;
    end;

    //оба отрезка невертикальные
     A1 := (p1.y - p2.y) / (p1.x - p2.x);
     A2 := (p3.y - p4.y) / (p3.x - p4.x);
     b1 := p1.y - A1 * p1.x;
     b2 := p3.y - A2 * p3.x;

    if (A1 = A2) then
    begin
        result:= false; //отрезки параллельны
        exit;
    end;

    //Xa - абсцисса точки пересечения двух прямых
    X.X := (b2 - b1) / (A1 - A2);
    X.Y := A1 * X.X + b1;
    if ((X.X < max(p1.x, p3.x)) or (X.X > min( p2.x, p4.x))) then
      begin
        result:= false; //точка Xa находится вне пересечения проекций отрезков на ось X
        exit;
      end
    else
      begin
        result:= true;
        exit;
      end;
end;

// процедура вывода точек пересечения
procedure TForm1.OutputArrayPoints(B: Points; count: integer);
var  i: integer;
begin
  StringGrid1.ColCount:=count+1;
  for i:=1 to count+1 do
    begin
      StringGrid1.Cells[i,0]:=IntToStr(i);
      StringGrid1.Cells[i,1]:=FloatToStr(B[i].X);
      StringGrid1.Cells[i,2]:=FloatToStr(B[i].Y);
    end;
  StringGrid1.Cells[0,0]:='№ п/п';
  StringGrid1.Cells[0,1]:='X';
  StringGrid1.Cells[0,2]:='Y';
end;

// процедура прорисовки треугольников
procedure TForm1.ImageTriangle(A: Points; kof: Integer);
var i: Integer;
    Temp: array[1..6] of TPoint;
begin
  for i:=1 to 6 do
    begin
      Temp[i].X:=Round(A[i].X*kof)+250;
      Temp[i].Y:=Image1.Height-(Round(A[i].Y*kof)+250);
    end;
  Image1.Canvas.MoveTo(Temp[1].X,Temp[1].Y);
  Image1.Canvas.LineTo(Temp[2].X,Temp[2].Y);
  Image1.Canvas.LineTo(Temp[3].X,Temp[3].Y);
  Image1.Canvas.LineTo(Temp[1].X,Temp[1].Y);

  Image1.Canvas.MoveTo(Temp[4].X,Temp[4].Y);
  Image1.Canvas.LineTo(Temp[5].X,Temp[5].Y);
  Image1.Canvas.LineTo(Temp[6].X,Temp[6].Y);
  Image1.Canvas.LineTo(Temp[4].X,Temp[4].Y);
end;

// процедура рисования точек пересечения
procedure TForm1.ImagePoints(B: Points; count: integer; kof: integer);
var i, x, y: Integer;
begin
  for i:=1 to count do
    begin
      x:=Round(B[i].X*kof)+250;
      y:=Image1.Height-(Round(B[i].Y*kof)+250);
      Image1.Canvas.Ellipse(x-1,y-1,x+1,y+1);
    end;

end;
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Label24.Caption:=IntToStr(TrackBar1.Position);
end;

// Цвет контура треугольника
procedure TForm1.Button3Click(Sender: TObject);
begin
  if not(ColorDialog1.Execute) then
    begin
      ShowMessage('Цвет не выбран!!!');
    end
  else
    begin
      Label26.Font.Color:=ColorDialog1.Color;
    end;
end;

// Цвет точек пересечения
procedure TForm1.Button4Click(Sender: TObject);
begin
  if not(ColorDialog2.Execute) then
    begin
      ShowMessage('Цвет не выбран!!!');
    end
  else
    begin
      Label27.Font.Color:=ColorDialog2.Color;
    end;
end;

// процедура настройки внешнего вида холста
procedure TForm1.ViewImage();
var i, kof: Integer;
begin
  kof:=TrackBar1.Position;
  // Сетка горизонталь
  Image1.Canvas.Pen.Color:=ColorDialog3.Color;
  Image1.Canvas.Pen.Width:=1;
  if (CheckBox3.Checked)then
    begin
      i:=kof;
      while (i <500) do
        begin
          Image1.Canvas.MoveTo(i,0);
          Image1.Canvas.LineTo(i,500);
          i:=i+kof;
        end;
    end;
  // Сетка вертикаль
  if (CheckBox5.Checked)then
    begin
      i:=kof;
      while (i <500) do
        begin
          Image1.Canvas.MoveTo(0,i);
          Image1.Canvas.LineTo(500,i);
          i:=i+kof;
        end;
    end;

  Image1.Canvas.Pen.Color:=clBlack;
  Image1.Canvas.Pen.Width:=3;
  // ось X
  if (CheckBox1.Checked)then
    begin
      Image1.Canvas.MoveTo(250,0);
      Image1.Canvas.LineTo(250,500);
    end;
  // ось Y
  if (CheckBox2.Checked)then
    begin
      Image1.Canvas.MoveTo(0,250);
      Image1.Canvas.LineTo(500,250);
    end;
end;

// Цвет сетки
procedure TForm1.Button5Click(Sender: TObject);
begin
  if not(ColorDialog3.Execute) then
    begin
      ShowMessage('Цвет не выбран!!!');
    end
  else
    begin
      Label35.Font.Color:=ColorDialog2.Color;
    end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ViewImage();
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  ViewImage();
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  ViewImage();
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  ViewImage();
end;

// процедура нахождения площади треугольника (заданного координатами вершин)
procedure TForm1.STriangl(A,B,C: TDot; var S: Real);
var x, y, z, p: real;
begin
  x:=Sqrt(Sqr(A.X-B.X)+Sqr(A.Y-B.Y));
  y:=Sqrt(Sqr(B.X-C.X)+Sqr(B.Y-C.Y));
  z:=Sqrt(Sqr(A.X-C.X)+Sqr(A.Y-C.Y));
  p:=(x+y+z)/2;
  S:=Sqrt(p*(p-x)*(p-y)*(p-z));
end;

// процедура удаления равных точек
procedure TForm1.DeletRavnPoint(var B: Points; var count: integer);
var i, j, k: integer;
begin
  i:=count;
  while (i>1)do
    begin
      k:=i-1;
      while (k>0) and (count >1) do
        begin
          if (B[i].X=B[k].X) and (B[i].Y=B[k].Y) then
            begin
              // удалить точку
              for j:=k+1 to count do
              begin
                B[j-1]:=B[j];
              end;
              dec(count);
            end;
          dec(k);
        end;
      if (i<=count) then
        dec(i)
      else
        i:=count;
    end;
end;

// процедура прорисовки линии пересечения
procedure TForm1.ImageLinePeresech(B: Points; count, kof: integer);
var i: Integer;
begin

  Image1.Canvas.MoveTo(Round(B[1].X*kof)+250, Image1.Height-(Round(B[1].Y*kof)+250));
  for i:=1 to count do
    begin
      Image1.Canvas.LineTo(Round(B[i].X*kof)+250, Image1.Height-(Round(B[i].Y*kof)+250));
    end;
  Image1.Canvas.LineTo(Round(B[1].X*kof)+250, Image1.Height-(Round(B[1].Y*kof)+250));
end;

// процедура упорядочения точек пересечения (по часавой стрелке)
procedure TForm1.SortPoint(var B: Points; count: integer);
var i: Integer;
    buf: TDot;
begin
  for i:=2 to (count div 2)-1 do
    begin
      if (B[i-1].X>B[i].X) then
        begin
          buf:=B[i-1];
          B[i-1]:=B[i];
          B[i]:=buf;
        end;
    end;

  for i:=count downto (count div 2)+2 do
    begin
      if (B[i-1].X<B[i].X) then
        begin
          buf:=B[i-1];
          B[i-1]:=B[i];
          B[i]:=buf;
        end;
    end;
end;

// процедура нахождения площади пересечения
procedure TForm1.SPeresech(B: Points; count: Integer; var S: real);
var i: integer;
    S1: real;
begin
  S:=0;
  for i:=1 to count-1 do
    begin
      S1:=0;
      STriangl(B[1],B[i],B[i+1],S1);
      s:=s+S1;
    end;
end;

// процедура нахождения внутренней точки
procedure TForm1.DopPoint(A: Points; var B: Points; var count: integer);
var x, y, z: real;
    i: Integer;
begin
  for i:=1 to 3 do
    begin
      x:=(A[4].X-A[i].X)*(A[5].Y-A[4].Y)-(A[5].X-A[4].X)*(A[4].Y-A[i].Y);
      y:=(A[5].X-A[i].X)*(A[6].Y-A[5].Y)-(A[6].X-A[5].X)*(A[5].Y-A[i].Y);
      z:=(A[6].X-A[i].X)*(A[4].Y-A[6].Y)-(A[4].X-A[6].X)*(A[6].Y-A[i].Y);
      if (x>0)and(y>0)and(z>0)or(x<0)and(y<0)and(z<0) then
        begin
          inc(count);
          B[count]:=A[i];
        end;
    end;
    i:=4;
    while(i<=6) do
    begin
      x:=(A[1].X-A[i].X)*(A[2].Y-A[1].Y)-(A[2].X-A[1].X)*(A[1].Y-A[i].Y);
      y:=(A[2].X-A[i].X)*(A[3].Y-A[2].Y)-(A[3].X-A[2].X)*(A[2].Y-A[i].Y);
     // z:=(A[3].X-A[i].X)*(A[1].Y-A[3].Y)-(A[1].X-A[3].X)*(A[3].Y-A[i].Y);
      if (x>0)and(y>0)and(((A[3].X-A[i].X)*(A[1].Y-A[3].Y)-(A[1].X-A[3].X)*(A[3].Y-A[i].Y))>0)or(x<0)and(y<0)and(((A[3].X-A[i].X)*(A[1].Y-A[3].Y)-(A[1].X-A[3].X)*(A[3].Y-A[i].Y))<0) then
        begin
          inc(count);
          B[count]:=A[i];
        end;
      inc(i);
    end;
end;

// процедура вызова справочной информации
procedure TForm1.btn1Click(Sender: TObject);
begin
winExec('hh DelphiHelp.chm', SW_RESTORE);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Form1.KeyPreview:=true;
end;

// процедура присвоения действий кнопкам
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = vk_f1 then winExec('hh DelphiHelp.chm', SW_RESTORE);
 if Key = VK_ESCAPE then Close;

end;

// процедура переключения между полями ввода координат
procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if (Key = #13) then begin
  Key:=#0;
  Perform(WM_NEXTDLGCTL,0,0);
 end;
end;

end.
