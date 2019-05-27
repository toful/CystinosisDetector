function cornea = flatten_cornea( cornea )

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
        cornea_limit = i + 20;
        i=i-1;
        while i < cornea_limit && i < rows
            aux = cornea(i,j);
            cornea(i,j) = 0;
            cornea(new_i,j) = aux;
            new_i = new_i+1;
            i = i+1;
        end
    end
end
%removing the rest
for j = 1:cols
    for i = 21:rows
        cornea(i,j) = 0;
    end
end

threshold = 0.05;
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