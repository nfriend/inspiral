# Downgrades

I'm skipping support for downgrades at the moment, mainly because [dropping
columns is a pain with (older versions of)
SQLite](https://stackoverflow.com/a/5987838/1063392), particularly since the
`state` table has so many columns. Downgrades can be added if/when they are
needed in the future.
