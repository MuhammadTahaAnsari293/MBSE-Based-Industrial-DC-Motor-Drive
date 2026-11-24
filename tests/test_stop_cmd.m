t = [0 1 1.1 9 10 10.1 12 12.1 20]';

start_cmd = timeseries( ...
    [0 1 0 0 0 0 1 0 0]', t);

reset_cmd = timeseries( ...
    [0 0 0 0 1 0 0 0 0]', t);

requested_speed = timeseries( ...
    [3 3 3 1 1 1 1 1 1]', t);

start_cmd = setinterpmethod(start_cmd,'zoh');
reset_cmd = setinterpmethod(reset_cmd,'zoh');
requested_speed = setinterpmethod(requested_speed,'zoh');