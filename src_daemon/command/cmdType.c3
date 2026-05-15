module taskmaster::daemon::commad::type;

import std::io;

alias T_Cmd = fn void(String[] args);

fn void tmp_load(String[] a){
	io::printn(a);
}

enum CmdE : (String s_cmd,T_Cmd cmd) {
	LOAD {"load", &tmp_load},
}