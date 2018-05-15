if %w(development test).include?(Rails.env)
  require "bootsnap"
  Bootsnap.setup(
    cache_dir:            "tmp/cache",          # Path to your cache
    development_mode:     true,                 # Current working environment, e.g. RACK_ENV, RAILS_ENV, etc
    load_path_cache:      true,                 # Optimize the LOAD_PATH with a cache
    autoload_paths_cache: true,                 # Optimize ActiveSupport autoloads with cache
    disable_trace:        false,                # (Alpha) Set `RubyVM::InstructionSequence.compile_option = { trace_instruction: false }`
    compile_cache_iseq:   !ENV["COVERAGE"],     # Compile Ruby code into ISeq cache, breaks coverage reporting.
    compile_cache_yaml:   true                  # Compile YAML into a cache
  )
end
