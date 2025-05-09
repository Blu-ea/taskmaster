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

	typedef void (Controller::*commands_function)(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

	std::map<std::string_view, commands_function> funct;

	Controller();
	~Controller() = default;
	Controller(const Controller& controller) = delete;

	static bool prompt(const std::string& prompt, std::string& user_input);
	void execute(std::string input);

	void help(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

	void load(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);
	void reload(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

	void start(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);
	void restart(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);
	void stop(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

	void info(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);
	void list(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

	void exit(std::vector<std::string_view>::iterator begin, std::vector<std::string_view>::iterator end);

private:
	Config config;
};



#endif //CONTROLLER_HPP
