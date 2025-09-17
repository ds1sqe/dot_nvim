local pythonConfig = require("util.lang.python")
local haskellConfig = require("util.lang.haskell")

return {
  ansiblels = {},
  bashls = {},
  clangd = {
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or vim.fs.dirname(
        vim.fs.find(".git", { path = fname, upward = true })[1]
      )
    end,
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
  cssls = {},
  dockerls = {},
  svelte = {},
  eslint = {},

  html = {},
  hls = {
    root_dir = haskellConfig.rootdir(),
    settings = {
      haskell = {
        formattingProvider = "stylish-haskell",
      },
    },
  },
  gopls = {},
  marksman = {},

  fsautocomplete = {
    cmd = {
      "/home/ds1sqe/proj/FsAutoComplete/src/FsAutoComplete/bin/Release/net6.0/fsautocomplete",
      "--adaptive-lsp-server-enabled",
    },
    settings = {
      FSharp = {
        EnableReferenceCodeLens = true,
        ExternalAutocomplete = true,
        InterfaceStubGeneration = true,
        InterfaceStubGenerationMethodBody = 'failwith "Not Implemented"',
        InterfaceStubGenerationObjectIdentifier = "this",
        Linter = true,
        RecordStubGeneration = true,
        RecordStubGenerationBody = 'failwith "Not Implemented"',
        ResolveNamespaces = true,
        SimplifyNameAnalyzer = true,
        UnionCaseStubGeneration = true,
        UnionCaseStubGenerationBody = 'failwith "Not Implemented"',
        UnusedDeclarationsAnalyzer = true,
        UnusedOpensAnalyzer = true,
        UseSdkScripts = true,
        keywordsAutocomplete = true,
      },
    },
    capabilities = {
      documentFormattingProvider = false,
    },
  },

  -- Python configs
  pyright = {
    -- root_dir = pythonConfig.rootdir(),
    single_file_support = false,
    settings = {
      --[boolean]: Determines whether pyright offers auto-import completions.
      autoImportCompletions = true,
      servername = "pyright",
      python = {
        analysis = {
          --[boolean]: Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
          autoSearchPaths = true,
          --["openFilesOnly", "workspace"]: Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file. If this option is set to "openFilesOnly", pyright analyzes only open files.
          diagnosticMode = "workspace",
          --[boolean]: Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files. Type information will typically be incomplete. We recommend using type stubs where possible. The default value for this option is false.
          useLibraryCodeForTypes = false,
          logLevel = "Information",
          stubPath = "",
          --typeshedPaths [array of paths]: Paths to look for typeshed modules. Pyright currently honors only the first path in the array.
          typeshedPaths = { "" },
          --["off", "basic", "strict"]: Determines the default type-checking level used by pyright. This can be overridden in the configuration file. (Note: This setting used to be called "pyright.typeCheckingMode". The old name is deprecated but is still currently honored.)
          typeCheckingMode = "off",
        },
        linting = { pylintEnabled = false },
      },
    },

    before_init = function(_, config)
      config.settings.python.pythonPath = pythonConfig.get_python_path(config.root_dir)
      -- venvPath is project root + venv
      config.settings.python.venvPath = pythonConfig.get_venv_path(config.root_dir)
      config.settings.python.venv = "venv"
    end,

    capabilities = {
      signatureHelpProvider = false,
      hoverProvider = false,
      definitionProvider = false,
    },
  },

  jedi_language_server = {
    -- root_dir = pythonConfig.rootdir(),
    settings = {
      initializationOptions = {
        codeAction = {
          nameExtractVariable = "jls_extract_var",
          nameExtractFunction = "jls_extract_def",
        },
        completion = {
          disableSnippets = false,
          resolveEagerly = false,
          ignorePatterns = {},
        },
        diagnostics = {
          enable = true,
          didOpen = true,
          didChange = true,
          didSave = true,
        },
        hover = {
          enable = true,
          disable = {
            -- class= { all= false, names= [], fullNames= [] },
            -- function= { all= false, names= [], fullNames= [] },
            -- instance= { all= false, names= [], fullNames= [] },
            -- keyword= { all= false, names= [], fullNames= [] },
            -- module= { all= false, names= [], fullNames= [] },
            -- param= { all= false, names= [], fullNames= [] },
            -- path= { all= false, names= [], fullNames= [] },
            -- property= { all= false, names= [], fullNames= [] },
            -- statement= { all= false, names= [], fullNames= [] }
          },
        },
        jediSettings = {
          autoImportModules = { "django", "numpy", "rest_framework" },
          caseInsensitiveCompletion = true,
          debug = false,
        },
        markupKindPreferred = "markdown",
        workspace = {
          extraPaths = {},
          --environmentPath= "/path/to/venv/bin/python",
          symbols = {
            ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
            maxSymbols = 333,
          },
        },
      },
    },

    before_init = function(_, config)
      config.settings = {
        workspace = {
          environmentPath = pythonConfig.get_python_path(config.root_dir),
        },
      }
    end,
  },

  yamlls = {},

  --lua
  lua_ls = {
    skip_default_setup = true,
    single_file_support = true,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          workspaceWord = true,
          callSnippet = "Both",
        },
        misc = {
          parameters = {
            "--log-level=trace",
          },
        },
        diagnostics = {
          -- enable = false,
          groupSeverity = {
            strong = "Hint",
            strict = "Warning",
          },
          groupFileStatus = {
            ["ambiguity"] = "Opened",
            ["await"] = "Opened",
            ["codestyle"] = "None",
            ["duplicate"] = "Opened",
            ["global"] = "Opened",
            -- ["luadoc"] = "Opened",
            ["redefined"] = "Opened",
            ["strict"] = "Opened",
            ["strong"] = "Opened",
            ["type-check"] = "Opened",
            ["unbalanced"] = "Opened",
            ["unused"] = "Opened",
          },
          unusedLocalExclude = { "_*" },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
      },
    },
    on_init = function(client)
      client.server_capabilities.semanticTokensProvider = nil

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            "$VIMRUNTIME",
            "$XDG_DATA_HOME/nvim/lazy",
            "${3rd}/luv/library",
          },
        },
      })
    end,
  },
  ocamllsp = {},
  vimls = {},
  -- tailwindcss = {},
  --
}
