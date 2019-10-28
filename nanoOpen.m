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
