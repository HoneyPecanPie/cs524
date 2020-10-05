option limrow = 0, limcol = 0 ;
option solprint = off;


$ontext
Around 10563 units of germanium should be melted in method 1 and minimum cost is $641725.352.
$offtext
set methods 'methond1 and method2'/m1,m2/;
set grades /def "defective", g1 "grade1", g2 "grade2", g3 "grade3", g4 "grade 4"/;
set refire_grades(grades) /def, g1, g2, g3/;

table q(grades,methods) "the qualities of germanium produced by different melting methods"
        m1      m2
def    0.3     0.2
g1     0.3     0.2
g2     0.2    0.25
g3    0.15     0.2
g4    0.05    0.15;

table refire(grades,refire_grades)
        def     g1      g2      g3
def     0.3      0       0       0
g1     0.25    0.3       0       0
g2     0.15    0.3     0.4       0
g3      0.2    0.2     0.3     0.5
g4      0.1    0.2     0.3     0.5;


positive variable
x(methods) "how many units of germanium tp be melted by different methods",
y(refire_grades) 'how many units of melted germanium in different grades are chosen to be refired';

free variable
processing_cost;

parameters
melt_cost(methods) /m1 50,m2 70/;

equations
cost,
germanium_limit,
refire_up(refire_grades),
g4_demands,
g3_demands,
g2_demands,
g1_demands;

cost..
processing_cost =e= sum(methods, melt_cost(methods)*x(methods)) + sum(refire_grades, y(refire_grades))*25;

germanium_limit..
sum(methods,x(methods)) =l= 20000;

refire_up(refire_grades)..
y(refire_grades) =l= sum(methods,q(refire_grades,methods)*x(methods));

g4_demands..
sum(methods,q('g4',methods)*x(methods)) + sum(refire_grades, refire('g4',refire_grades)*y(refire_grades)) =g= 1000;

g3_demands..
sum(methods,q('g3',methods)*x(methods)) - y('g3') + sum(refire_grades, refire('g3',refire_grades)*y(refire_grades)) =g= 2000;

g2_demands..
sum(methods,q('g2',methods)*x(methods)) - y('g2') + sum(refire_grades, refire('g2',refire_grades)*y(refire_grades)) =g= 3000;

g1_demands..
sum(methods,q('g1',methods)*x(methods))- y('g1') + sum(refire_grades, refire('g1',refire_grades)*y(refire_grades)) =g= 3000;

model transistors /all/;
solve transistors using lp minimizing processing_cost;
scalar sstat, mstat;
sstat = transistors.solvestat;
mstat = transistors.modelstat;

display sstat,mstat,x.l,processing_cost.l;
