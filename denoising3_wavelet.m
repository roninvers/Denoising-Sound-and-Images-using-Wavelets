[signal, Fs] = audioread('/Users/ronin/Downloads/ek_pal.mp3');  % Load MP3 file
% sound(signal, Fs)
% Ensure that signal is a column vector or matrix
if size(signal, 2) > 1
    signal = signal(:,1);  % For stereo, use the left channel
end

% Adding noise manually (without Communications Toolbox)
snr_value = 10;
signal_power = mean(signal.^2);
noise_power = signal_power / (10^(snr_value/10));
noise = sqrt(noise_power) * randn(size(signal));
noisy_signal = signal + noise;

% Play noisy signal
 % sound(noisy_signal, Fs);

% Perform wavelet denoising
% Choose the wavelet type (e.g., 'db8', 'sym4', 'db1', 'coif5', etc.)
% Daubechies wavelet with 8 vanishing moments gives the best output, we
% discovered it after hearing output from 4 different wavelet types.
[denoised_signal_1, ~] = wdenoise(noisy_signal, 5, 'Wavelet', 'db1');

[denoised_signal_2, ~] = wdenoise(noisy_signal, 5, 'Wavelet', 'sym4');

[denoised_signal_3, ~] = wdenoise(noisy_signal, 5, 'Wavelet', 'coif5');

[denoised_signal_4, ~] = wdenoise(noisy_signal, 5, 'Wavelet', 'db8');

[denoised_signal_5, ~] = wdenoise(noisy_signal, 3, 'Wavelet', 'db8');

[denoised_signal_6, ~] = wdenoise(noisy_signal, 9, 'Wavelet', 'db8');
% Play the denoised signal
 sound(denoised_signal_6, Fs);