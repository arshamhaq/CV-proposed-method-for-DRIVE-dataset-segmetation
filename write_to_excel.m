function [] = write_to_excel()
path = 'DRIVE/Test/images/';
path_mask = 'DRIVE/Test/mask/';
path_manual = 'DRIVE/Test/1st_manual/';

the_dir = dir(path);

sensitivity = zeros(20,1);
specificity = zeros(20,1);
accuracy = zeros(20,1);
cells = {'index', 'sensitivity', 'specificity', 'accuracy'};

for i = 3:22
    image_path = [path the_dir(i).name];
    mask_path = [path_mask the_dir(i).name(1:2) '_test_mask.gif'];
    manual_path = [path_manual the_dir(i).name(1:2) '_manual1.gif'];

    I = im2double(imread(image_path));
    the_mask = im2double(imread(mask_path));
    manual = im2double(imread(manual_path));
    J = vessel_extractor(I,the_mask);

    

    TP=0;FP=0;TN=0;FN=0;
      for k=1:size(I,1)
          for j=1:size(I,2)
              if(manual(k,j)==1 && J(k,j)==1)
                  TP=TP+1;
              elseif(manual(k,j)==0 && J(k,j)==1)
                  FP=FP+1;
              elseif(manual(k,j)==0 && J(k,j)==0)
                  TN=TN+1;
              else
                  FN=FN+1;
              end
          end
      end

    sensitivity(i-2) = TP/(TP + FN);
    specificity(i-2) = TN/(TN + FP);
    accuracy(i-2) = (TP + TN)/(TP + TN + FP + FN);
    
    cells = [cells ; {i-2, sensitivity(i-2), specificity(i-2), accuracy(i-2)}];

end
    cells = [cells ; {'mean', mean(sensitivity), mean(specificity), mean(accuracy)}];

    writecell(cells,'results.xlsx','Sheet',1,'WriteMode','overwritesheet');
end