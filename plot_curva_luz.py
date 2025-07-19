import numpy as np
import matplotlib.pyplot as plt

tempo, magnitude, erro = np.loadtxt('dados.txt', unpack=True)

plt.errorbar(tempo, magnitude, yerr=erro, fmt='o', capsize=4, label='Dados observados')
plt.xlabel('Tempo')
plt.ylabel('Magnitude')
plt.title('Curva de Luz')
plt.gca().invert_yaxis() 
plt.legend()
plt.tight_layout()
plt.savefig('curva_luz.png', dpi=150)
plt.show() 