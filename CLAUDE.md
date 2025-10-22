<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目名称

自用中山大学 LaTeX 模块化学术文档模板

## 🚀 项目概览

这是一个专为中山大学设计的模块化学术文档模板系统，支持多种文档类型（实验报告、课程作业、学术论文等）和布局模式（单栏/双栏）。项目采用三层架构设计，实现了高度模块化和配置灵活性。

核心特性：
- 支持单栏/双栏布局动态切换
- 模块化的文件结构，便于维护和扩展
- 智能编译系统，自动处理依赖关系
- 丰富的学术写作功能（算法、数学公式、表格、代码高亮等）
- 完整的中文支持和中文学术环境

## 🌳 目录结构

```
F:\Code\LaTeX-Homework/
├── main.tex                     # 主文件 - 无需修改，负责组装各模块
├── config.tex                   # 个人配置文件 - 唯一需要编辑的文件
├── build.bat                    # Windows一键构建脚本
├── .latexmkrc                   # 智能编译配置（跨平台支持）
├── main.bib                     # 参考文献数据库
├── build/                       # 编译临时文件（自动创建）
├── content/                     # 内容文件夹
│   ├── cover.tex                # 封面内容
│   ├── chapterD1.tex            # 示例章节1
│   ├── chapterD2.tex            # 示例章节2
│   └── template/                # 模板示例库
│       ├── template.tex         # 完整功能演示
│       ├── template_cover.tex   # 封面模板
│       └── long-table-data.tex  # 长表格示例
├── figure/                      # 图片资源
│   ├── badge.pdf                # 校徽图片
│   ├── badge-horizonal.pdf      # 横向校徽
│   └── template/                # 模板示例图片
├── preamble/                    # 模板核心配置
│   ├── mylab_style.sty          # 主样式包
│   ├── common/                  # 通用配置
│   │   ├── packages.tex         # 宏包导入
│   │   └── commands.tex         # 自定义命令
│   ├── layout_single/           # 单栏布局配置
│   │   └── settings.tex         # 单栏专用设置
│   └── layout_double/           # 双栏布局配置
│       ├── settings.tex         # 双栏专用设置
│       ├── floats.tex           # 浮动体配置
│       └── balance.tex          # 双栏平衡
└── 示例pdf/                     # 实际效果展示
    ├── 单列视图模板.pdf          # 单栏布局效果
    ├── 双列视图模板.pdf          # 双栏布局效果
    └── 一个实际示例.pdf          # 实际示例
```

## 📋 技术文档

### 主文件 (main.tex)
主文件采用模块化设计，负责根据config.tex中的配置动态加载对应的布局设置。核心功能：
- 条件加载单栏/双栏布局配置
- 智能处理目录和参考文献的页面布局
- 支持子文件模块化内容管理

### 配置文件 (config.tex)
唯一需要用户修改的文件，包含：
- 个人信息设置（学院、专业、姓名等）
- 模板类型选择（实验报告/课程作业/学术论文）
- 布局选择（单栏/双栏）
- 自定义格式参数覆盖

### 样式系统 (preamble/)
采用分层样式管理：
- `mylab_style.sty`: 主样式包，定义所有核心功能
- `common/`: 通用配置，包含宏包导入和自定义命令
- `layout_single/` / `layout_double/`: 布局特定配置

## 🛠️ 工具与技术栈

### 核心技术
- **LaTeX**: 文档排版系统
- **XeLaTeX**: 编译引擎，提供完整的Unicode和中文支持
- **Biber**: 参考文献处理引擎
- **latexmk**: 智能编译系统

### 主要宏包
- **geometry**: 页面布局控制
- **fancyhdr**: 页眉页脚设置
- **minted**: 代码高亮（需要Pygments支持）
- **algorithm2e**: 算法环境
- **tikz/pgfplots**: 绘图和数据可视化
- **booktabs**: 专业表格排版
- **amsmath/amssymb**: 数学公式支持

### 构建工具
- **build.bat**: Windows一键构建脚本
- **.latexmkrc**: 跨平台智能编译配置

## 📖 代码规范

### 文件命名规范
- 主文件：`main.tex`
- 配置文件：`config.tex`
- 内容文件：使用描述性名称，如`chapterD1.tex`
- 样式文件：`.sty`扩展名
- 辅助文件：自动生成到`build/`目录

### 编码规范
- 所有文件使用UTF-8编码
- 中文支持通过XeLaTeX和ctex宏包实现
- 自定义命令使用清晰的前缀命名

### 模块化原则
- 样式与内容分离
- 配置与逻辑分离
- 布局与内容分离

### 设计原则
- **未作明确规定要求，不要做过度的兼容性设计**：避免为未明确需求的场景进行过度设计，保持系统简洁高效

## 📚 开发指南

### 基本工作流程
1. 修改`config.tex`设置个人信息和文档类型
2. 在`content/`目录下添加或编辑内容文件
3. 在`main.tex`中引用新的内容文件
4. 运行构建命令生成PDF

### 内容开发规范
- 使用子文件模式：`\documentclass[../main]{subfiles}`
- 每个内容文件可独立编译和调试
- 遵循章节结构规范，使用标准LaTeX sectioning命令

### 样式自定义指南
- 优先通过`config.tex`进行参数调整
- 深度定制在对应的布局配置文件中修改
- 新功能在`preamble/common/commands.tex`中定义命令

## ⚙️ 配置信息

### 编译环境要求
- TeX Live 2020或更新版本
- Python 3.x（用于代码高亮功能）
- Pygments包：`pip install Pygments`

### 编译配置
编译选项在`.latexmkrc`中配置：
- 输出目录：`build/`
- 编译引擎：XeLaTeX
- 自动清理辅助文件
- 支持持续监控模式

## 🔄 常用命令

### 一键构建
```bash
# Windows（推荐）
build.bat

# 指定文件名
build.bat main
```

### 手动编译
```bash
# 标准编译
latexmk -pdf -xelatex -shell-escape main.tex

# 持续监控模式（实时预览）
latexmk -pvc -pdf -xelatex -shell-escape main.tex

# 清理辅助文件
latexmk -c
```

### 调试命令
```bash
# 显示详细编译信息
latexmk -pdf -xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex

# 仅编译一次（忽略依赖）
xelatex -shell-escape -interaction=nonstopmode main.tex
```

## 📊 项目状态

项目当前状态：稳定可用，支持多种学术文档类型的快速生成。

### 最新更新
- 实现了单栏/双栏布局的动态切换
- 完善了模块化架构
- 添加了丰富的学术写作功能
- 优化了编译流程和错误处理

### 支持的文档类型
- 实验报告
- 课程作业
- 课程设计
- 学术论文

### 已知限制
- 代码高亮功能需要Python环境支持
- 某些复杂表格在双栏模式下可能需要手动调整
- 参考文献样式主要适配中文学术环境