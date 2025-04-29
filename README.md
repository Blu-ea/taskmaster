# Task Manager

This Project is a taslmanager in Cpp, using a `.Yaml` as configuration file\

---
## Configuration

The configuration allow the user to specify the following, for each program
that will be supervised:

Start with a top level word :`task`, then a list of all your tasks, set they name, then a list of information :
- `cmd` | `<String>` : The command to use to launch the program 
- `num_procs` | `[<int>] *(default: `1`)*` : The number of processes to start and keep running
- `auto_start` | `[<boolean>]` *(default: `true`)* : Whether to start this program at launch or not
- `auto_restart` | `<always|yes> | <never|no> | <on_failure>` : Whether the program should be restarted
- `normal_exit_code` | `[<int> ...]` *(default: `0`)*  : Which return codes represent an "expected" exit status
- `startup_grace_period	` | `[<int>]` *(default: `10`)* : How long the program should be running after it’s started for it to be considered "successfully started" in seconds
- `num_retry` | `[<int>]` *(default: `3`)*  : How many times a restart should be attempted before aborting
- `stop_signal` | `<any Unix signal or number>` : Which signal should be used to stop (i.e. exit gracefully) the program
- `stop_timeout` | `[<int>] *(default :`10`)* : How long to wait after a graceful stop before killing the program in seconds
- `log_file` | `stdout:<path>, stderr:<path>`  : Options to discard the program’s stdout/stderr or to redirect them to files
- `umask` | `<mode_t>`: An umask to set before launching the program

--- 
Exemple:

```yaml
task:
  <service_name>:
    cmd: "/bin/my_server -u user"
    num_procs: 1
    auto_start: false
    auto_restart: always
    normal_exit_code:
      - 0
      - 2
    startup_grace_period: 5
    stop_signal: TERM # can be SIGTERM or 15
    log_file:
      stdout: "/tmp/log/my_server.log"
      stderr: discard # use discard for "/dev/null"
    umask: 022
```


---
 ## Possible commands

 - `help [<command>]`
 - `load <conf.file>`
 - `reload` 
 - `start [<service> ... ]`
 - `restart [<service> ... ]`
 - `stop [<service> ... ]`
 - `info <service>`
 - `list`
 - `exit`