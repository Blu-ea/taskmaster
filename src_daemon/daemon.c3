module taskmaster::daemon;

import std::time;
import std::net::os;
import std::io;
import std::os::linux;
import std::thread;
import libc;

import taskmaster::common::option;
import taskmaster::daemon::command::type;

fn String[]? get_input(NativeSocket socket, SockAddrUn* client_addr){
	char[] buff = mem::temp_array(char, 1024);

	sz read_sz = common::@recvfrom(socket, buff, client_addr);
	if (read_sz == -1) return os::socket_error()~;

	return String.tsplit(((String)buff).trim(" \n\t\r\f\v\0"), " ", 0, true);
}

fn void loop_daemon(NativeSocket sock, type::ServiceMap* service_map) {
	SockAddrUn client_addr;

	while (try String[] cmd_arg = get_input(sock, &client_addr)) @pool()
	{
		if (cmd_arg.len == 0) continue;
		io::printfn("received - %s", cmd_arg);
		
		if (cmd_arg[0] == "exit") break;
		
		CmdE? command = runtime::@enum_lookup(CmdE, "s_cmd", cmd_arg[0]);
		if (catch err = command){
			io::eprintfn("Error: Command not found %s", err);
		}
		else {
			io::printn(command);
			// command.cmd(cmd_arg[1..]);
		}
	};
	io::printn("End of loop");
}
