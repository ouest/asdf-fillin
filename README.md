<div align="center">

# asdf-fillin [![Build](https://github.com/ouest/asdf-fillin/actions/workflows/build.yml/badge.svg)](https://github.com/ouest/asdf-fillin/actions/workflows/build.yml) [![Lint](https://github.com/ouest/asdf-fillin/actions/workflows/lint.yml/badge.svg)](https://github.com/ouest/asdf-fillin/actions/workflows/lint.yml)


[fillin](https://github.com/ouest/asdf-fillin) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add fillin
# or
asdf plugin add fillin https://github.com/ouest/asdf-fillin.git
```

fillin:

```shell
# Show all installable versions
asdf list-all fillin

# Install specific version
asdf install fillin latest

# Set a version globally (on your ~/.tool-versions file)
asdf global fillin latest

# Now fillin commands are available
fillin --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ouest/asdf-fillin/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Daisuke NISHISAKA](https://github.com/ouest/)
