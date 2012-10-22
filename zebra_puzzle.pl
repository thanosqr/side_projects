% NW <- nationality of the person that drinks water
% NZ <- nationality of the person that owns the zebra
% R  <- the whole solution: see the first argument of constrains/3

solve(NW,NZ,R):-
	L=[1,1+1,1+1+1,1+1+1+1,1+1+1+1+1],
	constrains(CL,Water,Zebra,Nations),
	maplist(permutation(L),CL),
	maplist(is,[W,Z|N],[Water,Zebra|Nations]),
	nation(W,N,NW),
	nation(Z,N,NZ),
	maplist(maplist(is),R,CL).

nation(ZW,N,NZW):-
	nth1(T,N,ZW),
	nth1(T,[english,spaniard,ukrainian,norwegian,japanese],NZW).

constrains([
	    [English,Spaniard,Ukrainian,Norwegian,Japanese],
	    [Red,Green,Ivory,Yellow,Blue],
	    [Dog,Snails,Fox,Horse,Zebra],
	    [Coffee,Tea,Milk,Orange_Juice,Water],
	    [Old_Gold,Kools,Chesterfields,Lucky_Strike,Parliaments]
	   ],
	   Water,Zebra,
	   [English,Spaniard,Ukrainian,Norwegian,Japanese]
	  ):-
	
	English = Red,
	Spaniard=Dog,
	Coffee=Green,
	Ukrainian=Tea,
	Green = Ivory+1,
	Old_Gold = Snails,
	Kools = Yellow,
	Milk = 1+1+1,
	Norwegian = 1,
	(Chesterfields = Fox+1 ; Fox = Chesterfields+1 ),
	(Kools = Horse+1 ; Horse = Kools+1 ),
	Lucky_Strike = Orange_Juice,
	Japanese = Parliaments,
	(Norwegian = Blue+1 ; Blue = Norwegian+1 ).