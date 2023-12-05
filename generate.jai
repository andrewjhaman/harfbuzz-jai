
// This is a collection of regression tests for the bindings generator

// Since compile-time debugging is still tricky, it can sometimes be useful to compile this script into a binary and run that instead of generating the bindings at compile-time.
// But then we won’t compile the full tests suite, so keep this checked in as "AT_COMPILE_TIME :: true"!
AT_COMPILE_TIME :: true;

#if AT_COMPILE_TIME {

    #run,stallable build();

    build :: () {
        set_build_options_dc(.{do_output=false});

        options := get_build_options();
        extra: [] string;
        #if OS == .MACOS {
            macos_version_arg := tprint("-mmacosx-version-min=%.%", options.minimum_macos_version.major, options.minimum_macos_version.minor);
            extra = .[macos_version_arg];
        }

        if !generate_bindings() {
            compiler_set_workspace_status(.FAILED);
            return;
        }
    }
}

generate_bindings :: () -> bool {
    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

        #if OS == .WINDOWS {
            output_filename          = "windows.jai";
        } else #if OS == .LINUX {
            output_filename          = "linux.jai";
        } else #if OS == .MACOS {
            output_filename          = "macos.jai";
        } else {
            assert(false);
        }

        array_add(*libpaths,       ".");
        array_add(*libnames, "harfbuzz");
        array_add(*source_files,  "harfbuzz-main/src/hb.h");
        array_add(*extra_clang_arguments, "-x", "c++", "-DWIN32_LEAN_AND_MEAN");
        log_unsupported = true;
        generate_compile_time_struct_checks = true;
        strip_flags = 0;
        // strip_flags &= ~(Strip_Flags.CONSTRUCTORS | .DESTRUCTORS);
    }

    return generate_bindings(opts, output_filename);
}

#scope_file

#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "Check";
#import "Bindings_Generator";
#import "File";
