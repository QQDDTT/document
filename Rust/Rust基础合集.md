# Rust 命令

```bash
rustc xx.rs # 编译 xx 文件

# 生成可执行文件 xx

./xx # 运行可执行文件
```

# Rust 基础语法

```rust
let a = 123;       // 不可变变量
let mut b = 10;  // 可变变量
const a：i32 = 123; // 常量
```

# Rust 运算符

1. 算术运算符

| 运算符 | 说明 |
| --- | --- |
| + | 加法 |
| - | 减法 |
| * | 乘法 |
| / | 除法（整除） |
| % | 取余 |

2. 关系运算符

| 运算符 | 说明 |
| --- | --- |
| == | 相等 |
| != | 不相等 |
| > | 大于 |
| < | 小于 |
| >= | 大于等于 |
| <= | 小于等于 |

3. 逻辑运算符

| 运算符 | 说明 |
| --- | --- |
| && | 辑与（AND） |
| \|\| | 逻辑或（OR） |
| ! | 逻辑非（NOT） |

4. 位运算符

| 运算符 | 说明 |
| --- | --- |
| & | 按位与 |
| \| | 按位或 |
| ^ | 按位异或 |
| ! | 按位取反 |
| << | 左移 |
| >> | 右移 |

5. 赋值与复合赋值运算符

| 运算符 | 说明 |
| --- | --- |
| = |	赋值 |
| += |	加并赋值 |
| -= |	减并赋值 |
| *= |	乘并赋值 |
| /= |	除并赋值 |
| %= |	取余并赋值 |
| &= \|= ^= <<= >>= | 位运算复合赋值 |

6. 其他常见运算符

| 运算符 | 说明 | 示例 |
| --- | --- | --- |
| .. | 范围（不含右端） | 0..5 产生 0 到 4 |
| ..= |	范围（含右端） | 0..=5 产生 0 到 5 |
| as | 类型转换 | 5 as f32 |
| ? | 错误传播（在 Result 中） | some()?; |
| * | 解引用 | *ptr |
| & | 取引用 | &x |
| ref |	绑定为引用 | let ref y = x; |

# Rust 数据类型

- 整数型（Integer）

| 位长度 | 有符号 |	无符号 |
| --- | --- | --- |
| 8-bit | i8 | u8 |
| 16-bit | i16 | u16 |
| 32-bit | i32 | u32 |
| 64-bit | i64 | u64 |
| 128-bit |	i128 | u128 |
| arch | isize | usize |

| 进制 | 例 |
| --- | --- |
| 十进制 | 98_222 |
| 十六进制 | 0xff |
| 八进制 | 0o77 |
| 二进制 | 0b1111_0000 |
| 字节(只能表示 u8 型) | b'A' |

# 浮点数型（Floating-Point）

- Rust 与其它语言一样支持 32 位浮点数（f32）和 64 位浮点数（f64）。默认情况下，64.0 将表示 64 位浮点数。

# 布尔型

- 布尔型用 bool 表示，值只能为 true 或 false。

# 字符型

- 字符型用 char 表示。

# 复合类型

- 元组是用一对 ( ) 包括的一组数据，可以包含不同种类的数据：

```rust
let tup: (i32, f64, u8) = (500, 6.4, 1);
// tup.0 等于 500
// tup.1 等于 6.4
// tup.2 等于 1
let (x, y, z) = tup;
// y 等于 6.4
```

- 数组用一对 [ ] 包括的同类型数据。

```rust
let a = [1, 2, 3, 4, 5];
// a 是一个长度为 5 的整型数组

let b = ["January", "February", "March"];
// b 是一个长度为 3 的字符串数组

let c: [i32; 5] = [1, 2, 3, 4, 5];
// c 是一个长度为 5 的 i32 数组

let d = [3; 5];
// 等同于 let d = [3, 3, 3, 3, 3];

let first = a[0];
let second = a[1];
// 数组访问

a[0] = 123; // 错误：数组 a 不可变
let mut a = [1, 2, 3];
a[0] = 4; // 正确
```

# Rust 注释 

```rust
// 这是第一种注释方式

/* 这是第二种注释方式 */ 

/* 
 * 多行注释
 * 多行注释
 * 多行注释
 */
 ```

 - 用于说明文档的注释 

 ```rust
 /// Adds one to the number given. 
/// 
/// # Examples 
/// 
/// ``` 
/// let x = add(1, 2); 
/// 
/// ``` 

fn add(a: i32, b: i32) -> i32 { 
    return a + b; 
} 
    
fn main() { 
    println!("{}",add(2,3)); 
}
```


# Rust 函数

fn <函数名> ( <参数> ) <函数体>

```rust
fn main() {
    println!("Hello, world!");
    another_function();
}

fn another_function() {
    println!("Hello, runoob!");
}
```

- 函数返回值

```rust
fn add(a: i32, b: i32) -> i32 {
    return a + b;
}
```

# Rust 条件语句 
```rust
fn main() {
    let number = 3; 
    if number < 5 { 
        println!("条件为 true"); 
    } else { 
        println!("条件为 false"); 
    } 
}
```

# Rust 循环

- while 循环 

```rust
let mut number = 1; 
while number != 4 { 
    println!("{}", number); 
    number += 1; 
} 
println!("EXIT"); 
```

- for 循环

```rust
let a = [10, 20, 30, 40, 50]; 
for i in a.iter() { 
    println!("值为 : {}", i); 
} 
```

- loop 循环

```rust
let s = ['R', 'U', 'N', 'O', 'O', 'B']; 
let mut i = 0; 
loop { 
    let ch = s[i]; 
    if ch == 'O' { 
        break; 
    } 
    println!("\'{}\'", ch);
    i += 1; 
} 
```