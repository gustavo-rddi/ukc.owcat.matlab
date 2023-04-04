function colEnd = excelColumnOffset(colStart, offset)

if offset<21

    %initialise%
    colNumStart = 0;

    for i = 1 : length(colStart)

        %determine equivalent starting column number%
        colNumStart = colNumStart + (double(colStart(end-i+1)) - double('A') + 1) * 26^(i-1);

    end

    %add offset to starting column%
    colNumEnd = colNumStart + offset;

    %pre-allocate string for output column%
    colEnd = char(ones(1,ceil(log(colNumEnd)/log(26))));

    %start%
    i = 1;
    
    while colNumEnd ~= 0

        %determine letter codes through progressive division%
        colEnd(end-i+1) = char(double('A') + rem(colNumEnd, 26) - 1);

        %progress to next digit%
        colNumEnd = fix(colNumEnd/26);

        %increment%
        i = i + 1;
        
    end
elseif offset == 21
    colEnd = 'Z';

elseif offset == 47
    colEnd = 'AZ';
    
elseif offset <= 696
    a = floor((offset+5)/26);
    b = (offset+5)- a*26;
    
    if a == 1
      aa = 'A';
    elseif a == 2
      aa = 'B';
    elseif a == 3
      aa = 'C';  
    elseif a == 4
      aa = 'D';  
    elseif a == 5
      aa = 'E';  
    elseif a == 6
      aa = 'F';  
    elseif a == 7
      aa = 'G';        
    elseif a == 8
      aa = 'H';  
    elseif a == 9
      aa = 'I';  
    elseif a == 10
      aa = 'J';  
    elseif a == 11
      aa = 'K';  
    elseif a == 12
      aa = 'L';  
    elseif a == 13
      aa = 'M';  
    elseif a == 14
      aa = 'N';  
    elseif a == 15
      aa = 'O';  
    elseif a == 16
      aa = 'P';  
    elseif a == 17
      aa = 'Q';  
    elseif a == 18
      aa = 'R';  
    elseif a == 19
      aa = 'S';   
    elseif a == 20
      aa = 'T';  
    elseif a == 21
      aa = 'U';
    elseif a == 22
      aa = 'V';
    elseif a == 23
      aa = 'W';
    elseif a == 24
      aa = 'X';
    elseif a == 25
      aa = 'Y';
    else
      aa = 'Z';
    end
    
    if b == 1
      bb = 'A';
    elseif b == 2
      bb = 'B';
    elseif b == 3
      bb = 'C';  
    elseif b == 4
      bb = 'D';  
    elseif b == 5
      bb = 'E';  
    elseif b == 6
      bb = 'F';  
    elseif b == 7
      bb = 'G';        
    elseif b == 8
      bb = 'H';  
    elseif b == 9
      bb = 'I';  
    elseif b == 10
      bb = 'J';  
    elseif b == 11
      bb = 'K';  
    elseif b == 12
      bb = 'L';  
    elseif b == 13
      bb = 'M';  
    elseif b == 14
      bb = 'N';  
    elseif b == 15
      bb = 'O';  
    elseif b == 16
      bb = 'P';  
    elseif b == 17
      bb = 'Q';  
    elseif b == 18
      bb = 'R';  
    elseif b == 19
      bb = 'S';   
    elseif b == 20
      bb = 'T';  
    elseif b == 21
      bb = 'U';
    elseif b == 22
      bb = 'V';
    elseif b == 23
      bb = 'W';
    elseif b == 24
      bb = 'X';
    elseif b == 25
      bb = 'Y';
    else
      bb = 'Z';
    end
    
    colEnd = strcat(aa,bb);

elseif offset == 697
    colEnd = 'ZZ';
    
elseif offset <= 1368
    a0 = offset + 5 - 703;
    a = floor(a0/26);
    a2 = a + 1;
    b = a0 - a*26;
    b2 = b + 1;
    
    if a2 == 1
      aa = 'A';
    elseif a2 == 2
      aa = 'B';
    elseif a2 == 3
      aa = 'C';  
    elseif a2 == 4
      aa = 'D';  
    elseif a2 == 5
      aa = 'E';  
    elseif a2 == 6
      aa = 'F';  
    elseif a2 == 7
      aa = 'G';        
    elseif a2 == 8
      aa = 'H';  
    elseif a2 == 9
      aa = 'I';  
    elseif a2 == 10
      aa = 'J';  
    elseif a2 == 11
      aa = 'K';  
    elseif a2 == 12
      aa = 'L';  
    elseif a2 == 13
      aa = 'M';  
    elseif a2 == 14
      aa = 'N';  
    elseif a2 == 15
      aa = 'O';  
    elseif a2 == 16
      aa = 'P';  
    elseif a2 == 17
      aa = 'Q';  
    elseif a2 == 18
      aa = 'R';  
    elseif a2 == 19
      aa = 'S';   
    elseif a2 == 20
      aa = 'T';  
    elseif a2 == 21
      aa = 'U';
    elseif a2 == 22
      aa = 'V';
    elseif a2 == 23
      aa = 'W';
    elseif a2 == 24
      aa = 'X';
    elseif a2 == 25
      aa = 'Y';
    else
      aa = 'Z';
    end
    
    if b2 == 1
      bb = 'A';
    elseif b2 == 2
      bb = 'B';
    elseif b2 == 3
      bb = 'C';  
    elseif b2 == 4
      bb = 'D';  
    elseif b2 == 5
      bb = 'E';  
    elseif b2 == 6
      bb = 'F';  
    elseif b2 == 7
      bb = 'G';        
    elseif b2 == 8
      bb = 'H';  
    elseif b2 == 9
      bb = 'I';  
    elseif b2 == 10
      bb = 'J';  
    elseif b2 == 11
      bb = 'K';  
    elseif b2 == 12
      bb = 'L';  
    elseif b2 == 13
      bb = 'M';  
    elseif b2 == 14
      bb = 'N';  
    elseif b2 == 15
      bb = 'O';  
    elseif b2 == 16
      bb = 'P';  
    elseif b2 == 17
      bb = 'Q';  
    elseif b2 == 18
      bb = 'R';  
    elseif b2 == 19
      bb = 'S';   
    elseif b2 == 20
      bb = 'T';  
    elseif b2 == 21
      bb = 'U';
    elseif b2 == 22
      bb = 'V';
    elseif b2 == 23
      bb = 'W';
    elseif b2 == 24
      bb = 'X';
    elseif b2 == 25
      bb = 'Y';
    else
      bb = 'Z';
    end
    
    colEnd = strcat('A',aa,bb);
    
    
%elseif offset == 21
%    colEnd = 'Z';
%elseif offset == 22
%    colEnd = 'AA';
%elseif offset == 23
%    colEnd = 'AB';
%elseif offset == 24
%    colEnd = 'AC';
%elseif offset == 25
%    colEnd = 'AD';
%elseif offset == 26
%    colEnd = 'AE';
%elseif offset == 27
%    colEnd = 'AF';
%elseif offset == 28
%    colEnd = 'AG';
%elseif offset == 29
%    colEnd = 'AH';
%elseif offset == 30
%    colEnd = 'AI';
%elseif offset == 31
%    colEnd = 'AJ';
%elseif offset == 32
%    colEnd = 'AK';
%elseif offset == 33
%    colEnd = 'AL';
%elseif offset == 34
%    colEnd = 'AM';
%elseif offset == 35
%    colEnd = 'AN';
%elseif offset == 36
%    colEnd = 'AO';
%elseif offset == 37
%    colEnd = 'AP';
%elseif offset == 38
%    colEnd = 'AQ';
%elseif offset == 39
%    colEnd = 'AR';
%elseif offset == 40
%    colEnd = 'AS';
%elseif offset == 41
%    colEnd = 'AT';
%elseif offset == 42
%    colEnd = 'AU';
%elseif offset == 43
%    colEnd = 'AV';
%elseif offset == 44
%    colEnd = 'AW';
%elseif offset == 45
%    colEnd = 'AX';
%elseif offset == 46
%    colEnd = 'AY';
%elseif offset == 47
%    colEnd = 'AZ';
%elseif offset == 48
%    colEnd = 'BA';
%elseif offset == 49
%    colEnd = 'BB';
%elseif offset == 50
%    colEnd = 'BC';
%elseif offset == 51
%    colEnd = 'BD';
%elseif offset == 52
%    colEnd = 'BE';
%elseif offset == 53
%    colEnd = 'BF';
%elseif offset == 54
%    colEnd = 'BG';
%elseif offset == 55
%    colEnd = 'BH';
%elseif offset == 56
%    colEnd = 'BI';
%elseif offset == 57
%    colEnd = 'BJ';
%elseif offset == 58
%    colEnd = 'BK';
%elseif offset == 59
%    colEnd = 'BL';
%elseif offset == 60
%    colEnd = 'BM';
%elseif offset == 61
%    colEnd = 'BN';
%elseif offset == 62
%    colEnd = 'BO';
%elseif offset == 63
%    colEnd = 'BP';
%elseif offset == 64
%    colEnd = 'BQ';
%elseif offset == 65
%    colEnd = 'BR';
%elseif offset == 66
%    colEnd = 'BS';
%elseif offset == 67
%    colEnd = 'BT';
%elseif offset == 68
%    colEnd = 'BU';
%elseif offset == 69
%    colEnd = 'BV';
%elseif offset == 70
%    colEnd = 'BW';
%elseif offset == 71
%    colEnd = 'BX';
%elseif offset == 72
%    colEnd = 'BY';
%elseif offset == 73
%    colEnd = 'BZ';
%elseif offset == 74
%    colEnd = 'CA'; 
%elseif offset == 75
%    colEnd = 'CB'; 
%elseif offset == 76
%    colEnd = 'CC'; 
%elseif offset == 77
%    colEnd = 'CD'; 
%elseif offset == 78
%    colEnd = 'CE'; 
%elseif offset == 79
%    colEnd = 'CF';
%elseif offset == 80
%    colEnd = 'CG'; 
%elseif offset == 81
%    colEnd = 'CH'; 
%elseif offset == 82
%    colEnd = 'CI'; 
    
    
    
    
end
    
    
    
end