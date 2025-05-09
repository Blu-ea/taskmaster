//
// Created by Blu-ea on 25/04/25.
//

#ifndef COMMANDS_HPP
#define COMMANDS_HPP
#include <string>
#include <vector>

namespace Commands
{
	void help();
	void help(std::string_view);

	void load(const std::vector<std::string>&); // only a (1) string
	void reload(const std::vector<std::string>&); // will ignore input

	void start(const std::vector<std::string>&);
	void restart(const std::vector<std::string>&);
	void stop(const std::vector<std::string>&);

	void info(std::string&); // only a (1) string
	void list(); // will ignore input

	void exit();

	/**
	 * Next is the help information for all the commandes.
	 */

	inline std::string HELP =
		"- `help [<command>]`\n"
		"- `load <conf.file>`\n"
		"- `reload`\n"
		"- `start [<service> ... ]`\n"
		"- `restart [<service> ... ]`\n"
		"- `stop [<service> ... ]`\n"
		"- `info <service>`\n"
		"- `list`\n"
		"- `exit`\n.";

	inline std::string HELP_HELP = "Usage: `help [<command>]`\nSee the Help for said command.\n";
	inline std::string HELP_LOAD = "Usage: `load <conf.file>`\nLoad say config file into memory.\n";
	inline std::string HELP_RELOAD = "Usage: `reload`\nReload the previous loaded config file.\n";

	inline std::string HELP_START = "Usage: `start [<service> ... ]`\nWill start said service.\n"
						  "If no argument is provided, will launch them all\n";
	inline std::string HELP_RESTART = "Usage: `restart [<service> ... ]`\nWill restart said service.\n"
						  "If no argument is provided, will launch them all\n";
	inline std::string HELP_STOP = "Usage: `stop [<service> ... ]`\nWill stop and kill said service.\n"
						  "If no argument is provided, will stop and kill all services\n";

	inline std::string HELP_INFO = "Usage: `info <service>`\nPrint the informations of that service.\n";
	inline std::string HELP_LIST = "Usage: `list`\nPrint out all the services.\n";

	inline std::string HELP_EXIT = "Usage: `exit`\nWill kill all services, and quit Taskmaster.\n";
}

#endif //COMMANDS_HPP
