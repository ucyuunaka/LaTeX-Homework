# 中山大学 LaTeX 模块化学术文档模板

> 支持实验报告、课程作业、课程设计、学术论文等多种文档类型

## 文件结构

```
project/
├── main.tex              # 主文件
├── config.tex            # 个人配置文件
├── build.bat             # 自动化构建脚本
├── .latexmkrc           # 智能编译配置
├── build/               # 编译产生的临时文件目录
│   ├── main.aux
│   ├── main.log
│   ├── main.synctex.gz
│   └── ... （所有辅助文件）
├── preamble/            # 模板文件夹
│   ├── packages.tex     # 包导入
│   └── settings.tex     # 格式设置和命令定义
├── content/             # 内容文件夹
│   ├── cover.tex        # 封面
│   ├── chapterD1.tex     # 示例第1章
│   ├── chapterD2.tex     # 示例第2章
│   └── template/        # 模板示例文件夹 (这里存放了各种功能的 .tex 示例)
│       ├── template_cover.tex    # 封面模板
│       ├── template.tex         # 基础功能、算法与可视化、图表与代码、高级功能等完整示例模板
├── figure/              # 图片文件夹
├── 示例pdf/             # 存放示例PDF文件
│   ├── 一个实际示例.pdf
│   └── 模板.pdf
├── main.bib             # 参考文献数据库（包含数学建模相关文献）
├── main.pdf             # 生成的PDF文件
└── README.md            # 本文件
```

## 快速开始

### 第一步：环境准备（一次性设置）

确保您的系统已安装：

- **TeX 发行版**：TeX Live 2024
- **代码高亮支持**：Python + Pygments

### 第二步：个人信息配置

编辑 `config.tex` 文件，这是唯一需要修改的配置文件：

```latex
% 基本信息
\newcommand{\school}{您的学院}
\newcommand{\major}{您的年级专业}
\newcommand{\maintitle}{文档标题}
\newcommand{\course}{课程名称}
\newcommand{\teacher}{指导教师}
\newcommand{\name}{姓名1、姓名2、姓名3}
\newcommand{\id}{学号1、学号2、学号3}

% 选择文档类型（取消对应行的注释）
% \newcommand{\templatetype}{实验报告}
% \newcommand{\templatetype}{课程作业}
% \newcommand{\templatetype}{课程设计}
\newcommand{\templatetype}{学术论文}
```

### 第三步：推荐撰写顺序

#### 3.1 个人信息配置（已完成）

已在第二步完成 `config.tex` 的配置

#### 3.2 参考文献准备

在开始正文写作前，建议先准备参考文献：

1. **添加文献**：在 `main.bib` 文件中添加您的参考文献
2. **文献格式**：支持各种类型（书籍、期刊、会议论文等）
3. **示例文献**：文件中已包含常用的数学建模和学术写作相关文献（仅展示 可全部删除替换）

```bibtex
@article{your_reference,
  title={您的文献标题},
  author={作者姓名},
  journal={期刊名称},
  year={年份}
  ...
}
```

#### 3.3 正文撰写

按以下顺序编写您的文档：

1. **查看模板示例**：

   - `content/template/template.tex` 

2. **编写章节内容**：

   - **创建新章节文件**：在 `content/` 文件夹中创建新的 `.tex` 文件，如 `chapter3.tex`
   - **使用 subfiles 格式**：参考现有示例，使用以下模板结构：

   ```latex
   \documentclass[../main]{subfiles}
   \begin{document}

   \section{章节标题}
   % 你的内容...

   \end{document}
   ```

   - **添加到主文件**：在 `main.tex` 中添加对应的 `\subfile{}` 命令：

   ```latex
   \subfile{content/chapter3}
   ```

3. **添加图片**：
   - 将图片文件放入 `figure/` 文件夹
   - 推荐使用 PDF、PNG、JPG 格式

### 第四步：编译设置

#### 推荐方法：自动化构建脚本（最简单）

**TeXstudio 设置**：

1. 菜单：选项 → 设置 TeXstudio → 构建
2. 将"构建并查看"命令改为：`cmd /c build.bat`
3. 点击编译按钮即可

**命令行使用**：

```bash
build.bat
```

#### 备选方法：传统 latexmk 编译

TeXstudio 设置"构建并查看"为：

```
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build ?me
```

### 第五步：开始使用

1. **首次编译**：运行一次完整编译生成 PDF
2. **查看效果**：检查生成的 `main.pdf` 文件
3. **开始写作**：编辑 `content/` 文件夹中的章节文件
4. **实时预览**：每次修改后重新编译查看效果

> [!TIP] > **建议**：先编译一次模板查看效果，然后逐步替换示例内容为您自己的内容。

## 使用方法

### 方法 A：自动化构建脚本（强烈推荐）

#### TeXstudio 设置

**设置步骤**：

1. TeXstudio 菜单：选项 → 设置 TeXstudio → 构建
2. 找到"构建并查看"设置
3. 将命令改为：`cmd /c build.bat`

#### 命令行使用

```bash
# 直接运行构建脚本
build.bat

# 或指定文件名
build.bat main
```

### 方法 B：传统 latexmk 编译

#### TeXstudio 设置

在 TeXstudio 中设置"构建并查看"为：

```
latexmk -pdf -xelatex -shell-escape -outdir=build -auxdir=build ?me
```

> [!WARNING]  
> 注意：某些 TeXstudio 版本可能无法正确处理输出目录参数，推荐使用方法 A

#### 命令行使用

```bash
# 智能编译（推荐）
latexmk main.tex

# 持续监控模式（实时预览）
latexmk -pvc main.tex

# 清理临时文件
latexmk -c main.tex
```

### 方法 C：传统编译链

在 TeXstudio 中设置"构建并查看"为：

```
txs:///xelatex | txs:///biber | txs:///xelatex | txs:///xelatex
```

> [!NOTE]  
> 此方法会在根目录产生大量临时文件，不推荐使用

## 构建系统详解

### build.bat 脚本功能

- **自动目录管理**：创建 `build/` 目录存放所有临时文件
- **智能参数处理**：自动处理文件名参数，支持带或不带 `.tex` 扩展名
- **错误检测**：编译失败时返回错误代码并显示详细信息
- **PDF 输出**：编译成功后自动将 PDF 复制到根目录
- **TeXstudio 兼容**：优化了与 TeXstudio 的集成体验

### 目录结构优势

**传统方式**（所有文件混在根目录）：

```
project/
├── main.tex
├── main.pdf
├── main.aux     ❌ 临时文件
├── main.log     ❌ 临时文件
├── main.toc     ❌ 临时文件
├── ... 更多临时文件
└── content/
```

**新的构建系统**（临时文件隔离）：

```
project/
├── main.tex
├── main.pdf     ✅ 只有最终PDF在根目录
├── build/       ✅ 所有临时文件都在这里
│   ├── main.aux
│   ├── main.log
│   └── ...
└── content/
```

### 独立编译章节

模板支持单独编译某个章节（需要先编译一次主文件）：

```bash
# 方法1：命令行
cd content
xelatex --shell-escape chapter1.tex

# 方法2：TeXstudio
# 直接打开chapter1.tex并编译

# 方法3：使用构建脚本编译其他文件
build.bat chapter1
```

## 自定义配置（基本不修改）

### 修改格式设置

- **全局格式**：编辑 `preamble/settings.tex`
- **添加宏包**：编辑 `preamble/packages.tex`

## 使用技巧

### 写作建议

**模板文件利用**：

- 每个模板文件展示了不同的功能，可以直接复制相关代码

### 版本控制建议

- 使用 Git 管理文档版本
- `build/` 目录已在 `.gitignore` 中，不会提交临时文件
- 建议定期提交重要修改

### 编译优化

- **首次编译**：可能需要较长时间下载字体和包
- **增量编译**：后续编译会很快，latexmk 会智能判断需要重新编译的部分
- **清理重建**：遇到奇怪问题时，删除 `build/` 目录重新编译

## 故障排除

### 常见问题及解决方案

1. **编译错误**：

   - **字体问题**：确保系统安装了中文字体，或使用 TeX Live 完整版
   - **包缺失**：使用 TeX Live 包管理器安装缺失的包
   - **路径问题**：避免中文路径，确保路径中没有空格
   - **权限问题**：确保对项目目录有写入权限

2. **参考文献不显示**：

   - 确保在文档中使用了 `\autocite{}` 或 `\textcite{}` 引用文献
   - 检查 `.bib` 文件格式是否正确
   - 确保运行了完整的编译流程（XeLaTeX → Biber → XeLaTeX → XeLaTeX）
   - 使用 `build.bat` 会自动处理这个流程

3. **图片不显示**：

   - 检查图片路径是否正确（相对于主文件）
   - 确保图片格式支持（推荐 PDF、PNG、JPG）
   - 检查图片文件名是否包含特殊字符

4. **代码高亮失效**：

   - 确保安装了 Python 和 Pygments：`pip install Pygments`
   - 确保编译时使用了 `--shell-escape` 参数
   - 使用 `build.bat` 会自动添加此参数

5. **TeXstudio 构建失败**：

   - 确认构建命令设置为 `cmd /c build.bat`
   - 检查是否在正确的目录中（包含 `build.bat` 的目录）
   - 尝试在命令行中手动运行 `build.bat` 测试

6. **编译速度慢**：

   - 首次编译会较慢，后续编译会快很多
   - 可以使用 `latexmk -pvc` 开启持续监控模式
   - 大量图片时考虑使用草稿模式：`\documentclass[draft]{ctexart}`

## 开发时依赖环境

- **TeX 发行版**：TeX Live 2024
- **编译器**：XeLaTeX
- **参考文献**：Biber
- **代码高亮**：Python + Pygments
- **智能编译**：latexmk
- **编辑器**：TeXstudio 等
