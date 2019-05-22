function sections = get_segments_static( cornea )

nrows = size(cornea, 1);
ncols = size(cornea, 2);
c_stp = ncols/3;
height_limit = 15;

sections = cell( 6, 1);
sections{1} = imcrop( cornea, [0, 0, c_stp, height_limit] );
sections{2} = imcrop( cornea,[c_stp+1, 0, c_stp, height_limit] );
sections{3} = imcrop( cornea, [c_stp*2+1, 0, c_stp, height_limit] );
sections{4} = imcrop( cornea, [0, height_limit, c_stp, nrows] );
sections{5} = imcrop( cornea,[c_stp+1, height_limit, c_stp, nrows] );
sections{6} = imcrop( cornea, [c_stp*2+1, height_limit, c_stp, nrows] );

end