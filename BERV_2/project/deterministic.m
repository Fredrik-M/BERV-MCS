% Solves the deterministic circadian clock model on t = [0, 400] using 
% ode15s and plots solutions for A(t) and R(t). Also plots a comparison of 
% step sizes using ode15s and ode45 on t = [0, 50].

% A  -- activator protein
% R  -- repressor protein
% D  -- activator | repressor gene
% Dp -- activator | repressor gene with A | R bound
% M  -- mRNA
% C  -- inactive complex formed by A and R

% alpha  -- basal transcription rate
% alphaP -- activated transcription rate
% beta   -- translation rate
% delta  -- rate of spontaneous degradation
% gamma  -- rate of binding of A to other components
% theta  -- rate of unbinding of A from other components

% ======================================================================
set(groot, 'DefaultTextInterpreter','latex', 'DefaultLegendInterpreter','latex');
close all;
clear;
% ======================================================================

% parameters
p = importdata('params.mat');

% D_A, D_R, Dp_A, Dp_R, M_A, M_R, A, R, C
y0 = [1, 1, zeros(1, 7)];
tspan = [0, 400];

opts = odeset( ...
    'RelTol', 1e-3, ...
    'AbsTol', 1e-6 ...
    );
% solve with ode15s
f = @(t, y)CO_ODE(t, y, p);
[t, y] = ode15s(f, tspan, y0, opts);

% plot A(t) and R(t)
tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t, y(:,7));
ax2 = nexttile();
plot(t, y(:,8));

xticklabels(ax1, {});
ylabel(ax1, '$A(t)$');
ylabel(ax2, '$R(t)$');
xlabel(ax2, '$t$');

% solve with both ode15s and ode45 for step comparison
tspan = [0, 50];
[t45, y45]   = ode45(f, tspan, y0, opts);
[t15s, y15s] = ode15s(f, tspan, y0, opts);

% plot step sizes
figure();
tl = tiledlayout(2,1, 'TileSpacing','Compact');
ax1 = nexttile();
plot(t45(1:end-1), diff(t45));
ax2 = nexttile();
plot(t15s(1:end-1), diff(t15s));

title(ax1, 'ode45');
title(ax2, 'ode15s');
xticklabels(ax1, {});
ylabel(ax1, '$h(t)$');
ylabel(ax2, '$h(t)$');
xlabel(ax2, '$t$');
