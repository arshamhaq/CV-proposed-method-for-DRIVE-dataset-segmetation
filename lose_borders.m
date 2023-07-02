function [J] = lose_borders(I,the_mask)
the_mask = ~the_mask;
SE = strel('disk',5);
the_mask = ~(imdilate(the_mask,SE));
J = I & the_mask;
end