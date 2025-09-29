# CSS 盒子模型

| 盒子模型 | 说明 |
| --- | --- |
| Margin(外边距) | 清除边框外的区域，外边距是透明的。|
| Border(边框) | 围绕在内边距和内容外的边框。 |
| Padding(内边距) | 清除内容周围的区域，内边距是透明的。 |
| Content(内容) | 盒子的内容，显示文本和图像。 |

# 边框样式

 - border-style 属性用于指定要显示的边框类型。
| 属性 | 说明 |
| --- | --- |
| dotted | 定义点状边框。 |
| dashed | 定义虚线边框。 |
| solid | 定义实线边框。 |
| double | 定义双线边框。 |
| groove | 定义三维沟槽边框。效果取决于 border-color 的值。 |
| ridge | 定义三维脊状边框。效果取决于 border-color 的值。|
| inset | 定义三维嵌入边框。效果取决于 border-color 的值。 |
| outset | 定义三维突出边框。效果取决于 border-color 的值。 |
| none | 定义无边框。 |
| hidden | 定义隐藏边框。 |



# margin(外边距)
| 属性 | 说明 |
| --- | --- |
| margin-bottom | 设置元素的下外边距。 |
| margin-left | 设置元素的左外边距。 |
| margin-right | 设置元素的右外边距。 |
| margin-top | 设置元素的上外边距。 |



# padding（填充）
| 属性 | 说明 |
| --- | --- |
| padding-bottom | 设置元素的底部填充 |
| padding-left | 设置元素的左部填充 |
| padding-right | 设置元素的右部填充 |
| padding-top | 设置元素的顶部填充 |



# 尺寸 (Dimension)
| 属性 | 说明 |
| --- | --- |
| height | 设置元素的高度。 |
| line-height | 设置行高。 |
| max-height | 设置元素的最大高度。 |
| max-width | 设置元素的最大宽度。 |
| min-height | 设置元素的最小高度。 |
| min-width | 设置元素的最小宽度。 |
| width | 设置元素的宽度。 |



# Display(显示)
| 属性 | 说明 |
| --- | --- |
| none | 隐藏元素。 |
| block | 设置为块级元素。 |
| inline | 设置为行内元素。 |



# Visibility（可见性）
| 属性 | 说明 |
| --- | --- |
| visibility | 设置元素的可见性。 |
| hidden | 隐藏元素。 可以隐藏某个元素，但隐藏的元素仍需占用与未隐藏之前一样的空间。 |



# Position(定位)
| 属性 | 说明 |
| --- | --- |
| static | HTML元素的默认值，即没有定位，遵循正常的文档流对象。静态定位的元素不会受到 top, bottom, left, right影响。 |
| relative | 相对定位元素的定位是相对其正常位置。 |
| fixed | 元素的位置相对于浏览器窗口是固定位置。即使窗口是滚动的它也不会移动： |
| absolute | 绝对定位的元素的位置相对于最近的已定位父元素，如果元素没有已定位的父元素，那么它的位置相对于<html>: |
| sticky | 元素的位置相对于最近的定位元素是固定位置。即使窗口是滚动的它也不会移动： |



# Overflow (溢出)
| 属性 | 说明 |
| --- | --- |
| visible | 默认值。内容不会被修剪，会呈现在元素框之外。 |
| hidden | 内容会被修剪，并且其余内容是不可见的。 |
| scroll | 内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容。 |
| auto | 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。 |
| inherit | 规定应该从父元素继承 overflow 属性的值。 |



# Float(浮动) 会使元素向左或向右移动，其周围的元素也会重新排列。
| 属性 | 说明 |
| --- | --- |
| none | 默认值。元素不会浮动。 |
| left | 元素会向左浮动。 |
| right | 元素会向右浮动。 |
| inherit | 规定应该从父元素继承 float 属性的值。 |