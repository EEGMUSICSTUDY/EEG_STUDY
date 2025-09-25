clear all;

% Subject name (can be left empty for batch processing)
Nome = '';

% Define input and output folders
pastaDados  = 'C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\EDF_Rose\MERGE\SET\netlab\';
pastaReport = 'C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\EDF_Rose\MERGE\SET\netlab\Relatorio\';
mkdir(pastaReport);  % Create report folder if it does not exist

% Frequency markers and overall range
FreqMap   = [3 11 22 34];
FreqRange = [2 40];

% Channels to remove from analysis
delChanels = {'Cz','Status','trigger'};

% Define EEG rhythms and their frequency bands
ritmos = {'Delta', 'Teta', 'Alfa','Beta'};
freqIn = [0.5, 4, 8, 13];      % Lower frequency of each rhythm (Hz)
freqFi = [3.99, 7.99, 12.99, 30]; % Upper frequency of each rhythm (Hz)

% Epoch range for trimming
EpIni = 1;   % First epoch to keep (1 = from the beginning)
EpFin = 30;  % Last epoch to keep (-1 = keep all epochs)

%% Define brain regions and corresponding electrodes
reg = {'FrontalD','FrontalE','CentralD','CentralE','TempDir','TempEsq','ParietalD','ParietalE','OcipitalD','OcipitalE'};

regE = {  
    {'FP2','AF4','F10','F8','F6','F4'},       % Frontal right
    {'FP1','AF3','F9','F7','F5','F3'},       % Frontal left
    {'FC6','FC4','FC2','F2','C6','C4','C2'}, % Central right
    {'FC5','FC3','FC1','F1','C5','C3','C1'}, % Central left
    {'TP8','FT8','T10','T8'},                 % Temporal right
    {'TP7','FT7','T9','T7'},                  % Temporal left
    {'CP6','CP4','CP2','P10','P8','P6','P4','P2'}, % Parietal right
    {'CP5','CP3','CP1','P9','P7','P5','P3','P1'},  % Parietal left
    {'PO4','O2'},                             % Occipital right
    {'PO3','O1'}                              % Occipital left
};

%% Read .set files from folder
arq = dir([pastaDados, Nome, '*.set']); % List all .set files in folder
tamanho = length(arq);                   % Number of files

%% Load first file to get channel names
EEG = pop_loadset([pastaDados arq(1).name]);
ncanais = EEG.nbchan;

% Standardize channel labels to uppercase
for i = 1:ncanais
    EEG.chanlocs(i).labels = upper(EEG.chanlocs(i).labels);
end

% Remove unwanted channels
EEG = pop_select(EEG,'nochannel',upper(delChanels));
ncanais = EEG.nbchan;

% Store remaining channel names
for i = 1:ncanais
    chans{i} = EEG.chanlocs(i).labels; 
end
clear EEG

%% Preallocate result storage
out = cell(length(ritmos), length(arq), 3); % Spectral power per channel
des = cell(length(ritmos), length(arq), 1); % Standard deviation

%% MAIN LOOP: Process each file
for i = 1:tamanho
    disp(['PROCESSING FILE -------------------- ' arq(i).name]);
    
    % Load dataset
    EEG = pop_loadset([pastaDados arq(i).name]);
    
    % Remove unwanted channels
    EEG = pop_select(EEG,'nochannel',delChanels);
    EEG = eeg_checkset(EEG);
    
    % Adjust epoch end if EpFin == -1 (all epochs)
    if EpFin == 1
        EpFin = EEG.trials;
    end
    
    % Define epochs to reject outside desired range
    range = [];
    if EpIni > 1
        range = [1:EpIni-1];
    end
    if EpFin < EEG.trials
        range = [range EpFin+1:EEG.trials];
    end
    EEG = pop_rejepoch(EEG, range, 0);
    
    %% Compute mean spectral power for each rhythm
    np     = EEG.pnts;      % Number of points per epoch
    nepcs  = EEG.trials;    % Number of epochs
    srate  = EEG.srate;     % Sampling rate
    eegData = EEG.data;     % EEG data matrix
    canais = 1:EEG.nbchan;  % Channel indices
    
    for r = 1:length(ritmos)
        disp(['Calculating power for ' ritmos{r}]);
        spec = meanfreq2(freqIn(r), freqFi(r), canais, np, nepcs, srate, eegData);
        out{r,i,2} = nepcs;  % Store number of epochs
        out{r,i,3} = spec;   % Store spectral power
        des{r,i,1} = std(spec); % Store standard deviation
    end
end

%% Generate individual-level CSV
for rt = 1:length(ritmos)
    fp = fopen([pastaReport ritmos{rt} '_IND.csv'], 'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n', freqIn(rt), freqFi(rt));
    fprintf(fp,'Name;#Epochs;Power\n');
    
    for j = 1:length(arq)
        fprintf(fp,'%s;%d', arq(j).name, out{rt,j,2});
        soma = mean(out{rt,j,3}); % Mean across channels
        fprintf(fp, ';%f\n', soma);
    end
    fclose(fp);

    %% Electrode-level CSV
    fp = fopen([pastaReport ritmos{rt} '_ELE.csv'], 'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n', freqIn(rt), freqFi(rt));
    fprintf(fp,'Name;#Epochs');
    for i = 1:ncanais
        fprintf(fp, ';%s', chans{i});
    end
    fprintf(fp,'\n');
    
    for j = 1:length(arq)
        fprintf(fp,'%s;%d', arq(j).name, out{rt,j,2});
        for i = 1:ncanais
            fprintf(fp, ';%f', out{rt,j,3}(i));
        end
        fprintf(fp,'\n');
    end
    fclose(fp);
    
    %% Region-level CSV
    fp = fopen([pastaReport ritmos{rt} '_REG.csv'], 'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n', freqIn(rt), freqFi(rt));
    fprintf(fp,'Name;#Epochs');
    for r = 1:length(reg)
        fprintf(fp, ';%s', reg{r});
    end
    fprintf(fp,'\n');
    
    for j = 1:length(arq)
        fprintf(fp,'%s;%d', arq(j).name, out{rt,j,2});
        for r = 1:length(reg)
            soma = 0;
            N = 0;
            for i = 1:ncanais
                id = find(strcmpi(regE{r}, chans{i}));
                if ~isempty(id)
                    soma = soma + out{rt,j,3}(i);
                    N = N + 1;
                end
            end
            fprintf(fp, ';%f', soma/N); % Average power per region
        end
        fprintf(fp,'\n');
    end
    fclose(fp);
end

fclose all;
disp('PROCESSING COMPLETE');
