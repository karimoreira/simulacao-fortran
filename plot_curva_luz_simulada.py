import numpy as np
import matplotlib.pyplot as plt

np.random.seed(42)
tempo = np.linspace(0, 10, 300) 

magnitude_base = 12.5 + 0.05 * np.sin(2 * np.pi * tempo / 3) 
ruido = np.random.normal(0, 0.01, tempo.size)
magnitude = magnitude_base + ruido

transito_centro = 5.0  
transito_duracao = 0.3  
transito_profundidade = 0.08  
in_transit = np.abs(tempo - transito_centro) < (transito_duracao / 2)
magnitude[in_transit] += transito_profundidade

erro = np.full_like(magnitude, 0.012)

modelo = 12.5 + 0.05 * np.sin(2 * np.pi * tempo / 3)
modelo[in_transit] += transito_profundidade

plt.figure(figsize=(10,5))
plt.errorbar(tempo, magnitude, yerr=erro, fmt='o', color='#1f77b4', alpha=0.5, label='Observações')
plt.plot(tempo, modelo, color='red', linewidth=2, label='Modelo teórico')
plt.xlabel('Tempo (dias)')
plt.ylabel('Magnitude')
plt.title('Curva de Luz Simulada com Trânsito Planetário')
plt.gca().invert_yaxis()
plt.legend()
plt.tight_layout()
plt.savefig('curva_luz_simulada.png', dpi=150)
plt.show() 