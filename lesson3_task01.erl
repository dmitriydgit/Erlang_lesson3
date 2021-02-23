% 01: Извлечь из строки первое слово:
% Пример:
% 1> BinText = <<"Some text">>.
% <<"Some Text">>
% 2> lesson3_task1:first_word(BinText).
% <<”Some”>>

-module (lesson3_task01).

-export([first_word/1]).


first_word(BinText ) ->
	first_word(BinText, <<>>).

first_word(<<" ",_Y/binary>>, Acc) -> 
	 Acc;
first_word(<<X,Y/binary>>, Acc) -> 
	first_word(Y, <<Acc/binary, X>>).

