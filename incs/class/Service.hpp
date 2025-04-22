//
// Created by Blu-ea on 21/04/25.
//

#ifndef SERVICE_HPP
#define SERVICE_HPP


#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <csignal>

#include "yaml-cpp/node/convert.h"

class Service {
public:
	Service() = default;
	~Service() = default;
	Service(const Service&);

	enum AutoRestart
	{
		ALWAYS,
		NEVER,
		ON_FAILURE,
	};
	struct LogFiles
	{
		std::string stdout_file = "/dev/null";
		std::string stderr_file = "/dev/null";
	};
	enum class KillSignal : int{
		HUP=SIGHUP,
		INT=SIGINT,
		QUIT=SIGQUIT,
		ILL=SIGILL,
		ABRT=SIGABRT,
		FPE=SIGFPE,
		KILL=SIGKILL,
		SEGV=SIGSEGV,
		PIPE=SIGPIPE,
		ALRM=SIGALRM,
		TERM=SIGTERM,
		USR1=SIGUSR1,
		USR2=SIGUSR2,
		CHLD=SIGCHLD,
		STOP=SIGSTOP,
		TSTP=SIGTSTP,
		TTIN=SIGTTIN,
		TTOU=SIGTTOU,
	};


	void set_name(std::string name);

	friend YAML::convert<Service>;
private:
	std::string _name;

	std::string _cmd;
	int num_procs = 1;
	bool auto_start = true;
	AutoRestart auto_restart;
	std::vector<int> normal_exit_code = std::vector(1,0);
	int startup_grace_period = 10;
	int num_retry = 3;
	KillSignal stop_signal;
	int stop_timeout = 10;
	LogFiles log_file;
	mode_t umask;
};

template<>
struct YAML::convert<Service::AutoRestart>
{
	static bool decode(const Node& node, Service::AutoRestart& rhs)
	{
		std::string val = node.Scalar();
		std::transform(val.begin(), val.end(), val.begin(), ::tolower);
		std::cout << "auto_restart: " << val << std::endl;
		if (val == "always" || val == "yes" || val == "y")
			rhs = Service::AutoRestart::ALWAYS;
		else if (val == "never" || val == "no" || val == "n")
			rhs = Service::AutoRestart::NEVER;
		else if (val == "on_failure" || val == "failure" || val == "fail" || val == "f")
			rhs = Service::AutoRestart::ON_FAILURE;
		else
			return false;
		return true;
	}
};

template<>
struct YAML::convert<Service::KillSignal>
{
	static bool decode(const Node& node, Service::KillSignal& rhs)
	{
		std::cout << " signal - " << node.Type() << std::endl;
		rhs = Service::KillSignal::KILL;
		return true;
	}
};

template<>
struct YAML::convert<Service::LogFiles>
{
	static bool decode(const Node& node, Service::LogFiles& rhs)
	{
		if (!node.IsMap())
			return false;
		if (!node["stdout"] || !node["stderr"])
			return false;
		rhs.stdout_file = node["stdout"].as<std::string>();
		rhs.stderr_file = node["stderr"].as<std::string>();

		if (rhs.stdout_file == "discard") rhs.stdout_file = std::string("/dev/null");
		if (rhs.stderr_file == "discard") rhs.stderr_file = std::string("/dev/null");
		return true;
	}
};

template<>
struct YAML::convert<Service> {
	static Node encode(const Service& rhs) {
		Node node;
		std::cout << " IN ENCODE " << std::endl;
		return node;
	}

	static bool decode(const Node& node, Service& rhs) {
		std::cout << " IN DECODE " << std::endl;

		rhs._cmd = node["cmd"].as<std::string>();
		rhs.num_procs = node["num_procs"].as<int>(1);
		rhs.auto_start = node["auto_start"].as<bool>(true);
		rhs.auto_restart = node["auto_restart"].as<Service::AutoRestart>();
		rhs.normal_exit_code = node["normal_exit_code"].as<std::vector<int>>(std::vector(1,0));
		rhs.startup_grace_period = node["startup_grace_period"].as<int>(10);
		rhs.num_retry = node["num_retry"].as<int>(3);
		rhs.stop_signal = node["stop_signal"].as<Service::KillSignal>(Service::KillSignal::TERM);
		rhs.stop_timeout = node["stop_timeout"].as<int>(10);
		rhs.log_file = node["log_file"].as<Service::LogFiles>();
		rhs.umask = node["umask"].as<mode_t>();

		return true;
	}
};


#endif //SERVICE_HPP
