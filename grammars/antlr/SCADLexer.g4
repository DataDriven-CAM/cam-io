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
For : 'for';

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
RParenthese : ')';
LBrace : '{';
RBrace : '}';
LBracket : '[';
RBracket : ']';
LAngleBracket : '<';
RAngleBracket : '>';
Period : '.';
Comma : ',';
Semicolon : ';';
Dollar : '$' ->pushMode(SpecialVariables);
Pound : '#';
Percent : '%';
At: '@' ->pushMode(AnnotationLine);

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
ArgScale : Scale -> type(Scale);
Size: 'size';
Height : 'height';
Angle : 'angle';
Points : 'points';
Halign : 'halign';
Valign : 'valign';
Font : 'font';
ArgIntersectionFor : IntersectionFor -> type(IntersectionFor);
ArgFor : For -> type(For);

ArgVersion : Version -> type(Version);
R : 'r' ;
D : 'd';
H : 'h';

Float
    :  Number ArgPeriod Number?;// -> type(Double);
Number : ArgDigit+;
ArgVariable : Variable ->type(Variable);
ArgLParenthese : LParenthese -> type(LParenthese), pushMode(Args);
ArgRParenthese : RParenthese -> type(RParenthese), popMode;
ArgSemicolon : Semicolon -> type(Semicolon), popMode;
ArrayRBracket : RBracket -> type(RBracket);
ArgPeriod : Period -> type(Period);
ArgComma : Comma -> type(Comma);
Minus : '-';
Plus : '+';
Multiply : '*';
Divide : FSlash -> type(FSlash);
LessThan : '<';
GreaterThan : '>';
Not : '!';
Ampersand : '&';
Pipe : '|';
Question : '?';
Colon : ':';
String : ('"' ~('"')*'"');
ArgUnderscore : Underscore -> type(Underscore);
ArgEq : Eq -> type(Eq);
ArgLBracket : LBracket -> type(LBracket);
ArgDollar : Dollar -> type(Dollar), pushMode(SpecialVariables);
ArgPercent : Percent -> type(Percent);
ArgAt : At -> type(At), pushMode(AnnotationLine);

fragment
ArgLetter
    :	Letter
    ;

fragment
ArgDigit	    : Digit;

ArgWhitespace  :   Whitespace ->type(Whitespace), channel(HIDDEN);

mode ModuleLine;
ModuleVariable : Variable -> type(Variable), popMode;
ModuleWhitespace  :   Whitespace -> type(Whitespace), channel(HIDDEN);

mode FunctionLine;
FunctionVariable : Variable -> type(Variable),popMode;
FunctionWhitespace  :   Whitespace -> type(Whitespace), channel(HIDDEN);

mode AnnotationLine;
AnnotationVariable : Variable ->type(Variable);
AnnotationLParenthese : LParenthese -> type(LParenthese);
AnnotationRParenthese : RParenthese -> type(RParenthese), popMode;
NameStartChar	   :   	'A'..'Z' | '_' | 'a'..'z' | '\u00C0'..'\u00D6' | '\u00D8'..'\u00F6' | '\u00F8'..'\u02FF' | '\u0370'..'\u037D' | '\u037F'..'\u1FFF' | '\u200C'..'\u200D' | '\u2070'..'\u218F' | '\u2C00'..'\u2FEF' | '\u3001'..'\uD7FF' | '\uF900'..'\uFDCF' | '\uFDF0'..'\uFFFD';// | '\u10000'..'\uEFFFF';
NameChar	   :   	NameStartChar | '-' | '=' | '.' | '0'..'9' | '\u00B7' | '\u0300'..'\u036F' | '\u203F'..'\u2040';

AnnotationWhitespace  :   Whitespace -> type(Whitespace), channel(HIDDEN);

mode MathLine;
MathLParenthese : LParenthese -> type(LParenthese);

MathRParenthese : RParenthese -> type(RParenthese), popMode;
MathWhitespace  :   Whitespace -> type(Whitespace), channel(HIDDEN);

mode SpecialVariables;

Fa : 'fa' ->popMode;
Fs : 'fs' ->popMode;
Fn : 'fn' ->popMode;
Vpr : 'vpr' ->popMode;
Vpt : 'vpt' ->popMode;
Vpd : 'vpd' ->popMode;
T : 't' ->popMode;
SpecialChildren : Children ->type(Children), popMode;

SpecialWhitespace  :   Whitespace -> type(Whitespace), channel(HIDDEN);
