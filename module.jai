#module_parameters(FREETYPE_SUPPORT := true);

#if OS == .WINDOWS #load "windows.jai";
#if OS == .MACOS   #load "macos.jai";
#if OS == .LINUX   #load "linux.jai";

#if FREETYPE_SUPPORT {
    #import "freetype-2.12.1";
    #load "freetype.jai";
}

#scope_module
#if OS == .WINDOWS harfbuzz :: #library "win/harfbuzz";
#if OS == .MACOS   harfbuzz :: #library "macos/harfbuzz";
#if OS == .LINUX   harfbuzz :: #library "linux/harfbuzz";

