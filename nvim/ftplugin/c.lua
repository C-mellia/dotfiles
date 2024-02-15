-- vim.bo.shiftwidth = 4
-- (N: When in unclosed parentheses, indent N characters from the line with the unclosed parenthesis.  Add a 'shiftwidth' for every extra unclosed parentheses.  When N is 0 or the unclosed parenthesis is the first non-white character in its line, line up with the next non-white character after the unclosed parenthesis.
-- wN: When in unclosed parentheses and N is non-zero and either using "(0" or "u0", respectively, or using "U0" and the unclosed parenthesis is the first non-white character in its line, line up with the character immediately after the unclosed parenthesis rather than the first non-white character.
-- WN: When in unclosed parentheses and N is non-zero and either using "(0" or "u0", respectively and the unclosed parenthesis is the last non-white character in its line and it is not the closing parenthesis, indent the following line N characters relative to the outer context (i.e. start of the line or the next unclosed parenthesis).
-- :N: Place case labels N characters from the indent of the switch().
-- lN: If N != 0 Vim will align with a case label instead of the statement after it in the same line. 
-- pN: Parameter declarations for K&R-style function declarations will be indented N characters from the margin.
-- tN: Indent a function return type declaration N characters from the margin.
-- mN: When N is non-zero, line up a line starting with a closing parenthesis with the first character of the line with the matching opening parenthesis.
-- iN: Indent C++ base class declarations and constructor initializations, if they start in a new line (otherwise they are aligned at the right side of the ':').
-- JN: Indent JavaScript object declarations correctly by not confusing them with labels.  The value 'N' is currently unused but must be non-zero (e.g. 'J1').
-- jN: Indent Java anonymous classes correctly.  Also works well for Javascript.  The value 'N' is currently unused but must be non-zero (e.g. 'j1').
-- gN: Place C++ scope declarations N characters from the indent of the block they are in.
-- +N: Indent a continuation line (a line that spills onto the next) inside a function N additional characters.

vim.opt_local.cinoptions = "(0,ws,Ws,:0,Ls,l1,p0,t0,m1,j1,g0"
