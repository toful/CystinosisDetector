function cornea = flatten_corena( cornea )

%flatting the cornea
threshold = 0.15;
cornea_bin = imbinarize(cornea, threshold);
[rows, cols] = size( cornea );
for j = 1:cols
    i = 1;
    new_i = 1;
    while cornea_bin(i,j) < 1
        i=i+1;
    end
    for i = i:rows
        cornea(new_i,j) = cornea(i,j);
        cornea(i,j) = 0;
        new_i = new_i+1;
    end
end
I_pin_b = imbinarize( cornea, threshold );
s = regionprops( I_pin_b, 'BoundingBox');
bb = floor( s(1).BoundingBox );
cornea = cornea( bb(2)+1:bb(2)+bb(4), bb(1)+1:bb(1)+bb(3) );

end