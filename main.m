clc; clear; close all;

% write_to_excel();

I = im2double(imread("14_test.tif"));
the_mask = im2double(imread("14_test_mask.gif"));
my_result = vessel_extractor(I,the_mask);

subplot(1,2,1)
imshow(my_result, [])
title("my_result");

best = im2double(imread("14_manual1.gif"));
subplot(1,2,2)
imshow(best, [])
title("Doctor's Manual:")
