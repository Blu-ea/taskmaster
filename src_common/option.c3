module taskmaster::common::option;

import std::collections::list;

struct Option{
	bool is_daemon; // -d --daemon
	List {String} other_args;
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