
url("https://logic.puzzlebaron.com/pdf/H843CX.pdf").

solution([[5.75, 'Basketball', 		'Johnnie',	 'Perris'			],
		  [6.75, 'Fruit basket', 	'Everett',	 'Quimby'			],
		  [7.75, 'Computer', 		'Pablo',	 'Fontanelle'		],
		  [8.75, 'Rare book', 		'Luther',	 'Oakdale'			],
		  [9.75, 'Toaster', 		'Willie',	 'Newport Beach'	],
		  [10.75, 'Tea set', 		'Brad',		 'Mattawamkeag'		] ]).

packages(['Basketball', 'Fruit basket', 'Computer', 'Rare book', 'Toaster', 'Tea set']).
names(['Johnnie','Everett',	'Pablo','Luther','Willie','Brad']).
locations(['Perris', 'Quimby', 'Fontanelle', 'Oakdale', 'Newport Beach', 'Mattawamkeag']).

solve(T) :-
	
	T = [[5.75, P1, N1, L1],	
		 [6.75, P2, N2, L2],	
		 [7.75, P3, N3, L3],	
		 [8.75, P4, N4, L4],	
		 [9.75, P5, N5, L5],
		 [10.75, P6, N6, L6]],


	names(Names), permutation([N1, N2, N3, N4, N5, N6], Names),
	clue10(T),% M, _, N, _
	clue11(T),% M, _, N, _


	locations(Locations), permutation([L1, L2, L3, L4, L5, L6], Locations),
	clue13(T),% M, _, N, L
	clue2(T), % M, _, N, L
	clue7(T), % M, _, N, L


	packages(Packages), permutation([P1, P2, P3, P4, P5, P6], Packages),
	clue1(T), % M, P, _, L
	clue3(T), % _, P, N, L
	clue4(T), % _, P, N, _
	clue5(T), % M, P, _, L
	clue6(T), % M, P, _, L
	clue8(T), % M, P, N, L
	clue9(T), % M, P, N, _
	clue12(T).% M, P, N, _


	% 1. The package with the rare book in it cost 2 dollars less than the package going to Mattawamkeag.
	clue1(T) :-
		member([M1, 'Rare book', _, L1], T),
		member([M2, P2, _, 'Mattawamkeag'], T),
		M1 is M2 - 2,
		P2 \= 'Rare book',
		L1 \= 'Mattawamkeag'.

	% 2. The shipment going to Quimby cost somewhat less than Pablos package
	clue2(T) :-
		member([M1, _, N1, 'Quimby'], T),
		member([M2, _, 'Pablo', L1], T),
		M1 < M2,
		N1 \= 'Pablo',
		L1 \= 'Quimby'.

	% 3. The six packages are Luthers package, the shipment going to Mattawamkeag, the package going to
	%	 Newport Beach, the package with the basketball in it, the package with the fruit basket in it and the package
	%	 going to Fontanelle.

	clue3(T) :-
		member([_, P1, 'Luther', L1], T),
		member([_, P2, N2, 'Mattawamkeag'], T),
		member([_, P3, N3, 'Newport Beach'], T),
		member([_, 'Basketball', N4, L4], T),
		member([_, 'Fruit basket', N5, L5], T),
		member([_, P6, N6, 'Fontanelle'], T),

		P1 \= 'Basketball',
		P1 \= 'Fruit basket',
		P2 \= 'Basketball',
		P2 \= 'Fruit basket',
		P3 \= 'Basketball',
		P3 \= 'Fruit basket',
		P6 \= 'Basketball',
		P6 \= 'Fruit basket',

		N2 \= 'Luther',
		N3 \= 'Luther',
		N4 \= 'Luther',
		N5 \= 'Luther',
		N6 \= 'Luther',

		L1 \= 'Mattawamkeag',
		L1 \= 'Newport Beach',
		L1 \= 'Fontanelle',
		L4 \= 'Mattawamkeag',
		L4 \= 'Newport Beach',
		L4 \= 'Fontanelle',
		L5 \= 'Mattawamkeag',
		L5 \= 'Newport Beach',
		L5 \= 'Fontanelle'.

	% 4. The package with the tea set in it isnt Pablos
	clue4(T) :-
		member([_, 'Tea set', N1, _], T),
		member([_, P1, 'Pablo', _], T),
		N1 \= 'Pablo',
		P1 \= 'Tea set'.

	% 5. The shipment going to Fontanelle is either the shipment with the toaster in it or the package that cost
    % 	 7.75.
	clue5(T) :-
		member([M, P, _, 'Fontanelle'], T),
		(M = 7.75, P \= 'Toaster';
		 P = 'Toaster', M \= 7.75).


	% 6. The package with the basketball in it cost 2 dollars less than the shipment going to Fontanelle.
	clue6(T) :-
		member([M1, 'Basketball', _, L1], T),
		member([M2, P2, _, 'Fontanelle'], T),
		L1 \= 'Fontanelle',
		P2 \= 'Basketball',
		M1 is M2 - 2.

	% 7.  Of the shipment going to Perris and the shipment going to Mattawamkeag, one cost $5.75 and the other is
	%     Brads.
	clue7(T) :-
		member([M1, _, N1, 'Perris'], T),
		member([M2, _, N2, 'Mattawamkeag'], T),
		(M1 = 5.75, N2='Brad';
		 M2 = 5.75, N1= "Brad").

	% 8. Of the package going to Mattawamkeag and the shipment that cost $6.75, one is Brads and the other
	%	 contains the fruit basket.
	clue8(T) :-
		member([M1, P1, N1, 'Mattawamkeag'], T),
		member([6.75, P2, N2, L2], T),
		M1 \= 6.75,
		L2 \= 'Mattawamkeag',
		(P1='Fruit basket', N2='Brad';
		 P2='Fruit basket', N1='Brad').

	% 9. Everetts package is either the shipment with the toaster in it or the package that cost 6.75.
	clue9(T) :-
		member([M, P, 'Everett', _], T),
		(M = 6.75, P \= 'Toaster';
		 P = 'Toaster', M \= 6.75).

	% 10. The shipment that cost 9.75 isnt Everetts.
	clue10(T) :-
		member([M, _, 'Everett', _], T), M \= 9.75.

	% 11. The shipment that cost 7.75 isnt Willies.
	clue11(T) :-
		member([M, _, 'Willie', _], T), M \= 7.75.


	% 12. Brads shipment is either the package with the toaster in it or the shipment that cost 10.75.
	clue12(T) :-
		member([M, P, 'Brad', _], T),
		(M = 10.75, P \= 'Toaster';
		 P = 'Toaster', M \= 10.75).

	% 13. Johnnies package cost 4 dollars less than the shipment going to Newport Beach.
	clue13(T) :-
		member([M1, _, 'Johnnie', L1], T),
		member([M2, _, N2, 'Newport Beach'], T),
		N2 \= 'Johnnie',
		L1 \= 'Newport Beach',
		M1 is M2 - 4.

check :- 
	% Confirm that the correct solution is found
	solution(S), (solve(S); not(solve(S)), writeln("Fails Part 1: Does  not eliminate the correct solution"), fail),
	% Make sure S is the ONLY solution 
	not((solve(T), T\=S, writeln("Failed Part 2: Does not eliminate:"), print_table(T))),
	writeln("Found 1 solutions").

print_table([]).
print_table([H|T]) :- atom(H), format("~|~w~t~20+", H), print_table(T). 
print_table([H|T]) :- is_list(H), print_table(H), nl, print_table(T). 


% Show the time it takes to conform that there are no incorrect solutions
checktime :- time((not((solution(S), solve(T), T\=S)))).
