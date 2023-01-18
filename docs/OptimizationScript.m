%Iesu Agapito
%ENGI1100H
%10/31/2022
%Finding the maximum volume of open/closed containers given surface area
%Warning: hard to read, but tried to explain in comments.

clc, clear, close all
%Collect Data: Inputs + Volume formulas

SA = input('Surface Area [in^2]: ');
%Error Cases
if SA > 0
else
    disp('Invalid surface area! Please enter a numeric value greater than 0')
    return
end

OpenTopBaseCoef = 1;
ClosedTopBaseCoef = 2;
x = [0:(SA./10000):SA.*100];
Open_Square_V = (SA.*x.^2-OpenTopBaseCoef.*x.^4)./(4.*x);
Closed_Square_V = (SA.*x.^2-ClosedTopBaseCoef.*x.^4)./(4.*x);
Open_Cylinder_V = (SA.*x-OpenTopBaseCoef.*pi.*x.^3)./2;
Closed_Cylinder_V = (SA.*x-ClosedTopBaseCoef.*pi.*x.^3)./2;
Shape_list = ["Open Square", "Open Cylinder","Closed Square","Closed Cylinder"];
V_list = [Open_Square_V;Open_Cylinder_V;Closed_Square_V;Closed_Cylinder_V];

%Generate Solutions: Create vectors of possible volumes for each
%possible container. Create an array that stores the maximum volumes of
%each container in correspondence with the name of the container.

for row = 1:size(V_list, 1)
    [maxV, index] = max(V_list(row,1:size(V_list, 2)));
    Solution_array(row,1:3) = [Shape_list(row);maxV;x(index)];
end

%Refine and Implement: Compare the volumes of the two open containers,
%return the name and value of relating to the maximum volume value f the
%two. Do the same with the closed containers.
maxSqVOpen = str2double(Solution_array(1,2));
maxCyVOpen = str2double(Solution_array(2,2));
maxSqVClosed = str2double(Solution_array(3,2));
maxCyVClosed = str2double(Solution_array(4,2));

maxSqXOpen = str2double(Solution_array(1,3));
maxCyXOpen = str2double(Solution_array(2,3));
maxSqXClosed = str2double(Solution_array(3,3));
maxCyXClosed = str2double(Solution_array(4,3));
if maxSqVOpen > maxCyVOpen
    OpenSolution = "Open Square";
    OpenSolutionValue = maxSqVOpen;
else
    OpenSolution = "Open Cylinder";
    OpenSolutionValue = maxCyVOpen;
end

if maxSqVClosed > maxCyVClosed
    ClosedSolution = "Closed Square";
    ClosedSolutionValue = maxSqVClosed;
elseif maxCyVClosed > maxSqVClosed
    ClosedSolution = "Closed Cylinder";
    ClosedSolutionValue = maxCyVClosed;
end

%Outputs from array containing optimal shape and maximum volume
Solutions = [OpenSolution,OpenSolutionValue;ClosedSolution,ClosedSolutionValue];
fprintf("\nThe optimal open container for surface area %d in^2 is an <strong>%s</strong> with volume<strong> %.1f in^3</strong>. \n",SA,OpenSolution,round(OpenSolutionValue,1));
fprintf("\nThe optimal closed container for surface area %d in^2 is a <strong>%s</strong> with volume<strong> %.1f in^3</strong>. \n",SA,ClosedSolution,round(ClosedSolutionValue,1));
fprintf("\nGraphing...")

%Verify and Test: Plotting 
figure(1);
cla
plot(x, Open_Square_V, 'r');
hold on;
plot(maxSqXOpen, maxSqVOpen, '*');
hold on
plot(x, Open_Cylinder_V, 'b');
hold on
plot(maxCyXOpen, maxCyVOpen, '*');
hold on
axis([0, maxCyXOpen.*10, 0, maxCyVOpen.*1.5]);
xlabel("Side/Radius Length [in]");
ylabel("Volume [in^3]")
title("Volume Vs. Side/Radius Length of Open Top Containers")
legend({'Square Prism [x = side length]', 'Square Prism Max Volume', 'Cylinder [x = radius length]', 'Cylinder Max Volume'})
hold off;

figure(2);
cla
plot(x, Closed_Square_V, 'r')
hold on;
plot(maxSqXClosed, maxSqVClosed, '*');
hold on;
plot(x, Closed_Cylinder_V, 'b');
hold on;
plot(maxCyXClosed, maxCyVClosed, '*')
axis([0, maxCyXClosed.*10, 0, maxCyVClosed.*1.5]);
xlabel("Side/Radius Length [in]");
ylabel("Volume [in^3]");
title("Volume Vs. Side/Radius Length of Closed Top Containers")
legend({'Square Prism [x = side length]', 'Square Prism Max Volume', 'Cylinder [x = radius length]', 'Cylinder Max Volume'})

fprintf("\nThere are notable syntax differences between using the App Designer and a script.\n" +...;
    "Inputs and outputs in apps are displayed to the user through fields while inputs and outputs in scripts are prompted and displayed in the command window.\n"+...
    "Plots in scripts must reference a figure while plots apps must reference a plot component within the app.\n"+...
    "The app UI clears after every run while the command window must be cleared within the script or commands to clear variables and the display.\n")

