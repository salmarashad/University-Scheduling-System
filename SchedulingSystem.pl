
ta_slot_assignment([],[],_).

ta_slot_assignment([H|T],[H2|T2],Name):-
    H = ta(N,Load),
    N == Name, 
    Load2 is Load -1,
    Load>0,
    H2 = ta(N, Load2),
    ta_slot_assignment(T, T2, Name).

ta_slot_assignment([H|T],[H|T2],Name):-
    H= ta(N,_),
    N \= Name, 
    ta_slot_assignment(T,T2,Name).


slot_assignment(LabsNum,TAs,RemTAs,Assignment):-
    combination(LabsNum,TAs,AssTemp),
    permutation(AssTemp, AssTemp2),
    extract_name(AssTemp2,Assignment),
    repeat_assignment(TAs, Assignment, RemTAs).


extract_name([H|T],[H2|T2]):-
    H = ta(Name,_ ),
    H2 = Name, 
    extract_name(T,T2).
extract_name([],[]).

repeat_assignment(TAs, [], RemTAs) :-
    RemTAs = TAs.
repeat_assignment(TAs, [H|T], RemTAs) :-
    ta_slot_assignment(TAs, RemTAsTemp, H),
    repeat_assignment(RemTAsTemp, T, RemTAs).

combination(0,_,[]).
combination(K,L,[X|Xs]) :- K > 0,
   el(X,L,R), K1 is K-1, combination(K1,R,Xs).

el(X,[X|L],L).
el(X,[_|L],R) :- el(X,L,R).


max_slots_per_day(DaySched,Max):-
    flatten(DaySched, X),
    count_occurences(X, Max).

count_occurences([], _).
count_occurences([H|T], Max):-
    count(H,T,Rep),
    Rep =< Max,
    count_occurences(T,Max).

count(_,[],1).
count(H, [H|T], Rep):-
    count(H, T, Rep1),
    Rep is Rep1 + 1.
count(H, [H2|T], Rep):-
    H \= H2,
    count(H, T, Rep).


day_schedule([DaySlotsHead|DaySlotsTail],TAs,RemTAs,[AssignmentHead|AssignmentTail]):-
    slot_assignment(DaySlotsHead,TAs,RemTAsTemp,AssignmentHead),
    day_schedule(DaySlotsTail,RemTAsTemp,RemTAs,AssignmentTail).
day_schedule([],TAs,TAs,[]).

week_schedule([],_,_,[]).
week_schedule([WeekSlotsHead|WeekSlotsTail],TAs,DayMax,[WeekSchedHead|WeekSchedTail]):-
    day_schedule(WeekSlotsHead,TAs,RemTAs,WeekSchedHead),
    max_slots_per_day(WeekSchedHead,DayMax),
    week_schedule(WeekSlotsTail,RemTAs,DayMax,WeekSchedTail).


