//
// Created by Blu-ea on 21/04/25.
//

#include "../../incs/class/Config.hpp"

#include <iostream>

#include "yaml-cpp/yaml.h"

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

	{ // todo: Remove later.
		std::cout << "yaml Config:";
		switch (_config.Type()) {
		case YAML::NodeType::Null: std::cout << "Null" << std::endl; break;
		case YAML::NodeType::Scalar: std::cout << "Scalar" << std::endl; break;
		case YAML::NodeType::Sequence: std::cout << "Sequence" << std::endl; break;
		case YAML::NodeType::Map: std::cout << "Map" << std::endl; break;
		case YAML::NodeType::Undefined: std::cout << "Undefined" << std::endl; break;
		}
	}

	if (!_config.IsMap())
	{
		_status = NOT_OK;
		std::cerr << "TaskManager: `" + config_file + "` is not a valid config file" << std::endl;
		return;
	}
}

void Config::get_services()
{

	for (YAML::const_iterator it = _config.begin(); it != _config.end(); ++it)
	{
		std::cout << "Service name = : "  << it->first.as<std::string>() << std::endl;


		// std::cout << " | Value: " << it->second.as<std::map>() << std::endl;
	}

}
