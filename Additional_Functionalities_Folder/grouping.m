 function grouping(coordinate_matrix)
    
    %Calculate the distances between all objects 
    coor = pdist(coordinate_matrix);
    disp('Data input');
    disp(coordinate_matrix);
    
    %Link the data together into meaningful clusters
    link = linkage(coor);
    %Map the result into a hierarchical dendrogram
    dendrogram(link);
    
    %Check for errors 
    dissim_check = cophenet(link, coor);
    I = inconsistent(link); 
    
    %display results
    disp('Data that are within threshhold');
    disp(coor);
    disp('Dissimilarity Coefficient');
    disp(dissim_check);
    disp('Inconsistant Matrix');
    disp(I);
     
    
     
end