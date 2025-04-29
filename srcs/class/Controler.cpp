//
// Created by Blu-ea on 23/04/25.
//

#include "../../incs/class/Controler.hpp"

#include <iomanip>
#include <iostream>
#include <ranges>

#include "Commands.hpp"

Controller::Controller()
{
	funct["help"] = &Controller::help;

	funct["load"] = &Controller::load;
	funct["reload"] = &Controller::reload;

	funct["start"] = &Controller::start;
	funct["restart"] = &Controller::restart;
	funct["stop"] = &Controller::stop;

	funct["info"] = &Controller::info;
	funct["list"] = &Controller::list;

	funct["exit"] = &Controller::exit;
}

void Controller::execute(std::string input)
{
	std::vector<std::string_view> command_vector;
	for (const auto word : std::views::split(input, ' '))
	{
		if (word.empty())
			continue;
		command_vector.push_back(std::string_view(word));
	}
	if (command_vector.empty())
		return;
	try
	{
		(this->*funct.at(command_vector[0]))({});
	} catch (std::out_of_range e)
	{
		std::cout << "TaskMaster: " << command_vector[0] << ": This function does not exist. Use help to see commands" << std::endl;
	}
}

void Controller::help(std::vector<std::string> input)
{
}

void Controller::load(std::vector<std::string> input)
{
}

void Controller::reload(std::vector<std::string> input)
{
}

void Controller::start(std::vector<std::string> input)
{
}

void Controller::restart(std::vector<std::string> input)
{
}

void Controller::stop(std::vector<std::string> input)
{
}

void Controller::info(std::vector<std::string> input)
{
}

void Controller::list(std::vector<std::string> input)
{
}

void Controller::exit(std::vector<std::string> input)
{
	Commands::exit();
}

