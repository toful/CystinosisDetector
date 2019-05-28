% This script is the main scipt, it allows you to choose between comparing
% two different patients or to extract all details form one patient.

in = 0;
while in == 0
    fprintf("Choose which functionalities you want to use: \n");
    fprintf("1. Compare the evolution of Cystinosis.\n");
    fprintf("2. Get the information of Cystinosis of one patient. \n");
    
    in= input(">");
    isInteger = ~isempty(in) ...
            && isnumeric(in) ...
            && isreal(in) ...
            && isfinite(in) ...
            && (in == fix(in));
        
     if isInteger == 1
        if in >= 3 || in < 1
            fprintf("Index out of bound\n");
            in = 0;
        end
     else
         fprintf("The input is not a number.\n You must input that number that corresponds to the user in the list\n");
     end
end
% To start the comparison
if in == 1
    ComparePatients();
end

% To get the information
if in == 2
    CystinosisDetector();
end