# TODO: Rename to `development.profile`? (Since things like renderdoc isn't really coding.)
# TODO: Refactor into a module directory
#
#       Create submodules for different languages:
#           1. C/C++/C3C
#           2. Rust
#           4. Lua(JIT)
#           5. "3D" ... OpenGL/Vulkan/GLSL? (handle as options to other languages?)
#              ...
#           etc

{
   # TODO:
   #    neovim + plugins
   #    code-oss? (vscode)
}

# C/C++/C3:
#
#    clang, gcc, c3c
#    gdb, lldb, gdb-frontend ...
#    ASan, MSan, TSan ...
#    cpp-check?
#    valgrind
#    make, cmake...
#    clangd, ccls
#    clang-tidy
#    clang-format
#    emscripten? wasm?
#    nvim plugins... (overlay?)
#    dev shell...

# Rust:
#
#    rustc? rustup?
#    rustfmt
#    rust-bindgen?
#    rust-analyzer
#    rust-code-analysis?
#    wasm-tools?
#    nvim plugins... (overlay?)
#    dev shell...

# Lua:
#
#    lua, luau, luajit,
#    luabind, luabind_luajit, luabridge?
#    luaformatter
#    nvim plugins... (overlay?)
#    dev shell...

# "3D":
#
#    OpenGL, Vulkan ...
#    renderdoc
#    nvim plugins (GLSL)... (overlay?)
#    ...

# TODO: Decide on how to handle overlap (e.g. Lua|LuaJiT + C++ Sol2 ...
