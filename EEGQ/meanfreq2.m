function spec = meanfreq(fmin, fmax, chanArray, frames, epochs, srate, dados)
% meanfreq computes the mean spectral power within a frequency band
%
% Inputs:
%   fmin      - lower frequency bound (Hz)
%   fmax      - upper frequency bound (Hz)
%   chanArray - vector of channel indices to analyze
%   frames    - number of time samples per epoch
%   epochs    - total number of epochs in the data
%   srate     - sampling rate of the data (Hz)
%   dados     - matrix of raw EEG data (channels × total samples)
%
% Output:
%   spec      - vector of mean log-power values for each channel

    % Number of channels to process
    nchan = length(chanArray);
    
    % Preallocate a 3D array: channels × frames × epochs
    data = zeros(nchan, frames, epochs);

    % Extract and organize the requested channels into 'data'
    for k = 1:nchan
        data(k, :) = dados(chanArray(k), :);
    end

    % Determine FFT length as the next lower power of two
    fftlength = 2^floor(log(frames)/log(2));
    
    % Prepare variables for power spectra storage
    [rows, ~] = size(data);
    halfFreqBins = fftlength/2;
    spectra = zeros(rows, epochs * halfFreqBins);
    
    % Conversion factor from power to decibels
    dB = 10 / log(10);

    % Define the frequency band of interest
    Hzlimits = [fmin, fmax];

    % Loop over epochs and channels to compute Welch power spectral density
    for e = 1:epochs
        for r = 1:rows
            segment = data(r, (e-1)*frames+1 : e*frames);
            [Pxx, freqs2] = pwelch(segment, [], [], fftlength, srate);
            spectra(r, (e-1)*halfFreqBins+1 : e*halfFreqBins) = Pxx(1:halfFreqBins)';
        end
    end

    % Extract frequency vector and find indices within the desired band
    freqs = freqs2(1:halfFreqBins);
    bandIdx = find(freqs >= Hzlimits(1) & freqs <= Hzlimits(2));
    nfs = length(bandIdx);

    % Compute log-scaled spectra (dB) for the selected band
    showspec = zeros(rows, nfs * epochs);
    for e = 1:epochs
        idxRange = (e-1)*nfs + (1:nfs);
        specSegment = spectra(:, (e-1)*halfFreqBins + bandIdx);
        showspec(:, idxRange) = dB * log(specSegment);
    end

    % Average across time blocks of size 'nfs'
    showspec = blockave(showspec, nfs);

    % Compute the mean log-power across epochs for each channel
    if size(showspec, 2) > 1
        spec = mean(showspec, 2)';
    else
        spec = showspec;
    end

    % (Optional) Plot the resulting spectrum
    % plot(spec');
end
