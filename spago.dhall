{ name = "my-project"
, dependencies = [ "console", "effect", "prelude", "psci-support", "toppokki", "aff", "foldable-traversable", "aff-promise" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
