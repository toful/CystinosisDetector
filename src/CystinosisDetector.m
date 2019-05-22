%Cystinosis Avaluator

%Loading all the data
cd( '../data' )
patients = dir;
aux = cell( 1, numel( patients )-2 );
for i=3:numel( patients)
    aux{i-2} = patients(i).name;
end
patients = aux;

All_I = cell( 1, numel( patients ) );
for i = 1:numel( patients )
    D = patients{i}; %directory where the files are saved
    S = dir( fullfile(D,'*.BMP') ); % pattern to match filenames.
    All_I{i} = cell( 1, numel(S) );
    for k = 1:numel(S)
        F = fullfile( D, S(k).name );
        All_I{i}{k} = imread( F );
        %imshow( I{i}{k} );
    end
end
cd( '../src' )
fprintf("Data Loaded\n");

patient=6;
fprintf("Processing all images of patient: %s\n", patients{ patient } );
elems = size( All_I{ patient } );
for i = 1:elems(2)
    [ crystals_sections, grey_sections] = analyze_image( All_I{patient}{i}, 0 );
end

%[ crystals_sections, grey_sections] = analyze_image( All_I{1}{10}, 1 );


