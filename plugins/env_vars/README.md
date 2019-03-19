# Printing environmental variables

## Description

The plugin provides aliases for printing environmental variables like `PATH`.

## Aliases

The following aliases are defined:

| Alias                   | Implementation                      | Description                          |
| ----------------------- | ----------------------------------- | ------------------------------------ |
| `print-path`            | `echo -e ${PATH//:/\\n}`            | list all `PATH` variables            |
| `print-manpath`         | `echo -e ${MANPATH//:/\\n}`         | list all `MAN_PATH` variables        |
| `print-ld_library_path` | `echo -e ${LD_LIBRARY_PATH//:/\\n}` | list all `LD_LIBRARY_PATH` variables |
| `print-pkg_config_path` | `echo -e ${PKG_CONFIG_PATH//:/\\n}` | list all `PKG_CONFIG_PATH` variables |
