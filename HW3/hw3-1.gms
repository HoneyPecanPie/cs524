*option lp=cplex;

set T /July, August, September, October, November, December/;

scalars
I0 'initial inventory in June',
P0 'initial production schedulein June',
inc_cost 'cost of increasing production from one month to the next',
dec_cost 'cost of decreasing production from one month to the next',
storage_cost 'storage cost for less than 8000',
add_storage_cost 'additional storage cost for more than 8000',
loss 'cost in lost goodwill and reduction in future revenues';

I0 = 2000;
P0 = 4000;
inc_cost = 1.5;
dec_cost = 1;
storage_cost = 0.2;
add_storage_cost = 0.5;
loss = 1;

parameters
Sale(T) 'sales forecasts for months' /July 4000, August 8000, September 20000, October 12000, November 6000, December 2000/;

positive variables
I(T) 'inventory for every month',
I1(T),
P(T) 'production schedule for months',
L(T) 'increase cost',
S(T) 'decrease cost',
A(T),
B(T);

free variable
cost;

P.lo(T) = 0;

equations
inventory_eq(T),
cost_eq,
incdec_eq(T),
s_eq(T);

inventory_eq(T)..
I(T) - I1(T) =e= I0$(ord(T) = 1) + I(T-1) + P(T) - Sale(T);

$ontext
take the storage_cost in June into acount when we get cost
$offtext
cost_eq..
cost =e= sum(T, inc_cost*L(T) + dec_cost*S(T) + add_storage_cost*A(T)  - storage_cost*B(T) + loss*I1(T)) + card(T)*storage_cost*8000 + I0*storage_cost;

incdec_eq(T)..
P(T) - P(T-1) - P0$(ord(T) = 1) =e= L(T) - S(T);

s_eq(T)..
I(T) - 8000 =e= A(T) - B(T);

   
model pro1 /all/;
solve pro1 using lp minimizing cost;
display p.l, cost.l;
