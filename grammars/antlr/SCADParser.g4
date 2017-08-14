/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar SCADParser;

options {
    tokenVocab=SCADLexer;
}

scad : (import_line Semicolon| call Semicolon |component (scope|implicit_scope+ Semicolon?|Semicolon) |equation ArgSemicolon | fa ArgSemicolon | fs ArgSemicolon | fn ArgSemicolon |booleans (scope) |intersection_for (scope|implicit_scope+ Semicolon?) | for_loop (scope|implicit_scope+ Semicolon?) | if_then_else | use_line | modules (scope|implicit_scope+ Semicolon?) | function_line (scope|implicit_scope+ Semicolon?) | echo Semicolon | font Semicolon)+ EOF;

use_line : Use LessThan file_path GreaterThan;
import_line : modifier? Import import_file;
file_path : ~(GreaterThan)*;
import_file : LParenthese file (Comma (convexity|layer|origin|scale_arg))* RParenthese;
file : (variable Eq)*String;

modules : Module module_name (ModuleLParenthese (args|Comma)* ArgRParenthese)? ;
module_name : ModuleName;
function_line : Function functions LParenthese (args|Comma)* RParenthese Eq ;
args : equation|number|expression|array|arg_variable|size|string;
call : method LParenthese (args|Comma)* RParenthese ;

equation : variable (Eq|ShapeEq) (number|expression);
intersection_for : Intersection_for LParenthese ((variable Eq (LBracket expression Colon expression ArrayRBracket | expression)) Comma?)+ RParenthese;
for_loop : modifier? For LParenthese ((variable Eq (LBracket expression (Colon expression)? Colon expression ArrayRBracket | expression)) Comma?)+ RParenthese;
if_then_else : If LParenthese expression logical? RParenthese (scope|implicit_scope+ Semicolon) else_?;
else_ : Else (if_then_else| scope | implicit_scope+ Semicolon);

expression : (matrix|point|add|subtract|multiply|divide|mod|if_|abs|sign|sin|cos|tan|acos|asin|atan|atan2|floor|round|ceil|ln|len|let_|log|pow|sqrt|exp|rands|min|max|logical|call|precedence|array|number|array_number|variable|string)+;
add : Plus expression;
subtract : (Minus|ArrayMinus) expression;
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
bracket :  LBracket expression ArrayRBracket;

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
color : Color LParenthese (LBracket red Comma green Comma blue ArrayRBracket|number|textual|Comma)+ RParenthese ;
red : expression;
green : expression;
blue : expression;

rotate : Rotate TransformationLParenthese ((variable TransformationEq)* expression TransformationComma?)+ ArgRParenthese;
translate : Translate TransformationLParenthese (variable TransformationEq)* expression ArgRParenthese ;
scale : Scale TransformationLParenthese (variable TransformationEq)* expression ArgRParenthese;
resize : Resize TransformationLParenthese (variable TransformationEq)* expression ArgRParenthese;
mirror : Mirror TransformationLParenthese (variable TransformationEq)* expression ArgRParenthese;
offset : Offset TransformationLParenthese (variable TransformationEq)* expression ArgRParenthese;
hull : Hull LParenthese RParenthese ;
minkowski : Minkowski LParenthese RParenthese ;
linear_extrude : Linear_extrude LParenthese (center|convexity|scale_arg|height|twist|slices|number|fn|expression|Comma)* RParenthese;
rotate_extrude : Rotate_extrude LParenthese (angle|convexity|fn|fa|fs|Comma)* RParenthese ;
surface : Surface LParenthese file (center|convexity|Comma)* RParenthese ;
render : Render LParenthese (convexity)* RParenthese ;
projection : Projection LParenthese (convexity|cut)* RParenthese ;

matrix : LBracket ((LBracket (expression|Comma)+ ArrayRBracket)|Comma)+ ArrayRBracket;
point : LBracket x Comma y (Comma z)? ArrayRBracket;
vector : LBracket;

x : expression;
y : expression;
z : expression;

union_of : Union LParenthese RParenthese;
difference : Difference LParenthese RParenthese;
intersection : Intersection LParenthese RParenthese;

sphere : Sphere ArgLParenthese ((r|d|number|expression)|fa|fs|fn|Comma)* ArgRParenthese;
cube : Cube ArgLParenthese (size|center|point|number|expression|Comma)* ArgRParenthese;
cylinder : Cylinder ArgLParenthese (h Comma? | r Comma? | r1 Comma? | r2 Comma? | fa Comma? | center Comma? | expression Comma?)+ ArgRParenthese;
polyhedron : Polyhedron LParenthese (points|faces|convexity|triangles|Comma)* RParenthese;
children : Children LParenthese expression? RParenthese;

circle : Circle ArgLParenthese ((r|d|variable|number)|fa|fs|fn|expression|Comma)* ArgRParenthese;
square : Square ArgLParenthese (size|center|point|number|logical|expression|Comma)* ArgRParenthese;
polygon : Polygon LParenthese (points|paths|convexity|LBracket for_loop implicit_scope ArrayRBracket|expression)* RParenthese;
text : Text LParenthese textual (size|number|font|halign|valign|fn|expression|Comma)* RParenthese;
textual : Variable|String|expression;
font : Font Eq expression;
halign : Halign Eq expression;
valign : Valign Eq expression;

r : R ArgEq expression;
d : D ArgEq expression;
h : H ArgEq expression;
r1 : variable ArgEq expression;
r2 : variable ArgEq expression;
fa : Dollar Fa Eq number;
fs : Dollar Fs Eq number;
fn : Dollar Fn Eq expression;
points : Points ArgEq (point|array|matrix|Comma)+;
triangles : Triangles Eq (point|matrix|Comma)+;
faces : Faces Eq (point|Comma)+;
paths : Paths Eq (point|array|Comma)+;
angle : Angle Eq (number|expression);
convexity : Convexity Eq (number|expression);
layer : Layer Eq (number|expression);
origin : Origin Eq (number|expression);
cut : Cut Eq (number|expression);
height : Height ArgEq (number|expression);
scale_arg : ArgScale ArgEq (number|expression);
size : Size ArgEq (point|expression);
center : Center ArgEq logical;
twist : Twist Eq (number|expression);
slices : Slices Eq (number|expression);

        
functions : Variable;
method : Variable;
array : variable? ArgLBracket let_? for_loop? (expression) (ArrayComma (expression))* ArrayRBracket;
variable : (Variable|Function|Square|Rotate|Scale|Font|Len|Angle|Convexity|Layer|Children|Version|ArgVersion)+;
string: String;

number : Float|Number;
array_number : ArrayFloat|ArrayNumber;
arg_variable : (ArgVariable|ArgVersion)+;

echo : Echo ArgLParenthese (((variable ArgEq)* version Comma?)|((variable ArgEq)* expression Comma?))+ ArgRParenthese;
version : ArgVersion CallLParenthese CallRParenthese;

