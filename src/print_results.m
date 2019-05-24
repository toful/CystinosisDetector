function print_results( data, title_str, label )

figure,
for j = 1:6
    plot( [ data{j}{:} ] );
    hold on; 
end
title( title_str );
ylabel( label );
xlabel( 'Capture number' );
hold off;
legend( 'section 1', 'section 2', 'section 3', 'section 4', 'section 5', 'section 6' );

end