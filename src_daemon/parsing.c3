module taskmaster::daemon::parsing;

import taskmaster::daemon::commad::type;
import std::io;

fn void parsing(String input){
	String[] cmd_arg = 	String.tsplit(input, " ", skip_empty: true);
	CmdE? command = runtime::@enum_lookup(CmdE, "s_cmd", cmd_arg[0]);

	if (catch err = command){
		io::printfn("Error: Command not found %s", err);
	}
	else {
		command.cmd(cmd_arg[1..]);
	}
}