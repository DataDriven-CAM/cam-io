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
Module : 'module';
Function : 'function';
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
Fa : Dollar 'fa';
Fs : Dollar 'fs';
Fn : Dollar 'fn';
T : Dollar 't';
Vpr : Dollar 'vpr';
Vpt : Dollar 'vpt';
Vpd : Dollar 'vpd';
True : 'true';
False : 'false';
Polyhedron : 'polyhedron';
Faces : 'faces';
Paths : 'paths';
Convexity : 'convexity';
Layer : 'layer';
Origin : 'origin';
Cut : 'cut';
Points : 'points';
Triangles : 'triangles';
Angle : 'angle';
Size: 'size';
Height : 'height';
Center : 'center';
Twist : 'twist';
Slices : 'slices';
Text : 'text';
Font : 'font';
Halign : 'halign';
Valign : 'valign';
Echo : 'echo';
Version : 'version' '_num'?;
If : 'if';
Else : 'else';

Float
    :  Minus?Number Period Number?;
Number : Minus? Digit+;
String : ('"' ~('"')*'"');
Variable : (Letter|Digit|Underscore)+;

Eq : '=';
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
Comma : ',';
Underscore : '_';
LParenthese : '(';
RParenthese : ')';
LBrace : '{';
RBrace : '}';
LBracket : '[';
RBracket : ']';
Semicolon : ';';
Colon : ':';
Dollar : '$';
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


MultilineComment : ('/*' ~('"')*'*/')-> channel(HIDDEN);
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

