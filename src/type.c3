module taskmaster;

enum StartupPlan{
	ALWAYS, NEVER, ON_FAILURE
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
	ichar* normal_exit_code;
}

fn Service new_service(
	String _cmd,
	int _num_proc = 1,
	bool _auto_start = true,
	StartupPlan _auto_restart,
	int _startup_grace_period = 10,
	int _num_retry = 3,
	Signal _stop_signal,
	int _stop_timeout = 10,
	String _logfile = "",
	String _errfile = "",
	String _umask = "000",
	ichar[] _normal_exit_code = {0}
){
	ichar* exit_codes = malloc(_normal_exit_code.len * 8);
	return (Service) {
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
		.normal_exit_code = exit_codes
	};
}
