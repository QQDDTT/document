# Rust 迭代器 

```rust
pub trait Iterator {
    type Item;
    
    fn next(&mut self) -> Option<Self::Item>;
    
    // 其他默认实现的方法如 map, filter 等。
}
```

## 迭代器遵循以下原则：

- 惰性求值 (Laziness)：Rust 中的迭代器是惰性的，意味着迭代器本身不会立即进行任何计算或操作，直到你显式地请求数据。这使得迭代器在性能上表现良好，可以避免不必要的计算。

- 所有权和借用检查 (Ownership and Borrowing Checks)：Rust 迭代器严格遵守所有权和借用规则，避免数据竞争和内存错误。迭代器的生命周期与底层数据相关联，确保数据的安全访问。

- 链式调用 (Chaining)：Rust 迭代器支持链式调用，即可以将多个迭代器方法链接在一起进行组合操作，这使得代码简洁且具有高度可读性。例如，通过使用 .map()、.filter()、.collect() 等方法，可以创建复杂的数据处理流水线。

- 高效内存管理 (Efficient Memory Management)：迭代器避免了不必要的内存分配，因为大多数操作都是惰性求值的，并且在使用时直接进行遍历操作。这对于处理大数据集合尤其重要。

- 抽象和通用性 (Abstraction and Generality)：Rust 的迭代器通过 Iterator trait 实现抽象和通用性。任何实现了 Iterator trait 的类型都可以在不同的上下文中作为迭代器使用。此设计提高了代码的重用性和模块化。

## 创建迭代器

- map()：对每个元素应用给定的转换函数。
- filter()：根据给定的条件过滤集合中的元素。
- fold()：对集合中的元素进行累积处理。
- skip()：跳过指定数量的元素。
- take()：获取指定数量的元素。
- enumerate()：为每个元素提供索引。

## 用 for 循环遍历迭代器

```rust
let vec = vec![1, 2, 3, 4, 5];
for &num in vec.iter() {
    println!("{}", num);
}
```

## 消耗型适配器

- collect()：将迭代器转换为集合（如向量、哈希集）。
- sum()：计算迭代器中所有元素的和。
- product()：计算迭代器中所有元素的乘积。
- count()：返回迭代器中元素的个数。

```rust
let v = vec![1, 2, 3];
let sum: i32 = v.iter().sum();
assert_eq!(sum, 6);
```

## 适配器

- map()：对每个元素应用某个函数，并返回一个新的迭代器。
- filter()：过滤出满足条件的元素。
- take(n)：只返回前 n 个元素的迭代器。
- skip(n)：跳过前 n 个元素，返回剩下的元素迭代器。

```rust
let v = vec![1, 2, 3, 4, 5];
let doubled: Vec<i32> = v.iter().map(|x| x * 2).collect();
assert_eq!(doubled, vec![2, 4, 6, 8, 10]);
```

## 迭代器链

可以将多个迭代器适配器链接在一起，形成迭代器链。

```rust
use std::iter::Peekable;

let arr = [1, 2, 3, 4, 5];
let mut iter = arr.into_iter().peekable();
while let Some(val) = iter.next() {
    if val % 2 == 0 {
        continue;
    }
    println!("{}", val);
}
```

# 收集器

使用 collect 方法将迭代器的元素收集到某种集合中。

```rust
let arr = [1, 2, 3, 4, 5];
let sum: i32 = arr.into_iter().sum();
```

# 惰性求值

正如前面提到的，Rust 迭代器是惰性的，这意味着像 map()、filter() 等不会立刻执行操作，直到调用像 collect() 这样的消耗性方法才会真正处理数据。这使得迭代器处理更加高效，因为避免了不必要的计算。

# 自定义迭代器

```rust
struct Counter {
    count: usize,
}

impl Counter {
    fn new() -> Counter {
        Counter { count: 0 }
    }
}

impl Iterator for Counter {
    type Item = usize;
    
    fn next(&mut self) -> Option<Self::Item> {
        self.count += 1;
        if self.count <= 5 {
            Some(self.count)
        } else {
            None
        }
    }
}

let mut counter = Counter::new();
while let Some(num) = counter.next() {
    println!("{}", num);  // 输出 1 到 5
}
```

## 并行迭代器

如果需要在多线程环境中并行化操作，rayon crate 提供了并行迭代器的支持，通过 .par_iter() 代替 .iter()，可以在多线程环境中加速迭代操作。

## 迭代器和生命周期

迭代器的生命周期与它所迭代的元素的生命周期相关联。迭代器可以借用元素，也可以取得元素的所有权。这在迭代器的实现中通过生命周期参数来控制。

## 迭代器与闭包

迭代器适配器经常与闭包一起使用，闭包允许你为迭代器操作提供定制逻辑。

## 迭代器和性能

迭代器通常是非常高效的，因为它们允许编译器做出优化。例如，编译器可以内联迭代器适配器的调用，并且可以利用迭代器的惰性求值特性。