function [t W T_H T_C] = read_vpdata(path);
%----------------------------------------------------------------------
% Reads a data file from program Capstone where path is the path to data file
% (either absolute or relative). Returns a vector time containg the 
% sample time, a vector energy containing the total energy used by the
% compressor at that time, and two vectors with the temperatures in the hot
% and cold reservoir at the sample times.
%
%   modified version 2016-09-14 for Capstone data collection program by
%   Henrik Ekerfelt
%----------------------------------------------------------------------

    if nargin == 0
        [FileName,PathName] = uigetfile('*');
        path = fullfile(PathName,FileName);
    end

    en_p_pulse = 4500;      % energiinkrement per puls (i joule per puls)

    Mdata = fileread(path);
    Mdata = strrep(Mdata,',','.');
    fid = fopen('tmp.data','w');
    fwrite(fid,Mdata);
    fclose(fid);
        
    values = importdata('tmp.data');  %Imports data into a struct
    
    delete('tmp.data');
    
    % Finds index of different values.
    k = 1;
    k_temp = [];
    for str = values.textdata(2,:)
        if cell2mat(strfind(str,'Time'))
            k_time = k;
        elseif cell2mat(strfind(str,'Counts'))
            k_energy = k;
        elseif cell2mat(strfind(str,'Temp'))
            if k_temp
                k_temp = [k_temp,k];
            else
                k_temp = k;
            end
        end
        k = k+1;
    end
    
    time = values.data(1:end-1,k_time);
    energy = [0;cumsum(values.data(2:end-1,k_energy)).*en_p_pulse];
    if sum(values.data(1:end-1,k_temp(1))) > sum(values.data(1:end-1,k_temp(2)))
        th = values.data(1:end-1,k_temp(1));
        tc = values.data(1:end-1,k_temp(2));
    else
        th = values.data(1:end-1,k_temp(2));
        tc = values.data(1:end-1,k_temp(1));
    end
 %
 % byt till de gamla variabelnamnen
 %
 t=time;
 W=energy;
 T_H=th;
 T_C=tc;   
end