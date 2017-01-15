/*
 * Nisp Encode Grammar
 * It is a very limited data format to mis lisp and json.
 * It is designed to be fast and small.
 * ==========================
 *
 * (foo
 *     # comment
 *     (bar 'test')
 *
 *     # escape "We'll", double each single quote
 *     'We''ll'
 * )
 */

start
    = _ v:val _ { return v }

val
    = nisp
    / 'true'  { return true }
    / 'false' { return false }
    / 'null'  { return null }
    / $number { return parseFloat(text()) }
    / $name+
    / quote chars:escaped_char* quote { return chars.join('') }


nisp
    = '(' _ head:val tail:sep_val* _ ')'
    { tail.unshift(head); return tail }

sep_val 'value'
    = _ v:val { return v }

name 'name'
	= [^' ()\r\n\t]

escaped_char
    = "''" { return "'" }
    / [^']

quote
    = "'"

_ "whitespace"
    = ([ \t\r\n]+ / comment)*

comment
	= '#' [^\r\n]*

number
    = '-'? digit+ ("." digit+)? !name

digit
    = [0-9]