import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

x = np.linspace(0, 10, 40)
plt.plot(x, np.sin(x), marker='o', linestyle='-')

plt.savefig('AI実装検定/plot/sin_3.png', dpi=300, bbox_inches='tight')