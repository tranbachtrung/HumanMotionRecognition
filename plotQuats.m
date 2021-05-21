% used to plot quaternions for all Semgatrices in the current directory

% for all files in the Segmatrices directory
files = dir('*.mat');

for k = 1:length(files) % for each file
    
    % load file
    load(files(k).name)
    
     % back out to a figure storage directory
    cd ..
    cd 'Quaternion Figures'
    
    exercise = fieldnames(Segmatrix);
    segments = fieldnames(Segmatrix.(exercise{1})); % all segments
    parts = fieldnames(Segmatrix.(exercise{1}).(segments{1})); % all parts

    for i = 1:length(parts) % for each part
        for j = 1:length(segments) % for each segment
            
            % plot the quaternion figure for this file and part for all segments
            quatVisMulti(Segmatrix.(exercise{1}).(segments{j}).(parts{i}))
        
        end
        
        % name and save the figure
        figtext = strcat(subject_id,'_0',num2str(sample_number),'_',parts{i},'.pdf');
        exportgraphics(gcf,figtext,'ContentType','vector')
        close
    end
    
    % return to Segmatrices directory
    cd ..
    cd 'Segmatrices'
    
end
