
%% I will not accept a submission with the T0D0 comments left in place!

url("https://logic.puzzlebaron.com/pdf/I559QK.pdf").

solution([[350,    'Christian',	'Cooking',	'A Single Kiss'],
		  [710,    'Julius',	'Photography',	'Sad to See You'],
		  [1300,  'Cash',		'Astronomy',	'All By Myself'],
		  [2060,  'Katie',		'Reading',	'Moon River'],
		  [2080,  'Jaylin',		'Bird watching',	'One More Time'] ]).

names([ 'Christian', 'Julius', 'Cash', 'Katie',	'Jaylin']).
activities(['Cooking', 'Photography', 'Astronomy', 'Reading', 'Bird watching']).
songs(['A Single Kiss', 'Sad to See You', 'All By Myself', 'Moon River', 'One More Time']).


solve(T) :-

	T = [[350, N1, A1, S1],
		 [710, N2, A2, S2],
		 [1300, N3, A3, S3],
		 [2060, N4, A4, S4],
		 [2080, N5, A5, S5]],

	names(Names), permutation([N1, N2, N3, N4, N5], Names),
	activities(Activities), permutation([A1, A2, A3, A4, A5], Activities),
	songs(Songs), permutation([S1, S2, S3, S4, S5], Songs),
	
	clue1(T), 
	clue2(T), 
	clue3(T), 
	clue4(T), 
	clue5(T), 
	clue7(T), 
	clue6(T), 
	clue8(T), 
	clue9(T), 
	clue10(T),
	clue11(T).


	% 1. The 5 people were the singer known for Moon River, the person who enjoys photography, the one who received the
	%	 2080 reward, Cash, and the singer known for A Single Kiss.
	clue1(T) :-
		member([R1, N1, A1, 'Moon River'], T),
		member([R2, N2, 'Photography', S2], T),
		member([2080, N3, A3, S3], T),
		member([R4, 'Cash', A4, S4], T),
		member([R5, N5, A5, 'A Single Kiss'], T),
		R1 \= 2080,
		R2 \= 2080,
		R4 \= 2080,
		R5 \= 2080,

		N1 \= 'Cash',
		N2 \= 'Cash',
		N3 \= 'Cash',
		N5 \= 'Cash',

		A1 \= 'Photography',
		A3 \= 'Photography',
		A4 \= 'Photography',
		A5 \= 'Photography',

		S2 \= 'Moon River',
		S2 \= 'A Single Kiss',
		S3 \= 'Moon River',
		S3 \= 'A Single Kiss',
		S4 \= 'Moon River',
		S4 \= 'A Single Kiss'.


	% 2. The one with 1300 doesnt sing Sad to See You.
	clue2(T) :- member([1300, _, _, S], T), S \= 'Sad to See You'.

	% 3. Of Katie and Julius, one earned 2060 and the other is famous for the song Sad to See You.
	clue3(T) :- 
		member([R1, 'Katie', _, S1], T),
		member([R2, 'Julius', _, S2], T),
		(R1=2060, S2='Sad to See You';
		 R2=2060, S1= 'Sad to See You').

	% 4. The singer know for Moon River recieved a larger rewarded than Julius.
	clue4(T) :-
		member([R1, N, _, 'Moon River'], T),
		member([R2, 'Julius', _, S], T),
		R1 > R2,
		N \= 'Julius',
		S \= 'Moon River'.

	% 5. The person who enjoys astronomy was rewarded less than the singer know for Moon River.
	clue5(T) :-
		member([R1, _, 'Astronomy', S], T),
		member([R2, _, A, 'Moon River'], T),
		R1 < R2,
		A \= 'Astronomy',
		S \= 'Moon River'.

	% 6. The singer known for One More Time does not enjoy astronomy.
	clue6(T) :- member([_, _, A, 'One More Time'], T), A \= 'Astronomy'.

	% 7. Christian was rewarded less than the person who enjoys photography.
	clue7(T) :-
		member([R1, 'Christian', A, _], T),
		member([R2, N, 'Photography', _], T),
		R1 < R2,
		A \= 'Photography',
		N \= 'Christian'.

	% 8. Either the singer know for A Single Kiss or the singer known for All By Myself enjoys cooking.
	clue8(T) :-
		member([_, _, 'Cooking', S], T),
		member(S, ['A Single Kiss', 'All By Myself']).

	% 9. The singer known for All By Myself does not enjoy cooking.
	clue9(T) :- member([_, _, A, 'All By Myself'], T), A \= 'Cooking'.

	% 10. The one who recieved the 350 reward is famous for the song A Single Kiss.
	clue10(T) :- member([350, _, _, 'A Single Kiss'], T).

	% 11. The person who enjoys bird watching is Jaylin.
	clue11(T) :- member([_, 'Jaylin', 'Bird watching', _], T).

	


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
