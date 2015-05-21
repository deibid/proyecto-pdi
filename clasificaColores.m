clc
clear
close all
tic
indices1 = {[25,45,49,58,59,61,66];
    [2,17,43];
    [3,26,42];
    [1,4,11,14,21,65];
    [47];
    [7,37,52,54];
    [27,31,36,48,63];
    [20,67];
    [28,32,33,44,68];
    [5,8,15,35];
    [13,19,38,55];
    [9,10,12,40,51];
    [16];[6,22,56,57,60];
    [18,29,41];
    [23,24,34,53,62]};

indices2 = {[1,18,36,42,51,53,55,57,60];
    [9,37,62];
    [35];
    [7,13];
    [40];
    [2,29,46,52];
    [19,23,28,30,41,58];
    [12,61];
    [20,25,38,64];
    [4,8,22,27];
    [5,24,31,45,48];
    [3,6,33,44,59];
    [10,17];
    [14,49,50,54,65];
    [21,34];
    [15,16,43,47];
    };

indices3 = {[28];
    [1,9,41,45];
    [2,22,29];
    [14,17,21,27];
    [23,32,34,53];
    [35,50];
    [4,5];
    [40,51,54];
    [19];
    [0];
    [30,37,47];
    [11,48];
    [6,13,20,25,31];
    [12,16,33,52];
    [38,49];
    [8,18,26,39];
    };

indices4 = {[5,34,38,39,42];
    [24,26];
    [28];
    [12,30,35,44];
    [1,11,13,19,37];
    [20,33,50];
    [2,22,47];
    [10];
    [0];
    [8];
    [6,40];
    [3,16];
    [9,46,49];
    [7,23,27,32,48];
    [4,14,17,21,31,36,41];
    [25,29,43];
    };

indices5 = {[0];
    [12,14,46];
    [1,31,38,48,53,54];
    [56,57];
    [10,17,20,25,28];
    [11];
    [0];
    [6,13,15,27,37,47,49];
    [3,26];
    [7,22,39];
    [5,36,43];
    [8,18,29,34,41,51];
    [0];
    [0];
    [19,33];
    [0];
    };

Indices = {indices1, indices2, indices3, indices4};

Colores = {'rojos'
    'naranjas'
    'yemas'
    'amarillos'
    'limons'
    'verdes'
    'azuls'
    'aquas'
    'turquesas'
    'rosas'
    'morados'
    'fosfos'
    'cafes'
    'griss'
    'blancos'
    'negros'};


size(Indices{1}{1})
%pause

Valores = [];
for j = 1 : 16
    for i=1 : 4
        im = imread(['pruebas',num2str(i),'.jpg']);
        %figure, imshow(im)
        [trash, imBin] = binarizar(im);
        se = strel('disk',2);
        imBinErod = imerode(imBin, se);
        imBinErod = bwareaopen(imBinErod, 80);
        %figure, imshow(imBinErod);
        imBinErod = cast(imBinErod, 'uint8');
        [L, numObj] = bwlabel(imBinErod);
        mask = cat(3, imBinErod, imBinErod, imBinErod);
        mask = im.*mask;
        
        %for j=1 : 16
        
        for k=1 : size(Indices{i}{j},2)
            B1 = L == Indices{i}{j}(k);
            if Indices{i}{j}(k)~=0
                %figure, imshow(B1);
                [X1, R1] = imstack2vectors(mask, B1);
                Valores = cat(1,Valores,X1);
            end
        end
        
    end
    %Colores{j}
    save(Colores{j},'Valores');
    Valores = [];
    %pause
end
toc
