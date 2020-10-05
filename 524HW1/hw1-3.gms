set CE "chemical elements" /C, Cu, Mn/;
set RM "raw material" /I1, I2, I3, C1 , C2, A1, A2/;


table a(CE,RM) "grades"
     I1     I2      I3      C1      C2      A1      A2
C   2.5      3       0       0       0       0       0
Cu    0      0     0.3      90      96     0.4     0.6
Mn  1.3    0.8       0       0       4     1.2       0;

parameter
avail(RM) /I1 400,I2 300,I3 600,C1 500,C2 200,A1 300,A2 250/,
cost(RM) /I1 200,I2 250,I3 150,C1 220,C2 240,A1 200,A2 165/,
minGrade(CE) /C 2,Cu 0.4,Mn 1.2/,
maxGrade(CE) /C 3,Cu 0.6,Mn 1.65/;

positive variables
x(RM);

free variable
totalcost;

equations
min_chem_elem_grade(CE),
max_chem_elem_grade(CE),
prod_cost,
order;

min_chem_elem_grade(CE)..
sum(RM,a(CE,RM)*x(RM)) =g= sum(RM,x(RM))*minGrade(CE);

max_chem_elem_grade(CE)..
sum(RM, a(CE,RM)*x(RM)) =l= sum(RM,x(RM))*maxGrade(CE);

prod_cost..
totalcost =e= sum(RM,x(RM)*cost(RM));

order..
sum(RM,x(RM)) =g= 500;

x.up(RM) = avail(RM);

model pro3 /all/;

solve pro3 using lp minimizing totalcost;

parameters pct(CE);

pct(CE) = sum(RM,a(CE,RM)*x.l(RM)) / sum(RM,x.l(RM));

display pct, x.l, totalcost.l ; 



 