// *********************
    //  disp("x: "+string(x));
    //  disp("y: "+string(y));
// ********************



function [fiteredImg] = applyFilter(img, mx, normCoeff)
    dsp = getDisplacement(mx);
    largeImg = setUpBorders(img,dsp);
    vals = 0,
    for x=1+dsp:size(largeImg,"c")-dsp
        for y=1+dsp:size(largeImg,"r")-dsp
            sumVals = getSum(dsp,mx, largeImg,x, y );
//            disp("sum: " + string(sumVals));
            if(normCoeff > 0) then
                sumVals = sumVals * (1 / normCoeff);
            end
            largeImg(y,x) = sumVals;
        end
    end
    fiteredImg = deleteFalseBorders(largeImg, dsp);
endfunction

function [smFilteredImg] = deleteFalseBorders (img, dsp)
    smFilteredImg = 0;
    for x = 1 + dsp: size(img,"c") - dsp
        for y = 1 + dsp: size(img,"r") - dsp
            smFilteredImg(y,x)  = img(x,y);
        end
    end
endfunction

function [sumVals] = getSum(dsp, mx, img, centerX, centerY)
    vals = list();
    for x = centerY - dsp: centerY + dsp
        for y = centerX - dsp: centerX + dsp
//            disp("x: "+string(x));
//            disp("y: "+string(y));
//            disp("iVal: "+string(img(x,y)));
            vals($+1) = img(x,y);
            
        end
    end
    i = 0;
    valsMx = 0;
    sumVals = 0;
    for x=1:size(mx,"c")
        for y=1:size(mx,"r")
            i = i + 1;
            sumVals = sumVals + vals(i) * mx(x,y);
//            disp("img: " + string(mx(x,y)));
//            disp("vals: " + string(vals(i)));
            
//            pause;
        end
    end
endfunction

function [dsp] = getDisplacement(filter)
    if(validateMatrix(filter) == 1) then
        disp('Matrix verification:  DONE');
    end
    dsp = modulo(size(filter,"r"),2);
endfunction

function [mStat] = validateMatrix(filter)
    msH = size(filter,"r");
    msW = size(filter,"c")
    if(msH > 3 | msW > 3) then
        halt("  Matrix is too small.  ");
        mStat = 0;
    elseif ((modulo(msH, 2) == 0) |(modulo(msW ,2) == 0)) then
        halt("   Size of matrix cannot be an odd number   ");
        mStat = 0;
    elseif (msH <> msW) then
        halt("   Height of matrix must be equals to it width   ");
        mStat = 0;
    else
        mStat = 1;
    end
endfunction

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
    disp('Setup false borders:  DONE');
endfunction

