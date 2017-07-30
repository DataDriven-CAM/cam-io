/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar SCADParser;

options {
    tokenVocab=SCADLexer;
}

scad : (import_line Semicolon| call Semicolon |component (scope|implicit_scope+ Semicolon?|Semicolon) |equation Semicolon |booleans (scope) |intersection_for (scope|implicit_scope+ Semicolon?) | for_loop (scope|implicit_scope+ Semicolon?) | if_then_else | use_line | modules (scope|implicit_scope+ Semicolon?) | function_line (scope|implicit_scope+ Semicolon?) | echo Semicolon | font Semicolon)+ EOF;

use_line : Use LessThan file_path GreaterThan;
import_line : modifier? Import import_file;
file_path : ~(GreaterThan)*;
import_file : LParenthese file (Comma (convexity|layer|origin|scale_arg))* RParenthese;
file : (variable Eq)*String;

modules : Module method (LParenthese (args|Comma)* RParenthese)? ;
function_line : Function functions LParenthese (args|Comma)* RParenthese Eq ;
args : equation|number|expression|array|variable|string;
call : method LParenthese (args|Comma)* RParenthese ;

equation : variable Eq expression;
intersection_for : Intersection_for LParenthese ((variable Eq (LBracket expression Colon expression RBracket | expression)) Comma?)+ RParenthese;
for_loop : modifier? For LParenthese ((variable Eq (LBracket expression (Colon expression)? Colon expression RBracket | expression)) Comma?)+ RParenthese;
if_then_else : If LParenthese expression logical? RParenthese (scope|implicit_scope+ Semicolon) else_?;
else_ : Else (if_then_else| scope | implicit_scope+ Semicolon);

expression : (matrix|point|add|subtract|multiply|divide|mod|if_|abs|sign|sin|cos|tan|acos|asin|atan|atan2|floor|round|ceil|ln|len|let_|log|pow|sqrt|exp|rands|min|max|logical|call|precedence|array|number|variable|string)+;
add : Plus expression;
subtract : Minus expression;
multiply : Mutliply expression;
divide : Divide expression;
mod : Percent expression;
if_ : Question expression  Colon expression ;
abs : Abs LParenthese expression RParenthese;
sign : Sign LParenthese expression RParenthese;
sin : Sin LParenthese expression RParenthese;
cos : Cos LParenthese expression RParenthese;
tan : Tan LParenthese expression RParenthese;
acos : Acos LParenthese expression RParenthese;
asin : Asin LParenthese expression RParenthese;
atan : Atan LParenthese expression RParenthese;
atan2 : Atan2 LParenthese expression Comma expression RParenthese;
floor : Floor LParenthese expression RParenthese;
round : Round LParenthese expression RParenthese;
ceil : Ceil LParenthese expression RParenthese;
ln : Ln LParenthese expression RParenthese;
len : Len LParenthese expression RParenthese;
let_ : Let LParenthese (equation|expression) scope? (Comma (equation|expression))* RParenthese;
log : Log LParenthese expression RParenthese;
pow : Pow LParenthese expression RParenthese;
sqrt : Sqrt LParenthese expression RParenthese;
exp : Exp LParenthese expression RParenthese;
rands : Rands LParenthese expression Comma expression Comma expression (Comma expression)? RParenthese;
min : Min LParenthese expression Comma expression RParenthese;
max : Max LParenthese expression Comma expression RParenthese;
precedence :  LParenthese expression RParenthese;
bracket :  LBracket expression RBracket;

logical : True|False|less_than_equal|greater_than_equal|is_equal|less_than|greater_than|and_|or_ ;
is_equal : Eq Eq expression logical?;
and_ : Ampersand Ampersand expression logical?;
or_ :  Pipe Pipe expression logical?;
less_than_equal : LessThan Eq expression logical?;
greater_than_equal : GreaterThan Eq expression logical? ;
less_than : LessThan expression logical?;
greater_than : GreaterThan expression logical? ;


component : modifier? (color|transforms|children|sphere|cube|cylinder|polyhedron|circle|square|polygon|hull|minkowski|linear_extrude|rotate_extrude|surface|render|projection|call|text|import_line) ;
booleans : (union_of|difference|intersection);
modifier : Mutliply|Not|Pound|Percent;
scope : (LBrace (implicit_scope Semicolon?)+  RBrace) ;
implicit_scope : ((component+ |booleans|modules|function_line|equation|expression|intersection_for | for_loop | if_then_else | echo) (scope?));

transforms : (translate|rotate|scale|resize|mirror|offset);
color : Color LParenthese (LBracket red Comma green Comma blue RBracket|number|textual|Comma)+ RParenthese ;
red : expression;
green : expression;
blue : expression;

rotate : Rotate LParenthese ((variable Eq)* expression Comma?)+ RParenthese;
translate : Translate LParenthese (variable Eq)* expression RParenthese ;
scale : Scale LParenthese (variable Eq)* expression RParenthese;
resize : Resize LParenthese (variable Eq)* expression RParenthese;
mirror : Mirror LParenthese (variable Eq)* expression RParenthese;
offset : Offset LParenthese (variable Eq)* expression RParenthese;
hull : Hull LParenthese RParenthese ;
minkowski : Minkowski LParenthese RParenthese ;
linear_extrude : Linear_extrude LParenthese (center|convexity|scale_arg|height|twist|slices|number|fn|expression|Comma)* RParenthese;
rotate_extrude : Rotate_extrude LParenthese (angle|convexity|fn|fa|fs|Comma)* RParenthese ;
surface : Surface LParenthese file (center|convexity|Comma)* RParenthese ;
render : Render LParenthese (convexity)* RParenthese ;
projection : Projection LParenthese (convexity|cut)* RParenthese ;

matrix : LBracket ((LBracket (expression|Comma)+ RBracket)|Comma)+ RBracket;
point : LBracket x Comma y (Comma z)? RBracket;
vector : LBracket;

x : expression;
y : expression;
z : expression;

union_of : Union LParenthese RParenthese;
difference : Difference LParenthese RParenthese;
intersection : Intersection LParenthese RParenthese;

sphere : Sphere LParenthese ((r|d|variable|number)|fa|fs|fn|expression|Comma)* RParenthese;
cube : Cube LParenthese (size|center|point|number|expression|Comma)* RParenthese;
cylinder : Cylinder LParenthese (h Comma? | r1 Comma? | r2 Comma? | fa Comma? | center Comma? | expression Comma?)+ RParenthese;
polyhedron : Polyhedron LParenthese (points|faces|convexity|triangles|Comma)* RParenthese;
children : Children LParenthese expression? RParenthese;

circle : Circle LParenthese ((r|d|variable|number)|fa|fs|fn|expression|Comma)* RParenthese;
square : Square LParenthese (size|center|point|number|logical|expression|Comma)* RParenthese;
polygon : Polygon LParenthese (points|paths|convexity|LBracket for_loop implicit_scope RBracket|expression)* RParenthese;
text : Text LParenthese textual (size|number|font|halign|valign|fn|expression|Comma)* RParenthese;
textual : Variable|String|expression;
font : Font Eq expression;
halign : Halign Eq expression;
valign : Valign Eq expression;

r : variable Eq expression;
d : variable Eq expression;
h : variable Eq expression;
r1 : variable Eq expression;
r2 : variable Eq expression;
fa : Fa Eq number;
fs : Fs Eq number;
fn : Fn Eq expression;
points : Points Eq (point|array|matrix|Comma)+;
triangles : Triangles Eq (point|matrix|Comma)+;
faces : Faces Eq (point|Comma)+;
paths : Paths Eq (point|array|Comma)+;
angle : Angle Eq (number|expression);
convexity : Convexity Eq (number|expression);
layer : Layer Eq (number|expression);
origin : Origin Eq (number|expression);
cut : Cut Eq (number|expression);
height : Height Eq (number|expression);
scale_arg : Scale Eq (number|expression);
size : Size Eq (point|expression);
center : Center Eq logical;
twist : Twist Eq (number|expression);
slices : Slices Eq (number|expression);

        
functions : Variable;
method : Variable;
array : variable? LBracket let_? for_loop? expression (Comma expression)* RBracket;
variable : (Variable|Function|Font|Len|Angle|Height|Center|Size|Convexity|Layer|Children|Fs|Fa|Fn|Vpr|Vpt|Vpd|T|Dollar)+;
string: String;

number : Float|Number;

echo : Echo LParenthese (((Version Eq)* version Comma?)|((variable Eq)* expression Comma?))+ RParenthese;
version : Version LParenthese RParenthese;

