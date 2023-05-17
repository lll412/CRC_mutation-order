clear all
seed=12345;  
rng(seed,'twister');
M0=[3
 3
 55
 188
 589
 1376
 2893
 5396
 10084
 17957
 31526
 42381
 54754
 67393
 74473
 74301
 62117
];  
P0=[72394578
 72210122
 74259274
 75390703
 76696109
 79981477
 79416642
 74888049
 70349908
 64617689
 58921791
 51312063
 43156922
 35513414
 28508602
 22311393
 15601745
];  
Actual=(M0./P0)*10^(5)*0.15; 
[T, ss]=size(Actual);  
a1=73;
b1=73-0.07;
a2=a1;
b2=b1;
a3=a1;
b3=a3-0.27;
a4=a1;
b4=b3;
parnum=5; 
min_p=[ 0 0 0 0 0];max_p=[ 20 1000 1000 1000 1000]; 
particle=100; 
generation=11;  
epsilon(1)=10^5;  
epsilon(2:generation)=10^4*[1 0.9 0.8 0.6 0.3 0.05 0.03 0.003 0.002 
0.0008];
param_tot=zeros(generation,particle,parnum);
diff=zeros(generation,particle,parnum);
weight=zeros(1,particle);
weight1=zeros(1,particle);
para=zeros(1,particle);
var1=zeros(1,parnum);
weight0=zeros(1,particle);
err_tot=zeros(particle,generation); 
ii=1;
while ii<(particle+1); 
 param_0=unifrnd(min_p,max_p);
 v=param_0(1);
 mu2=param_0(2);
 mu3=param_0(3);
 mu4=param_0(4);
 mu5=param_0(5);
 err2=0;
simulation=my_kr(a1,b1,a2,b2,a3,b3,a4,b4,v,mu2,mu3,mu4,mu5);
err2=err2+(Actual-simulation)'*(Actual- simulation); 
err_tot(ii,gener)=err2;
err_tot(ii,1)=err2;
 if err_tot(ii,1)<epsilon(1) 
 param_tot(1,ii,1)=param_0(1); 
 param_tot(1,ii,2)=param_0(2);
 param_tot(1,ii,3)=param_0(3);
 param_tot(1,ii,4)=param_0(4);
 param_tot(1,ii,5)=param_0(5);
 ii=ii+1 ; 
 end
for ii=1:particle
 weight(ii,1)=1/particle;
end
for gener=2:generation
 ii=1;
 for i=1:particle
 weight1(i)=weight(i,gener-1); 
 end
 while ii<(particle+1);
 w00=cumsum(weight1);
 w01=w00/w00(end);
 rr=rand; 
 w02=[w01 rr];
 w03=sort(w02);
 [aa index0]=find(w03==rr)
 v_0= param_tot(gener-1,index0,1);
 mu2_0=param_tot(gener-1,index0,2);
 mu3_0=param_tot(gener-1,index0,3); 
 mu4_0=param_tot(gener-1,index0,4);
 mu5_0=param_tot(gener-1,index0,5);
 variance1=10; 
 v=v_0+randn*variance1;
 mu2=mu2_0+randn*variance1*10;
 mu3=mu3_0+randn*variance1*10;
 mu4=mu4_0+randn*variance1*10;
 mu5=mu5_0+randn*variance1*10; 
err2=0
simulation=my_kr(a1,b1,a2,b2,a3,b3,a4,b4,v,mu2,mu3,mu4,mu5);
err2=err2+(Actual- simulation)'*(Actual- simulation); 
err_tot(ii,gener)=err2; 
 if err_tot(ii,gener)<epsilon(gener) 
 param_tot(gener,ii,1)=v;
 param_tot(gener,ii,2)=mu2;
 param_tot(gener,ii,3)=mu3;
 param_tot(gener,ii,4)=mu4;
 param_tot(gener,ii,5)=mu5;
 diff(gener,ii,1)=v-v_0;
 diff(gener,ii,2)=mu2-mu2_0;
 diff(gener,ii,3)=mu3-mu3_0;
 diff(gener,ii,4)=mu4-mu4_0;
 diff(gener,ii,5)=mu5-mu5_0;
 ii=ii+1;
 end
 
 end
 end
 for j=1:4
 clear para
 for i=1:particle
 para(i)=param_tot(gener,i,j);
 end
 var1(j)=var(para);
 end
 dom=0;
 for i=1:particle
 p1=exp(-(diff(gener,i,1))^2/2/var1(1));
 p2=exp(-(diff(gener,i,2))^2/2/var1(2));
 p3=exp(-(diff(gener,i,3))^2/2/var1(3));
 p4=exp(-(diff(gener,i,4))^2/2/var1(4));
 p5=exp(-(diff(gener,i,5))^2/2/var1(5));
 dom=dom+weight(i,gener-1)*(p1+p2+p3+p4+p5);
 end
 for i=1:particle
 weight0(i)=1/err_tot(i,gener)/dom;
 end
 for i=1:particle
 weight(i,gener)=weight0(i)/sum(weight0);  
 end
end
end
