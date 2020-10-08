
clc
clear all
close all

%% Loss Coefficients
f = 0.38; % Percent Open Area of Perf.Plate
k_plate = ((0.707*(1-f).^0.375 + 1 - f).^2).*(1/f.^2);
k_hx = 36;
k_system = (2*k_plate)+k_hx;

%% Given Data
rho = 0.0023769; % Density of Air [slug/ft^3]
CFM = 500:1:3000; % CFM of Blower
B = 1.66667; % [ft] 
W = 2; % [ft]
Area = (B*W); % Tunnel Dimensions [ft^2]
v_fm = ((CFM./ Area)); % Velocity of air [ft/min]
v = v_fm./60; % Velocity of air [ft/s]
% v = v_fm.*0.2; % Velocity of air [in/s]

%% Pressure Calculations
dP_plates = ((2*k_plate).*((rho.*(v.^2))./2)./5.2023)+0.3; % [Inches Water]
dP_plate_hx = (k_plate+k_hx).*((rho.*(v.^2))./2)./5.2023; % [Inches Water]
dP_system = ((k_system).*((rho.*(v.^2))./2)./5.2023) +0.3; % [Inches Water]

%% Plot
figure
plot(CFM,dP_plates,'LineWidth',1.25)
hold on
grid on
plot(CFM,dP_system,'-.','LineWidth',1.25)
title('Pressure Change vs. CFM','FontSize',15)
xlabel('Blower CFM','Fontweight','bold')
ylabel('Pressure Drop [Inches WG]','Fontweight','bold')
legend('Both Perforated Plates','Entire System (Both Plates + HX)','Location','best')
 %