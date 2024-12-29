# portable-toolset

This project contains a few scripts which I use time to time in my everyday work. It wasnt designed for public usage or distribution cause it is not very flexible and solve specific cases. But it may be useful for someone.

# Installation

It is very simple: just clone this repo, copy scripts to the one of the directorys in `PATH` and set execution permissions.

```
mv ./pts_* /usr/local/sbin && chmod +x /usr/local/sbin/pts_*
```

## pts_bepasty

This tool intended to upload text or files to [bepasty](https://github.com/bepasty/bepasty-server) API through CLI.

```
Usage: pts_bepasty [options] file1.txt file2.json ...
Usage: echo 'some important text' | pts_bepasty [options]
Options:
  -h, --help      This help screen
  -n, --name      Title of the paste
  -t, --type      Format of paste. Default is text/plain
  -u, --url       URL of target service. E.g. http://8.8.8.8:1234/bepasty
      --verbose   Print verbose output
  -v, --version   Print version and exit
```

## pts_install


## pts_pg_dump

This tool perform postgresql database backups like ordinary `pg_dump` or `pg_dumpall` but have some useful features:

* You may use `-C` flan even with dump command to remove old backup files after perform a new one.
* It will compress `.sql` text dump to `.gz` archive by default.
* If you use `dumpall` command it will create one dump file for all databases from your server. But also you may use command `dump` with `-e` flag to automatically create separate dump file for every database on your server.
* Flag `-m` specify how dump will be written to file system. If `write` mode is used, dump file will be written to the destination directory (specified with `-D` flag) at once. If `copy` mode is used, dump file will be written to `/tmp` directory and only then dump file will be copied entirely to the destination directory. It may be useful to avoid sequential writing to file in not fully POSIX compatible file systems (like if you want to place dump to mounted remote volume with `s3fs`).

```
Usage: pts_pg_dump COMMAND [options]
Commands:
  clean                 Remove old backups
  dump                  Create dump of one database
  dumpall               Create dump of all databases
Options:
  -C, --clean-days      Remove backup file older then specified days
  -c, --compression     Backup compression level (0..9)
  -D, --dir             Directory for store backups
  -d, --dbname          Database name
  -e, --dump-every-db   Create separate backups for all databases (in dump command)
  -H, --host            Database address. Override PGHOST variable
  -h, --help            This help screen
  -m, --mode            Backup write mode (write/copy)
  -n, --name            Backup title
      --no-compression  Dont compress dump file
  -p, --port            Database port. Override PGPORT variable
  -U, --username        Database username. Override PGUSER variable
      --verbose         Print verbose output
  -v, --version         Print version and exit
  -W, --password        Database password. Override PGPASSWORD variable
  -w, --no-password     Connect without password
```

## pts_pg_top

Just a simple script to connect to postgres database and perform some querys about database statistic like number of connections, database size and etc.

```
Usage: pts_pg_top [options]
Options:
  -a, --all             Get all statistic
  -c, --connections     Get database connections
  -d, --dbname          Get statistic about specified database
  -H, --host            Database address. Override PGHOST variable
  -h, --help            This help screen
  -p, --port            Database port. Override PGPORT variable
  -S, --size            Get database size
  -s, --status          Get database status and overall info
  -U, --username        Database username. Override PGUSER variable
      --verbose         Print verbose output
  -v, --version         Print version and exit
  -W, --password        Database password. Override PGPASSWORD variable
  -w, --no-password     Connect without password
```

## pts_yaml2json

Simple script for converting yaml configs to json format.

```
usage: yaml2json.py [-h] [-o OUTPUT] yaml_file
positional arguments:
  yaml_file             Path to the YAML file

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Path to the JSON file for saving (optional)
```



