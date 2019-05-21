I = imread("../data/OD1con_Cistinosis/CISTINOSIS_20160718_120806_PENTACAM_R_02.BMP");
I = imcrop( I,[0, 130, 870, 410] );
I = rgb2gray(I);
croped = imcrop( I,[0, 0, size(I,2), 10] );
bin = imbinarize( croped,0.35 );
mid = 0;

[row, column] = find(bin, 1, 'last');

fprintf("%i, %i\n", row, column);
I(:, column) = 255;
imshow(I);
croped = imcrop(I, [column-250, 0 , 250*2, size(I,1)]);

imshow(croped);