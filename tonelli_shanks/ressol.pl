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
    factor2(P_,S,Q),
    ( S == 1 -> 
        RF is (N^( (P+1)/4 )) mod P ;
       ( findZ(P,Z),
         C is Z^Q mod P,
         T is N^Q mod P,
         R is N^( (Q+1)/2 ) mod P,
         findRF(P,S,T,C,R,RF)
        )
    ).

factor2(P,0,P):-
    1 is P mod 2.
factor2(P,S,Q):-
    \+ 1 is P mod 2,	
    PN is P/2,
    factor2(PN,SN,Q),
    S is SN+1.

findZ(P,Z):-
    P_ is P-1,
    random(1,P,ZT),
    (legendre_symbol(P,ZT,P_) -> Z = ZT; findZ(P,Z)).

legendre_symbol(P,Z,L):-
	L is Z^((P-1)/2) mod P.

findRF(P,_,T,_,R,R):-
    1 is T mod P.
findRF(P,M,T,C,R,RF):-
    \+ 1 is T mod P,
    findI(P,T,I),
    B is C^(2^(M-I-1)) mod P,
    RN is R*B mod P,
    CN is B*B mod P,
    TN is T*CN mod P,
    findRF(P,I,TN,CN,RN,RF).

findI(P,T,I):-
    TSQR is T^2 mod P,
    findIrec(P,TSQR,I).

findIrec(P,T,1):-
    1 is T mod P.
findIrec(P,T,I):-
    \+1 is T mod P,
    TN is T^2 mod P,
    findI(P,TN,IN),
    I is IN+1.


check_input(P,N):-
	1 is P mod 2,
	legendre_symbol(P,N,1).
