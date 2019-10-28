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
function rfwrite(s, freq, fileName)
    N = size(freq);
    order = size(s,1);
    fid = fopen(fileName, 'wt');
    % comment
    fprintf(fid, '%s\n', '! created with rfwrite.m by alex_m');
    fprintf(fid, '%s\n', '! https://github.com/qrp73/NanoVNA-MATLAB');
    fprintf(fid, '%s\n', '! ');
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
    end;
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
        end;
        fprintf(fid, '\n');
    end;
    fclose(fid);
end
