# File and directory statistics

## Description

The plugin provides nicely formatted, custom `stat` and `du` commands.

## Aliases

If `ncdu` is present, `dud` and `duf` are both replaced with aliases to `ncdu`.

## Functions

- `pstat` uses `stat`'s output with a better formatted file size and timestamp.

    Example: <br />
    ```
    $ pstat README.md
    Name:			README.md
    Type:			regular file
    Owner:			alice
    Size:			4,2KiB
    Permissions:	-rw-r--r--
    Access:			2019-03-19 13:06:29
    Modify:			2019-03-19 13:06:29
    Change:			2019-03-19 13:06:29
    ```

- Two new functions for displaying directory statistics:

    | Function | Implementation          | Description                                                 |
    | -------- | ----------------------- | ----------------------------------------------------------- |
    | `dud`    | `du -hc $@ | sort -hr`  | list all directory sizes human-readable in descending order |
    | `duf`    | `du -ahc $@ | sort -hr` | list all file sizes human-readable in descending order      |
