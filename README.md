# LaTeX thesis nix flake template

## How to use

### Prerequisites

1. If you're not on [NixOS](https://nixos.org/), you'll need to install [nix](https://nix.dev/install-nix).

2. Enable flakes in your nix (or NixOS) config
```nix
experimental-features = nix-command flakes
```

3. Adjust language-specific packages in `flake.nix` and `tex/main.tex` - Polish is configured by default as it's my native language

### Env activation
This template has `.envrc` in order to activate it automatically upon entering the directory. \
In order for this to work, you'll need to install [direnv](https://direnv.net/) and then run `direnv allow` in this environment's workdir.


Alternatively, you can still activate it manually.
```sh
nix develop
```

## Directory structure
```
├── code                # source code for listings
├── images              # images
└── tex                 # all document source files
    ├── chapters
    │   |── intro.tex
    |   └── ...
    ├── main.tex
    ├── references.bib
    └── titlepage.tex
```

## Makefile
LaTeX build artifacts go into `.build` dir to avoid clutter and the final `thesis.pdf` goes directly into your workdir.

The makefile utilizes `latexmk` under the hood.

Available `make` commands:
```
clean           Clean up build artifacts
help            Show this help menu
hot-reload      Live-reload as you type
pdf             Compile the PDF (default)
```
