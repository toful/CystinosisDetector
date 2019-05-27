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

% Start the comparison

for i=1:size(All_I{1},2)
    %figure,
    %imshowpair(All_I{1}{i}, All_I{2}{i}, 'montag');
    
    [crystals, gray] = compare(All_I{1}{i}, All_I{2}{i}, 0);
    fprintf("\n------------------------\n");
    fprintf("Gray %i: \n",i);
    for s=1:6
        fprintf("%i. %.2f ", s,gray{s}{3});
        %plot([gray{s}{3}]);
        %hold on;
    end
    
    %ylabel("Percentage");
    %xlabel("Sections");
    
    %hold off;
    fprintf("\n");
    fprintf("Crystals %i: \n", i);
    aux=cell(1,6);
    for s=1:6
        fprintf("%i. %.2f ", s, crystals{s}{3});
        aux{s} = crystals{s}{3};
    end
    x = linspace(0,1,6);
    plot(x,cell2mat(aux));
    hold on;
    ylabel("Percentage");
    xlabel("Sections");
    hold off;
end