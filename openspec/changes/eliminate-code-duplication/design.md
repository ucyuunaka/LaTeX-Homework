# 重复代码重构设计文档

## 当前架构分析

### 现有问题架构

```
当前结构 (存在重复):
├── preamble/
│   ├── mylab_style.sty          (包含重复的宏包导入 + 命令定义)
│   └── common/
│       ├── packages.tex         (与 mylab_style.sty 重复)
│       └── commands.tex         (与 mylab_style.sty 部分重复)
```

### 重复代码分布

1. **宏包导入重复 (100%)**
   - `mylab_style.sty:15-74` ←→ `packages.tex:6-65`
   - 60个 `\RequirePackage` 语句完全相同

2. **自定义命令重复 (80%)**
   - 定理环境: `mylab_style.sty:91-96` ←→ `commands.tex:7-12`
   - 代码样式: `mylab_style.sty:99-143` ←→ `commands.tex:18-76`
   - 自定义命令: `mylab_style.sty:176-213` ←→ `commands.tex:93-130`

## 目标架构设计

### 重构后的清晰架构

```
目标结构 (消除重复):
├── preamble/
│   ├── mylab_style.sty          (样式包入口，逻辑控制)
│   └── common/
│       ├── packages.tex         (唯一宏包导入源)
│       ├── commands.tex         (通用命令定义)
│       └── core-settings.tex    (新增：核心格式设置)
```

### 模块职责划分

#### 1. `mylab_style.sty` (主控制器)
```latex
% 提供样式包接口
\ProvidesPackage{mylab_style}[2025/07/04 ucyuunaka]

% 导入核心管理包
\RequirePackage{kvoptions}
\RequirePackage{scrlfile}

% 导入通用模块
\RequirePackage{common/packages}
\RequirePackage{common/commands}
\RequirePackage{common/core-settings}

% 布局逻辑控制
\DeclareBoolOption{singlecolumn}[true]
\ProcessKeyvalOptions*

% 条件加载布局设置
\ifmylab_stylesinglecolumn
    \RequirePackage{layout_single/settings}
\else
    \RequirePackage{layout_double/settings}
    \RequirePackage{layout_double/floats}
    \RequirePackage{layout_double/balance}
\fi
```

#### 2. `common/packages.tex` (宏包管理中心)
- **职责**: 统一管理所有宏包导入
- **原则**: 单一数据源，避免重复
- **分组**: 按功能分类组织宏包

#### 3. `common/commands.tex` (通用命令库)
- **职责**: 定义跨布局共享的命令和环境
- **内容**: 定理环境、代码样式、通用命令
- **原则**: 布局无关的命令集中管理

#### 4. `common/core-settings.tex` (核心格式设置) - 新增
- **职责**: 定义基础格式和样式
- **内容**: 颜色定义、超链接设置、基础样式
- **目的**: 分离格式设置与命令定义

## 重构策略

### 阶段1: 宏包导入重构
1. **移除重复**: 删除 `mylab_style.sty` 中的宏包导入部分
2. **添加引用**: 在 `mylab_style.sty` 中引用 `common/packages`
3. **验证编译**: 确保宏包加载正常

### 阶段2: 命令定义重构
1. **命令分析**: 识别通用命令 vs 布局特定命令
2. **重新组织**: 将通用命令移至 `commands.tex`
3. **清理冗余**: 删除 `mylab_style.sty` 中的重复定义

### 阶段3: 核心设置分离
1. **提取设置**: 将格式设置从 `mylab_style.sty` 中提取
2. **创建新文件**: 建立 `common/core-settings.tex`
3. **重新组织**: 按职责分离格式设置

### 阶段4: 布局文件优化
1. **清理重复**: 移除布局文件中的重复设置
2. **专门化**: 确保每个布局文件只包含布局特定内容
3. **继承关系**: 建立清晰的设置继承机制

## 依赖关系图

```
mylab_style.sty (主控制器)
├── common/packages.tex (宏包)
├── common/commands.tex (命令)
├── common/core-settings.tex (设置)
└── layout_*/settings.tex (布局特定)
    ├── layout_single/
    └── layout_double/
        ├── floats.tex
        └── balance.tex
```

## 验证策略

### 编译验证
1. **单文件测试**: 每个修改后立即验证编译
2. **全量测试**: 所有修改完成后完整编译测试
3. **布局测试**: 验证单栏和双栏布局都正常工作

### 功能验证
1. **宏包功能**: 确保所有宏包功能正常
2. **命令可用性**: 验证所有自定义命令可用
3. **样式一致性**: 确保样式输出一致

### 性能验证
1. **编译时间**: 对比重构前后编译时间
2. **文件大小**: 检查生成的PDF文件大小
3. **内存使用**: 监控LaTeX编译过程内存使用

## 回滚计划

如果重构出现问题，回滚步骤：
1. **恢复备份**: 使用git恢复到重构前状态
2. **问题定位**: 分析具体哪个步骤导致问题
3. **逐步修复**: 逐个解决问题或重新规划
4. **重新测试**: 确保修复后功能正常

## 长期维护

### 防止重复回归
1. **代码审查**: 添加代码时检查是否产生重复
2. **文档规范**: 更新开发文档明确模块职责
3. **自动化检查**: 可考虑添加脚本检测重复代码

### 扩展指南
1. **新宏包**: 统一添加到 `packages.tex`
2. **新命令**: 通用命令添加到 `commands.tex`，布局特定添加到对应布局文件
3. **新设置**: 核心设置添加到 `core-settings.tex`