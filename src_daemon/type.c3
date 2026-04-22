module taskmaster::daemon;

import std::collections::list;

enum StartupPlan : (String e_val) {
	ALWAYS {"always"},
	NEVER {"never"},
	ON_FAILURE {"on_failure"}
}
enum Signal{
	TERM,
	INT,
	UP,
}


struct Service{
	String cmd;
	int num_proc;
	bool auto_start;
	StartupPlan auto_restart;
	int startup_grace_period;
	int num_retry;
	Signal stop_signal;
	int stop_timeout;
	String logfile;
	String errfile;
	String umask;
	ichar[] normal_exit_code;
}

fn Service* new_service(
	String _cmd,
	int _num_proc,
	bool _auto_start,
	StartupPlan _auto_restart,
	int _startup_grace_period,
	int _num_retry,
	Signal _stop_signal,
	int _stop_timeout,
	String _logfile,
	String _errfile,
	String _umask,
	ichar[] _normal_exit_code
){
	
	Service* ret =  mem::new(Service, {
		.cmd = _cmd,
		.num_proc = _num_proc,
		.auto_start = _auto_start,
		.auto_restart = _auto_restart,
		.startup_grace_period = _startup_grace_period,
		.num_retry = _num_retry,
		.stop_signal = _stop_signal,
		.stop_timeout = _stop_timeout,
		.logfile = _logfile,
		.errfile = _errfile,
		.umask = _umask,
		.normal_exit_code = _normal_exit_code
	});
	return ret;
}

struct Option{
	bool is_daemon; // -d --daemon
	List {String} other_args;
}