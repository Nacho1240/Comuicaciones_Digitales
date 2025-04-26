alpha1 = 0;
alpha2 = 0.25;
alpha3 = 0.75;
alpha4 = 1;

sps = 16;         
span = 4;  
snr = 30;        

% Generar bits y señal NRZ
bits = randi([0 1], 1, 10000);
nrzl = 2*bits - 1;  % Convertir a ±1

% Upsample una vez (compartido para todos los alfas)
nrz_upsampled = upsample(nrzl, sps);

% Lista de alfas a evaluar
alfas = [alpha1, alpha2, alpha3, alpha4];

% Generar diagramas de ojo para cada alfa
for alpha = alfas
    % Diseñar filtro coseno elevado
    rcFilter = rcosdesign(alpha, span, sps, 'normal');
    
    % Filtrar la señal
    tx_signal = conv(nrz_upsampled, rcFilter, 'same');
    
    % Añadir ruido
    tx_signal_ruidosa = awgn(tx_signal, snr, 'measured');
    
    % Mostrar diagrama de ojo
    figure;
    eyediagram(tx_signal_ruidosa, 2*sps);
    title(['Diagrama de Ojo con \alpha = ', num2str(alpha)]);
end
