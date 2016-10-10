function plotGraficoFacil(valoresEixoX,valoresEixoY,legenda,titulo)
plot(valoresEixoX,valoresEixoY);
title(titulo);
xlabel('q(\theta,\lambda)');
ylabel('Intensidade');
legend(legenda)
grid on
end