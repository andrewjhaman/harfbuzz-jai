#run {
    set_build_options_dc(.{do_output = false});

    #if OS == .WINDOWS {
        path_prefix := "win";
        extra := string.["/DMESHOPTIMIZER_API=__declspec(dllexport)"];
    } else {
        #if OS == .LINUX {
            path_prefix := "linux";
        }
        #if OS == .MACOS {
            path_prefix := "macos";
        }
        extra := string.[];
    }
    
    make_directory_if_it_does_not_exist(path_prefix);
    libname := tprint("%/harfbuzz", path_prefix);

    print("Building dynamic library:\n");

    src :=  "harfbuzz-main/src/harfbuzz.cc";
    //build_cpp_dynamic_lib(libname, src, debug = false, extra = .["-DHB_DLL_EXPORT", "-Dfreetype=enabled"]);
    //build_cpp_dynamic_lib(libname, ..srcs, extra=extra);

    print("Building static library:\n");
    build_cpp_static_lib(libname, src, debug=false, extra = .["-DHB_DLL_EXPORT"]);
};

#import "File";
#import "BuildCpp";
#import "Compiler";
#import "Basic";
