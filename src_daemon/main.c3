module taskmaster::daemon;

import std::collections::list;
import std::collections::map;
import taskmaster::common;
import std::io;
import std::net::os;
import std::os;
import std::thread;

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
		main_parent(opt, sock, pid);
	}


}

	// [x] Create link `make_socketpair()` | `make_socket()`
	// [x] create a fork
	// [x] Parent - promt -- si -d -- kill itself 
	// [ ] Child - daemon -- si -d -- create another fork then kill itself
		// created taskes -- beware to close sockets to avoid strage stuff


fn void main_parent(common::option::Option opt, NativeSocket[2] tmp_sock, Pid_t child_pid) {

	NativeSocket sock;
	if (opt.is_daemon) {
		libc::close(tmp_sock[0]);
		io::printfn("TaskMaster Daemon launched with pid [%d]", child_pid);
	
		os::exit(0);
	} else {
		sock = tmp_sock[0];
		defer(libc::close(sock));
		libc::close(tmp_sock[1]);
	}
	io::printn("Im the prompt :D");
}

import std::time;

fn void main_daemon(common::option::Option opt, NativeSocket[2] tmp_sock) {
	NativeSocket sock;
	if (opt.is_daemon) {
		sock = tmp_sock[0];
	} else {
		sock = tmp_sock[1];
		libc::close(tmp_sock[0]);
	}
	defer(libc::close(sock));

	// HashMap {String, Service*} service_map;
	// service_map.init(mem);

	thread::sleep((std::time::Duration) 5000000);
	io::printn("I m the daemon");
	
}
