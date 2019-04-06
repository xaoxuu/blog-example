---
type: blog
title: 自定义meta信息
date: 2019-04-06
categories: 教程
tags: ss
meta:
  header: [title, author, updated, counter]
  footer: [categories, tags, share]
valine:
  path: /top/
---

现在你可以在文章开头和末尾放置任意支持的meta标签，支持的标签有：
```
title
author
date
updated
categories
tags
counter
top
```

例如本文：

```yml
---
type: blog
title: 自定义meta信息
date: 2019-04-06
categories: 教程
tags: ss
meta:
  header: [title, author, updated, counter]
  footer: [categories, tags, share]
valine:
  path: /top/
---
```


如果不写，就按照主题配置文件中的显示。
如果不想显示任何meta标签，就写`false`，例如关于页面：

```yml
---
title: 关于
meta:
  header: false
  footer: false
valine:
  placeholder: 有什么想对我说的呢？
sidebar: false
---
```
