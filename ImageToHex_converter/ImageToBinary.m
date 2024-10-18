b=imread('bird2.bmp'); % 24-bit BMP image RGB888 

k=1;
fid = fopen('bird2.txt', 'wt');
% change i and j limits according to image resolution
for i=1:200 % image is written from the first row to the last row
    for j=1:200
        a(k)=b(i,j,1);
        a(k)=bitsra(a(k), 4);
        fprintf(fid, '%s', HexToBinary_function(a(k)));
        a(k+1)=b(i,j,2);
        a(k+1)=bitsra(a(k+1), 4);
        fprintf(fid, '%s', HexToBinary_function(a(k+1)));
        a(k+2)=b(i,j,3);
        a(k+2)=bitsra(a(k+2), 4);
        fprintf(fid, '%s\n', HexToBinary_function(a(k+2)));
        k=k+3;
    end
end

disp('Text file write done'); disp(' ');
% coewrite(a, 16, 'bird3')
% disp('Conversion done'); disp(' ');
fclose(fid);