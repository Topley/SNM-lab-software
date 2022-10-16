function [goodUnits,goodST,COV,rSpikes] = Remove_MUs_User(filename, MotorUnits,SpikeTrain,window)
%%% This function takes the file, the muscles motor units, the smoothed binary spike
%%% train, and the contraction window to help remove bad motor units

    % the function will calculate the COV of the smoothed spike trains within the contraction window
    % and plot them in the legend. Two windows will plot the units and spike trains for better selection
    % bad units will be removed and one of the windows will be closed. The
    % other window will stay open and be reused later in main script

filtST = zeros(size(SpikeTrain,1),size(SpikeTrain,2)); 
fsamp = 2048;
stax = window(1);
endax = window(2);
figFiring = SpikeTrain;

filtST = 2*fftfilt(hanning(fsamp),SpikeTrain');
allSmoothST = rot90(filtST);

SpikeTrain = SpikeTrain(:,(stax+1)*fsamp:endax*fsamp);
goodST = allSmoothST(:,(stax+1)*fsamp:endax*fsamp);

COV = std(filtST((stax+1)*fsamp:endax*fsamp,:))./mean(filtST((stax+1)*fsamp:endax*fsamp,:))*100;

rSpikes = COV(COV>30);

goodUnits = MotorUnits;
goodST = SpikeTrain;

goodUnits(rSpikes) = [];
%goodST(rSpikes,:) = [];
figFiring(rSpikes,:) = [];
end
