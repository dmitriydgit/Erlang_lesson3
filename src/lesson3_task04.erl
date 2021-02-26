% 04: Разобрать JSON:

-module (lesson3_task04).

-export([decode/2]).


decode(Json, Type) -> 
	if
Type == proplist -> split(Json);
Type == map -> map;
true -> Json
end.

% split1(Json,Arg) ->
% 	Arg.

split(BinText) ->
	split(BinText, <<>>, {<<>>,<<>>},[]). % Acc2 = <<>>, Acc1 = {}, Acc = []

split(<<>>, <<>>, {<<>>,<<>>}, Acc) ->
	 Acc;
split(<<>>, <<>>, Acc1, Acc) ->
	 split(<<>>, <<>>, {<<>>,<<>>}, Acc++[Acc1]);
split(<<>>, Acc2, Acc1,  Acc) -> 
	 split(<<>>, <<>>, {Acc1, Acc2}, Acc);
split(<<X,Y/binary>>, Acc2, Acc1,  Acc) -> % Acc2 = <<>>, Acc1 = {}, Acc = []
		case binary_to_list(<<X>>) of 
				"{" -> split(Y, Acc2, Acc1, Acc);
				"}" -> split(Y, Acc2, Acc1, Acc);
				":" -> split(Y, Acc2, Acc1, Acc);
				%" " -> split(Y, Acc2, Acc1, Acc);
				"'" -> 
					{H,T} = Acc1,
					case H == <<>> of
						true -> split(Y, <<>>, {Acc2,T}, Acc);% Acc2 = <<>>, Acc1 = {}, Acc = []
						false -> split(Y, <<>>, {H,Acc2}, Acc)
					end;
				"," -> split(Y, <<>>, {<<>>,<<>>}, Acc++[Acc1]);
				_ -> split(Y, <<Acc2/binary, X>>, Acc1, Acc)
		end.
		
								%io:format("~nAcc: ~p~n~n", [Acc]),
	 %io:format("~nX: ~p~n~n", [Sym]), 
	 %io:format("~nX: ~p~n~n", [Sym]), 

%lesson3_task04:decode(Json, proplist). 
%c(lesson3_task04). 

%JSON
% Json = <<"{'squadName': 'Super hero squad','homeTown': 'Metro City','formed': 2016,'secretBase': 'Super tower','active': true}">>

%Template
%[{<<"squadName">>,<<"Super hero squad">>},{<<"homeTown">>,<<"Metro City">>},

%My Result
%[<<"{">>,<<"squadName">>,<<": ">>,<<"Super hero squad">>,{<<>>},<<>>,<<"homeTown">>,<<": ">>,<<"Metro City">>,<<"}">>]



%[{},{},[[{},{},{}],[{},{},{}]]]

% [{<<"squadName">>,<<"Super hero squad">>},
% {<<"homeTown">>,<<"Metro City">>},
% {<<"formed">>,2016},
% {<<"secretBase">>,<<"Super tower">>},
% {<<"active">>,true},
% {<<"members">>,
% [[{<<"name">>,<<"Molecule Man">>},
% {<<"age">>,29},
% {<<"secretIdentity">>,<<"Dan Jukes">>},
% {<<"powers">>,
% [<<"Radiation resistance">>,<<"Turning tiny">>,
% <<"Radiation blast">>]}],
% [{<<"name">>,<<"Madame Uppercut">>},
% {<<"age">>,39},
% {<<"secretIdentity">>,<<"Jane Wilson">>},
% {<<"powers">>,
% [<<"Million tonne punch">>,<<"Damage resistance">>,
% <<"Superhuman reflexes">>]}],
% [{<<"name">>,<<"Eternal Flame">>},
% {<<"age">>,1000000},
% {<<"secretIdentity">>,<<"Unknown">>},
% {<<"powers">>,
% [<<"Immortality">>,<<"Heat Immunity">>,<<"Inferno">>,
% <<"Teleportation">>,<<"Interdimensional travel">>]}]]}]


% words(BinText) ->
% 	words(BinText, <<>>, []).

% words(<<>>, <<>>, Acc) -> 
% 	 Acc;
% words(<<>>, Acc2, Acc) -> 
% 	 Acc ++ [Acc1] ;
% words(<<X,Y/binary>>, Acc2, Acc) -> 

% 	case X == 32 of 
% 		true -> 
% 			words(Y, <<>>, Acc ++ [Acc1] );
% 		false -> words(Y, <<Acc1/binary, X>>, Acc)




% flatten(List) ->
%  lists:reverse(flatten(List, [])).

% flatten([], Acc) ->
%     Acc;
% flatten([<<>>|Tail], Acc) ->
%     flatten(Tail, Acc);
% flatten([Head|Tail], Acc) ->
%     NewAcc = [Head|Acc],
%     flatten(Tail, NewAcc).
% 			end.



%io:format("~nX: ~p~n~n", [binary_to_list(<<X>>)]),



	% case binary_to_list(<<X>>) == "," of 
	% 						true -> 
	% 							split(Y, Sym, <<>>, Acc++[{Acc1}]);
	% 						false -> 
	% 							case binary_to_list(<<X>>) == "'"  of  %lists:member(binary_to_list(<<X>>),Sym)
	% 								true -> 
	% 									split(Y, Sym, <<>>, Acc ++ [Acc1]);
	% 								false -> 
	% 									split(Y, Sym, <<Acc1/binary, X>>, Acc)
	% 									end
	% 				end