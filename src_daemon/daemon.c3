module taskmaster::daemon;

import std::time;
import std::net::os;
import std::io;
import std::os::linux;
import std::thread;
import libc;

import taskmaster::common::option;
import taskmaster::daemon::command::type;

macro String[]? @get_input(NativeSocket #socket){
	char[] buff = mem::temp_array(char, 1024);
	
	sz read_sz = libc::recv(#socket, buff, 1024, 0);
	if (read_sz == -1) return os::socket_error()~;

	String[] ret = String.tsplit(((String)buff).trim(" \n\t\r\f\v\0"), " ", 0, true);
	return ret;
}

fn void loop_daemon(NativeSocket sock, type::ServiceMap* service_map) {

	while (try String[] cmd_arg = @get_input(sock)) @pool()
	{
		if (cmd_arg.len == 0) continue;
		io::printfn("received - %s", cmd_arg);

		if (cmd_arg[0] == "exit") break;
	};
	io::printn("Nothing");
}
