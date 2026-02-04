# P6's POSIX.2: p6df-ruby

## Table of Contents

- [Badges](#badges)
- [Summary](#summary)
- [Contributing](#contributing)
- [Code of Conduct](#code-of-conduct)
- [Usage](#usage)
  - [Aliases](#aliases)
  - [Functions](#functions)
- [Hierarchy](#hierarchy)
- [Author](#author)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

TODO: Add a short summary of this module.

## Contributing

- [How to Contribute](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com/p6m7g8-dotfiles/.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

- `p6_bundle` -> `p6df::modules::ruby::cli::bundle`

### Functions

#### p6df-ruby

##### p6df-ruby/init.zsh

- `p6df::modules::ruby::aliases::init()`
- `p6df::modules::ruby::deps()`
- `p6df::modules::ruby::home::symlink()`
- `p6df::modules::ruby::init(_module, dir)`
  - Args:
    - _module - 
    - dir - 
- `p6df::modules::ruby::langs()`
- `p6df::modules::ruby::vscodes()`
- `p6df::modules::ruby::vscodes::config()`
- `str str = p6df::modules::ruby::prompt::env()`
- `str str = p6df::modules::ruby::prompt::lang()`

#### p6df-ruby/lib

##### p6df-ruby/lib/cli.sh

- `p6df::modules::ruby::cli::bundle()`

##### p6df-ruby/lib/rbenv.sh

- `p6df::modules::ruby::rbenv::latest()`
- `p6df::modules::ruby::rbenv::latest::installed()`

## Hierarchy

```text
.
├── init.zsh
├── lib
│   ├── cli.sh
│   └── rbenv.sh
├── README.md
└── share

3 directories, 4 files
```

## Author

Philip M. Gollucci <pgollucci@p6m7g8.com>
