//
// Created by Blu-ea on 21/04/25.
//

#include "../../incs/class/Config.hpp"

#include <iostream>

#include "class/Service.hpp"
#include "yaml-cpp/yaml.h"

Config::Config() : _status(NOT_INITIALIZED)
{
}

Config::Config(const std::string& config_file) : config_file_name(config_file)
{
	try
	{
		_config = YAML::LoadFile(config_file);
	}
	catch (const YAML::BadFile &e)
	{
		_status = NOT_OK;
		std::cerr << e.what() << std::endl;
		return;
	}
	if (!_config.IsMap())
	{
		_status = NOT_OK;
		std::cerr << "TaskManager: `" + config_file + "` is not a valid config file" << std::endl;
		return;
	}
}

std::list<Service> Config::get_services() const
{
	std::list<Service> services;
	std::cout << " all size - " <<  _config["task"].size() << std::endl ;

	YAML::Node tasks = _config["task"];
	for (YAML::const_iterator task = tasks.begin(); task != tasks.end(); ++task){
		std::cout << "[TaskManager]- Loading " << task->first << std::endl;
		Service service = task->second.as<Service>();
		service.set_name(task->first.as<std::string>());

		services.push_back(service);
	}
	return services;
}
