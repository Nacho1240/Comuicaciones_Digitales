B = 1;                     % Ancho de banda 

T = 1 / (2 * B);           % Tiempo de símbolo

t = linspace(0, 8*T, 1000);   % T >= 0

f = linspace(-2*B, 2*B, 1000); % Frecuencia 

% Roll-off α 
alpha1 = 0;
alpha2 = 0.25;
alpha3 = 0.75;
alpha4 = 1;

%ALPHA
alpha = alpha4; 

% Respuesta al impulso h(t)
h = zeros(size(t));
for k = 1:length(t)
    if abs(2*alpha*t(k)/T) == 1
        h(k) = alpha / (2*T) * sin(pi/(2*alpha));% importante  
    else
        sinc_part = sin(pi*t(k)/T) / (pi*t(k)/T);
        cos_part = cos(pi*alpha*t(k)/T);
        denom = 1 - (2*alpha*t(k)/T)^2;
        h(k) = sinc_part * cos_part / denom;
    end
end

% Respuesta en frecuencia H(f)
H = zeros(size(f));
f1 = (1 - alpha) * B;
f2 = (1 + alpha) * B;

for k = 1:length(f)
    af = abs(f(k));
    if af < f1
        H(k) = 1;
    elseif af >= f1 && af < f2
        H(k) = 0.5 * (1 + cos(pi * (af - f1) / (2 * alpha * B)));
    else
        H(k) = 0;
    end
end

%Gráficas
figure;

subplot(2,1,1);
plot(t, h, 'LineWidth', 1.5);
title(['Respuesta al impulso h(t), \alpha = ', num2str(alpha)]);
xlabel('t'); ylabel('h(t)');
grid on;

subplot(2,1,2);
plot(f, H, 'LineWidth', 1.5);
title(['Respuesta en frecuencia H(f), \alpha = ', num2str(alpha)]);
xlabel('f'); ylabel('H(f)');
grid on;
