# Date and Time

## Description

The plugin provides aliases related to date and time.

## Aliases

The following aliases are defined:

| Alias      | Implementation                                  | Description                                                                       |
| ---------- | ----------------------------------------------- | --------------------------------------------------------------------------------- |
| `today`    | `date "+%A %d %B %Y (%Y-%m-%d %Z %z) Week: %V"` | print current date: <br />`Tuesday 19 March 2019 (2019-03-19 CET +0100) Week: 12` |
| `now`      | `date "+%H:%M:%S.%3N"`                          | print current time: <br />`16:55:59.398`                                          |
| `timezone` | `timedatectl`                                   | print information about current timezone                                          |
