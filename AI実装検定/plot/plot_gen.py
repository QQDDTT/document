# import matplotlib.pyplot as plt
# import seaborn as sns
# import numpy as np
# from sklearn.datasets import load_linnerud
# import pandas as pd

# from sklearn import datasets


# iris = datasets.load_iris()
# iris_data = iris.data

# setosa_data = iris_data[:50]
# versicolor_data = iris_data[50:100]
# virginica_data = iris_data[100:150]

# plt.scatter(setosa_data[:, 0], setosa_data[:, 1], label='Setosa')
# plt.scatter(versicolor_data[:, 0], versicolor_data[:, 1], label='Versicolor')
# plt.scatter(virginica_data[:, 0], virginica_data[:, 1], label='Virginica')
# plt.legend()
# plt.xlabel('Sepal Length (cm)')
# plt.ylabel('Sepal Width (cm)')
# plt.savefig('AI実装検定/plot/iris_scatter_1.png', dpi=300, bbox_inches='tight')

# plt.scatter(setosa_data[:, 2], setosa_data[:, 3], label='Setosa')
# plt.scatter(versicolor_data[:, 2], versicolor_data[:, 3], label='Versicolor')
# plt.scatter(virginica_data[:, 2], virginica_data[:, 3], label='Virginica')
# plt.legend()
# plt.xlabel('Petal Length (cm)')
# plt.ylabel('Petal Width (cm)')


# plt.savefig('AI実装検定/plot/iris_scatter_2.png', dpi=300, bbox_inches='tight')

import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import fetch_california_housing
from sklearn.linear_model import LinearRegression

# 1. 加载数据集 (替代 load_boston)
housing = fetch_california_housing()

# 2. 转换为 DataFrame
# 使用 MedInc (收入中位数) 作为自变量来预测房价
housing_df = pd.DataFrame(housing.data, columns=housing.feature_names)
housing_df['MedHouseVal'] = housing.target

# 3. 准备模型
lr = LinearRegression()

# 4. 提取特征和目标 (类似图片4中提取 RM 和 MEDV 的操作)
# X 必须是二维数组，所以使用双括号 [['MedInc']]
X = housing_df[['MedInc']].values 
Y = housing_df['MedHouseVal'].values

# 5. 模型学习 (fit)
lr.fit(X, Y)

# 6. 可视化结果 (绘图)
plt.figure(figsize=(10, 6))
# 绘制原始数据的散点图
plt.scatter(X, Y, color='blue', alpha=0.5, label='Actual Data')
# 绘制回归预测的直线
plt.plot(X, lr.predict(X), color='red', linewidth=2, label='Regression Line')

plt.xlabel('Median Income')
plt.ylabel('Median House Value')
plt.title('Linear Regression: Income vs House Value')
plt.legend()
plt.savefig('AI実装検定/plot/california_housing_regression.png', dpi=300, bbox_inches='tight')