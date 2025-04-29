//
// Created by Blu-ea on 23/04/25.
//

#ifndef CONTROLLER_HPP
#define CONTROLLER_HPP

#include <map>
#include <string>
#include <vector>

#include "Config.hpp"

/**
 * Command available:
 *  - Help [<Any function>]
 *  - Load [<path-to-cfg.yaml>]
 *  - Start [<service-name>]
 *  - Restart [<service-name>]
 *  - Kill [<service-name>]
 *  - Status [<service-name>]
 *  - List
 */
class Controller {
public:

	typedef void (Controller::*commands_function)(std::vector<std::string> input);

	std::map<std::string_view, commands_function> funct;

	Controller();
	~Controller() = default;
	Controller(const Controller& controller) = delete;

	void execute(std::string input);

	void help(std::vector<std::string> input);

	void load(std::vector<std::string> input);
	void reload(std::vector<std::string> input);

	void start(std::vector<std::string> input);
	void restart(std::vector<std::string> input);
	void stop(std::vector<std::string> input);

	void info(std::vector<std::string> input);
	void list(std::vector<std::string> input);

	void exit(std::vector<std::string> input = {});

private:
	Config config;
};



#endif //CONTROLLER_HPP
