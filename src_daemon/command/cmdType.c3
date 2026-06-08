module taskmaster::daemon::command::type;

import std::io;
import std::collections::map;

// TODO: Change this type to 
alias ServiceMap = map::HashMap {String, Service*};
// alias T_Cmd = fn void(String[] args,  ServiceMap* service_map);
alias T_Cmd = fn void(String[] args);

fn void tmp_load(String[] a){
	io::printn(a);
}

<*
	s_cmd: `The command name`
	cmd: `The function called`
*>
enum CmdE : (String s_cmd,T_Cmd cmd) {
	LOAD {"load", &tmp_load},
}