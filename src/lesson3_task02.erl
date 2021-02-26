% 02: Разделить строку на слова:
% Пример:
% 1> BinText = <<"Text with four words">>.
% <<"Text with four words">>
% 2> lesson3_task2:words(BinText).
% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]
%lesson3_task02:words("Text with four words").

-module (lesson3_task02).

-export([words/1]).


words(BinText) ->
	words(BinText, <<>>, []).

words(<<>>, <<>>, []) -> 
	[<<>>];
words(<<>>, <<>>, Acc) -> 
	Acc;
words(<<>>, Acc1, Acc) -> 
	Acc ++ [Acc1] ;
words(<<X,Y/binary>>, Acc1, Acc) -> 

	case X == 32 of 
		true -> 
			words(Y, <<>>, Acc ++ [Acc1] );
		false -> words(Y, <<Acc1/binary, X>>, Acc)
	end.


-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

words_test_() -> [
	?_assert(words(<<"Text with four words">>) =:= [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]),
	?_assert(words(<<>>) =:= [<<>>])].
-endif.


%io:format("~nX: ~p~n~n", [binary_to_list(<<X>>)]),
