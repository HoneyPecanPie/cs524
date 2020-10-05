set r 'region' /A,B/;
set p 'product' /cream, milk/;
set br 'butterfat rate' /25, 41, 12, 15, 43, 5/;

parameter
rate(br) /25 0.25, 41 0.41, 12 0.12, 15 0.15, 43 0.43, 5 0.05/;

positive variables
x(r) ' gallons purchased form all regions',
y(r) 'how many gallons to be seperated from regions',
n(br) 'how many gallons are after seperated',
z(br,p) 'how many gallons are mixed',
c 'how many gallons cream',
m 'how many gallons milk',
g(r),
h(r);

c.up = 250;
m.up = 2000;

free variable
profit 'in cents';


equations
Asep,
Bsep,
n25_eq,
n15_eq,
c_eq,
m_eq,
e1,
e2,
e3,
e4,
e5(r),
mix_eq(br),
cream_eq,
milk_eq,
profit_eq;

Asep..
0.25*y('A') =e= 0.41*n('41') + 0.12*n('12');

e3..
y('A') =e= n('41') + n('12');

e4..
y('B') =e= n('43') + n('5');

e5(r)..
y(r) =l= x(r);

Bsep..
0.15*y('B') =e= 0.43*n('43') + 0.05*n('5');

n25_eq..
n('25') =e= x('A') - y('A');

n15_eq..
n('15') =e= x('B') - y('B');

c_eq..
sum(br, z(br,'cream')) =e= c;

m_eq..
sum(br, z(br,'milk')) =e= m;

mix_eq(br)..
sum(p, z(br,p)) =e= n(br);

cream_eq..
sum(br,z(br,'cream')*rate(br)) =g= c*0.4;

milk_eq..
sum(br,z(br,'milk')*rate(br)) =g= m*0.2;

e1..
x('A') - 500 =e= g('A') - h('A');

e2..
x('B') - 700 =e= g('B') - h('B');

profit_eq..
profit =e= c*150 + m*70 - (58*g('A') - 54*h('A')) - (42*g('B') - 38*h('B')) - (500*54 + 700*38) - y('A')*5 - y('B')*7;

model pro3 /all/;
solve pro3 using lp maximizing profit;
display x.l, profit.l;

$ontext
pro3.2
we cannot formulate the profit maximization problem as a linear program  because the purchase price is no longer a convex function.
$offtext