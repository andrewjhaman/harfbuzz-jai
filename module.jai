#if OS == .WINDOWS #load "windows.jai";
#if OS == .MACOS   #load "macos.jai";
#if OS == .LINUX   #load "linux.jai";


#scope_file

#if OS == .WINDOWS harfbuzz_lib :: #library "win/harfbuzz";
#if OS == .MACOS   harfbuzz_lib :: #library "macos/harfbuzz";
#if OS == .LINUX   harfbuzz_lib :: #library "linux/harfbuzz";
