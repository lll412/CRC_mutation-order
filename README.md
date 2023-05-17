# CRC_mutation-order
# CRC_Risk
approximate Bayesian computation schemes with the simulated likelihood density for our ppaer on mathematical modeling the order of driver gene mutation in colorectal cancer
1. how to build
-----------------
The code is edited by Matlab, which includes the solution of systems of differential equations by using the fourth-order Runge-Kutta method.
Hence, the hazard function in paper is solved by the file named "my_rk". 
The parameters are estimated by using approximate Bayesian computation schemes with the simulated likelihood density which is named as "abe_sld" (file name). 
In the file named "abe_sld", it need call "my_rk" function.

Note: the number of parameter in file named "abe_sld" shold keep consitent with the parameter of "my_rk" function, and the range of parameter value shold be set to an appropriate range.
For example, the mutation rate, mu1、mu2、mu3、mu4, are limited to the interval (0,1).

2. how to run 
---------------
setting the range of parameters you hope to estimate in the  file named "abe_sld", eg : min_p=[ 0 0 0 0 0], max_p=[ 20 1000 1000 1000 1000].
try to set the threshold values (err value between the real data and simulated value) for accepting estimate, 
where you can first set large value, and then gradually reduce the acceptable value of the error by the last fitting results.
when all the threshold values (err value between the real data and simulated value) stay on an order of magnitude for all particles, and the fitting results of the last generation are the optimal results.
you can click the Run button directly in matlab editor with the file named "abe_sld", 
after you set suitable initial value range of parameters and the threshold values (err value between the real data and simulated value) for accepting estimate.

Note: the file named "abe_sld" and the file named "my_rk" are edited in Matlab editor, the Run of "abe_sld" need call the "my_rk" function. 
You will need to change the values of the parameters ai and bi (i=1,2,3,4) in the named "abe_sld" when you choose other models with different pathways displayed in the paper.



 
