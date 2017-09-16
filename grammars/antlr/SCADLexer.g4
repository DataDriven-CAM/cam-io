/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
lexer grammar SCADLexer;

Children : 'children';
Sphere : 'sphere';
Cube : 'cube';
Cylinder : 'cylinder';
Circle : 'circle';
Square : 'square';
Polygon : 'polygon';
Translate : 'translate';
Rotate : 'rotate';
Scale : 'scale';
Resize : 'resize';
Mirror : 'mirror';
Offset : 'offset';
Hull : 'hull';
Minkowski : 'minkowski';
Union : 'union';
Difference : 'difference';
Intersection : 'intersection';
Color : 'color';
Module : 'module' ->pushMode(ModuleLine);
Function : 'function' ->pushMode(FunctionLine);
Linear_extrude : 'linear_extrude';
Rotate_extrude : 'rotate_extrude';
Surface : 'surface';
Render : 'render';
Projection : 'projection';
IntersectionFor : 'intersection_for';
For : 'intersection_'?'for';

Import : 'import';
Use : 'use';
Polyhedron : 'polyhedron';
Text : 'text';
Echo : 'echo';
Version : 'version' '_num'?;
If : 'if';
Else : 'else';

Variable : (Letter|Digit|Underscore)+;

Eq : '=' ->pushMode(Args);
Underscore : '_';
FSlash : '/';
LParenthese : '(' ->pushMode(Args);
LBrace : '{';
RBrace : '}';
LBracket : '[';
RBracket : ']';
LAngleBracket : '<';
RAngleBracket : '>';
Period : '.';
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

mode Args;

Abs : 'abs';
Sign : 'sign';
Sin : 'sin' ;
Cos : 'cos' ;
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
Cross : 'cross';

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
ArgIntersectionFor : IntersectionFor;
ArgFor : For;

ArgVersion : Version;
R : 'r' ;
D : 'd';
H : 'h';

Float
    :  Number ArgPeriod Number?;
Number : ArgDigit+;
ArgVariable : (ArgLetter|ArgDigit|ArgUnderscore)+;
ArgLParenthese : LParenthese ->pushMode(Args);
RParenthese : ')' ->popMode;
ArgSemicolon : Semicolon ->popMode;
ArrayRBracket : RBracket ;
ArgPeriod : Period;
Comma : ',';
Minus : '-';
Plus : '+';
Multiply : '*';
Divide : '/';
LessThan : '<';
GreaterThan : '>';
Not : '!';
Ampersand : '&';
Pipe : '|';
Question : '?';
Colon : ':';
String : ('"' ~('"')*'"');
ArgUnderscore : Underscore;
ArgEq : Eq;
ArgLBracket : LBracket ;
ArgDollar : Dollar ->pushMode(SpecialVariables);
ArgPercent : '%';

fragment
ArgLetter
    :	Letter
    ;

fragment
ArgDigit	    : Digit
            ;

ArgWhitespace  :   Whitespace -> channel(HIDDEN);

mode ModuleLine;
ModuleVariable : Variable ->popMode;
ModuleWhitespace  :   Whitespace -> channel(HIDDEN);

mode FunctionLine;
FunctionVariable : Variable ->popMode;
FunctionWhitespace  :   Whitespace -> channel(HIDDEN);

mode MathLine;
MathLParenthese : LParenthese;

MathRParenthese : RParenthese ->popMode;
MathWhitespace  :   Whitespace -> channel(HIDDEN);

mode SpecialVariables;

Fa : 'fa' ->popMode;
Fs : 'fs' ->popMode;
Fn : 'fn' ->popMode;
Vpr : 'vpr' ->popMode;
Vpt : 'vpt' ->popMode;
Vpd : 'vpd' ->popMode;
T : 't' ->popMode;
SpecialChildren : 'children' ->popMode;

SpecialWhitespace  :   Whitespace -> channel(HIDDEN);
