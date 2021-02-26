% 03: Разделить строку на части, с явным указанием разделителя:
% Пример:
% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
% <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
% 2> lesson3_task3:split(BinText, "-:-").
% [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]
%lesson3_task03:split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>, "-:-").

-module (lesson3_task03).

-export([split/2]).



split(BinText, Sym) ->
	flatten(split(BinText, Sym, <<>>, [])).

% split(<<>>, _, <<>>, []) -> 
% 	 [<<>>];
split(<<>>, _, <<>>, Acc) -> 
	 Acc;
split(<<>>, _, Acc1, Acc) -> 
	 Acc ++ [Acc1] ;
split(<<X,Y/binary>>, Sym, Acc1, Acc) -> 

	case lists:member(X,Sym) of 
		true -> split(Y, Sym, <<>>, Acc ++ [Acc1]);
		false -> split(Y, Sym, <<Acc1/binary, X>>, Acc)
			end.


flatten(List) ->
 lists:reverse(flatten(List, [])).

flatten([], Acc) ->
    Acc;
flatten([<<>>|Tail], Acc) ->
    flatten(Tail, Acc);
flatten([Head|Tail], Acc) ->
    NewAcc = [Head|Acc],
    flatten(Tail, NewAcc).




-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

split_test_() -> [
	?_assert(split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>, "-:-") =:= [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]),
	?_assert(split(<<>>,"-:-") =:= [])].
-endif.
