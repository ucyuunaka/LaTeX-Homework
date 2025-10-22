#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
LaTeX 文档编译脚本
替代 build.bat，提供跨平台支持
"""

import os
import sys
import argparse
import subprocess
import shutil
from pathlib import Path


def create_build_directory():
    """创建 build 目录（如果不存在）"""
    build_dir = Path("build")
    build_dir.mkdir(exist_ok=True)
    return build_dir


def compile_latex(filename, build_dir):
    """
    使用 latexmk 编译 LaTeX 文件
    
    Args:
        filename: 要编译的文件名（不含扩展名）
        build_dir: 构建目录路径
    
    Returns:
        subprocess.CompletedProcess: 编译过程的结果
    """
    tex_file = f"{filename}.tex"
    
    # 检查文件是否存在
    if not Path(tex_file).exists():
        print(f"[错误] 找不到文件: {tex_file}")
        sys.exit(1)
    
    # 构建 latexmk 命令
    cmd = [
        "latexmk",
        "-pdf",
        "-xelatex",
        "-shell-escape",
        f"-outdir={build_dir}",
        f"-auxdir={build_dir}",
        "-interaction=nonstopmode",
        "-synctex=1",
        tex_file
    ]
    
    print(f"[编译] 开始编译 {tex_file}...")
    
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        return result
    except subprocess.CalledProcessError as e:
        print(f"[错误] 编译失败，返回码: {e.returncode}")
        if e.stdout:
            print(f"[输出] {e.stdout}")
        if e.stderr:
            print(f"[错误信息] {e.stderr}")
        return e


def copy_pdf(filename, build_dir):
    """
    将编译生成的 PDF 从 build 目录复制到当前目录
    
    Args:
        filename: 文件名（不含扩展名）
        build_dir: 构建目录路径
    
    Returns:
        bool: 复制是否成功
    """
    source_pdf = build_dir / f"{filename}.pdf"
    target_pdf = Path(f"{filename}.pdf")
    
    if not source_pdf.exists():
        print(f"[错误] 未找到 PDF 文件: {source_pdf}")
        return False
    
    try:
        shutil.copy2(source_pdf, target_pdf)
        print(f"[成功] PDF 文件已复制为 {filename}.pdf")
        return True
    except Exception as e:
        print(f"[错误] PDF 复制失败: {e}")
        return False


def main():
    """主函数"""
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(
        description="LaTeX 文档编译脚本",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  python build.py              # 编译 main.tex
  python build.py mydoc        # 编译 mydoc.tex
  python build.py chapter1.tex # 编译 chapter1.tex
        """
    )
    
    parser.add_argument(
        "filename",
        nargs="?",
        default="main",
        help="要编译的 LaTeX 文件名（不含扩展名，默认为 main）"
    )
    
    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="显示详细输出"
    )
    
    args = parser.parse_args()
    
    # 处理文件名，去掉 .tex 扩展名（如果有）
    filename = args.filename
    if filename.lower().endswith(".tex"):
        filename = filename[:-4]
    
    # 创建构建目录
    build_dir = create_build_directory()
    
    # 编译 LaTeX 文件
    result = compile_latex(filename, build_dir)
    
    # 检查编译结果
    if result.returncode != 0:
        print(f"[编译] 编译失败，错误代码: {result.returncode}")
        if not args.verbose:
            input("按 Enter 键退出...")
        sys.exit(result.returncode)
    
    # 复制 PDF 文件
    if copy_pdf(filename, build_dir):
        print(f"[完成] 编译成功！")
    else:
        print("[完成] 编译后处理失败")
        if not args.verbose:
            input("按 Enter 键退出...")
        sys.exit(1)
    
    # 如果不是详细模式，等待用户按键
    if not args.verbose:
        input("按 Enter 键退出...")


if __name__ == "__main__":
    main()