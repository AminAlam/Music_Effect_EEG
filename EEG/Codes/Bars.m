%% loading datas 
clc
clear
filename = "DATA/AliEpochAVGRefICA.txt";
data_ghavam = load(filename);
data_ghavam = reshape(data_ghavam,19,34000,11);

filename = "DATA/MaryamEpochAVGRefICA.txt";
data_maryam = load(filename);
data_maryam = reshape(data_maryam,19,34000,11);

filename = "DATA/YasiEpochAVGRefICA.txt";
data_yasi = load(filename);
data_yasi = reshape(data_yasi,19,34000,11);

filename = "DATA/FarajEpochAVGRefICA.txt";
data_faraj = load(filename);
data_faraj = reshape(data_faraj,19,34000,10);

filename = "DATA/ArsalanEpochAVGRefICA.txt";
data_arsalan = load(filename);
data_arsalan = reshape(data_arsalan,19,34000,9);

% making struct
Subjects.subject1 = myBand(data_ghavam, 1);
Subjects.subject2 = myBand(data_maryam, 1);
Subjects.subject3 = myBand(data_arsalan, 2);
Subjects.subject4 = myBand(data_faraj, 1);
Subjects.subject5 = myBand(data_yasi, 3);

% process
clc
close all

for genre = ["opera", "rock", "pop", "jazz", "rap"]

    for band = ["Alpha","Beta","Delta","Theta","Gamma"]
       
        for type = ["rest","task"]
            
            if(genre == "opera")
             x = [Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band))]; 
                
            else
            x = [Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject3.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band)),...
            Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s",type)).(sprintf("%s",band))];
            end
            
        
        S.(sprintf("%s_%s_%s",genre,type,band)).mean = mean(x);
        S.(sprintf("%s_%s_%s",genre,type,band)).var = var(x);
            
        end
     
    end
       
end

myBar(S)
%%
% regrssion basics

clc
close all

for genre = ["opera", "rock", "pop", "jazz", "rap"]

    for band = ["Alpha","Beta","Delta","Theta","Gamma"]
       
        for type = ["rest","task"]
            
            if(genre ~= "opera")    
            diff1 = Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff2 = Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff3 = Subjects.subject3.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject3.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));   
            diff4 = Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff5 = Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            SD.(sprintf("%s",genre)).(sprintf("%s",band)) = (([diff1 diff2 diff3 diff4 diff5]));
            else
            diff1 = Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject1.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff2 = Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject2.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff4 = Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject4.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            diff5 = Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s","task")).(sprintf("%s",band)) - Subjects.subject5.(sprintf("%s",genre)).(sprintf("%s","rest")).(sprintf("%s",band));
            SD.(sprintf("%s",genre)).(sprintf("%s",band)) = (([diff1 diff2 diff4 diff5]));

            end
  
        end
     
    end
       
end


 Q1 = load("Questionnaire/S1_Q.mat");
 Q1 = Q1.S1_q;
 Q1 = table2array(Q1(:,2:end-1));
 Q2 = load("Questionnaire/S2_Q.mat");
 Q2 = Q2.S2_q;
 Q2 = table2array(Q2(:,2:end-1));
 Q3 = load("Questionnaire/S3_Q.mat");
 Q3 = Q3.S3_q;
 Q3 = table2array(Q3(:,2:end-1));
 Q4 = load("Questionnaire/S4_Q.mat");
 Q4 = Q4.S4_q;
 Q4 = table2array(Q4(:,2:end-1));
 Q5 = load("Questionnaire/S5_Q.mat");
 Q5 = Q5.S5_q;
 Q5 = table2array(Q5(:,2:end-1));
 temp1 = [0 0 0;Q1];
 temp1(end,:) = [];
 temp2 = [0 0 0;Q2];
 temp2(end,:) = [];
 temp3 = [0 0 0;Q3];
 temp3(end,:) = [];
 temp4 = [0 0 0;Q4];
 temp4(end,:) = [];
 temp5 = [0 0 0;Q5];
 temp5(end,:) = [];
 Q1D = Q1 - temp1;
 Q2D = Q2 - temp2;
 Q3D = Q3 - temp3;
 Q4D = Q4 - temp4;
 Q5D = Q5 - temp5;
 Q.Q1 = Q1D;
 Q.Q2 = Q2D;
 Q.Q3 = Q3D;
 Q.Q4 = Q4D;
 Q.Q5 = Q5D;
% mapping to -1 and +1
 for i = 1 : 5
     
     temp = Q.(sprintf("Q%i",i));
     Q_maped.(sprintf("Q%i",i)) = temp(2:end,:);
     
 end

    subject = []
 i = 1;
for genre = ["opera","rock","pop","rap","jazz"]
    
    QuestionsMarks = zeros(3,5);
    for j = 1:5
        
        temp = Q_maped.(sprintf("Q%i",j));
        QuestionsMarks(1,j) = temp(i,1);
        QuestionsMarks(2,j) = temp(i,2);
        QuestionsMarks(3,j) = temp(i,3);
        
    end
    SD.(sprintf("%s",genre)).drowsiness = QuestionsMarks(1,:);
    SD.(sprintf("%s",genre)).focus = QuestionsMarks(2,:);
    SD.(sprintf("%s",genre)).anxiety = QuestionsMarks(3,:);
    i = i + 1;
end

save("SD.mat","SD")
%% Linear Regression

clc
clear
load('Sd.mat');

i = 1;
coeefs = [];
for genre = ["opera","rock","pop","rap","jazz"]
    
    for band = ["Alpha","Beta","Delta","Theta","Gamma"]
        for question = ["drowsiness","focus","anxiety"]
            input = SD.(sprintf("%s",genre)).(sprintf("%s",band));
            output = SD.(sprintf("%s",genre)).(sprintf("%s",question));
                if(genre == "opera")
                  output(3) = [];
                end
                
                temp = regress(output',input');
                
            Regress.(sprintf("%s",genre)).(sprintf("%s",band)).(sprintf("%s",question)) = temp;
        end
    end
    
end

for genre = ["opera","rock","pop","rap","jazz"]
    
    for band = ["Alpha","Beta","Delta","Theta","Gamma"]
        for question = ["drowsiness","focus","anxiety"]
            cooef = Regress.(sprintf("%s",genre)).(sprintf("%s",band)).(sprintf("%s",question));
            if abs(cooef)>=0.8
                goodRegress.(sprintf("%s",genre)).(sprintf("%s",band)).(sprintf("%s",question)) = cooef;
            end
        end
    end
    
end

%% coorplot 
clc
close all
for genre = ["rock","pop","rap","jazz","opera"]
    figure('Name',genre);
    Mat = [];
    genre
    VariableNames = ["Alpha","Beta","Delta","Theta","Gamma","drowsiness","focus","anxiety"];
    for element = VariableNames
            mat = SD.(sprintf("%s",genre)).(sprintf("%s",element));
                if(genre == "opera")
                    if(element == "drowsiness" || element == "focus" || element == "anxiety")
                        mat(3) = [];
                    end
                end
             Mat = [Mat mat'];
    end
        corrplot(Mat,'varNames', VariableNames);        
         
end

    
%% Functions
function myStruct = myBand(signal, order)
% ghavam maryam faraj
    if order==1
        myStruct.opera.rest = myband(signal(:,:,1));
        myStruct.opera.task = myband(signal(:,:,2));

        myStruct.rock.rest = myband(signal(:,:,3));
        myStruct.rock.task = myband(signal(:,:,4));

        myStruct.pop.rest = myband(signal(:,:,5));
        myStruct.pop.task = myband(signal(:,:,6));

        myStruct.rap.rest = myband(signal(:,:,7));
        myStruct.rap.task = myband(signal(:,:,8));

        myStruct.jazz.rest = myband(signal(:,:,9));
        myStruct.jazz.task = myband(signal(:,:,10));
    end
    % arsalan
    if order==2
        myStruct.pop.rest = myband(signal(:,:,1));
        myStruct.pop.task = myband(signal(:,:,2));

        myStruct.rock.rest = myband(signal(:,:,3));
        myStruct.rock.task = myband(signal(:,:,4));

        myStruct.jazz.rest = myband(signal(:,:,5));
        myStruct.jazz.task = myband(signal(:,:,6));

        myStruct.rap.rest = myband(signal(:,:,7));
        myStruct.rap.task = myband(signal(:,:,8));

    end
    % yassi
    if order==3
        myStruct.jazz.rest = myband(signal(:,:,1));
        myStruct.jazz.task = myband(signal(:,:,2));

        myStruct.opera.rest = myband(signal(:,:,3));
        myStruct.opera.task = myband(signal(:,:,4));

        myStruct.pop.rest = myband(signal(:,:,5));
        myStruct.pop.task = myband(signal(:,:,6));

        myStruct.rock.rest = myband(signal(:,:,7));
        myStruct.rock.task = myband(signal(:,:,8));

        myStruct.rap.rest = myband(signal(:,:,9));
        myStruct.rap.task = myband(signal(:,:,10));
    end



end

function out = myband(signal)
Delta = [0.05,3];
Theta = [4,7];
Alpha = [8,12];
Beta = [12,30];
Gamma = [30,70];
Alpha_p = 0;
Delta_p = 0;
Theta_p = 0;
Gamma_p = 0;
Beta_p = 0;
for i = 1:19
    Alpha_p = Alpha_p + bandpower(signal(i,:),200,Alpha);
    Delta_p = Delta_p + bandpower(signal(i,:),200,Delta);
    Theta_p = Theta_p + bandpower(signal(i,:),200,Theta);
    Gamma_p = Gamma_p + bandpower(signal(i,:),200,Gamma);
    Beta_p = Beta_p + bandpower(signal(i,:),200,Beta);
    
end
Alpha_p = Alpha_p/19;
Delta_p = Delta_p/19;
Theta_p = Theta_p/19;
Gamma_p = Gamma_p/19;
Beta_p = Beta_p/19;

out.Alpha = Alpha_p;
out.Delta = Delta_p;
out.Theta = Theta_p;
out.Gamma = Gamma_p;
out.Beta = Beta_p;
end

function myBar(S)

for genre = ["opera", "rock", "pop", "jazz", "rap"]
    figure
    X = categorical({'Alpha','Betha','Delta','Theta','Gamma'});
    X = reordercats(X,{'Alpha','Betha','Delta','Theta','Gamma'});
    
    X = [1 2 3 4 5];
    
    Y = [S.(sprintf("%s_%s_%s",genre,"rest","Alpha")).mean,S.(sprintf("%s_%s_%s",genre,"task","Alpha")).mean;...
        S.(sprintf("%s_%s_%s",genre,"rest","Beta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Beta")).mean;...
        S.(sprintf("%s_%s_%s",genre,"rest","Delta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Delta")).mean;...
        S.(sprintf("%s_%s_%s",genre,"rest","Theta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Theta")).mean;...
        S.(sprintf("%s_%s_%s",genre,"rest","Gamma")).mean,S.(sprintf("%s_%s_%s",genre,"task","Gamma")).mean];
    
    bar(Y)
    errhigh = [sqrt(S.(sprintf("%s_%s_%s",genre,"rest","Alpha")).var)/2,sqrt(S.(sprintf("%s_%s_%s",genre,"task","Alpha")).var)/2,...
        sqrt(S.(sprintf("%s_%s_%s",genre,"rest","Beta")).var)/2,sqrt(S.(sprintf("%s_%s_%s",genre,"task","Beta")).var)/2,...
        sqrt(S.(sprintf("%s_%s_%s",genre,"rest","Delta")).var)/2,sqrt(S.(sprintf("%s_%s_%s",genre,"task","Delta")).var)/2,...
        sqrt(S.(sprintf("%s_%s_%s",genre,"rest","Theta")).var)/2,sqrt(S.(sprintf("%s_%s_%s",genre,"task","Theta")).var)/2,...
        sqrt(S.(sprintf("%s_%s_%s",genre,"rest","Gamma")).var)/2,sqrt(S.(sprintf("%s_%s_%s",genre,"task","Gamma")).var)/2];
    hold on 
    X = [0.85 1.15 1.85 2.15 2.85 3.15 3.85 4.15 4.85 5.15];
    Y = [S.(sprintf("%s_%s_%s",genre,"rest","Alpha")).mean,S.(sprintf("%s_%s_%s",genre,"task","Alpha")).mean,...
        S.(sprintf("%s_%s_%s",genre,"rest","Beta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Beta")).mean,...
        S.(sprintf("%s_%s_%s",genre,"rest","Delta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Delta")).mean,...
        S.(sprintf("%s_%s_%s",genre,"rest","Theta")).mean,S.(sprintf("%s_%s_%s",genre,"task","Theta")).mean,...
        S.(sprintf("%s_%s_%s",genre,"rest","Gamma")).mean,S.(sprintf("%s_%s_%s",genre,"task","Gamma")).mean];
    
    er = errorbar(X,Y,errhigh,errhigh);    
    er.Color = [0 0 0];                            
    er.LineStyle = 'none';
    names = {'Alpha','Betha','Delta','Theta','Gamma'};
    set(gca,'xtick',[1:5],'xticklabel',names)
    legend("Rest","Task",'FontSize',6,'Interpreter','latex')
    title(genre,'FontSize',16,'Interpreter','latex')
    xlabel("$Fequency(Hz)$",'FontSize',12,'Interpreter','latex')
    ylabel("$Power(v^2)$",'FontSize',12,'Interpreter','latex')
    ylim([0 90])
end


end




