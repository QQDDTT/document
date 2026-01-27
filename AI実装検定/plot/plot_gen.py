import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

plt.scatter(
    np.random.randn(100),
    np.random.randn(100),
    c=np.random.randn(100),
    s=np.random.randn(100) * 200,
    alpha=0.5
)

plt.savefig('AI実装検定/plot/sin_3.png', dpi=300, bbox_inches='tight')