# 渐进式框架‌

## 渐进式框架‌优点：

- 易于上手：开发者可以从基础功能开始，逐步学习和使用。
- 灵活性：按需引入框架功能，兼容现有代码。
- 降低学习曲线：分阶段学习，逐步掌握高级特性。
- 提升效率：快速构建原型，逐步扩展功能。
- 与其他技术兼容：轻量设计，能与现有技术共存。
- 减少技术债务：避免一开始的大规模重构。
  
# Vue3 安装

## 使用 CDN 方法

```html
<!-- Vue 3 unpkg -->
<script src="https://unpkg.com/vue@next"></script>

<!-- Vue 3 CDN -->
<script src="https://cdn.jsdelivr.net/npm/vue@next"></script>
```


## NPM 方法

```bash
# 最新稳定版
$ npm init vue@latest
```

# Vue3 项目打包

```bash
$ npm run build
```


# Vue3 创建项目

## npm create 命令

```bash
npm create vite@latest <project-name> --template vue
```

## vue ui 命令

```bash
$ vue ui
->  Starting GUI...
->  Ready on http://localhost:8000
...
```

# 项目结构

```bash
my-vue-app/
├── node_modules/                  # 存放项目的所有依赖包，由 npm 或 yarn 自动生成和管理。
├── public/                        # 静态文件目录，里面的文件不会被 Webpack 处理，最终会原样复制到打包目录下。
│   ├── favicon.ico                # 网站图标
│   └── index.html                 # HTML 模板文件，定义了应用的路由规则
├── src/                           # 源码目录，里面的文件会被 Webpack 处理，最终会生成到打包目录下。
│   ├── assets/                    # 静态文件目录，里面的文件会被 Webpack 处理，最终会生成到打包目录下。
│   │   └── logo.png               # 图片文件
│   ├── components/                # 组件目录，里面的文件会被 Webpack 处理，最终会生成到打包目录下。
│   │   └── HelloWorld.vue         # 组件文件
│   ├── views/                     # 视图目录，里面的文件会被 Webpack 处理，最终会生成到打包目录下。
│   │   └── Home.vue               # 默认生成的主页组件。
│   ├── App.vue                    # 根组件，整个应用的入口组件。
│   ├── main.js                    # 应用的入口文件，负责创建 Vue 实例并挂载到 DOM 上。
│   └── router/                    # 路由目录，里面的文件会被 Webpack 处理，最终会生成到打包目录下。
│       └── index.js               # 路由配置文件，定义了应用的路由规则。
├── .gitignore                     # Git 忽略文件，用于指定哪些文件不会被 Git 管理。
├── babel.config.js                # Babel 配置文件，用于配置 Babel 的选项。
├── package.json                   # 项目的依赖、脚本和其他元数据。
├── README.md                      # 项目的说明文档。
├── vue.config.js                  # Vue 配置文件，用于配置 Vue 的选项。
└── yarn.lock or package-lock.json # 项目的依赖锁定文件，用于记录项目的依赖版本。


