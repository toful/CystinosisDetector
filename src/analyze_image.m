function [ crystals_sections, grey_sections] = analyze_image( I, prin )

[ cornea, diff ] = get_cornea( I );

cornea = flatten_corena( cornea );
%figure, imshow( cornea );

sections = get_segments( cornea, diff )

crystals_sections = cell( 6, 1);
grey_sections = cell( 6, 1);
crystals = imbinarize( cornea, 0.625 );


% getting the crystals in the cornea
[ counts, binLocations ] = imhist( crystals );
%counting the grey level in the crystals
grey = bsxfun( @times, cornea, uint8(crystals) );
[ counts2, binLocations2 ] = imhist( grey );
grey_lvl = 0;
for j = 1:size( counts2 )
    grey_lvl = grey_lvl + counts2(j)*binLocations2(j);
end
if prin == 1
    figure,
    subplot(3,3,[1,2,3]);
    imshow(cornea);
    tit = sprintf("Crystals: %i\nGrey levels: %i", counts(2), grey_lvl );
    title( tit );
end

for i=1:6
    %counting the crystals
    bin = imbinarize( sections{i}, 0.625 );
    [ counts, binLocations ] = imhist( bin );
    crystals_sections{i} = counts(2);
    %counting the grey level in the crystals
    grey = bsxfun( @times, sections{i}, uint8(bin) );
    [ counts, binLocations ] = imhist( grey );
    tmp = 0;
    for j = 1:size( counts )
        tmp = tmp + counts(j)*binLocations(j);
    end
    grey_sections{i} = tmp;
    if prin == 1
        subplot(3,3,3+i);
        imshow( sections{i} );
        tit = sprintf("Crystals: %i\nGrey lvls: %i", crystals_sections{i}, grey_sections{i} );
        title( tit );
    end
end
end
