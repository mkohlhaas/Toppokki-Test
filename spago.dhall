{ name = "my-project"
, dependencies = [ "console", "effect", "prelude", "psci-support", "toppokki", "test-unit", "aff", "strings" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
