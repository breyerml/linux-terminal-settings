# File and directory statistics

## Description

The plugin provides nicely formatted `stat` and `du` commands.

## Functions

- `pstat` uses `stat`'s output with a better formatted filesize and timestamps.

    Example: <br />
    ```
    $ pstat README.md 
    Name:		'README.md'
    Type:		regular file
    Owner:		marcel
    Size:		4,2KB
    Permissions:	-rw-r--r--
    Access:		2019-03-19 13:06:29
    Modify:		2019-03-19 13:06:29
    Change:		2019-03-19 13:06:29
    ```

- Two new functions for displaying directory statistics:

    | Function | Implementation          | Description                                                       |
    | -------- | ----------------------- | ----------------------------------------------------------------- |
    | `duc`    | `du -hc $1 | sort -hr`  | list all non-hidden file sizes human-readable in descending order |
    | `dua`    | `du -ahc $1 | sort -hr` | list all file sizes human-readable in descending order            |

    If `ncdu` is present `duc` and `dua` are replaced with aliases to `ncdu`.
