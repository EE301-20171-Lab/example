%% This script is for EE301L lab2 Q2. 
% Modified from B. P. Lathi, Linear Systems and Signals, page 232, ex M2.4.
% Modified from Jacob Swanson's lab report.
%
% Destructive and constructive interference by pulse spacing. 
% Wayne Weiyi Chen, 1/25/2017


% Loop for plots with 2 different pulse spacing.
for i=[1,2]
    % Create figure window
    figure(i)
    
    % The pulse width must be large enough to register a y(t) value during
    % constructive interference, and small enough to sufficiently
    % demonstrate destructive interference.
    % you can play around with this parameter.
    dt = 0.01;
    
    %% What do you observe for different value of T
    % Answer this questions: when is the interference constructive, and
    % when is it destructive?
    T = (i/5)*pi;
    x = @(t) heaviside(t)-heaviside(t-dt)...
              +heaviside(t-dt-T)-heaviside(t-dt-T-dt);
    h = @(t) sin(5*t).*heaviside(t);
    dtau = 0.0005;
    
    %% convolution and plot
    tau = -1:dtau:4;
    ti = 0;
    tvec = -1:0.1:4;
    % Pre-allocate memory
    y = NaN*zeros(1,length(tvec));
    for t = tvec
        % Time index
        ti = ti+1;
        xh = x(t-tau).*h(tau);
        lxh = length(xh);
        % trapezoidal approximation of integral
        y(ti) = sum(xh.*dtau);
        subplot(2,1,1), plot(tau,h(tau), 'r-', tau, x(t-tau), 'b--',t,0,'ok');
        axis([tau(1) tau(end) -2.0 2.5]);
        % patch command is used to create the gray-shaded area of convolution
        patch([tau(1:end-1); tau(1:end-1); tau(2:end); tau(2:end)],...
            [zeros(1,lxh-1); xh(1:end-1); xh(2:end);
            zeros(1,lxh-1)],...
            [0.8 0.8 0.8], 'edgecolor','none');
        xlabel('\tau');
        legend('h(\tau)', 'x(t-\tau)','t','h(\tau)x(t-\tau)',3);
        c = get(gca, 'children');
        set(gca,'children', [c(2);c(3);c(4);c(1)]);
        subplot(2,1,2), plot(tvec,y,'k',tvec(ti),y(ti),'ok');
        xlabel('t');
        ylabel('y(t)');
        title('y(t) = \int h(\tau)x(t-\tau) d\tau');
        axis([tau(1) tau(end) -0.1 0.1]);
        grid;
        % drawnow command updates graphics window for each loop iteration
        drawnow;
        % Using the pause command allows one to manually step through the
        % pause;
    end
end