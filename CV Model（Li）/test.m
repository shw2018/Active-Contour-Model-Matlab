%   Matlad code implementing Chan-Vese model in the paper 'Active Contours Without Edges'
%   This method works well for bimodal images, for example the image 'three.bmp'
%   created on 04/26/2004
%   author: Chunming Li
%   email: li_chunming@hotmail.com
%   Copyright (c) 2004-2006 by Chunming Li

clear;

%Img=imread('three.bmp');     % example that CV model works well
Img=imread('vessel.bmp');    % example that CV model does NOT work well
%Img=imread('twoCells.bmp');  % example that CV model does NOT work well
%Img=imread('noisyNonUniform.bmp');

U=Img(:,:,1);

% get the size
[nrow,ncol] =size(U);

ic=nrow/2;
jc=ncol/2;
r=30;
phi_0 = sdf2circle(nrow,ncol,ic,jc,r);


delta_t = 0.1;
lambda_1=1;
lambda_2=1;
nu=0;
h = 1;
epsilon=1;
mu = 0.01*255*255;

I=double(U);
% iteration should begin from here
phi=phi_0;
figure;
imagesc(uint8(I));colormap(gray)
hold on;
plotLevelSet(phi,0,'r');

numIter = 1;
for k=1:400,
    phi=evolution_cv(I, phi, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter);   % update level set function
    if mod(k,10)==0
        pause(.5);
        imagesc(uint8(I));colormap(gray)
        hold on;
        plotLevelSet(phi,0,'r');
    end    
end;
