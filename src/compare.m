%Function used to extract the cornea and compare the two imatges of
%different patiens or state of healing of the same patient.
function [ crystals_sections, grey_sections] = compare( pat1, pat2, prin )

cornea = cell(1, 2);
diff = cell(1, 2);
sections = cell(1, 2);
crystals = cell(1, 2); 

[ cornea{1}, diff{1} ] = get_cornea( pat1 );
[ cornea{2}, diff{2} ] = get_cornea( pat2 );

for i=1: numel(cornea)
    cornea{i} = flatten_cornea(cornea{i});
    sections{i} = get_segments(cornea{i}, diff{i});
    crystals{i} = imbinarize( cornea{i}, 0.625 ); 
end

% Make the comparasion in the same sections of the cornea
% by making each section have the same size
for i=1:6
    % Make the size of rows the same
    if size(sections{1}{i}, 1) > size(sections {2}{i}, 1)
        sections{1}{i} = imcrop(sections{1}{i}, [0, 0, size(sections{1}{i}, 2), size(sections{2}{i}, 1)]);
    else
        sections{2}{i} = imcrop(sections{2}{i}, [0, 0, size(sections{2}{i}, 2), size(sections{1}{i}, 1)]);
    end
    % Make the size of columns the same
    if size(sections{1}{i}, 2) > size(sections {2}{i}, 2)
        sections{1}{i} = imcrop(sections{1}{i}, [0, 0, size(sections{2}{i}, 2), size(sections{1}{i}, 1)]);
    else
        sections{2}{i} = imcrop(sections{2}{i}, [0, 0, size(sections{1}{i}, 2), size(sections{2}{i}, 1)]);
    end
end


crystals_sections = cell( 6, 3);
grey_sections = cell( 6, 3);

for k=1:numel(sections)
    
    % getting the crystals in the cornea
    [ counts, binLocations ] = imhist( crystals{k} );
    %counting the grey level in the crystals
    grey = bsxfun( @times, cornea{k}, uint8(crystals{k}) );
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
        bin = imbinarize( sections{k}{i}, 0.625 );
        [ counts, binLocations ] = imhist( bin );
        crystals_sections{i}{k} = counts(2);
        %counting the grey level in the crystals
        grey = bsxfun( @times, sections{k}{i}, uint8(bin) );
        [ counts, binLocations ] = imhist( grey );
        tmp = 0;
        for j = 1:size( counts )
            tmp = tmp + counts(j)*binLocations(j);
        end
        grey_sections{i}{k} = tmp;
        if prin == 1
            subplot(3,3,3+i);
            imshow( sections{k}{i} );
            tit = sprintf("Crystals: %i\nGrey lvls: %i", crystals_sections{i}{k}, grey_sections{i}{k} );
            title( tit );
        end
    end
end
% Get the difference between the two patiens
for i=1:size(crystals_sections, 1)
   crystals_sections{i}{3} = crystals_sections{i}{2}/crystals_sections{i}{1};
   if isnan(crystals_sections{i}{3}) || isinf(crystals_sections{i}{3})
       crystals_sections{i}{3} = 0;
   end
       
   grey_sections{i}{3} = grey_sections{i}{2}/grey_sections{i}{1};
   if isnan(grey_sections{i}{3}) || isinf(grey_sections{i}{3})
       grey_sections{i}{3} = 0;
   end
end
end