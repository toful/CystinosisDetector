I = imread("../data/OD1con_Cistinosis/CISTINOSIS_20160718_120806_PENTACAM_R_25.BMP");
I = imcrop( I,[100, 130, 700, 410] );
I = rgb2gray(I);

% Get the center of the eye
croped = imcrop( I,[0, size(I,1)-10, size(I,2), 10] );
bin = imbinarize( croped, 0.35 );
[row, column] = find(bin, 1, 'last');

% Equilize the image
J = histeq(I);

% Create erode objects
se = strel('disk',5);
% Erode image
S = imerode(J, se);
% binarize the image
bin = imbinarize(S, "adaptive", "sensitivity", 0.000001);


%less = bwareaopen(bin,700);

% Mask the image with the original one 
tmp = bsxfun(@times, I, uint8(bin));
% binarize the imge to extract features
bin_t = imbinarize(tmp, 0.1);
%Segment the image extracting a boxe for each object
s = regionprops(bin_t, "BoundingBox");

% Get the box with the maximum width
maxm = s(1);
for i=1 : size(s)-1
    en = s(i+1);
    if en.BoundingBox(3)> maxm.BoundingBox(3)
        maxm = en;
    end
end

bb = floor(maxm.BoundingBox);

% Obtain relative position in the cropped cornea
diff = column - bb(1);

% Crop the cornea
cornea = I( bb(2)+1:bb(2)+bb(4), bb(1)+1:bb(1)+bb(3) );

figure,
imshowpair( I ,cornea, "montage" );