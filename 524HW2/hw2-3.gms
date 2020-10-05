option limrow = 0, limcol = 0 ;
option solprint = off;



$ontext
After experiment with different NUM_WANDS 500,1000,1500,2000,2500,300,3500,5000, I find that the total galleons
produced increase at first and then decrease. Also I try different solvers when NUM_WANDS=1000.
            PARAMETER LP_time              =        0.086  
            PARAMETER CPLEX_time           =        0.020  
            PARAMETER BARON_time           =        0.200  
            PARAMETER BDMLP_time           =        0.088  
            PARAMETER IPOPT_time           =        0.438
Different solvers need different time to solve this problem but they end up in the same solution.

$offtext

$setglobal NUM_WANDS 1000
$setglobal NUM_COMPONENTS 100
$setglobal DENSITY_CONTROL 0.05
sets
    W Wands /wand1*wand%NUM_WANDS%/
    C Components /component1*component%NUM_COMPONENTS%/
;

parameters
    b(C) Number of components on hand
    g(W) Galleons per wand
    a(C,W)  Number of c requried to make w
    u(W)    Max number of wands to make
    ell(W)    Min number of wans to make
;

scalars
  alpha / %DENSITY_CONTROL% /
;

b(C) = round(uniform(5000,10000)) ;
g(W) = uniform(5,30) ;
a(C,W) = 1$(uniform(0,1) < alpha) + 1$(uniform(0,1) < alpha) ;
ell(W) = round(uniform(5,20)) ;
u(W) = round(uniform(50,100)) ;

positive variables
x(W);

free variable
obj;

equations
galleons,
res_constraints(C);

galleons..
obj =e= sum(W,x(W)*g(W));

res_constraints(C)..
sum(W,a(C,W)*x(W)) =l= b(C);

x.up(W) = u(W);
x.lo(W) = ell(W);

model pro /all/;
solve pro using lp maximizing obj;

scalar sstat, mstat,LP_time;
sstat = pro.solvestat;
mstat = pro.modelstat;
LP_time=pro.resusd;
display sstat,mstat,x.l,obj.l;

scalar CPLEX_time;
option lp=CPLEX;
solve pro using lp maximizing obj;
CPLEX_time=pro.resusd;

scalar BARON_time;
option lp=BARON;
solve pro using lp maximizing obj;
BARON_time=pro.resusd;

scalar BDMLP_time;
option lp=BDMLP;
solve pro using lp maximizing obj;
BDMLP_time=pro.resusd;

scalar IPOPT_time;
option lp=IPOPT;
solve pro using lp maximizing obj;
IPOPT_time=pro.resusd;

display LP_time,CPLEX_time,BARON_time,BDMLP_time,IPOPT_time;
