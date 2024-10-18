function [outputBinary] = HexToBinary_function(inputHex)
% returns the corresponding 4 bit binary string of the hex number
% given as input
switch inputHex
    case 0
        outputBinary = '0000';
    case 1
        outputBinary = '0001';
    case 2
        outputBinary = '0010';
    case 3
        outputBinary = '0011';
    case 4
        outputBinary = '0100';
    case 5
        outputBinary = '0101';
    case 6
        outputBinary = '0110';
    case 7
        outputBinary = '0111';
    case 8
        outputBinary = '1000';
    case 9
        outputBinary = '1001';
    case 0xA
        outputBinary = '1010';
    case 0xB
        outputBinary = '1011';
    case 0xC
        outputBinary = '1100';
    case 0xD
        outputBinary = '1101';
    case 0xE
        outputBinary = '1110';
    otherwise
        outputBinary = '1111';
end