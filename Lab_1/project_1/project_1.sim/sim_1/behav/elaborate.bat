@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 78fc071a77ed4adba44f1f0312efda9f -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot test_bench_behav xil_defaultlib.test_bench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
