//
// Created by Blu-ea on 30/04/25.
//

#include <iostream>

#include "../incs/Commands.hpp"

void Commands::help()
{
	std::cout << HELP << std::endl;
}

void Commands::help(std::string_view arg)
{
	if (arg == "help")
		std::cout << Commands::HELP_HELP;
	else if (arg == "load")
		std::cout << Commands::HELP_LOAD;
	else if (arg == "reload")
		std::cout << Commands::HELP_RELOAD;
	else if (arg == "start")
		std::cout << Commands::HELP_START;
	else if (arg == "restart")
		std::cout << Commands::HELP_RESTART;
	else if (arg == "stop")
		std::cout << Commands::HELP_STOP;
	else if (arg == "info")
		std::cout << Commands::HELP_INFO;
	else if (arg == "list")
		std::cout << Commands::HELP_LIST;
	else if (arg == "exit")
		std::cout << Commands::HELP_EXIT;
	else
		std::cout << "Taskmaster: "<< arg <<": This function does not exist. Use help to see commands" << std::endl;
}