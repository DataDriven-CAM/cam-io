/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
lexer grammar SCADLexer;

Children : 'children';
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
Intersection_for : 'intersection_for';
For : 'intersection_'?'for';
Abs : 'abs';
Sign : 'sign';
Sin : 'sin';
Cos : 'cos';
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

Import : 'import';
Use : 'use';
Polyhedron : 'polyhedron';
Faces : 'faces';
Paths : 'paths';
Convexity : 'convexity';
Layer : 'layer';
Origin : 'origin';
Cut : 'cut';
Triangles : 'triangles';
Angle : 'angle';
Twist : 'twist';
Slices : 'slices';
Text : 'text';
Font : 'font';
Halign : 'halign';
Valign : 'valign';
Echo : 'echo' ->pushMode(ShapeLine);
Version : 'version' '_num'?;
If : 'if';
Else : 'else';

Variable : (Letter|Digit|Underscore)+;

String : ('"' ~('"')*'"');
Eq : '=' ->pushMode(ShapeLine),pushMode(Args);
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
Underscore : '_';
LParenthese : '(';
RParenthese : ')';
LBrace : '{';
RBrace : '}';
LBracket : '[';
RBracket : ']';
Semicolon : ';';
Colon : ':';
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
ArgLParenthese : LParenthese ->pushMode(Args);
ShapeWhitespace  :   Whitespace -> channel(HIDDEN);

mode TransformationLine;

TransformationEq : Eq ->pushMode(Args);
TransformationComma : Comma;
TransformationLParenthese : LParenthese ->pushMode(Args);
TransformationWhitespace  :   Whitespace -> channel(HIDDEN);

mode Args;

True : 'true';
False : 'false';
Center : 'center';
ArgScale : Scale;
Size: 'size';
Height : 'height';
Points : 'points';
ArgVersion : Version ->pushMode(CallLine);
R : 'r' ;
D : 'd';
H : 'h';

Float
    :  Number Period Number?;
Number : Digit+;
ArgVariable : (Letter|Digit|Underscore)+;
ArgRParenthese : RParenthese ->popMode, popMode;
ArgSemicolon : Semicolon ->popMode, popMode;
ArgPeriod : Period;
Comma : ',';
Minus : '-';
ArgEq : Eq;
ArgLBracket : LBracket ->pushMode(ArrayLine);
ArgString : String;

ArgWhitespace  :   Whitespace -> channel(HIDDEN);

mode ArrayLine;
ArrayComma : Comma;
ArrayMinus : Minus;
ArrayFloat
    :  Number Period Number?;
ArrayNumber : Digit+;
ArrayRBracket : RBracket ->popMode;

mode CallLine;

CallLParenthese : LParenthese;
CallRParenthese : RParenthese ->popMode;
CallWhitespace  :   Whitespace -> channel(HIDDEN);

mode SpecialVariables;

Fa : 'fa' ->popMode;
Fs : 'fs' ->popMode;
Fn : 'fn' ->popMode;
Vpr : 'vpr' ->popMode;
Vpt : 'vpt' ->popMode;
Vpd : 'vpd' ->popMode;
T : 't' ->popMode;
