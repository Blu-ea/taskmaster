module taskmaster::daemon;

import std::collections::list;
import std::collections::map;
import taskmaster::common;
import std::io;
import std::net::os;

import libc;
extern fn Pid_t fork();

fn void main(String[] args)
{
	option::Option opt = option::get_option(args[1..]);
	defer opt.other_args.free();

	NativeSocket[2] sock;
	if(opt.is_daemon){
		NativeSocket? tsock =  common::make_socket();
		if (catch tsock) {
			io::eprintn("Error: Cannot create Socket");
			return;
		}
		sock[0] = tsock;
	
	} else {
		NativeSocket[2]? tsock =  common::make_socketpair();
		if (catch tsock) {
			io::eprintn("Error: Cannot create Socket");
			return;
		}
		sock = tsock;
	}



	Pid_t pid = fork();
	if (pid == -1) io::eprintn("Error: canot launch TaskMaster");

	if (pid == 0) {
		main_daemon(opt, sock);
	} else {
		main_parent(opt, sock);
	}


}

	// [x] Create link `make_socketpair()` | `make_socket()`
	// [x] create a fork
	// [ ] Parent - promt -- si -d -- kill itself 
	// [ ] Child - daemon -- si -d -- create another fork then kill itself
		// created taskes -- beware to close sockets to avoid strage stuff


fn void main_parent(common::option::Option opt, NativeSocket[2] sock) {
	// NativeSocket sock_fd = *sock;
	// if (!opt.is_daemon)
	// {
	// 	libc::close(*sock);
	// 	sock_fd = (*sock + 1);
		
	// } 
	io::printn("Im the prompt :D");
}

fn void main_daemon(common::option::Option opt, NativeSocket[2] sock) {
	// HashMap {String, Service*} service_map;
	// service_map.init(mem);

	io::printn("I m the daemon");
}
