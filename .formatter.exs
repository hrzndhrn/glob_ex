# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test,bench}/**/*.{ex,exs}"],
  import_deps: [:prove, :benchee_dsl],
  normalize_charlists_as_sigils: false
]
