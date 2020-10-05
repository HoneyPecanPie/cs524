positive variables x1, x2, x3;

free variable z;

equations
e1,
e2,
e3,
obj 'min obj';

e1..
x1 - 4*x2 + x3 =l= 15;

e2..
9*x1 + 6*x3 =e= 12;

e3..
-5*x1 + 9*x2 =g= 3;

obj..
z =e= 3*x1 + 2*x2 - 33*x3;

model p1 /all/;

solve p1 using lp minimizing z;

parameter x1val, x2val, x3val, zval;
x1val = x1.l;
x2val = x2.l;
x3val = x3.l;
zval = z.l;
display zval, x1val, x2val,x3val;

