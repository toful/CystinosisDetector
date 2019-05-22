function cornea = flatten_corena( cornea )

%flatting the cornea
threshold = 0.15;
cornea_bin = imbinarize(cornea, threshold);
[rows, cols] = size( cornea );
for j = 1:cols
    i = 1;
    new_i = 1;
    if cornea_bin(i,j) < 1
        while cornea_bin(i,j) < 1 && i < rows
            i=i+1;
        end
        for i = i:rows
            cornea(new_i,j) = cornea(i,j);
            cornea(i,j) = 0;
            new_i = new_i+1;
        end
    end
end
I_pin_b = imbinarize( cornea, threshold );
s = regionprops( I_pin_b, 'BoundingBox');
maxm = s(1);
for i=1 : size(s)-1
    en = s(i+1);
    if en.BoundingBox(3)> maxm.BoundingBox(3)
        maxm = en;
    end
end
bb = floor(maxm.BoundingBox);
cornea = cornea( bb(2)+1:bb(2)+bb(4), bb(1)+1:bb(1)+bb(3) );

end