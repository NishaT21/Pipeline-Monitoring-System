## Acoustic Holography Flex-Array Leak Simulation
## GNU Octave / MATLAB compatible

clear all; close all; clc;
pkg load signal

% ---------------- Parameters ----------------
fs = 48000;              % Sampling rate (Hz)
duration = 0.2;          % Signal duration (s)
c = 343;                 % Speed of sound (m/s)
N_mics = 16;             % Number of microphones
r = 0.07;                % Array radius (m) ~ 7 cm
theta_leak = 295*pi/180;  % Leak direction (rad)

% ---------------- Leak signal ----------------
t = (0:1/fs:duration-1/fs)';
white_noise = randn(size(t));
[B,A] = butter(4,[2000 20000]/(fs/2),'bandpass');
leak_signal = filter(B,A,white_noise);

% ---------------- Mic signals (circular array) ----------------
phi = linspace(0,2*pi,N_mics+1);
phi(end) = [];  % remove duplicate
mic_signals = zeros(length(t), N_mics);

for i = 1:N_mics
    delay = (r/c) * cos(theta_leak - phi(i));  % delay in sec
    delay_samples = round(delay * fs);
    if delay_samples >= 0
        mic_signals(:,i) = [zeros(delay_samples,1); leak_signal(1:end-delay_samples)];
    else
        delay_samples = abs(delay_samples);
        mic_signals(:,i) = [leak_signal(delay_samples+1:end); zeros(delay_samples,1)];
    end
end

% ---------------- GCC-PHAT helper ----------------
function tau = gcc_phat_tau(x, y, fs)
    L = length(x) + length(y);
    N = 2^nextpow2(L);      % zero-pad length
    X = fft(x, N);
    Y = fft(y, N);
    R = X .* conj(Y);
    R = R ./ (abs(R) + eps);
    cc = real(ifft(R));
    cc = fftshift(cc);      % center zero lag
    lags = (-N/2:N/2-1).';  % sample lags
    [~, idx] = max(cc);
    tau = lags(idx) / fs;   % delay in seconds
end

% ---------------- Opposite pairs (x and y axes) ----------------
d = 2*r;   % distance between opposite mics

ix0   = 1;            % mic at 0°
ix180 = N_mics/2+1;   % mic at 180°
iy90  = N_mics/4+1;   % mic at 90°
iy270 = 3*N_mics/4+1; % mic at 270°

tau_x = gcc_phat_tau(mic_signals(:,ix0),   mic_signals(:,ix180), fs);
tau_y = gcc_phat_tau(mic_signals(:,iy90),  mic_signals(:,iy270), fs);

sx = max(-1, min(1, (tau_x * c) / d));  % cos(theta)
sy = max(-1, min(1, (tau_y * c) / d));  % sin(theta)

theta_est = atan2(sy, sx);
if theta_est < 0, theta_est = theta_est + 2*pi; end

% ---------------- Visualization ----------------
figure;
polar([theta_leak theta_leak],[0 1],'r-'); hold on;
polar([theta_est theta_est],[0 1],'b--');
legend('True Leak Direction','Estimated Direction');
title('Acoustic Holography Leak Localization (Simulation)');

