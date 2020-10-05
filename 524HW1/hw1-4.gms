set woodcrafts /bookcase, desk, chair, bedframe/;

parameters
time(woodcrafts) /bookcase 3,desk 2,chair 1,bedframe 2/,
metal(woodcrafts) /bookcase 1,desk 1,chair 1,bedframe 1/,
wood(woodcrafts) /bookcase 4,desk 3,chair 3,bedframe 4/,
profit(woodcrafts) /bookcase 19,desk 13,chair 12,bedframe 17/;

positive variable
x(woodcrafts);

free variable
z;

equations
time1,
metal1,
wood1,
profit1;

time1..
sum(woodcrafts,time(woodcrafts)*x(woodcrafts)) =l= 225;

metal1..
sum(woodcrafts,metal(woodcrafts)*x(woodcrafts)) =l= 117;

wood1..
sum(woodcrafts,wood(woodcrafts)*x(woodcrafts)) =l= 420;

profit1..
z =e= sum(woodcrafts,profit(woodcrafts)*x(woodcrafts));

model pro4 /all/;

solve pro4 using lp maximizing z;

display x.l, z.l;