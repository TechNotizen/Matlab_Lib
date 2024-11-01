% This is a script using Class
close all;clc;clear;
ASM1 = ASMClass(1,30,1.2,0.5,220,50,2);
% 2 fach XSh
ASM2 = ASMClass(1,60,1.2,0.5,220,50,2);
% 0.5 fach XSh
ASM3 = ASMClass(1,15,1.2,0.5,220,50,2);
% 2 fach XRsigma
ASM4 = ASMClass(1,30,2.4,0.5,220,50,2);
%3 fach RR'
ASM5 = ASMClass(1,30,1.2,1.5,220,50,2);

figure;
ASM1.dispok('r','Orign');
ASM2.dispok('g','2XSh');
ASM3.dispok('b','0.5XSh');
ASM4.dispok('c','2XRSigma');
ASM5.dispok('m','3RR');
axis([-10, 150, -60, 60]);
legend('show')
xlabel('-Im');
ylabel('Re');
title('Ortskreis des ASM');


figure;
ASM1.dispmel('r','Orign');
ASM2.dispmel('g','2XSh');
ASM3.dispmel('b','0.5XSh');
ASM4.dispmel('c','2XRSigma');
ASM5.dispmel('m','3RR');
legend('show')
xlabel('-s');
ylabel('Mel');
title('Mel gegen s-ASM');

