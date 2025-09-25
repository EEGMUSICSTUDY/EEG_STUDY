% Clear workspace, close figures, and clear the command window
clear all;
close all;
clc;

% Define base directories (update with your own paths)
dataDir   = 'path/to/baseline/data/';      % Folder containing .set files
reportDir = 'path/to/baseline/report/';    % Folder for CSV output
mkdir(reportDir);

% Frequency markers and overall range (for plotting or analysis)
freqMap         = [3 11 22 34];
freqRange       = [2 40];
channelsToRemove = {'Cz','Status','trigger'};  % Channels to exclude from analysis

% Define EEG rhythms and their frequency bands
rhythms   = {'Delta','Theta','Alpha','Beta'};
freqStart = [0.5,   4,    8,    13];    % Lower bound of each band (Hz)
freqEnd   = [3.99, 7.99, 12.99, 30];    % Upper bound of each band (Hz)

% Specify epoch range for trimming
epochStart = 1;   % First epoch to keep
epochEnd   = 30;  % Last epoch to keep (-1 means keep all epochs)

%% Define brain regions and their corresponding electrodes
regions = {'Frontal','Central','TemporalRight','TemporalLeft','Parietal',
