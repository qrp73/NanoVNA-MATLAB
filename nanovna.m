%    MATLAB script to read data from NanoVNA vector network analyzer.
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
%
function nanovna()
    clear; clc;
    hCom = nanoOpen('COM3');
    cleaner = onCleanup(@() nanoClose(hCom));

    nanoCommand(hCom, 'sweep start 50000');
    nanoCommand(hCom, 'sweep stop 900000000');
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
    
    % save network data
    %rfwrite(netwk.Parameters, netwk.Frequencies, 'nanovna.s2p');
    %netwk = sparameters('nanovna.s2p');
    
    
    % plot S11 LOGMAG
    figure(1)
    rfplot(netwk,1,1, '-r')
    ylim([-90 10])
    hold on
    rfplot(netwk,2,1, '-b')
    hold off
    
    % plot S11 SMITH CHART
    figure(2);
    smith(netwk,1,1);
    
    

    
    
    %===[NanoVNA functions]================================================
    % Copyright (C) 2019 alex_m
    % GNU General Public License
    % https://github.com/qrp73/NanoVNA-MATLAB
    function hCom = nanoOpen(port)
        hCom = serial(port);
        hCom.InputBufferSize = 4096;
        hCom.Terminator = 13;
        try
            fprintf('connect: %s\n', hCom.Name);
            fopen(hCom);
            fprintf('status:  %s\n', hCom.Status);
            if strcmp(hCom.Status, 'open') ~= 1
                delete(hCom);
                hCom = [];
            end;
        catch ex
            delete(hCom);
            rethrow(ex)
        end;
    end
    function nanoClose(hCom) 
        if ~isempty(hCom) && isvalid(hCom) && strcmp(hCom.Status, 'open') == 1
            fprintf('close\n');
            fclose(hCom);
        end;
        if isvalid(hCom)
            delete(hCom);
        end;
    end
    function result = nanoCommand(hCom, command)
        fprintf(hCom, command);
        isValid = false;
        lines = {};
        line = '';
        while true %strcmp(line, 'ch>') ~= 0
            data = fread(hCom, 1);
            if numel(data) ~= 1
                c = 13;
            else
                c = data(1);
            end;
            if c == 10
                continue;
            elseif c ~= 13
                line = [line, c];
                if strcmp(strtrim(line), 'ch>') == 1
                    break;
                end;
                continue;
            end;
            if isValid
                lines{end+1} = line;
            else
                isValid = strcmp(strtrim(line), command) == 1;
            end;
            line = '';
            if numel(data) ~= 1
                break;
            end;
        end;
        result = lines;
    end
    function value = str2complex(str)
        vals = strsplit(str);
        re = str2double(vals(1));
        im = str2double(vals(2));
        value = complex(re, im);
    end
    function rfwrite(s, freq, fileName)
        N = size(freq);
        order = size(s,1);
        fid = fopen(fileName, 'wt');
        % comment
        fprintf(fid, '%s\n', '! created with rfwrite');
        % specifier line
        fprintf(fid, '%s\n', '# Hz S RI R 50');
        % comment-format
        fprintf(fid, '! format: ');
        fprintf(fid, 'F ');
        for wj = 1:order
            for wk = 1:order
                fprintf(fid, 'real(S%d%d)\t', wk, wj);
                fprintf(fid, 'imag(S%d%d)', wk, wj);
                if (wj ~= order || wk ~= order)
                    fprintf(fid, '\t');
                end;
            end;
        end
        fprintf(fid, '\n');
        % write data
        for wi = 1:N
            fprintf(fid, '%d\t', freq(wi));
            for wj = 1:order
                for wk = 1:order
                    fprintf(fid, '%.17g\t', real(s(wk,wj,wi)));
                    fprintf(fid, '%.17g', imag(s(wk,wj,wi)));
                    if (wj ~= order || wk ~= order)
                        fprintf(fid, '\t');
                    end;
                end;
            end
            fprintf(fid, '\n');
        end        
    end
end
