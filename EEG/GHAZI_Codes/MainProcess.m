clc
clear
filename = "Ghavam_clean.txt";
data = readtable(filename);
data = table2array(data);
data = data';
% analysis - average of channels

Fs = 500;

% Ghavam

Max = max(data(1:19,:),[],2);
MaxMat = repmat(Max,1,length(data(1,:)));

data = data(1:19,:)./MaxMat;
data = mean(data,1);
%Opera

index1 = 0;
index1 = index1 + 1;
index2 = index1 + 5*60*500+52*500;
part1 = data(1,index1:index2);

%rock
index1 = index2 + 2*60*500 + 1;
index2 = index1 + (6*60+6)*500;
part2 = data(1,index1:index2);

%pop
index1 = index2 + 2*60*500 + 1;
index2 = index1 + (6*60+20)*500;
part3 = data(1,index1:index2);

%rap
index1 = index2 + 2*60*500 + 1;
index2 = index1 + (6*60+20)*500;
part4 = data(1,index1:index2);

%jazz
index1 = index2 + 2*60*500 + 1;
index2 = index1 + (6*60)*500;
part5 = data(1,index1:index2);


my_bandpower(part1,'Opera')
my_bandpower(part2,'Rock')
my_bandpower(part3,'Pop')
my_bandpower(part4,'Rap')
my_bandpower(part5,'Jazz')


%% Questionnaire
 clc
 clear
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
 
 for i = 1 : 5
     temp = Q.(sprintf("Q%i",i));
     [row,col] = find(temp<0);
     temp(row,col) = -1;
     [row,col] = find(temp>0);
     temp(row,col) = 1;
     Q_maped.(sprintf("Q%i",i)) = temp(2:end,:);
 end
 temp = zeros(5,3);
 pop_inc = [0,0,0];
 pop_dec = [0,0,0];
 jazz_inc = [0,0,0];
 jazz_dec = [0,0,0];
 rock_inc = [0,0,0];
 rock_dec = [0,0,0];
 opera_inc = [0,0,0];
 opera_dec = [0,0,0];
 rap_inc = [0,0,0];
 rap_dec = [0,0,0];
 
 for i = 1 : 5
     temp = Q_maped.(sprintf("Q%i",i));
     
     for j = 1:3
         
         if(temp(1,j)>0)
           opera_inc(j) = opera_inc(j) +1; 
         end
         if(temp(1,j)<0)
           opera_dec(j) = opera_dec(j) +1 ; 
         end


         if(temp(2,j)>0)
           rock_inc(j) = rock_inc(j) +1  ;
         end
         if(temp(2,j)<0)
           rock_dec(j) = rock_dec(j) +1  ;
         end

         if(temp(3,j)>0)
           pop_inc(j) = pop_inc(j) +1  ;
         end
         if(temp(3,j)<0)
           pop_dec(j) = pop_dec(j) +1  ;
         end

         if(temp(4,j)>0)
           rap_inc(j) = rap_inc(j) +1 ; 
         end
         if(temp(4,j)<0)
           rap_dec(j) = rap_dec(j) +1  ;
         end

         if(temp(5,j)>0)
           jazz_inc(j) = jazz_inc(j) +1;  
         end
         if(temp(5,j)<0)
           jazz_dec(j) = jazz_dec(j) +1  ;
         end
     
     end
     
 end

 pop_inc = pop_inc/5*100;
 pop_dec = pop_dec/5*100;
 jazz_inc = jazz_inc/5*100;
 jazz_dec = jazz_dec/5*100;
 rock_inc = rock_inc/5*100;
 rock_dec = rock_dec/5*100;
 opera_inc = opera_inc/5*100;
 opera_dec = opera_dec/5*100;
 rap_inc = rap_inc/5*100;
 rap_dec = rap_dec/5*100;
 
 for i = 1 : 5
     temp = Q_maped.(sprintf("Q%i",i)) + temp;
 end
 Qmaped_total = temp/5;
 
 Corr12 = corr(Q1D,Q2D);
 Corrs = [];
 CoorsforTable = ones(5);
 for i = 1:4
     
     for j = i+1:5
         a = (Q.(sprintf("Q%i",i)));
         b = (Q.(sprintf("Q%i",j)));
         a(1,:) = [];
         b(1,:) = [];
         a = a;
         b = b;
         S_Corr.(sprintf("Corr%i%i",i,j)) = corrcoef(a,b,'rows','complete');
         temp = S_Corr.(sprintf("Corr%i%i",i,j));
         Corrs = [Corrs temp(1,2)];
         CoorsforTable(i,j) = temp(1,2);
         CoorsforTable(j,i) = temp(1,2);
     end
     
 end
 S_Corr.Corrs = Corrs;
 S_Corr.VarOfCorrs = var(Corrs);
 S_Corr.average = mean(Corrs);
 name = {'Subject1','Subject2','Subject3','Subject4','Subject5'};
 Rowname = {'Subject1';'Subject2';'Subject3';'Subject4';'Subject5'};
 CorrsTable = array2table(CoorsforTable,'VariableNames',name,'RowNames',Rowname);
%% Functions

function my_bandpower(Signal,Title)
Delta = [0.05,3];
Theta = [4,7];
Alpha = [8,12];
Beta = [12,30];
Gamma = [30,70];

Power_rest_Delta = bandpower(Signal(1:3*60*500),500,Delta)
Power_rest_Theta = bandpower(Signal(1:3*60*500),500,Theta)
Power_rest_Alpha = bandpower(Signal(1:3*60*500),500,Alpha)
Power_rest_Beta = bandpower(Signal(1:3*60*500),500,Beta)
Power_rest_Gamma = bandpower(Signal(1:3*60*500),500,Gamma)

Power_task_Delta = bandpower(Signal(3*60*500+1:end),500,Delta)
Power_task_Theta = bandpower(Signal(3*60*500+1:end),500,Theta)
Power_task_Alpha = bandpower(Signal(3*60*500+1:end),500,Alpha)
Power_task_Beta = bandpower(Signal(3*60*500+1:end),500,Beta)
Power_task_Gamma = bandpower(Signal(3*60*500+1:end),500,Gamma)


figure
% task
X = categorical({'Delta','Theta','Alpha','Beta','Gamma'});
X = reordercats(X,{'Delta','Theta','Alpha','Beta','Gamma'});
Y = [Power_task_Delta-Power_rest_Delta, Power_task_Theta-Power_rest_Theta, Power_task_Alpha-Power_rest_Alpha, Power_task_Beta-Power_rest_Beta, Power_task_Gamma-Power_rest_Gamma];
bar(X,Y,'b')

ylabel("Power",'FontSize',12,'Interpreter','latex')
xlabel("Freqeuncy Components",'FontSize',12,'Interpreter','latex')

title(Title+"(Diffrence of task and rest)",'FontSize',15,'Interpreter','latex')

end




