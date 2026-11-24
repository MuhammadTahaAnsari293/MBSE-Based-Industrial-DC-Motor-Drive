
%% Stateflow Supervisor - Test Inputs
clearvars;

Ts = 0.01;
t = (0:Ts:12)';

% Operator commands
start_cmd_data = double(t >= 1 & t < 1.2 | ...
                        t >= 6 & t < 6.2);

stop_cmd_data = double(t >= 3 & t < 3.2);

reset_cmd_data = double(t >= 9 & t < 9.2);

% Requested motor speed
requested_speed_data = ones(size(t));

% Simulated motor speed feedback
measured_speed_data = zeros(size(t));

% Motor runs after first start
measured_speed_data(t >= 1.2 & t < 3) = 1.0;

% Motor slows down after Stop
idx = t >= 3 & t < 4;
measured_speed_data(idx) = 1 - (t(idx) - 3);

% Motor stopped
measured_speed_data(t >= 4 & t < 6.2) = 0;

% Second run
measured_speed_data(t >= 6.2 & t < 7) = 1.0;

% Current feedback
measured_current_data = 0.1 * ones(size(t));

% Inject overcurrent at 7 seconds
measured_current_data(t >= 7 & t < 8) = 0.7;

% Current returns to normal
measured_current_data(t >= 8) = 0.1;

% Create timeseries
start_cmd = timeseries(start_cmd_data, t);
stop_cmd = timeseries(stop_cmd_data, t);
reset_cmd = timeseries(reset_cmd_data, t);

requested_speed = timeseries(requested_speed_data, t);
measured_speed = timeseries(measured_speed_data, t);
measured_current = timeseries(measured_current_data, t);

% Zero-order hold interpolation
start_cmd = setinterpmethod(start_cmd, 'zoh');
stop_cmd = setinterpmethod(stop_cmd, 'zoh');
reset_cmd = setinterpmethod(reset_cmd, 'zoh');
requested_speed = setinterpmethod(requested_speed, 'zoh');
measured_speed = setinterpmethod(measured_speed, 'zoh');
measured_current = setinterpmethod(measured_current, 'zoh');

disp('Supervisor test signals initialized.');