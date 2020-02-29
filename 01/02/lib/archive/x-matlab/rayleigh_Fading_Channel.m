function [fading_channel_out] = rayleigh_Fading_Channel(Channel_in)

l_tx                   = length(Channel_in);
Ts                     = ((10^-3)/125)/8;                                     % Sampling period of channel
Fd                     = 1;                                                   % Max Doppler frequency shift
tau                    = [0]*Ts;                                             % Path delays
pdb                    = [0];                                                % Avg path power gains
h                      = rayleighchan(Ts, Fd, tau, pdb);
h.StoreHistory         =1;
h.StorePathGains       =1;
h.ResetBeforeFiltering =1;
fading_channel_out     = filter(h, Channel_in); 
%plot(h);

% Fd = 0;        % 0Hz 5Hz 70Hz                                         % Max Doppler frequency shift
% tau = [0 30 70 90 110 190 410]*(10^-9);                                    % Path delays
% pdb = [0 -1.0 -2.0 -3.0 -8.0 -17.2 -20.8];                                       % Avg path power gains
% h = rayleighchan(Ts, Fd, tau, pdb);
% h.StoreHistory = 0;
