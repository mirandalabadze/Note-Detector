function [maxNote, maxNoteFreq] = noteDetect(xx, fs)
% NOTEDETECT Detects the musical note from an input audio signal.
% Input:  xx - input audio signal
%         fs - sampling frequency of the input signal
% Output: maxNote - index of detected note (0 to 12)
%         maxNoteFreq - frequency of the detected note

% --- Step 1: Extract base frequency f0 from Note02.wav ---
[x, Fs] = audioread('Note02.wav');          % Read reference note audio
[pxx, f] = pspectrum(x, Fs);                % Compute power spectrum
[~, idx] = max(pxx);                        % Find peak frequency index
f0 = f(idx);                                % f0 = frequency with highest power

% --- Step 2: Generate 13 note frequencies (equal-tempered scale) ---
freqs = zeros(1, 13);                       % Initialize frequency array
freqs(1) = f0;                              % Set base frequency
for i = 2:13
    freqs(i) = f0*2^((i-1)/12);             % Compute note frequencies using 12-TET formula
end

% --- Step 3: Apply a narrow bandpass filter for each note and compute energy ---
energies = zeros(1, 13);                    % Initialize energy array
r = 0.95;                                   % Pole radius for filter sharpness

for i = 1:13
    w0 = 2*pi*freqs(i)/fs;                  % Convert frequency to angular frequency
    a = [1, -2*r*cos(w0), r^2];             % Denominator (poles) of second-order IIR filter
    b = 1-r;                                % Simple numerator (no zeros) to scale gain
    y = filter(b, a, xx);                   % Filter the input signal
    energies(i) = sum(abs(y));              % Measure energy (sum of absolute value)
end

% --- Step 4: Identify the note with the highest energy ---
[~, maxIdx] = max(energies);               % Index of strongest energy (note detected)
maxNote = maxIdx-1;                        % Note index (0-based)
maxNoteFreq = freqs(maxIdx);              % Frequency of detected note

end
