//
// Created by Blu-ea on 21/04/25.
//

#include "../incs/taskmanager.hpp"
#include "yaml-cpp/yaml.h"

int main(){

	Config my_config("/home/Blu-ea/CLionProjects/taskmaster/test_config/TaskManager.cfg.yaml");

	if (my_config.status() != Config::OK)
		return EXIT_FAILURE;

	std::list<Service> services = my_config.get_services();
	;
}
