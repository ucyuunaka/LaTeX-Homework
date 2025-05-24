# LaTeX 智能编译配置文件
# 使用方法：latexmk main.tex 或 latexmk -pvc main.tex（持续监视）

# 设置输出目录 - 将辅助文件保存到 build 文件夹
$out_dir = 'build';
$aux_dir = 'build';

# 确保输出目录存在
system("mkdir build 2>nul") if ($^O eq 'MSWin32' and not -d 'build');
system("mkdir -p build") if ($^O ne 'MSWin32' and not -d 'build');

# 使用 XeLaTeX 编译
$pdf_mode = 5;

# 强制设置选项（这些设置会覆盖命令行参数）
# 设置默认的输出和辅助目录选项
@default_files = ("main.tex");
$out_dir = 'build';
$aux_dir = 'build';

# XeLaTeX 命令配置 - 强制指定输出目录，即使命令行有其他参数
$xelatex = 'xelatex -shell-escape -interaction=nonstopmode -synctex=1 -output-directory=build %O %S';

# 使用 Biber 处理参考文献 - 指定输出目录
$biber = 'biber --output-directory build %O %S';

# 编译成功后将PDF复制到根目录
$success_cmd = 'copy build\\main.pdf main.pdf' if ($^O eq 'MSWin32');
$success_cmd = 'cp build/main.pdf main.pdf' if ($^O ne 'MSWin32');

# 清理文件扩展名
@generated_exts = (@generated_exts, 'synctex.gz', 'run.xml', 'bbl', 'bcf', 'blg', 'aux', 'log', 'out', 'toc', 'nav', 'snm', 'vrb', 'fls', 'fdb_latexmk', 'xdv', 'pyg');

# 自定义清理规则
$clean_ext = 'synctex.gz run.xml bbl bcf blg aux log out toc nav snm vrb fls fdb_latexmk xdv pyg';

# 强制使用指定的输出目录，忽略命令行的-outdir参数
$do_cd = 0;  # 不改变工作目录
$silent = 0; # 显示详细输出以便调试

# 钩子函数：在开始编译前强制设置输出目录
sub set_output_directory {
    $out_dir = 'build';
    $aux_dir = 'build';
}

# 预览器设置（根据系统自动选择）
if ($^O eq 'MSWin32') {
    # Windows 系统
    $pdf_previewer = 'start %O %S';
} elsif ($^O eq 'darwin') {
    # macOS 系统
    $pdf_previewer = 'open %O %S';
} else {
    # Linux 系统
    $pdf_previewer = 'evince %O %S';
} 