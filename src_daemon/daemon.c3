module taskmaster::daemon;

import std::time;
import std::net::os;
import std::io;
import std::thread;
import libc;

import taskmaster::common::option;

fn void loop_daemon(NativeSocket sock) {

	// HashMap {String, Service*} service_map;
	// service_map.init(mem);

	// io::printn("I m the daemon");
		thread::sleep((time::Duration) 10 * 1000000); // 10 secondes
}
