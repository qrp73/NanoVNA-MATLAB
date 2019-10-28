%    MATLAB scripts to read data from NanoVNA vector network analyzer.
%    It allows to establish connection with NanoVNA, send commands,
%    obtain S11 and S21 parameters, save it to S2P file and show
%    Logmag and Smith chart with no needs to use external applications.
%
%    https://github.com/qrp73/NanoVNA-MATLAB
%
%    Copyright (C) 2019 alex_m
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <https://www.gnu.org/licenses/>.
function netwk = nanoGetData(hCom)
    str_freq = nanoCommand(hCom, 'frequencies');
    str_s11 = nanoCommand(hCom, 'data 0');
    str_s21 = nanoCommand(hCom, 'data 1');
    fprintf('freq: %d\n', numel(str_freq));
    fprintf('s11:  %d\n', numel(str_s11));
    fprintf('s21:  %d\n', numel(str_s21));

    % convert string responses to s-network
    len = numel(str_freq);
    freqs = zeros(1,len);
    sparams = zeros(2,2,len);
    for i=1:len
        freqs(i) = str2double(str_freq{i});
        sparams(1,1,i) = str2complex(str_s11{i});
        sparams(2,1,i) = str2complex(str_s21{i});
        sparams(1,2,i) = complex(0,0);
        sparams(2,2,i) = complex(0,0);
    end;
    netwk = sparameters(sparams, freqs, 50.0);
    
    function value = str2complex(str)
        vals = strsplit(str);
        re = str2double(vals(1));
        im = str2double(vals(2));
        value = complex(re, im);
    end
end