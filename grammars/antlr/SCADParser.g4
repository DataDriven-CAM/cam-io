/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
parser grammar SCADParser;

options {
    tokenVocab=SCADLexer;
}

scad : (import_line Semicolon| call Semicolon |component (scope|implicit_scope+ Semicolon?|Semicolon) |equation (ArgSemicolon|Semicolon) | special ArgSemicolon |booleans (scope) |intersection_for (scope|implicit_scope+ Semicolon?) | for_loop (scope|implicit_scope+ Semicolon?) | if_then_else | use_line | modules (scope|implicit_scope+ Semicolon?) | function_line (scope|implicit_scope+ Semicolon?) | echo Semicolon | font Semicolon)+ EOF;

use_line : Use LessThan file_path GreaterThan;
import_line : modifier? Import import_file;
file_path : ~(GreaterThan)*;
import_file : ShapeLParenthese file (Comma (convexity|layer|origin|scale_arg))* RParenthese;
file : (variable Eq)*String;

modules : Module module_name (ModuleLParenthese (args|Comma)* RParenthese)? ;
module_name : ModuleName;
function_line : Function functions FunctionLParenthese (args|Comma)* RParenthese Eq ;
args : equation|expression|size|fa|fn|fs|t;
call : method (ArgLParenthese|LParenthese) (args|Comma)* RParenthese ;

equation : variable (Eq|ArgEq|ShapeEq) (expression);
intersection_for : Intersection_for LParenthese ((variable ArgEq (LBracket expression Colon expression ArrayRBracket | expression)) Comma?)+ RParenthese;
for_loop : modifier? For LParenthese ((variable ArgEq (LBracket expression (Colon expression)? Colon expression ArrayRBracket | expression)) Comma?)+ RParenthese;
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
let_ : Let ArgLParenthese (equation|expression) scope? (Comma (equation|expression))* RParenthese;
log : Log ArgLParenthese expression RParenthese;
pow : Pow ArgLParenthese expression RParenthese;
sqrt : Sqrt ArgLParenthese expression RParenthese;
exp : Exp ArgLParenthese expression RParenthese;
rands : Rands ArgLParenthese expression Comma expression Comma expression (Comma expression)? RParenthese;
min : Min ArgLParenthese expression Comma expression RParenthese;
max : Max ArgLParenthese expression Comma expression RParenthese;
precedence :  ArgLParenthese expression RParenthese;
bracket :  LBracket expression ArrayRBracket;

logical : True|False|less_than_equal|greater_than_equal|is_equal|less_than|greater_than|and_|or_ ;
is_equal : ArgEq ArgEq expression logical?;
and_ : Ampersand Ampersand expression logical?;
or_ :  Pipe Pipe expression logical?;
less_than_equal : LessThan ArgEq expression logical?;
greater_than_equal : GreaterThan ArgEq expression logical? ;
less_than : LessThan expression logical?;
greater_than : GreaterThan expression logical? ;


component : modifier? (color|transforms|children|sphere|cube|cylinder|polyhedron|circle|square|polygon|hull|minkowski|linear_extrude|rotate_extrude|surface|render|projection|call|text|import_line) ;
booleans : (union_of|difference|intersection);
modifier : Mutliply|Not|Pound|Percent;
scope : (LBrace (implicit_scope Semicolon?)+  RBrace) ;
implicit_scope : ((component+ | booleans component* |modules component* |function_line component* |equation ArgSemicolon| expression|intersection_for | for_loop | if_then_else | echo) scope?);

transforms : (translate|rotate|scale|resize|mirror|offset);
color : Color ColorLParenthese (LBracket red Comma green Comma blue ArrayRBracket|number|textual|Comma)+ RParenthese ;
red : expression;
green : expression;
blue : expression;

rotate : Rotate TransformationLParenthese ((variable TransformationEq)* expression TransformationComma?)+ RParenthese;
translate : Translate TransformationLParenthese (equation| expression) RParenthese ;
scale : Scale TransformationLParenthese (variable TransformationEq)* expression RParenthese;
resize : Resize TransformationLParenthese (variable TransformationEq)* expression RParenthese;
mirror : Mirror TransformationLParenthese (variable TransformationEq)* expression RParenthese;
offset : Offset TransformationLParenthese (variable TransformationEq)* expression RParenthese;
hull : Hull LParenthese BooleanRParenthese ;
minkowski : Minkowski LParenthese BooleanRParenthese ;
linear_extrude : Linear_extrude ShapeLParenthese (center|convexity|scale_arg|height|twist|slices|number|fn|expression|Comma)* RParenthese;
rotate_extrude : Rotate_extrude ShapeLParenthese (angle|convexity|fn|fa|fs|Comma)* RParenthese ;
surface : Surface ShapeLParenthese file (center|convexity|Comma)* RParenthese ;
render : Render LParenthese (convexity)* RParenthese ;
projection : Projection ShapeLParenthese (convexity|cut)* RParenthese ;

matrix : LBracket ((LBracket (expression|Comma)+ ArrayRBracket)|Comma)+ ArrayRBracket;
point : LBracket x Comma y (Comma z)? ArrayRBracket;
vector : LBracket;

x : expression;
y : expression;
z : expression;

union_of : Union BooleanLParenthese BooleanRParenthese;
difference : Difference BooleanLParenthese BooleanRParenthese;
intersection : Intersection BooleanLParenthese BooleanRParenthese;

sphere : Sphere ShapeLParenthese ((r|d|number|expression)|fa|fs|fn|Comma)* RParenthese;
cube : Cube ShapeLParenthese (size|center|point|number|expression|Comma)* RParenthese;
cylinder : Cylinder ShapeLParenthese (h Comma? | r Comma? | r1 Comma? | r2 Comma? | d Comma? | fa Comma? | center Comma? | expression Comma?)+ RParenthese;
polyhedron : Polyhedron LParenthese (points|faces|convexity|triangles|Comma)* RParenthese;
children : Children CallLParenthese expression? RParenthese;

circle : Circle ShapeLParenthese ((r|d|variable|number)|fa|fs|fn|expression|Comma)* RParenthese;
square : Square ShapeLParenthese (size|center|point|number|logical|expression|Comma)* RParenthese;
polygon : Polygon ShapeLParenthese (points|paths|convexity|LBracket for_loop implicit_scope ArrayRBracket|expression)* RParenthese;
text : Text ShapeLParenthese textual (size|number|font|halign|valign|fn|expression|Comma)* RParenthese;
textual : Variable|ArgVariable|String|expression;
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

special : fa|fs|fn|vpr|vpt|vpd|t;
fa : (Dollar|ArgDollar) Fa (Eq|ArgEq) number;
fs : (Dollar|ArgDollar) Fs (Eq|ArgEq) number;
fn : (Dollar|ArgDollar) Fn (Eq|ArgEq) expression;
vpr : (Dollar|ArgDollar) Vpr (Eq|ArgEq) expression;
vpt : (Dollar|ArgDollar) Vpt (Eq|ArgEq) expression;
vpd : (Dollar|ArgDollar) Vpd (Eq|ArgEq) expression;
t : (Dollar|ArgDollar) T ((Eq|ArgEq) expression)?;
        
functions : (FunctionName);
method : (Variable|ArgVariable);
array : variable? ArgLBracket let_? for_loop? (args Comma?)* ArrayRBracket;
variable : (Variable|ArgVariable|TransformVariable|Function|Square|Rotate|Scale|Font|Len|Angle|Layer|Children|Version|ArgVersion|Cylinder|Height|Size|T)+;
string: String;

number : Float|Number;

echo : Echo ShapeLParenthese ((version|(variable ArgEq)* expression) Comma?)+ RParenthese;
version : ArgVersion (CallEq CallVersion CallLParenthese RParenthese| CallLParenthese RParenthese);

