{ name = "my-project"
, dependencies = [ "console", "effect", "prelude", "psci-support", "toppokki", "aff", "foldable-traversable" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
