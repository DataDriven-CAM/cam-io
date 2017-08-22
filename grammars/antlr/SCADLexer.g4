/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
lexer grammar SCADLexer;

Children : 'children'->pushMode(CallLine);
Sphere : 'sphere' ->pushMode(ShapeLine);
Cube : 'cube' ->pushMode(ShapeLine);
Cylinder : 'cylinder' ->pushMode(ShapeLine);
Circle : 'circle' ->pushMode(ShapeLine);
Square : 'square' ->pushMode(ShapeLine);
Polygon : 'polygon' ->pushMode(ShapeLine);
Translate : 'translate' ->pushMode(TransformationLine);
Rotate : 'rotate' ->pushMode(TransformationLine);
Scale : 'scale' ->pushMode(TransformationLine);
Resize : 'resize' ->pushMode(TransformationLine);
Mirror : 'mirror' ->pushMode(TransformationLine);
Offset : 'offset' ->pushMode(TransformationLine);
Hull : 'hull';
Minkowski : 'minkowski';
Union : 'union' ->pushMode(BooleanLine);
Difference : 'difference' ->pushMode(BooleanLine);
Intersection : 'intersection' ->pushMode(BooleanLine);
Color : 'color' ->pushMode(ColorLine);
Module : 'module' ->pushMode(ModuleLine);
Function : 'function' ->pushMode(FunctionLine);
Linear_extrude : 'linear_extrude' ->pushMode(ShapeLine);
Rotate_extrude : 'rotate_extrude' ->pushMode(ShapeLine);
Surface : 'surface' ->pushMode(ShapeLine);
Render : 'render';
Projection : 'projection' ->pushMode(ShapeLine);
Intersection_for : 'intersection_for';
For : 'intersection_'?'for';

Import : 'import' ->pushMode(ShapeLine);
Use : 'use';
Polyhedron : 'polyhedron' ->pushMode(ShapeLine);
Text : 'text' ->pushMode(ShapeLine);
Echo : 'echo' ->pushMode(ShapeLine);
Version : 'version' '_num'?;
If : 'if';
Else : 'else';

Variable : (Letter|Digit|Underscore)+;

Eq : '=' ->pushMode(ShapeLine),pushMode(Args);
Underscore : '_';
LParenthese : '('->pushMode(BooleanLine),pushMode(Args);
LBrace : '{';
RBrace : '}';
LBracket : '[';
RBracket : ']';
Semicolon : ';';
Dollar : '$' ->pushMode(SpecialVariables);
Pound : '#';
Percent : '%';

fragment
Letter
    :	'A'..'Z'
    |	'a'..'z'
    ;

//Spaces	:	(Space|'\t')+;

//fragment
//Space	:	  ' ';


MultilineComment : ('/*' ~('*')*'*/')-> channel(HIDDEN);
Comment : ('//' ~('\n')*)-> channel(HIDDEN);
Whitespace  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
         ) -> channel(HIDDEN)
    ;

Newline: ('\n');

fragment
Digit	    : '0'..'9'
            ;

mode ModuleLine;

ModuleName : Variable;
ModuleLParenthese : LParenthese ->pushMode(Args);
ModuleWhitespace  :   Whitespace -> channel(HIDDEN);

mode FunctionLine;

FunctionName : Variable;
FunctionLParenthese : LParenthese ->pushMode(Args);
FunctionWhitespace  :   Whitespace -> channel(HIDDEN);

mode ShapeLine;

ShapeEq : Eq ->pushMode(Args);
ShapeLParenthese : LParenthese ->pushMode(Args);
ShapeWhitespace  :   Whitespace -> channel(HIDDEN);

mode ColorLine;

ColorEq : Eq ->pushMode(Args);
ColorLParenthese : LParenthese ->pushMode(Args);
ColorWhitespace  :   Whitespace -> channel(HIDDEN);

mode TransformationLine;

TransformationEq : Eq ->pushMode(Args);
TransformationComma : Comma;
TransformationLParenthese : LParenthese ->pushMode(Args);
TransformationWhitespace  :   Whitespace -> channel(HIDDEN);

mode Args;

Abs : 'abs';
Sign : 'sign';
Sin : 'sin' ->pushMode(MathLine),pushMode(Args);
Cos : 'cos' ->pushMode(MathLine),pushMode(Args);
Tan : 'tan';
Asin : 'asin';
Acos : 'acos';
Atan2 : 'atan2';
Atan : 'atan';
Floor : 'floor';
Round : 'round';
Ceil : 'ceil';
Ln : 'ln';
Len : 'len';
Let : 'let';
Log : 'log';
Pow : 'pow';
Sqrt : 'sqrt';
Exp : 'exp';
Rands : 'rands';
Min : 'min';
Max : 'max';

True : 'true';
False : 'false';
Convexity : 'convexity';
Center : 'center';
Twist : 'twist';
Cut : 'cut';
Slices : 'slices';
Faces : 'faces';
Paths : 'paths';
Layer : 'layer';
Origin : 'origin';
Triangles : 'triangles';
ArgScale : Scale;
Size: 'size';
Height : 'height';
Angle : 'angle';
Points : 'points';
Halign : 'halign';
Valign : 'valign';
Font : 'font';
ArgVersion : Version ->pushMode(CallLine);
R : 'r' ;
D : 'd';
H : 'h';

Float
    :  Number Period Number?;
Number : Digit+;
ArgVariable : (Letter|Digit|Underscore)+;
ArgLParenthese : LParenthese;
RParenthese : ')' ->popMode, popMode;
ArgSemicolon : Semicolon ->popMode, popMode;
ArrayRBracket : RBracket ;
ArgPeriod : Period;
Comma : ',';
Minus : '-';
Plus : '+';
Mutliply : '*';
Divide : '/';
LessThan : '<';
GreaterThan : '>';
Not : '!';
Ampersand : '&';
Pipe : '|';
Period : '.';
Question : '?';
Colon : ':';
String : ('"' ~('"')*'"');
ArgEq : '=';
ArgLBracket : '[' ;
ArgDollar : Dollar ->pushMode(SpecialVariables);

ArgWhitespace  :   Whitespace -> channel(HIDDEN);

mode BooleanLine;
BooleanLParenthese : LParenthese;

BooleanRParenthese : RParenthese ->popMode;
BooleanWhitespace  :   Whitespace -> channel(HIDDEN);

mode MathLine;
MathLParenthese : LParenthese;

MathRParenthese : RParenthese ->popMode;
MathWhitespace  :   Whitespace -> channel(HIDDEN);

mode CallLine;
CallVersion : Version;

CallLParenthese : LParenthese ->pushMode(Args);
CallEq : Eq;
CallWhitespace  :   Whitespace -> channel(HIDDEN);

mode SpecialVariables;

Fa : 'fa' ->popMode;
Fs : 'fs' ->popMode;
Fn : 'fn' ->popMode;
Vpr : 'vpr' ->popMode;
Vpt : 'vpt' ->popMode;
Vpd : 'vpd' ->popMode;
T : 't' ->popMode;
SpecialWhitespace  :   Whitespace -> channel(HIDDEN);
