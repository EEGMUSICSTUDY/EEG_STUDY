clear all;
Nome='';
pastaDados= 'C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\EDF_Rose\MERGE\SET\netlab\';
pastaReport= 'C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\EDF_Rose\MERGE\SET\netlab\Relatorio\';
mkdir(pastaReport);
FreqMap = [3 11 22 34];
FreqRange = [2 40];
delChanels ={'Cz','Status','trigger'};


ritmos = {'Delta', 'Teta', 'Alfa','Beta'};
freqIn = [0.5,   4,     8,   13];           % frequências iniciais de cada ritmo
freqFi = [3.99, 7.99, 12.99, 30];           % frequências finais de cada ritmo

EpIni=1;  % Epoca Inicial para recorte. Se eu colocar 1 aqui, significa q quero do começo
EpFin=30; % Epoca Final para recorte (-1 para pegar até o final)se é -1 pega do inicio até a ultima época, se eu quero do inicio (1) e final 30 epocas eu boto 1 e 30


%% Dados para Agrupamento por região
%% REGIÃO
reg={'FrontalD','FrontalE','CentralD','CentralE','TempDir','TempEsq','ParietalD','ParietalE','OcipitalD','OcipitalE'};
% ELETRODOS PARA CADA REGIÃO
regE={  {'FP2',' AF4',' F10',' F8','F6',' F4'};...
    {'FP1','AF3','F9','F7','F5','F3'};...
    {'FC6','FC4','FC2','F2','C6','C4','C2'};...
    {'FC5','FC3','FC1','F1','C5','C3','C1'};...
    {'TP8','FT8','T10','T8'};...
    {'TP7','FT7','T9','T7'};...
    {'CP6','CP4','CP2','P10','P8','P6','P4','P2'};...
    {'CP5','CP3','CP1','P9','P7','P5','P3','P1'};...
    {'PO4','O2'};...
    {'PO3','O1'}};


%% LÊ OS ARQUIVOS DAS PASTAS
arq=dir([pastaDados, Nome, '*.set']); %Pega os arquivos set na pastaDados
tamanho=length(arq); %diz qtos arquivos tem na pasta

%% CARREGA TABELA COM OS NOMES DOS ELETRODOS
EEG = pop_loadset( [pastaDados arq(1).name]);
ncanais=EEG.nbchan;
for i=1:ncanais
    EEG.chanlocs(i).labels = upper(EEG.chanlocs(i).labels);
end
EEG = pop_select( EEG,'nochannel',upper(delChanels));
ncanais=EEG.nbchan;
for i=1:ncanais
   chans{i}=EEG.chanlocs(i).labels; 
end
clear EEG

%% TABELAS COM AS SAIDAS
out=cell(length(ritmos), length(arq),3);  %tabela com os resultados por canal
des=cell(length(ritmos), length(arq),1);  %tabela com os desvios

%% MAIN 
for i=1:tamanho
    disp(['PROCESSANDO ARQUIVO --------------------' arq(i).name]);
    EEG = pop_loadset( [pastaDados arq(i).name]);
    EEG = pop_select( EEG,'nochannel',delChanels);
    EEG = eeg_checkset( EEG );
   %%EEG = pop_reref( EEG, []);      %% Referencia para média
    EEG = eeg_checkset( EEG );
    if EpFin==1
        EpFin=EEG.trials;
    end
    range=[];
    if EpIni>1
        range = [1:EpIni-1];
    end
    if EpFin<EEG.trials
       range=[range EpFin+1:EEG.trials];
    end
    EEG = pop_rejepoch( EEG, range ,0);
    
    %% CALCULA POWER PARA OS RITMOS
    np=EEG.pnts;
    nepcs=EEG.trials;
    srate=EEG.srate;
    eegData=EEG.data;
    canais=1:EEG.nbchan;
    for r=1:length(ritmos)
        disp(['Calculando para ' ritmos{r}]);
        spec = meanfreq2(freqIn(r),freqFi(r),canais,np,nepcs,srate,eegData);
        %out{r,j,1}=ritmos{r};
        out{r,i,2}=nepcs;
        out{r,i,3}=spec;
        des{r,i,1}=std(spec);
    end
    
%     figure;
%     pop_spectopo(EEG, 1, [0  EEG.pnts-1], 'EEG' , 'freq', FreqMap, 'freqrange',FreqRange,'electrodes','on');
%     nameImg=[pastaReport arq(i).name(1:end-3) 'png'];
%     saveas(gcf,nameImg);
%     close
end

%% Gera arquivo com saidas por individuos
for rt=1:length(ritmos)
    fp=fopen([pastaReport ritmos{rt} '_IND.csv'],'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n',freqIn(rt),freqFi(rt));
    fprintf(fp,'Name;#Ephocs;Power\n');
    for j=1:length(arq)
        fprintf(fp,'%s;%d',arq(j).name,out{rt,j,2});
        soma = 0;
        for i=1:ncanais
            soma = soma + out{rt,j,3}(i);
        end
        fprintf(fp, ';%f\n',soma/ncanais);
    end
    fclose(fp);

    %% Gera arquivo com saidas por eletrodos
    fp=fopen([pastaReport ritmos{rt} '_ELE.csv'],'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n',freqIn(rt),freqFi(rt));
    fprintf(fp,'Name;#Ephocs');
    for i=1:ncanais
        fprintf(fp, ';%s',chans{i});
    end
    fprintf(fp,'\n');
    for j=1:length(arq)
        fprintf(fp,'%s;%d',arq(j).name,out{rt,j,2});
        for i=1:ncanais
            fprintf(fp, ';%f',out{rt,j,3}(i));
        end
        fprintf(fp,'\n');
    end
    fclose(fp);
    
    %% Gera arquivo com saidas por região
    fp=fopen([pastaReport ritmos{rt} '_REG.csv'],'wt');
    fprintf(fp, 'Freq. Range[%d,%d]\n',freqIn(rt),freqFi(rt));
    fprintf(fp,'Name;#Ephocs');
    for r=1:length(reg)
        fprintf(fp,';%s',reg{r});
    end
    fprintf(fp,'\n');
    for j=1:length(arq)
        fprintf(fp,'%s;%d',arq(j).name,out{rt,j,2});
        for r=1:length(reg)
            soma=0;
            N=0;
            for i=1:ncanais
                id=find(strcmpi(regE{r},chans{i}));
                if ~isempty(id)
                    soma = soma + out{rt,j,3}(i);
                    N=N+1;
                end
            end
            fprintf(fp, ';%f',soma/N);
        end
        fprintf(fp,'\n');
    end
    fclose(fp);
end

fclose all;
disp('FIM');

