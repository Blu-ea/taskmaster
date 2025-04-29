//
// Created by Blu-ea on 21/04/25.
//

#ifndef CONFIG_HPP
#define CONFIG_HPP
#include <string>

#include "yaml-cpp/node/node.h"

class Service;

class Config {

public:
	Config();
	explicit Config(const std::string&);
	~Config() = default;


	enum Status
	{
		OK,
		NOT_OK,
		NOT_INITIALIZED,
	};
	[[nodiscard]] Status status() const { return _status;}
	[[nodiscard]] std::list<Service> get_services() const;

private:
	YAML::Node _config;
	Status _status;
	std::string config_file_name;

};



#endif //CONFIG_HPP
