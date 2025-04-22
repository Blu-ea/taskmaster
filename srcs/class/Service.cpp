//
// Created by Blu-ea on 21/04/25.
//

#include "../../incs/class/Service.hpp"

Service::Service(const Service& rhs)
{
	std::cout << "const copy" << std::endl;
	_name = rhs._name;
	_cmd = rhs._cmd;
	num_procs = rhs.num_procs;
	auto_start = rhs.auto_start;
	auto_restart = rhs.auto_restart;
	normal_exit_code = rhs.normal_exit_code;
	startup_grace_period = rhs.startup_grace_period;
	num_retry = rhs.num_retry;
	stop_signal = rhs.stop_signal;
	stop_timeout = rhs.stop_timeout;
	log_file = rhs.log_file;
	umask = rhs.umask;

}

void Service::set_name(std::string name)
{
	_name = name;
}
