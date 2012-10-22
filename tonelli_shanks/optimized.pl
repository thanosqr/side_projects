ressol(P,N,R1,R2):-
	check_input(P,N),
	tonsha(P,N,R1,R2).
ressol(P,N,R):-
	ressol(P,N,R,_).

tonsha(P,N,R1,R2):-
	tonsha(P,N,R1),
	R2 is P-R1,!.
tonsha(P,N,RF):-
    P_ is P-1,
    factor2(P_,S,Q,0),
    ( S == 1 -> 
        RF is (N^( (P+1)/4 )) mod P ;
       ( findZ(P,Z),
         C is Z^Q mod P,
         T is N^Q mod P,
         R is N^( (Q+1)/2 ) mod P,
         findRF(P,S,T,C,R,RF)
        )
    ).

factor2(P,Counter,P,Counter):-
    1 is P mod 2,!.
factor2(P,S,Q,Counter):-
    PN is P/2,
    Counter_ is Counter +1,!,
    factor2(PN,S, Q,Counter_).

findZ(P,Z):-
     random(1,P,ZT),
    (P is (ZT^((P-1)/2) mod P)+1 -> Z = ZT; findZ(P,Z)).

findRF(P,_,T,_,R,R):-
    1 is T mod P,!.
findRF(P,M,T,C,R,RF):-
    findI(P,T,I),
    B is C^(2^(M-I-1)) mod P,
    RN is R*B mod P,
    CN is B*B mod P,
    TN is T*CN mod P,
    findRF(P,I,TN,CN,RN,RF).

findI(P,T,I):-
    TSQR is T^2 mod P,
    findIrec(P,TSQR,I,1).

findIrec(P,T,C,C):-
    1 is T mod P,!.
findIrec(P,T,I,C):-
    TN is T^2 mod P,
    C_ is C+1,!,
    findI(P,TN,I,C_).


check_input(P,N):-
	1 is P mod 2,
	legendre_symbol(P,N,1).
