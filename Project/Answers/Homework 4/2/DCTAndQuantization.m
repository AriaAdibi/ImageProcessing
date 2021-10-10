function y= DCTAndQuantization( theBox, qtms )
    y= dct2(theBox)./qtms;
    y= zigzagScan(y);
end