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
	sz last_index;

	foreach F_LOOP: (index, arg : args)
	{
		last_index = index;
		switch (arg)
		{
		case "-d":
		case "--daemon":
			ret.is_daemon = true;

		case "--":
			break F_LOOP;

		default:
			ret.other_args.push(arg);

		}
	}

	if (args.len == last_index) return ret;
	foreach (arg : args[(last_index + 1)..])
	{
		ret.other_args.push(arg);
	}
	return ret;
}