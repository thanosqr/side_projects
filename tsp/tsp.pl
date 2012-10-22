/*
#---------------------------------------
|  
|  The Travelling Salesman Problem
|  A logical approach using XSB
|  
#-------------------------------------
|  How to Use
#---------------------------------------
|  1)import select/3:
|     import select/3 from basics
|  2)import the code
|     e.g: [tsp].
|  3)import the tescase
|     e.g.: [pltest].
|  for more information about the format
|  of the testcases check the pltest file
#---------------------------------------  
*/


%call tsp(+N,-R).
% N: number of cities
% R: result (minimum cost)
tsp(N,R):-
	nodes(N,G),
	minRoute(1,1,G,R).


%nodes: generates a list [1,2,...,N]
nodes(0,[]):-!.
nodes(N,[N|L]):-
	N>0,
	N_ is N-1,
	nodes(N_,L),!.


%a ("random") route From To With (nodes) has Cost
route(X,X,[],0).
route(From,To,With,Cost):-
	select(Next,With,WithRest),
	minRoute(Next,To,WithRest,CostRest),
	cost(From,Next,CostNode),
	Cost is CostRest+CostNode.


%symmetrical tsp:the minimum route From->To With
%is the same with the minimum route To->From With
%therefore we can save memory (and time)
%by tabling only the first one
%this is achieved by filtering with minRoute
%the (X,X,[],0) is also filtered here
%and therefore is not tabled
minRoute(X,X,[],0):-!.
minRoute(From,To,With,Cost):-
	From>=To,
	minRouteS(From,To,With,Cost),!.
minRoute(From,To,With,Cost):-
	From<To,
	minRouteS(To,From,With,Cost),!.


%the minimum route From, To, With (nodes), has Cost
:- table minRouteS/4.
minRouteS(From,To,With,Cost):-
	findall(TempCost, route(From,To,With,TempCost),L),
	getMin(L,Cost).


%returns the minimum value of a list
getMin([H],H).
getMin([H1,H2],H):-
	H is min(H1,H2).
getMin([H1,H2|L],M):-
	H is min(H1,H2),
	getMin([H|L],M).
