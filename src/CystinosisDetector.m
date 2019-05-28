%Cystinosis Avaluator
function [] = CystinosisDetector()
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
        
    end
end
cd( '../src' )
fprintf("Data Loaded\n");

patient=1;
elems = size( All_I{ patient } );
% creating structures to store the results
crystals = cell( 1, numel( 6 ) );
greys = cell( 1, numel( 6 ) );
for i = 1:6
    crystals{i} = cell( 1, numel( elems(2) ) );
    greys{i} = cell( 1, numel( elems(2) ) );
end

%[ crystals_sections, grey_sections] = analyze_image( All_I{2}{4}, 0 );

fprintf("Processing all images of patient: %s\n", patients{ patient } );
for i = 1:elems(2)
    % Analyze all the images of a patient
    [ crystals_sections, grey_sections] = analyze_image( All_I{patient}{i}, 0 );
    for j = 1:6
       crystals{j}{i} = crystals_sections{j};
       greys{j}{i} = grey_sections{j}; 
    end
end

% printing the results
fprintf("Plotting the results of patient: %s\n", patients{ patient } );
print_results( crystals, sprintf('Crystals of patient %s', patients{ patient } ), 'Crystal Pixels' );
print_results( greys, sprintf('Grey level on Crystals of patient %s', patients{ patient } ), 'Grey level on Crystal Pixels' );
end
