clc
clear
close
chems = imread('Chems.jpg');

% rayas = chems;
% 
% rayas(:, 1:size(rayas,2)*(1/3), 1);
% rayas(:, 1:size(rayas,2)*(1/3), 2)=0;
% rayas(:, 1:size(rayas,2)*(1/3), 3)=0;
% 
% rayas(:, round(size(rayas,2)*(1/3))+1:round(size(rayas,2)*(2/3)), 1)=0;
% rayas(:, size(rayas,2)*(1/3)+1:size(rayas,2)*(2/3), 2);
% rayas(:, size(rayas,2)*(1/3)+1:size(rayas,2)*(2/3), 3)=0;
% 
% rayas(:, size(rayas,2)*(2/3):end, 1)=0;
% rayas(:, size(rayas,2)*(2/3):end, 2)=0;
% rayas(:, size(rayas,2)*(2/3):end, 3);

letra = chems;
% roja
letra(:,1:217,1);
letra(:,1:217,2)=0;
letra(:,1:217,3)=0;

letra(1:229,218:round(size(letra,2)*1/2),1);
letra(1:229,218:round(size(letra,2)*1/2),2)=0;
letra(1:229,218:round(size(letra,2)*1/2),3)=0;

letra(752:end,218:round(size(letra,2)*1/2),1);
letra(752:end,218:round(size(letra,2)*1/2),2)=0;
letra(752:end,218:round(size(letra,2)*1/2),3)=0;

letra(306:453,294:round(size(letra,2)*1/2),1);
letra(306:453,294:round(size(letra,2)*1/2),2)=0;
letra(306:453,294:round(size(letra,2)*1/2),3)=0;

letra(306:453,294:round(size(letra,2)*1/2),1);
letra(306:453,294:round(size(letra,2)*1/2),2)=0;
letra(306:453,294:round(size(letra,2)*1/2),3)=0;

letra(530:675,294:round(size(letra,2)*1/2),1);
letra(530:675,294:round(size(letra,2)*1/2),2)=0;
letra(530:675,294:round(size(letra,2)*1/2),3)=0;

%Verde
letra(230:305,218:518,1)=0;
letra(230:305,218:518,2);
letra(230:305,218:518,3)=0;

letra(306:751,218:293,1)=0;
letra(306:751,218:293,2);
letra(306:751,218:293,3)=0;

letra(676:751,294:518,1)=0;
letra(676:751,294:518,2);
letra(676:751,294:518,3)=0;

letra(454:529,294:443,1)=0;
letra(454:529,294:443,2);
letra(454:529,294:443,3)=0;

%Azul
letra(:,519:end,1)=0;
letra(:,519:end,2)=0;
letra(:,519:end,3);

letra(1:229,round(size(letra,2)*1/2)+1:end,1)=0;
letra(1:229,round(size(letra,2)*1/2)+1:end,2)=0;
letra(1:229,round(size(letra,2)*1/2)+1:end,3);

letra(752:end,round(size(letra,2)*1/2)+1:end,1)=0;
letra(752:end,round(size(letra,2)*1/2)+1:end,2)=0;
letra(752:end,round(size(letra,2)*1/2)+1:end,3);

letra(306:453,369:518,1)=0;
letra(306:453,369:518,2)=0;
letra(306:453,369:518,3);

letra(530:675,369:518,1)=0;
letra(530:675,369:518,2)=0;
letra(530:675,369:518,3);

letra(454:529,444:518,1)=0;
letra(454:529,444:518,2)=0;
letra(454:529,444:518,3);

figure(1)
imshow(letra);