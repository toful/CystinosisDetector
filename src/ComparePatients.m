% Read two folders with the same number of sections and compare
% the different sections to find if there is more or less crystals

%Loading all the data
cd( '../data' )
patients = dir;
aux = cell( 1, numel( patients )-2 );
for i=3:numel( patients)
    aux{i-2} = patients(i).name;
end
patients = aux;

id = 1;
users = cell(1, 2);

% User interaccion to choose the patients to compare
while id < 3
    fprintf("Choose patient %i to compare\n", id);
    for i=1:numel(patients)
        fprintf("%i. %s\n",i, patients{i});
    end
    in = input("");
    isInteger = ~isempty(in) ...
            && isnumeric(in) ...
            && isreal(in) ...
            && isfinite(in) ...
            && (in == fix(in));
        
     if isInteger == 1
        if in > numel(patients) || in < 1
            fprintf("Index out of bound\n");
        else            
            users{id} = patients{in};
            id = id +1;
        end
     else
         fprintf("The input is not a number.\n You must input that number that corresponds to the user in the list\n");
     end
     isInteger = 0;
     
end

%Reading all the images from the choosen folders

All_I = cell(1, numel(users));

for i=1:numel(users)
    D = users{i}; % Directory where the files are saved
    S = dir(fullfile(D, '*.BMP')); % Pattern to match filnames.
    All_I{i} = cell(1, numel(S)); % Create the space to store the imatges
    % Read all the imatges
    for k=1:numel(S)
        F = fullfile(D,S(k).name);
        All_I{i}{k}= imread(F);
    end
end

% Return to the execution
cd('../src')
fprintf("Data Loaded\n");

elems = min( size( All_I{1},2 ) , size( All_I{2},2 ) );

% creating structures to store the results
crystals = cell( 1, 6 );
greys = cell( 1, 6 );
for i = 1:6
    crystals{i} = cell( 1,  elems );
    greys{i} = cell( 1, elems );
end

% Start the comparison
for i=1:elems
    [crystals_sections, grey_sections] = compare(All_I{1}{i}, All_I{2}{i}, 0);
    for j = 1:6
       crystals{j}{i} = crystals_sections{j}{3};
       greys{j}{i} = grey_sections{j}{3}; 
    end
    fprintf("\n------------------------\n");
    fprintf("Gray %i: \n",i);
    for s=1:6
        fprintf("%i. %.2f ", s, grey_sections{s}{3});
    end
    fprintf("\n");
    fprintf("Crystals %i: \n", i);
    for s=1:6
        fprintf("%i. %.2f ", s, crystals_sections{s}{3});
    end
end

% Printing the plots
print_results( crystals, sprintf('Crystal Pixels Ratio Increment'), 'Ratio Increment' );
print_results( greys, sprintf('Grey level on Crystal Pixels Ratio Increment'), 'Ratio Increment' );

MIN = cell(1,6);
MAX = cell(1,6);
crystals_norm = crystals;
for j=1:6
    MIN{j} = min( [crystals{j}{:}] );
    MAX{j} = max( [crystals{j}{:}] );
    for i=1:elems
        crystals_norm{j}{i} = ( crystals{j}{i} - MIN{j} ) / ( MAX{j} -MIN{j} ); 
    end
end
MIN = [ MIN{:} ];
MAX = [ MAX{:} ];
crystals_norm2 = crystals;
for j=1:6
    for i=1:elems
        crystals_norm2{j}{i} = ( crystals{j}{i} - MIN ) / ( MAX -MIN ); 
    end
end
print_results( crystals_norm, sprintf('Crystal Pixels Ratio Increment'), 'Ratio Increment Normalized for each Segment' );
print_results( crystals_norm2, sprintf('Crystal Pixels Ratio Increment'), 'Ratio Increment Normalized' );

%%%%%%%%%%%%%%%%%%%%%%2nd plots
MIN = cell(1,6);
MAX = cell(1,6);
greys_norm = greys;
for j=1:6
    MIN{j} = min( [greys{j}{:}] );
    MAX{j} = max( [greys{j}{:}] );
    for i=1:elems
        greys_norm{j}{i} = ( greys{j}{i} - MIN{j} ) / ( MAX{j} -MIN{j} ); 
    end
end
MIN = [ MIN{:} ];
MAX = [ MAX{:} ];
greys_norm2 = greys;
for j=1:6
    for i=1:elems
        greys_norm2{j}{i} = ( greys{j}{i} - MIN ) / ( MAX -MIN ); 
    end
end
print_results( greys_norm, sprintf('Grey level on Pixels Ratio Increment'), 'Ratio Increment Normalized for each Segment' );
print_results( greys_norm2, sprintf('Grey level on Pixels Ratio Increment'), 'Ratio Increment Normalized' );