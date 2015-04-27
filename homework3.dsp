//Racquel Ivy Awuor
//AME 264: Audio software engineering II
//Homework 3: Filters 

declare name "Second order parametric Q filter";
declare author "Racquel Ivy Awuor";

import("music.lib");
import("filter.lib");
import("math.lib");

//Inputs to be specified by user

Gain = nentry("gain[unit:dB]",12,-12,12,0.01):db2linear;
fc = nentry("Center Frequency[unit:Hz]", 1000, 10, 10000, 10);
Q = nentry("Q-factor", 2, 1,10,0.00001);

//variable definition

theta_c = 2*PI*(fc/SR); //theta_c
m = 10^(Gain/20);
s = 4/(1+m);
beta = 0.5*((1-(s*tan(theta_c/(2*Q))))/(1+(s*tan(theta_c/(2*Q)))));
//beta = 1;
R = (0.5+beta)*(cos(theta_c)); 
a0 = 0.5 - beta;
a1 = 0.0;
a2 = -(0.5-beta);
b1 = -2*R;
b2 = 2*beta;
c0 = m - 10;
d0 = 1.0;

//solution considering recursive has a one sample delay
parametric =  _ <:((((((_:mem)<:(*(a1)),((_:mem),(a2):*)),*(a0):>_ )):+ ~ (_ <:(_,(-b1):*),((_:mem), (-b2):*) :>_)),(c0):*), (*(d0)):+;
process = noise:parametric <: _, _; //generate a stereo
//process = parametric <: _, _;


