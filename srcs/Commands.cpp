//
// Created by Blu-ea on 25/04/25.
//

#include "../incs/Commands.hpp"

#include <iostream>
#include <bits/ostream.tcc>

void Commands::help()
{
	printf(
		"This is the help\n"
		" - `help [<command>]`\n"
		"- `load <conf.file>`\n"
		"- `reload` \n"
		"- `start [<service> ... ]`\n"
		"- `restart [<service> ... ]`\n"
		"- `stop [<service> ... ]`\n"
		"- `info <service>`\n"
		"- `list`");
}


void Commands::load(const std::vector<std::string>&)
{
}

void Commands::reload(const std::vector<std::string>&)
{
}


void Commands::start(const std::vector<std::string>&)
{
}

void Commands::restart(const std::vector<std::string>&)
{
}

void Commands::stop(const std::vector<std::string>&)
{
}


void Commands::info(std::string&)
{
}

void Commands::list()
{
}

void Commands::exit()
{
	stop({});
	std::cout << "Exiting..." << std::endl;
	::exit(0);
}