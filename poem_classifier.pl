rhyme(cat,bat).
rhyme(dog,fog).

noofelements([],0).
noofelements([_|T],N) :- noofelements(T,X), N is X+1.

rhyming([H|[X,_]]) :- rhyme(H,X).
rhyming([H|[X,_]]) :- rhyme(X,H).
rhyming([H|[X|_]]) :- rhyme(H,X).
rhyming([H|[X|_]]) :- rhyme(X,H).
rhyming([H|[_|T]]) :- rhyming([H|T]).
rhyming([_|[X|T]]) :- rhyming([X|T]).

ishaiku([H|T]) :- noofelements([H|T],1), noofelements(H,7), \+rhyming(H).

rhymelikedoha([_,_,_,A,_,_,B],[_,_,_,C,_,_,D]) :- rhyme(A,C),rhyme(B,D).
rhymelikedoha([_,_,_,A,_,_,B],[_,_,_,C,_,_,D]) :- rhyme(C,A),rhyme(B,D).
rhymelikedoha([_,_,_,A,_,_,B],[_,_,_,C,_,_,D]) :- rhyme(A,C),rhyme(D,B).
rhymelikedoha([_,_,_,A,_,_,B],[_,_,_,C,_,_,D]) :- rhyme(C,A),rhyme(D,B).

isdoha([H,T]) :- rhymelikedoha(H,T),noofelements(H,7), noofelements(T,7).

rhymelikequartet([A|_],[_,_,_,_,_,_,B],[C|_],[_,_,_,_,_,_,D]) :- rhyme(A,C), rhyme(B,D).
rhymelikequartet([A|_],[_,_,_,_,_,_,B],[C|_],[_,_,_,_,_,_,D]) :- rhyme(C,A), rhyme(B,D).
rhymelikequartet([A|_],[_,_,_,_,_,_,B],[C|_],[_,_,_,_,_,_,D]) :- rhyme(A,C), rhyme(D,B).
rhymelikequartet([A|_],[_,_,_,_,_,_,B],[C|_],[_,_,_,_,_,_,D]) :- rhyme(C,A), rhyme(D,B).

isquartet([A,B,C,D]) :- rhymelikequartet(A,B,C,D), noofelements(A,7), noofelements(B,7), noofelements(C,7), noofelements(D,7).

isfusionsonnet([W,X,Y,Z]) :- isdoha([W,X]), isdoha([Y,Z]).
isfusionsonnet([A,B,C,D,E,F]) :- isdoha([E,F]), isquartet([A,B,C,D]).
isfusionsonnet([A,B,C,D,E,F]) :- isquartet([C,D,E,F]), isdoha([A,B]).
isfusionsonnet([A,B,C,D,E,F,G,H]) :- isquartet([E,F,G,H]),isquartet([A,B,C,D]).
isfusionsonnet([A,B,C,D,E]) :- isquartet([A,B,C,D]),ishaiku([E]). 
isfusionsonnet([X,Y,Z]) :- ishaiku([Z]), isdoha([X,Y]).

isfusionsonnet([H,F|T]) :-  isdoha([H,F]), isfusionsonnet(T).
isfusionsonnet([H,Q,R,M|T]) :-  isquartet([H,Q,R,M]), isfusionsonnet(T).

isunknown([]).
isunknown([H|T]) :- \+isdoha([H|T]),\+ishaiku([H|T]),\+isfusionsonnet([H|T]),\+isquartet([H|T]) .

classify([]) :- write('Unknown'),!.
classify([H|T]) :- isunknown([H|T]), write('Unknown'),!.
classify([H|T]) :- isdoha([H|T]), write('Doha'),!.
classify([H|T]) :- ishaiku([H|T]), write('Haiku'),!.
classify([H|T]) :- isquartet([H|T]), write('Quartet'),!.
classify([H|T]) :- isfusionsonnet([H|T]), write('Fusion Sonnet'),!.

