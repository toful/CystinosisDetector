function [ cornea, diff ] = get_cornea_static( I )

% pre porcessing
I = rgb2gray(I);
I = imcrop( I,[0, 130, 870, 410] );

%%%% croping the image
%getting the first 10 rows
croped = imcrop( I, [0, 0, size(I,2), 10] );
bin = imbinarize( croped,0.35 );
%finding the eye center
[row, column] = find( bin, 1, 'last');
%creating a ROI
I = imcrop(I, [column-250, 0 , 250*2, size(I,1)]);
%imshow( I );

%localitzem la cornia
se = strel( 'disk', 2 );
threshold = 0.1;
I_pin_b = imbinarize( I, threshold );
I_pin_b = imdilate( I_pin_b, se );
%filling the holes in the image (crystals)
I_pin_b = imfill( I_pin_b,'holes');
%removing samall objects from binary image
I_pin_b = bwareaopen( I_pin_b, 60 );
%figure,
%imshowpair( I, I_pin_b, 'montage' );   
% Apply regionprops to the binary mask
s = regionprops( I_pin_b, 'BoundingBox');
% Get the bounding box property
bb = floor( s(1).BoundingBox );
% Extract out the object from the segmented image
cornea = I( bb(2)+1:bb(2)+bb(4), bb(1)+1:bb(1)+bb(3) );

diff = column/2;
end