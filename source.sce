img=readpbm('timgone.pbm');

mask = [1,1,1;
        1,9,1;
        1,1,1];






function [largeImg] = setUpBorders(smImg, dsp)
    
    oldHeight = size(smImg,"r");
    oldWidth = size(smImg,"c");
    newHeight = oldHeight + dsp * 2;
    newWidth = oldWidth + dsp * 2;
    largeImg = zeros(newHeight,newWidth);
    
    // Center
    for y=1+dsp:newHeight - dsp
        for x=1+dsp:newWidth - dsp
            largeImg(y,x) = smImg(y-dsp, x-dsp);
        end
    end
    
    //  write X think Y 
    //  want Width write Height
    
    // Top
    for x=1:dsp     
        for y=1+dsp:oldHeight+dsp     
            largeImg(y,x) = smImg(y-dsp,1);
        end
    end
    // Bottom
    for x=dsp+oldWidth:newWidth
        for y=1+dsp:oldHeight+dsp 
            largeImg(y,x) = smImg(y-dsp,oldWidth);
        end
    end
    //Left
    for x=1:newWidth
        for y=1:dsp
            largeImg(y,x) = largeImg(dsp+1,x);
        end
    end
    //Right
    for x=1:newWidth
        for y=oldHeight+dsp:newHeight
            largeImg(y,x) = largeImg(oldHeight+dsp,x);
        end
    end
        
endfunction

largeImg = setUpBorders(img,50);
display_gray(largeImg);
