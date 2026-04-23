module taskmaster::daemon;

import std::collections::object;
import std::encoding::json;
import std::io;
import std::collections::map;
import std::collections::list;
import std::net;
import std::io::path;

fn void main(String[] args)
{
	Option opt = get_option(args[1..]);
	defer opt.other_args.free();


	Path file_path = path::new(mem, "/home/amiguez/Projects/taskmaster/config_exemple/TaskManager.cfg.json")!!;
	HashMap {String, Service*} service_map;

	service_map.init(mem);

	command::load(file_path, &service_map)!!;

	io::printn(service_map);


}


fn Option get_option(String[] args)
{
	Option ret;
	ret.other_args.init(mem);

	foreach (arg : args)
	{
		switch (arg)
		{
		case "-d":
		case "--daemon":
			ret.is_daemon = true;

		default:
			ret.other_args.push(arg);

		}
	}
	return ret;
}