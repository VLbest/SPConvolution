clear
exec('applyFilter.sce', -1);
exec('display_gray.sci', -1);
exec('readpbm.sci', -1);

//************************************************
//

img=readpbm('timgone.pbm');

mask = [0.75,0.75,0.75;
        0.75,1,0.75;
        0.75,0.75,0.75];

contrast = 7;

//
//************************************************


//  image, filter matrix, contrast normalisation
resultImg = applyFilter(img, mask, contrast);
display_gray(img);
scf;
display_gray(resultImg);
