/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar SCADParser;

options {
    tokenVocab=SCADLexer;
}

scad : (import_line Semicolon | use_line | modules (scope|implicit_scope+) Semicolon? | function_line (scope|implicit_scope+)? ArgSemicolon? Semicolon? | echo Semicolon | font Semicolon| call Semicolon | component ((scope|implicit_scope+) Semicolon?|Semicolon) |equation (ArgSemicolon|Semicolon) | special ArgSemicolon |booleans (scope) |intersection_for ((scope|implicit_scope+) Semicolon?) | for_loop ((scope|implicit_scope+) Semicolon?) | if_then_else)+ EOF;

use_line : Use LAngleBracket file_path RAngleBracket;
import_line : modifier? Import import_file;
file_path : ~(RAngleBracket)*;
import_file : LParenthese file (Comma (convexity|layer|origin|scale_arg))* RParenthese;
file : (variable ArgEq)*String;

modules : Module module_name (LParenthese (args|Comma)* RParenthese)? ;
module_name : ModuleVariable;
function_line : Function function_name LParenthese (args|Comma)* RParenthese Eq ;
function_name : FunctionVariable;
args : equation|expression|size|fa|fn|fs|t;
call : method (ArgLParenthese|LParenthese) (args|Comma)* RParenthese ;
annotation_line: (At|ArgAt)  annotation_name AnnotationLParenthese annotation AnnotationRParenthese;
annotation_name : AnnotationVariable;
annotation : ~(AnnotationRParenthese)*;

equation : variable (ArgEq|Eq) (expression);
intersection_for : (ArgIntersectionFor|IntersectionFor) (ArgLParenthese|LParenthese) ((variable ArgEq (ArgLBracket expression Colon expression ArrayRBracket | expression)) Comma?)+ RParenthese;
for_loop : modifier? (ArgFor|For) (ArgLParenthese|LParenthese) ((variable ArgEq (ArgLBracket expression (Colon expression)? Colon expression (ArrayRBracket|ArrayRBracket) | expression)) Comma?)+ RParenthese;
if_then_else : If LParenthese expression logical? RParenthese (scope|implicit_scope+ Semicolon) else_?;
else_ : Else (if_then_else| scope | implicit_scope+ Semicolon);

expression : (matrix|point|add|subtract|multiply|divide|mod|if_|abs|sign|sin|cos|tan|acos|asin|atan|atan2|floor|round|ceil|ln|len|let_|log|pow|sqrt|exp|rands|min|max|cross|logical|call|precedence|array|bracket|number|variable|string|special)+;
add : Plus expression;
subtract : Minus expression;
multiply : Multiply (precedence| expression);
divide : Divide expression;
mod : ArgPercent expression;
if_ : Question expression  Colon expression ;
abs : Abs ArgLParenthese expression RParenthese;
sign : Sign ArgLParenthese expression RParenthese;
sin : Sin ArgLParenthese expression RParenthese;
cos : Cos ArgLParenthese expression RParenthese;
tan : Tan ArgLParenthese expression RParenthese;
acos : Acos ArgLParenthese expression RParenthese;
asin : Asin ArgLParenthese expression RParenthese;
atan : Atan ArgLParenthese expression RParenthese;
atan2 : Atan2 ArgLParenthese expression Comma expression RParenthese;
floor : Floor ArgLParenthese expression RParenthese;
round : Round ArgLParenthese expression RParenthese;
ceil : Ceil ArgLParenthese expression RParenthese;
ln : Ln ArgLParenthese expression RParenthese;
len : Len ArgLParenthese expression RParenthese;
let_ : Let ArgLParenthese (equation|expression) (Comma? (equation|expression))* RParenthese  ;
log : Log ArgLParenthese expression RParenthese;
pow : Pow ArgLParenthese expression RParenthese;
sqrt : Sqrt ArgLParenthese expression RParenthese;
exp : Exp ArgLParenthese expression RParenthese;
rands : Rands ArgLParenthese expression Comma expression Comma expression (Comma expression)? RParenthese;
min : Min ArgLParenthese expression Comma expression RParenthese;
max : Max ArgLParenthese expression Comma expression RParenthese;
precedence :  ArgLParenthese expression RParenthese expression?;
bracket :  ArgLBracket let_? for_loop? (args Comma?)*  ArrayRBracket;
cross : Cross ArgLParenthese expression Comma expression RParenthese;

logical : (True|False)|less_than_equal|greater_than_equal|is_equal|less_than|greater_than|and_|or_ ;
is_equal : ArgEq ArgEq expression logical?;
and_ : Ampersand Ampersand expression logical?;
or_ :  Pipe Pipe expression logical?;
less_than_equal : LessThan ArgEq expression logical?;
greater_than_equal : GreaterThan ArgEq expression logical? ;
less_than : LessThan ;
greater_than : GreaterThan expression logical? ;


component : modifier? (color|transforms|children|sphere|cube|cylinder|polyhedron|circle|square|polygon|hull|minkowski|linear_extrude|rotate_extrude|surface|render|projection|call|text|import_line) ;
booleans : (union_of|difference|intersection);
modifier : Multiply|Not|Pound|Percent;
scope : (LBrace (implicit_scope Semicolon?)+  RBrace) ;
implicit_scope : ((component+ | booleans component* |modules component* | function_line component* ArgSemicolon?|intersection_for | for_loop implicit_scope? |equation ArgSemicolon| expression ArgSemicolon?| if_then_else | echo) scope?);

transforms : (translate|rotate|scale|resize|mirror|offset);
color : Color LParenthese (ArgLBracket red Comma green Comma blue ArrayRBracket|expression|Comma)+ RParenthese ;
red : expression;
green : expression;
blue : expression;

rotate : Rotate LParenthese ((variable ArgEq)* expression Comma?)+ RParenthese;
translate : Translate LParenthese (equation| expression) RParenthese ;
scale : Scale LParenthese (variable ArgEq)* expression RParenthese;
resize : Resize LParenthese (variable ArgEq)* expression RParenthese;
mirror : Mirror LParenthese (variable ArgEq)* expression RParenthese;
offset : Offset LParenthese (variable ArgEq)* expression RParenthese;
hull : Hull LParenthese RParenthese ;
minkowski : Minkowski LParenthese RParenthese ;
linear_extrude : Linear_extrude LParenthese (center|convexity|scale_arg|height|twist|slices|number|fn|expression|Comma)* RParenthese;
rotate_extrude : Rotate_extrude LParenthese (angle|convexity|fn|fa|fs|Comma)* RParenthese ;
surface : Surface LParenthese file (center|convexity|Comma)* RParenthese ;
render : Render LParenthese (convexity)* RParenthese ;
projection : Projection LParenthese (convexity|cut)* RParenthese ;

matrix : ArgLBracket ((ArgLBracket (expression|Comma)+ ArrayRBracket)|Comma)+ ArrayRBracket;
point : ArgLBracket x Comma y (Comma z)? ArrayRBracket;
vector : ArgLBracket;

x : expression;
y : expression;
z : expression;

union_of : Union LParenthese RParenthese;
difference : annotation_name? Difference LParenthese RParenthese;
intersection : Intersection LParenthese RParenthese;

sphere : Sphere LParenthese ((r|d|number|expression)|fa|fs|fn|Comma)* RParenthese;
cube : Cube LParenthese (size|center|point|number|expression|Comma)* RParenthese;
cylinder : annotation_line? Cylinder LParenthese (h Comma? | r Comma? | r1 Comma? | r2 Comma? | d Comma? | fa Comma? | center Comma?| special Comma? | expression Comma?)+ RParenthese;
polyhedron : Polyhedron LParenthese (points|faces|convexity|triangles|Comma)* RParenthese;
children : Children LParenthese expression? RParenthese;

circle : Circle LParenthese ((r|d|variable|number)|fa|fs|fn|expression|Comma)* RParenthese;
square : Square LParenthese (size|center|point|number|logical|expression|Comma)* RParenthese;
polygon : Polygon LParenthese (points|paths|convexity|ArgLBracket for_loop implicit_scope ArrayRBracket|expression|Comma)* RParenthese;
text : Text LParenthese textual (size|number|font|halign|valign|fn|expression|Comma)* RParenthese;
textual : (Variable|ArgVariable|String)|expression;
font : Font ArgEq expression;
halign : Halign ArgEq expression;
valign : Valign ArgEq expression;

r : R ArgEq expression;
d : D ArgEq expression;
h : H ArgEq expression;
r1 : variable ArgEq expression;
r2 : variable ArgEq expression;
points : Points ArgEq (point|array|matrix|Comma)+;
triangles : Triangles ArgEq (point|matrix|Comma)+;
faces : Faces ArgEq (point|Comma)+;
paths : Paths ArgEq (point|array|Comma)+;
angle : Angle ArgEq (number|expression);
convexity : Convexity ArgEq (number|expression);
layer : Layer ArgEq (number|expression);
origin : Origin ArgEq (number|expression);
cut : Cut ArgEq (number|expression);
height : Height ArgEq (number|expression);
scale_arg : ArgScale ArgEq (number|expression);
size : Size ArgEq (point|expression);
center : Center ArgEq logical;
twist : Twist ArgEq (number|expression);
slices : Slices ArgEq (number|expression);

special : fa|fs|fn|vpr|vpt|vpd|t|special_children;
fa : (Dollar|ArgDollar) Fa (Eq|ArgEq) number;
fs : (Dollar|ArgDollar) Fs (Eq|ArgEq) number;
fn : (Dollar|ArgDollar) Fn (Eq|ArgEq) expression;
vpr : (Dollar|ArgDollar) Vpr (Eq|ArgEq) expression;
vpt : (Dollar|ArgDollar) Vpt (Eq|ArgEq) expression;
vpd : (Dollar|ArgDollar) Vpd (Eq|ArgEq) expression;
t : (Dollar|ArgDollar) T ((Eq|ArgEq) expression)?;
special_children : (Dollar|ArgDollar) SpecialChildren ((Eq Eq |ArgEq ArgEq) expression)?;
        
method : (Variable|ArgVariable);
array : variable bracket;
variable : (ArgVariable|Variable|Function|Square|Rotate|Scale|Paths|Points|Font|Len|Angle|Layer|Children|Version|ArgVersion|Height|Size|R|D|H|T)+;
string: String;

number : Float|Number;

echo : Echo LParenthese ((version|(variable ArgEq)* expression) Comma?)+ RParenthese;
version : ArgVersion (ArgEq ArgVersion ArgLParenthese RParenthese| ArgLParenthese RParenthese);

