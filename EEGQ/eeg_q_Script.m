clear all;
nameFile='';
dataFolder= 'C:\Users\eegStudy\Matlab\Scripts\EDF_files\MERGE\SET\netlab\';   % path to your folder location
reportFolder= 'C:\Users\eegStudy\Matlab\Scripts\EDF_files\MERGE\SET\netlab\Report\';   % path to your folder location
mkdir(reportFolder);

FreqMap = [3 11 22 34];
FreqRange = [2 40];
delChannels ={'Cz','Status','trigger'};

% Brain rhythms
rhythms = {'Delta', 'Theta', 'Alpha','Beta'};
freqStart = [0.5,   4,     8,   13];           % initial frequencies of each rhythm
freqEnd = [3.99, 7.99, 12.99, 30];            % final frequencies of each rhythm

epochStart=1;  % Initial epoch for slicing (1 = start from the beginning)
epochEnd=30;   % Final epoch (-1 = until the last epoch)

%% Data for grouping by region
%% REGIONS
regions={'FrontalR','FrontalL','CentralR','CentralL','TempR','TempL','ParietalR','ParietalL','OccipitalR','OccipitalL'};

% ELECTRODES FOR EACH REGION
regionElectrodes={  {'FP2','AF4','F10','F8','F6','F4'};...
    {'FP1','
