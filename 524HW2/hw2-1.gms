option limrow = 0, limcol = 0 ;
option solprint = off;

$ontext
1.1 problem
we should sign up 10 minites on TV, 80 pages on magezine, and maximun audience is 98 million
$offtext
set ad three ways to advertise /TV, magazine, radio/;
set part_ad(ad) /TV, magazine/;

positive variable
x(ad);

free variable
z 'audience amount';

parameters
galleons(ad) /TV 20000, magazine 10000, radio 2000/,
customers(ad) /TV 1.8, magazine 1, radio 0.25/;

equations
maxgalleons_1,
total_customer_1;

maxgalleons_1..
sum(part_ad,x(part_ad)*galleons(part_ad)) =l= 1000000;

total_customer_1..
z =e= sum(part_ad,customers(part_ad)*x(part_ad));

x.lo("TV") = 10;

model pro1 /maxgalleons_1, total_customer_1/;
solve pro1 using lp maximizing z;

scalar sstat, mstat;
sstat = pro1.solvestat;
mstat = pro1.modelstat;

display sstat,mstat,x.l,z.l;



$ontext
1.2 problem
we should sign up 40 minutes on TV, 20 pages on magazine, and maximun audience is 92 million
$offtext

parameters  ww(ad);
ww('TV') = 1;
ww('magazine') = 3;
ww('radio') = 1/7; 

equations
total_ww_1;

total_ww_1..
sum(part_ad,x(part_ad)*ww(part_ad)) =l= 100;

model pro2 /maxgalleons_1, total_customer_1, total_ww_1/;
solve pro2 using lp maximizing z;
scalar sstat, mstat;
sstat = pro2.solvestat;
mstat = pro2.modelstat;

display sstat,mstat,x.l,z.l;



$ontext
1.3 problem
we should sign up 10 minutes on TV, 400 minutes on radio, and maximum audience is 118 million
$offtext

positive variable
x(ad);

equations
maxgalleons_2,
total_customer_2,
total_ww_2;

maxgalleons_2..
sum(ad,x(ad)*galleons(ad)) =l= 1000000;

total_customer_2..
z =e= sum(ad,x(ad)*customers(ad));

total_ww_2..
sum(ad,x(ad)*ww(ad)) =l= 100;

model pro3 /maxgalleons_2,total_customer_2,total_ww_2/;
solve pro3 using lp maximizing z;
scalar sstat, mstat;
sstat = pro3.solvestat;
mstat = pro3.modelstat;

display sstat,mstat,x.l,z.l;





$ontext
1.4 problem
we should sign up around 29 minutes on TV, 18 pages on magazine, 120 minutes on radio, and maximum
audience is 100.194 million
$offtext
x.lo("magazine") = 2;
x.up("radio") = 120;

model pro4 /maxgalleons_2,total_customer_2,total_ww_2/;
solve pro4 using lp maximizing z;
scalar sstat, mstat;
sstat = pro4.solvestat;
mstat = pro4.modelstat;

display sstat,mstat,x.l,z.l;