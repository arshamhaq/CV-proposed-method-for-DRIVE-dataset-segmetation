function [J] = vessel_extractor(I,the_mask)

I = I(:,:,2) .* the_mask;
%--------------------------------------only using G plane.
%---------------------------------------------layer1: adaptive thesholding with 0.67 

T = adaptthresh(I,0.67,"ForegroundPolarity","bright","NeighborhoodSize",[15 15]);
T = ~(imbinarize(I,T)) & the_mask; %using the mask and adaptive tresholding result 

T = lose_borders(T,the_mask); % some times the mask is not enough!

%---------------------------------------------determining the length of
%strel which is adaptive based on number of 1's in picture.
%then we'll use 8 lines with different angles for opening operation
%for the strel and we'll OR
%the results.

numb = 8;
leng = what_length(sum(sum(T)));
answer = zeros(size(T,1),size(T,2),'logical');
for i = 1:numb
    SE = strel("line",leng,floor((i-1)*(180/numb)));
    temp_T = imopen(T, SE);
    answer = (answer | temp_T);
end

%----------------------------------at the end to make the lines thicker a
%simple dilatoin will be used.

SE = strel("disk",1);
answer = imdilate(answer,SE);
J = answer;
%--------------------------Done


end