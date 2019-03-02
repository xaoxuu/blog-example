---
title: 隐藏meta信息
categories: 教程
tags: ss
meta:
  date: false
  categories: false
  counter: false
  updated: false
  share: false
  tags: false
valine:
  path: /top/
---

在Front-matter找到或者新增`meta`，需要隐藏哪个meta标签将其置为`false`。例如：

```yml
---
title: 隐藏meta信息
categories: 教程
tags: ss
meta:
  date: false
  categories: false
  counter: false
  updated: false
  share: false
  tags: false
valine:
  path: /top/
---
```
这只会在page页面内生效而不会在列表中生效。
