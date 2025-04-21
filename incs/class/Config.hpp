//
// Created by Blu-ea on 21/04/25.
//

#ifndef CONFIG_HPP
#define CONFIG_HPP
#include <string>

#include "yaml-cpp/node/node.h"

class Config {

public:
	Config() = delete;
	explicit Config(const std::string&);
	~Config() = default;


	enum Status
	{
		OK,
		NOT_OK,
	};
	[[nodiscard]] Status status() const { return _status;}
	void get_services();

private:
	YAML::Node _config;
	Status _status;
	std::string config_file_name;

};



#endif //CONFIG_HPP
