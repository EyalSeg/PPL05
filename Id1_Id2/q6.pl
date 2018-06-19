% Signature: sub(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order. 
% Precondition: List is fully instantiated (queries do not include variables in their first argument). 
% Example:
% ?- sub(X, [1, 2, 3]).
% X = [1, 2, 3];
% X = [1, 2];
% X = [1, 3];
% X = [2, 3];
% X = [1];
% X = [2];
% X = [3];
% X = [];
% false

sub([], []).
sub(Sublist, List) :-
    append([Head1], Tail1, Sublist),
    append([Head2], Tail2, List),
    Head1 = Head2,
    sub(Tail1, Tail2).

sub(Sublist, List) :-
    append([_], Tail2, List),
    sub(Sublist, Tail2).
    

        
