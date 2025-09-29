 - 扩展(逻辑注入模块)
 逻辑解析模块[用于解释或编译用户脚本]，设计中...
 流程 1[调查并选择合适的脚本语言（JavaScript...）]
 流程 2[根据选择的脚本语言设计接口]
 流程 3[根据设计的接口，制作简单的测试脚本]
 流程 4[根据设计的接口，设计和制作脚本文件的解释器]
 流程 5[测试解释器，并添加必要的提示信息]
 流程 6[调试，修正]


```cpp
#include "quickjs.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <filesystem>

// C++ 里的加法函数，供 JavaScript 调用
// 该函数的参数包括：
// ctx - JavaScript 上下文
// this_val - this 关键字的值（未使用）
// argc - 传入参数个数
// argv - 传入参数数组
JSValue js_add(JSContext *ctx, JSValueConst this_val, int argc, JSValueConst *argv) {
    int a, b;
    // 将 JavaScript 传入的第一个参数转换为 C++ int 类型
    JS_ToInt32(ctx, &a, argv[0]);
    // 将 JavaScript 传入的第二个参数转换为 C++ int 类型
    JS_ToInt32(ctx, &b, argv[1]);
    // 返回两个整数的和，封装成 JSValue
    return JS_NewInt32(ctx, a + b);
}

// 创建一个复杂对象并注入到 JavaScript 全局作用域
JSValue create_complex_object(JSContext *ctx) {
    // 创建一个 JavaScript 对象
    JSValue obj = JS_NewObject(ctx);
    // 设置对象的属性 name = "QuickJS"
    JS_SetPropertyStr(ctx, obj, "name", JS_NewString(ctx, "QuickJS"));
    // 设置对象的属性 version = 1.0
    JS_SetPropertyStr(ctx, obj, "version", JS_NewFloat64(ctx, 1.0));
    return obj;
}
```

```cpp
#include "quickjs.h"

// 创建一个 Map 对象并注入到 JavaScript 全局作用域
JSValue create_complex_map(JSContext *ctx) {
    // 获取 Map 构造函数
    JSValue map_ctor = JS_GetPropertyStr(ctx, JS_GetGlobalObject(ctx), "Map");
    if (JS_IsUndefined(map_ctor) || JS_IsException(map_ctor)) {
        return JS_EXCEPTION; // 如果获取失败，返回异常
    }

    // 创建 Map 实例
    JSValue map_obj = JS_CallConstructor(ctx, map_ctor, 0, nullptr);
    JS_FreeValue(ctx, map_ctor);
    if (JS_IsException(map_obj)) {
        return JS_EXCEPTION; // 如果创建失败，返回异常
    }

    // 设置 Map 的键值对
    JSValue key1 = JS_NewString(ctx, "name");
    JSValue value1 = JS_NewString(ctx, "QuickJS");
    JSValue key2 = JS_NewString(ctx, "version");
    JSValue value2 = JS_NewFloat64(ctx, 1.0);

    JSValue args1[] = {key1, value1};
    JSValue args2[] = {key2, value2};

    JS_Invoke(ctx, map_obj, JS_NewAtom(ctx, "set"), 2, args1);
    JS_Invoke(ctx, map_obj, JS_NewAtom(ctx, "set"), 2, args2);

    // 释放不再需要的值
    JS_FreeValue(ctx, key1);
    JS_FreeValue(ctx, value1);
    JS_FreeValue(ctx, key2);
    JS_FreeValue(ctx, value2);

    return map_obj;
}


// 读取 JavaScript 文件内容
std::string read_script_from_file(const std::string &filename) {
    std::filesystem::path project_root = std::filesystem::current_path(); // 获取当前工作目录
    std::filesystem::path file_path = project_root / "js" / filename; // 组合路径

    std::ifstream file(file_path);
    std::stringstream buffer;
    if (file) {
        buffer << file.rdbuf();
        file.close();
    }
    return buffer.str();
}
```

```cpp
int main() {
    // 创建 QuickJS 运行时
    JSRuntime *rt = JS_NewRuntime();
    // 创建 JavaScript 上下文
    JSContext *ctx = JS_NewContext(rt);

    // 获取全局对象（相当于 JavaScript 里的 `globalThis`）
    JSValue global = JS_GetGlobalObject(ctx);
    // 在全局对象中注册 `add` 函数，使 JavaScript 可以调用它
    JS_SetPropertyStr(ctx, global, "add", JS_NewCFunction(ctx, js_add, "add", 2));
    
    // 创建并注册复杂对象
    JSValue complex_obj = create_complex_object(ctx);
    JS_SetPropertyStr(ctx, global, "config", complex_obj);

    // 读取 JavaScript 文件
    std::string script = read_script_from_file("script.js");
    
    // 执行 JavaScript 代码
    JSValue result = JS_Eval(ctx, script.c_str(), script.length(), "script.js", JS_EVAL_TYPE_GLOBAL);

    int32_t int_result;
    // 将 JavaScript 计算结果转换为 C++ int 并输出
    if (JS_ToInt32(ctx, &int_result, result) == 0) {
        std::cout << "JS 调用 C++ 返回结果: " << int_result << std::endl;
    }

    // 释放 JSValue 资源，避免内存泄漏
    JS_FreeValue(ctx, result);
    JS_FreeValue(ctx, complex_obj);
    JS_FreeValue(ctx, global);
    // 释放上下文和运行时
    JS_FreeContext(ctx);
    JS_FreeRuntime(rt);
    return 0;
}
```