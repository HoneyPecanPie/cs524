set J /1, 2, 3/;

positive variables
x(J);

free variable
z;

equations
e1,
obj;

e1..
3*x("1") =g= sum(J,x(J));

obj..
z =e= 5*(x("1") + 2*x("2")) - 11*(x("2") - x("3"));

x.lo(J) = 0;
x.up(J) = 3;

model prob2 /all/;

solve prob2 using lp maximizing z;

display x.l, x.lo, x.up, z.l;