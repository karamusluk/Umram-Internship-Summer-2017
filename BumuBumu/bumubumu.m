[wPtr , rect] = Screen('OpenWindow', 0, [],[0 0 900 700]); % open window command

trial =1;

xCenter = rect(3)/2;
yCenter = rect(4)/2;


beauty =  imread('beauty.jpg');
beast =  imread('beast.jpg');

beautyText = Screen('MakeTexture', wPtr,beauty);
beastText = Screen('MakeTexture', wPtr,beast);

space = 100;
[imageHeight , imageWidth, color] = size(beast);

left = [xCenter - space - imageWidth, yCenter - imageHeight/2,xCenter - space, yCenter + imageHeight/2];
right = [xCenter + space , yCenter - imageHeight/2,xCenter + space + imageWidth, yCenter + imageHeight/2];

texts = [beautyText, beastText];
names = {'Beauty ','Beast'};

rects = [left , right];
rName = {'left', 'right'};


file = sprintf('logfile.txt');
lFile = fopen(file, 'a');


beautyKey = KbName('g');
beastKey = KbName('b');

correctVal = [];


for i=1:10
    
    randPicNum = randi(2);
    selectedPic = texts(randPicNum);
    
    randRectNum = randi(2);
    selectedRect = rects(randRectNum);
    
    Screen('DrawTexture',wPtr, selectedPic,[],selectedRect);
    flipTime = Screen('Flip', wPtr);
    
    [secs, key] = KbWait();
    Screen('Flip', wPtr);
    
    respond = find(key);
    respondTime = secs - flipTime;
    
    flag = 0;
    if randPicNum == 1
        if respond == beautyKey
            flag =1;
        end
    elseif randPicNum == 2
        if respond == beastKey
            flag =1;
        end
    end
    
    correctVal(end+1) = correct;
    
    fprintf(lFile,'%d\t%s\t%s\t%.3f\t%d\n', trial, names{randPicNum},...
        rName{randRectNum},KbName(response), respondTime,correct);
    
    WaitSecs(1);
end


overall = mean(correctVal);
fprintf(lFile,'\nOverall correctness is: %.3f', overall);
fclose(lFile);
clear Screen;

