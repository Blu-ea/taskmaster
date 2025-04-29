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

	void load(const std::vector<std::string>&); // only a (1) string
	void reload(const std::vector<std::string>&); // will ignore input

	void start(const std::vector<std::string>&);
	void restart(const std::vector<std::string>&);
	void stop(const std::vector<std::string>&);

	void info(std::string&); // only a (1) string
	void list(); // will ignore input

	void exit();
}


#endif //COMMANDS_HPP
