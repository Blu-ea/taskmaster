module taskmaster::daemon::commad::type;

import std::io;

// TODO: Change this type to 
alias ServiceMap = HashMap {String, Service*}
// alias T_Cmd = fn void(String[] args,  ServiceMap* service_map);
alias T_Cmd = fn void(String[] args);

fn void tmp_load(String[] a){
	io::printn(a);
}

<*
	@param s_cmd: `The command name`
	@param cmd: `The function called`
*>
enum CmdE : (String s_cmd,T_Cmd cmd) {
	LOAD {"load", &tmp_load},
}