function [leng] = what_length(ones_count)
if ones_count <= 12300
    leng = 1;
else
    if ones_count <= 13500
        leng = 2;
    else
        if ones_count <= 22000
            leng = 3;
        else
            if ones_count <= 25000
                leng = 4;
            else
                leng = 9;
            end
        end
    end
end
end