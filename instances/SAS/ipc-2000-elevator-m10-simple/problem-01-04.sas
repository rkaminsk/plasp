begin_version
3
end_version
begin_metric
0
end_metric
3
begin_variable
var0
-1
2
Atom boarded(p0)
NegatedAtom boarded(p0)
end_variable
begin_variable
var1
-1
2
Atom lift-at(f0)
Atom lift-at(f1)
end_variable
begin_variable
var2
-1
2
Atom served(p0)
NegatedAtom served(p0)
end_variable
1
begin_mutex_group
2
1 0
1 1
end_mutex_group
begin_state
1
0
1
end_state
begin_goal
1
2 0
end_goal
4
begin_operator
down f1 f0
0
1
0 1 1 0
1
end_operator
begin_operator
stop f0
1
1 0
2
0 0 -1 1
1 0 0 2 -1 0
1
end_operator
begin_operator
stop f1
1
1 1
1
1 2 1 0 -1 0
1
end_operator
begin_operator
up f0 f1
0
1
0 1 0 1
1
end_operator
0
