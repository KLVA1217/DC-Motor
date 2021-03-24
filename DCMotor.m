% Program Name: DCMotor.m 
% Author: Ken Leonard V. Aquino 
% Last Modified: 4/17/2019 
% Program Description: A program that emulates a DC Motor in various cases. 

clear,clc,close all % Sets MATLAB on a clean slate 
format short, format compact %formats the output when viewing from command window 

%Given Values based on project 
R=10; 
k=0.1; 
Ke=k; 
Kt=k; 

La=0.5*10^(-3); 
b=0.1; 
J=0.01; 

Tau=La/R; 

%Conversions: 
RAD2DEG=180/pi; 
DegPSec2RPM = 60/(2*pi); 

% Top Graph 
% 
% 

run('Simulink_Project_Case_1b.slx'); %Tells MATLAB to run the following file SimResult1 = sim('Simulink_Project_Case_1b.slx' , 'StopTime' , '10'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays 
SimResult1_Current=SimResult1.Current; 
SimResult1_Position=SimResult1.Position; 
SimResult1_Speed=SimResult1.Speed; 
SimResult1_Step_Source=SimResult1.Step_Source; 
SimResult1_Time=SimResult1.tout;
figure %Tells MATLAB to create a new figure for a graph 

subplot(2,1,1) %Creates a subplot where the following graph will take the spot on top 

title('Graph of Current Output and Voltage Input over Time') %The title of the graph xlabel('Time') %Sets the x label of the graph 
yyaxis left %Sets the scale of the left y axis to that of the Step Source Graph plot(SimResult1_Time, SimResult1_Step_Source, '-b'); %Plots the graph of the Step Source Voltage over time, the plot will be a solid red line. 
ylabel('Voltage Input') %Labels the y axis 
xlim([0, 5*Tau]) % sets the x axis limit 
ylim([-0.1,10.5]) % sets the y axis limit of the Step Source Plot 

yyaxis right %Sets the scale of the right y axis to that of the Step Source Graph plot(SimResult1_Time, SimResult1_Current, '-r'); %Plots the graph of the Current (in Amps) over time, the plot will be a solid blue line. 
ylabel('Current Output') % labels the y axis 
ylim([-0.1,1.1]) %sets the y limit of the Current Plot 
legend('Voltage Input (V)' , 'Current Output (Amps)'); %Creates the legend for the two plots grid on %Turns graph grid 

% Bottom Graph 
% 
% 
subplot(2,1,2) 

yyaxis left 
plot(SimResult1_Time, SimResult1_Speed, '-b'); 
ylabel('Speed (RPM)') 

yyaxis right 
plot(SimResult1_Time, SimResult1_Position, '-r'); 
ylabel('Position (Degrees per Second)') 

legend('Speed (RPM)','Position (Degrees)'); 
title('Graph of Speed(RPM), Position (Degrees)') 
xlabel('Time'); 

grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
CASE2K=0.1; 

%Set Voltage Input of Step Source to 900V 

run('Simulink_Project_Case_2.slx'); %Tells MATLAB to run the following file SimResult2 = sim('Simulink_Project_Case_2.slx' , 'StopTime' , '20'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays
SimResult2_Current=SimResult2.Current; 
SimResult2_Position=SimResult2.Position; 
SimResult2_Speed=SimResult2.Speed; 
SimResult2_Step_Source=SimResult2.Step_Source; 
SimResult2_Time=SimResult2.tout; 

% To confirm that the voltage input is sufficient such that the motor will % move 2.5 revolutions (or 900 degrees) and that the output response is % stable and reaches 2.5 revolutions, exponentially. 

figure 

subplot (2,1,1) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Position, '-b'); 
ylabel('Position (Degrees per Second)') 

ylim([-1 , 930]) 

yyaxis right 
plot(SimResult2_Time, SimResult2_Step_Source, '-r'); 
ylabel('Step Source Voltage (Volts))') 

xlim([-1 , 21]) 
ylim([-1 , 930]) 

legend('Position (Degrees)' , 'Input Voltage (Volts)'); 
title('Graph of Position (Degrees), Step Source Voltage Over Time') xlabel('Time'); 
grid on 

subplot (2,1,2) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Position, '-b'); 
ylabel('Position (Degrees per Second)') 

xlabel('Time'); 

xlim([-1 , 21]) 
ylim([-1 , 930]) 

grid on 

% Case 2 Subplot Graphs 

% Top Graph: Current vs time and Input vs Time
% Bottom Graph: Degree vs Time, and Input vs Time 
% Top Graph: Current vs time and Input vs Time % 
% 
figure 

subplot (2,1,1) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Current, '-b'); ylabel('Output Current (A)') 

yyaxis right 
plot(SimResult2_Time, SimResult2_Step_Source, '-r'); ylabel('Step Source Voltage (Volts))') 

%xlim([-1 , 21]) 
%ylim([-1 , 930]) 

legend('Output Current (A)' , 'Input Voltage (Volts)'); 
title('Output Current (A) and Step Source Voltage Over Time') xlabel('Time'); 
grid on 

% Bottom Graph: Degree vs Time, and Speed vs Time % 
% 

subplot (2,1,2) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Position, '-b'); ylabel('Position (Degrees)') 

%ylim([-1 , 930]) 

yyaxis right 
plot(SimResult2_Time, SimResult2_Speed, '-r'); ylabel('Speed (RPM)') 

%xlim([-1 , 21]) 

legend('Position (Degrees)' , 'Speed (RPM)'); 
title('Position and Speed Over time') 
xlabel('Time');
grid on 

%Graphs for Simulating Different Controller Gains 
% 
% 

inc=1; % Used for incrementing 
figure % Creates a new figure to place a new plot 

for CASE2K= [0.1:0.1:1] %A for loop to iterate through the test cases run('Simulink_Project_Case_2.slx'); %Tells MATLAB to run the following file SimResult2 = sim('Simulink_Project_Case_2.slx' , 'StopTime' , '20'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 
%The code below breaks down the array to the individual variables to create %different arrays 
SimResult2_Current=SimResult2.Current; 
SimResult2_Position=SimResult2.Position; 
SimResult2_Speed=SimResult2.Speed; 
SimResult2_Step_Source=SimResult2.Step_Source; 
SimResult2_Time=SimResult2.tout; 

%Creates a new figure to have 6 graphs per figure 
	if inc==4 
		figure 
		inc=1; 
	end 

subplot (2,3,inc) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Current, '-b'); 
ylabel('Output Current(A)') 

yyaxis right 
plot(SimResult2_Time, SimResult2_Step_Source, '-r'); 
ylabel('Input Voltage (Volts))') 

xlim([-0.1 , 10]) 

legend('Output Current (A)' , 'Input (Volts)'); 
title(['A & V with Gain: ', num2str(CASE2K)]) 
xlabel('Time'); 
grid on
% Bottom Graph: Degree vs Time, and Speed vs Time % 
% 
%inc+3 to have the bottom graphs as the position and speed plots 
subplot (2,3,inc+3) 
yyaxis left 
plot(SimResult2_Time, SimResult2_Position, '-b'); 
ylabel('Position (Degs)') 

yyaxis right 
plot(SimResult2_Time, SimResult2_Speed, '-r'); 
ylabel('Speed (RPM)') 

xlim([-0.1 , 10]) 

legend('Position(Degs)' , 'Speed (RPM)'); 
title(['Pos & Spd with Gain: ' , num2str(CASE2K)]) xlabel('Time'); 
grid on 
%Increments the subplot 
inc=inc+1; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %Set the Step Source Voltage to a Maximum Value of 10 

CASE3K=1;
%Set Voltage Input of Step Source to 10V 

run('Simulink_Project_Case_3.slx'); %Tells MATLAB to run the following file SimResult3 = sim('Simulink_Project_Case_3.slx' , 'StopTime' , '20'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays 
SimResult3_Current=SimResult3.Current; 
SimResult3_Position=SimResult3.Position; 
SimResult3_Speed=SimResult3.Speed; 
SimResult3_Step_Source=SimResult3.Step_Source; 
SimResult3_Time=SimResult3.tout; 

% Confirmation that the System is works as intended 
% 
% 

figure 

yyaxis left 
plot(SimResult3_Time, SimResult3_Speed, '-b'); 
ylabel('Speed (RPM)') 

yyaxis right 
plot(SimResult3_Time, SimResult3_Step_Source, '-r'); 
ylabel('Input Voltage (Volts))') 

xlim([-0.1 , 1]) 

legend('Speed (RPM)' , 'Input (Volts)'); 
title(['Speed and Voltage Input Over Time']) 
xlabel('Time'); 
grid on 

% Below is code that runs simulations various times to test the system at % different gains 
% 
% 

xmin= -0.01; 
xmax= 0.5;
inc=1; 
figure 
for CASE3K= [1:1500/12:1500] 
	run('Simulink_Project_Case_3.slx'); %Tells MATLAB to run the following file SimResult3 = sim('Simulink_Project_Case_3.slx' , 'StopTime' , '5'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 
	%The code below breaks down the array to the individual variables to create %different arrays 
	SimResult3_Current=SimResult3.Current; 
	SimResult3_Position=SimResult3.Position; 
	SimResult3_Speed=SimResult3.Speed; 
	SimResult3_Step_Source=SimResult3.Step_Source; 
	SimResult3_Time=SimResult3.tout; 
	
	if inc==4 
		figure 
		inc=1; 
	end 
	
	subplot (2,3,inc) 
	yyaxis left 
	plot(SimResult3_Time, SimResult3_Current, '-b'); 
	ylabel('Output Current(A)') 

	yyaxis right 
	plot(SimResult3_Time, SimResult3_Step_Source, '-r'); 
	ylabel('Input Voltage (Volts)') 

	xlim([xmin , xmax]) 
	legend('Output Current (A)' , 'Input (Volts)'); 
	title(['A & V with Gain: ', num2str(CASE3K)]) 
	xlabel('Time'); 
	grid on 

	% Bottom Graph: Degree vs Time, and Speed vs Time 
	% 
	% 
	subplot (2,3,inc+3) 
	yyaxis left 
	plot(SimResult3_Time, SimResult3_Position, '-b'); 
	ylabel('Position (Degs)')
	yyaxis right 
	plot(SimResult3_Time, SimResult3_Speed, '-r'); ylabel('Speed (RPM)') 
	
	xlim([xmin , xmax]) 
	
	legend('Position(Degs)' , 'Speed (RPM)'); title(['Pos & Spd with Gain: ' , num2str(CASE3K)]) 
	xlabel('Time'); 
	grid on 
	
	inc=inc+1; 
end

clear,clc,close all % Sets MATLAB on a clean slate 
format short, format compact %formats the output when viewing from command window 

%Given Values based on project 
R=10; 
k=0.1; 
Ke=k; 
Kt=k; 

La=0.5*10^(-3); 
b=0.1; 
J=0.01; 

Tau=La/R; 

%Conversions: 
RAD2DEG=180/pi; 
DegPSec2RPM = 60/(2*pi);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %Set the Step Source Voltage to a Maximum Value of 10 
%Need to Adjust the controller Gain such that Time Constant of Position %Plot Tau is less than 0.2 seconds 

CASE4K=100; 

run('Simulink_Project_Case_4.slx'); %Tells MATLAB to run the following file SimResult4 = sim('Simulink_Project_Case_4.slx' , 'StopTime' , '30'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays 
SimResult4_Current=SimResult4.Current; 
SimResult4_Position=SimResult4.Position; 
SimResult4_Speed=SimResult4.Speed; 
SimResult4_Step_Source=SimResult4.Step_Source; 
SimResult4_Time=SimResult4.tout; 

% Confirmation that the System is Works as Intended 
% Verify that Time constant of Position Plot is <0.2 Seconds and that the % output response (Position) is stable and reaches a steady state value % 

figure 

yyaxis left 
plot(SimResult4_Time, SimResult4_Position, '-b'); 
ylabel('Position (Degrees)') 

xlim([0,1.2]); 
ylim([-1,11]) 
yyaxis right 
plot(SimResult4_Time, SimResult4_Step_Source, '-r'); 
ylabel('Input Voltage (Volts)') 

xlim([0,1.2]); 

legend('Position (Degrees)' , 'Input Voltage (Volts)'); 
title(['Position and Voltage Input Over Time with Gain= ' , num2str(CASE4K)])
xlabel('Time'); 
grid on 

%Case 4 Graphs 
% 
% 
run('Simulink_Project_Case_4.slx'); %Tells MATLAB to run the following file SimResult4 = sim('Simulink_Project_Case_4.slx' , 'StopTime' , '30'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays 
SimResult4_Current=SimResult4.Current; 
SimResult4_Position=SimResult4.Position; 
SimResult4_Speed=SimResult4.Speed; 
SimResult4_Step_Source=SimResult4.Step_Source; 
SimResult4_Time=SimResult4.tout; 

xmin=0; 
xmax=2; 

% Top Graph: Current and Voltage Over Time 
% 
% 

figure 
subplot(2,1,1) 
yyaxis left 
plot(SimResult4_Time, SimResult4_Current, '-b'); 
ylabel('Current (Amps)') 

xlim([xmin,xmax]); 

yyaxis right 
plot(SimResult4_Time, SimResult4_Step_Source, '-r'); 
ylabel('Input Voltage (Volts)') 

xlim([xmin,xmax]); 

legend('Current (Amps)' , 'Input Voltage (Volts)'); 
title('Current and Voltage Input Over Time') 
xlabel('Time'); 
grid on

% Bottom Graph: Position and Speed Over Time 
% 
% 

subplot(2,1,2) 

yyaxis left 
plot(SimResult4_Time, SimResult4_Position, '-b'); 
ylabel('Position (Degrees)') 

xlim([xmin,xmax]); 
ylim([-1,11]) 

yyaxis right 
plot(SimResult4_Time, SimResult4_Speed, '-r'); 
ylabel('Speed (RPM)') 

xlim([xmin,xmax]); 

legend('Position (Degrees)' , 'Speed (RPM)'); 
title('Position and Speed Over Time') 
xlabel('Time'); 
grid on 

% To Test for Different Gains 
% 
% 

RunMultGainSims=0;%When set to run will run the code to run multiple simulations with different gains 

if RunMultGainSims==1 
	inc=1; 
	figure 

	%Variables used for running the multiple simulations 
	K4Start=0.1; 
	K4End=1000; 
	NumOfSubplots=3; 
	NumOfGraphs=NumOfSubplots*3; 
	K4Inc=K4End/NumOfGraphs; 

	for CASE4K = K4Start:K4Inc:K4End 
		%Set Voltage Input of Step Source to 10V
		if inc==4 
		figure 
		inc=1; 
		end 

		run('Simulink_Project_Case_4.slx'); %Tells MATLAB to run the following file SimResult4 = sim('Simulink_Project_Case_4.slx' , 'StopTime' , '10'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

		%The code below breaks down the array to the individual variables to create %different arrays 
		SimResult4_Current=SimResult4.Current; 
		SimResult4_Position=SimResult4.Position; 
		SimResult4_Speed=SimResult4.Speed; 
		SimResult4_Step_Source=SimResult4.Step_Source; 
		SimResult4_Time=SimResult4.tout; 

		if inc==4 
			figure 
			inc=1; 
		end 

		subplot (2,3,inc) 
		yyaxis left 
	
		plot(SimResult4_Time, SimResult4_Current, '-b'); 
		ylabel('Output Current(A)') 

		yyaxis right 
		plot(SimResult4_Time, SimResult4_Step_Source, '-r'); 
		ylabel('Input Voltage (Volts)') 

		legend('Output Current (A)' , 'Input (Volts)'); 
		title(['A & V with Gain: ', num2str(CASE4K)]) 
		xlabel('Time'); 
		grid on 

		% Bottom Graph: Degree vs Time, and Speed vs Time 
		% 
		% 

		subplot (2,3,inc+3) 
		yyaxis left 
		plot(SimResult4_Time, SimResult4_Position, '-b'); 
		ylabel('Position (Degs)')
		yyaxis right 
		plot(SimResult4_Time, SimResult4_Speed, '-r'); ylabel('Speed (RPM)') 
		legend('Position(Degs)' , 'Speed (RPM)'); title(['Pos & Spd with Gain: ' , num2str(CASE4K)]) 
		xlabel('Time'); 
		grid on 
		inc=inc+1; 
	end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CASE5K=100; 
run('Simulink_Project_Case_5.slx'); %Tells MATLAB to run the following file SimResult5 = sim('Simulink_Project_Case_5.slx' , 'StopTime' , '10'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %different arrays 
SimResult5_Current=SimResult5.Current; 
SimResult5_Position=SimResult5.Position; 
SimResult5_Speed=SimResult5.Speed; 
SimResult5_Step_Source=SimResult5.Step_Source; 
SimResult5_Time=SimResult5.tout; 

figure; 

subplot (2,1,1) 
yyaxis left 
plot(SimResult5_Time, SimResult5_Current, '-b'); 
ylabel('Output Current(A)')

yyaxis right 
plot(SimResult5_Time, SimResult5_Step_Source, '-r'); ylabel('Input Voltage (Volts)') 

legend('Output Current (A)' , 'Input (Volts)'); title(['A & V with Gain: ', num2str(CASE5K)]) xlabel('Time'); 
grid on 

% Bottom Graph: Degree vs Time, and Speed vs Time % 
% 

subplot (2,1,2) 
yyaxis left 

plot(SimResult5_Time, SimResult5_Position, '-b'); ylabel('Position (Degs)') 

yyaxis right 
plot(SimResult5_Time, SimResult5_Speed, '-r'); ylabel('Speed (RPM)') 
legend('Position(Degs)' , 'Speed (RPM)'); title(['Pos & Spd with Gain: ' , num2str(CASE5K)]) 
xlabel('Time'); 
grid on 

% To Test Multiple Gains 
% 
% 

RunMultGainSims=1; 
if RunMultGainSims==1 
	inc=1; 
	figure 
	
	K5Start=0.1; 
	K5End=1000; 
	NumOfSubplots=3; 
	NumOfGraphs=NumOfSubplots*3; 
	K5Inc=K5End/NumOfGraphs;

	for CASE5K = K5Start:K5Inc:K5End 
		%Set Voltage Input of Step Source to 10V 
		if inc==4 
			figure 
			inc=1; 
		end 

		run('Simulink_Project_Case_5.slx'); %Tells MATLAB to run the following file SimResult5 = sim('Simulink_Project_Case_5.slx' , 'StopTime' , '10'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

		%The code below breaks down the array to the individual variables to create %different arrays 
		SimResult5_Current=SimResult5.Current; 
		SimResult5_Position=SimResult5.Position; 
		SimResult5_Speed=SimResult5.Speed; 
		SimResult5_Step_Source=SimResult5.Step_Source; 
		SimResult5_Time=SimResult5.tout; 

		if inc==4 
			figure 
			inc=1; 
		end 

		subplot (2,3,inc) 
		yyaxis left 
		plot(SimResult5_Time, SimResult5_Current, '-b'); 
		ylabel('Output Current(A)') 

		yyaxis right 
		plot(SimResult5_Time, SimResult5_Step_Source, '-r'); 
		ylabel('Input Voltage (Volts)') 

		legend('Output Current (A)' , 'Input (Volts)'); 
		title(['A & V with Gain: ', num2str(CASE5K)]) 
		xlabel('Time'); 
		grid on 

		% Bottom Graph: Degree vs Time, and Speed vs Time 
		% 
		% 
		subplot (2,3,inc+3)
		yyaxis left 
		plot(SimResult5_Time, SimResult5_Position, '-b'); ylabel('Position (Degs)') 

		yyaxis right 
		plot(SimResult5_Time, SimResult5_Speed, '-r'); ylabel('Speed (RPM)') 

		legend('Position(Degs)' , 'Speed (RPM)'); title(['Pos & Spd with Gain: ' , num2str(CASE5K)]) xlabel('Time'); 
		grid on 

		inc=inc+1; 
	end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Case 6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %Voltage Inut at 15 Volts 

CASE6K=1/10; 

run('Simulink_Project_Case_6.slx'); %Tells MATLAB to run the following file SimResult6 = sim('Simulink_Project_Case_6.slx' , 'StopTime' , '10'); % Tells MATLAB to run the simulation and put the results of the simulink in the 'SimResult1' array 

%The code below breaks down the array to the individual variables to create %differrent arrays 
SimResult6_Current=SimResult6.Current; 
SimResult6_Position=SimResult6.Position; 
SimResult6_Speed=SimResult6.Speed; 
SimResult6_Step_Source=SimResult6.Step_Source; 
SimResult6_Time=SimResult6.tout; 

% Plot to verify that the system works as intended
% 
% 
figure 

yyaxis left 
plot(SimResult6_Time, SimResult6_Position, '-b'); ylabel('Position (Degrees)') 

xlim([0.1,10]) 
ylim([0.1,16]) 

yyaxis right 
plot(SimResult6_Time, SimResult6_Step_Source, '-r'); ylabel('Input Voltage (Volts)') 

xlim([0.1,10]) 
ylim([0.1,16]) 

legend('Position (Degrees)' , 'Input Voltage (Volts)'); title('Position and Voltage Input Over Time') 
xlabel('Time'); 
grid on 

figure; 

subplot (2,1,1) 
yyaxis left 
plot(SimResult6_Time, SimResult6_Current, '-b'); ylabel('Output Current(A)') 

yyaxis right 
plot(SimResult6_Time, SimResult6_Step_Source, '-r'); ylabel('Input Voltage (Volts)') 

legend('Output Current (A)' , 'Input (Volts)'); title('Output Current and Input Voltage Over Time') 
xlabel('Time'); 
grid on 

% Bottom Graph: Degree vs Time, and Speed vs Time % 
% 

subplot (2,1,2) 
yyaxis left
plot(SimResult6_Time, SimResult6_Position, '-b'); 
ylabel('Position (Degs)') 

yyaxis right 
plot(SimResult6_Time, SimResult6_Speed, '-r'); 
ylabel('Speed (RPM)') 

legend('Position(Degs)' , 'Speed (RPM)'); title('Position and Speed over Time') 
xlabel('Time'); 
grid on