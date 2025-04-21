//
// Created by Blu-ea on 21/04/25.
//

#ifndef SERVICE_HPP
#define SERVICE_HPP
#include <string>
#include <vector>


class Service {
public:
	Service();
	~Service();

	enum AutoRestart
	{
		ALWAYS,
		NEVER,
		UNEXPECTED_EXIT,
	};
	struct LogFiles
	{
		int stdout_fd;
		int stderr_fd;
	};
private:
	std::string _name;

	std::string _cmd;
	int num_procs = 1;
	bool auto_start = true;
	AutoRestart auto_restart;
	std::vector<int> normal_exit_code = std::vector(1,0);
	int startup_grace_period = 10;
	int num_retry = 3;
	short int stop_signal;
	int stop_timeout = 10;
	LogFiles log_file;
	mode_t umask;
};



#endif //SERVICE_HPP
