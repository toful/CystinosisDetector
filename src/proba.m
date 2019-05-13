
I = imread("C:\\Users\\Pc\\Dropbox\\Classe_Info4\\VC\\CystinosisDetector\\data\\OD1con_Cistinosis\\croped.bmp");
nrows = size(I,1);
ncols = size(I,2);
fill = 0.3;
[xi,yi] = meshgrid(1:ncols,1:nrows);
xt = xi - ncols/2;
yt = yi - nrows/2;
[theta,r] = cart2pol(xt,yt);

rmax = max(r(:));


b = 0.456; % Try varying the amplitude of the cubic term.
s = r - r.^3*(b/rmax.^2);

[ut,vt] = pol2cart(theta,s);
ui = ut + ncols/2;
vi = vt + nrows/2;
ifcn = @(c) [ui(:) vi(:)];
tform = geometricTransform2d(ifcn);
I_pin = imwarp(I,tform,'FillValues',fill);
imshow(I_pin)