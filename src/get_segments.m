function sections = get_segments( cornea, diff )

nrows = size(cornea, 1);
ncols = size(cornea, 2);
c_stp = floor(ncols*(1/3));
mid = floor(c_stp/2);

r_stp = floor(nrows*(2/3));


sections = cell( 6, 1);
sections{1} = imcrop( cornea, [0, 0, diff-mid, r_stp] );
sections{2} = imcrop( cornea,[(diff-mid)+1, 0, c_stp, r_stp] );
sections{3} = imcrop( cornea, [(diff+mid)+1, 0, ncols-(diff+mid), r_stp] );
sections{4} = imcrop( cornea, [0, r_stp, diff-mid, nrows-r_stp] );
sections{5} = imcrop( cornea,[(diff-mid)+1, r_stp, c_stp, nrows-r_stp] );
sections{6} = imcrop( cornea, [(diff+mid)+1, r_stp, ncols-(diff+mid), nrows-r_stp] );


end