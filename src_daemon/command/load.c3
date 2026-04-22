module taskmaster::daemon::command;

import std::io::path;
import std::io::file;
import std::io;
import std::encoding::json;
import std::collections::object;
import std::collections::map;


// todo: set the result to be hashMap
fn Service[]? load(Path file_path) {
	String file_content = (String) file::load_path(mem, file_path)!;
	defer free(file_content);

	HashMap {String, Service} new_services;

	Object* a = json::parse(mem, file_content)!;
	defer free(a);

	a.@each_entry(;String service_name, Object* value)
	{
		do{
			if(!value.is_keyable()) {
				io::printfn("Error: `%s`: Service `%s` is not a dictionary", file_path, service_name);
				break;
			}

			String? cmd = value.get_string("cmd");
			if(catch err = cmd) {
				missing_key(file_path, service_name, "cmd");
				break;
			}
			//	Enum doesn't seems to work properly :(
			//	todo : Waiting for a response  - https://github.com/c3lang/c3c/issues/3163
			StartupPlan auto_restart = NEVER;
			Signal stop_signal = TERM;

				// StartupPlan auto_restart = value.get_enum(StartupPlan, "auto_restart")!;

				// String? auto_restart_string = value.get_string("auto_restart");
				// if(catch err = auto_restart_string) {
				// 	missing_key(file_path, service_name, "auto_restart");
				// 	break;
				// }
				// StartupPlan auto_restart = StartupPlan::lookup_field(e_val, auto_restart_string);
				// io::printn(auto_restart);
				
				// int? stop_signal = value.get_int("stop_signal");
				// if(catch err = stop_signal) {
				// 	missing_key(file_path, service_name, "stop_signal");
				// 	break;
				// }

			String? umask = value.get_string("umask");
			if(catch err = umask) {
				missing_key(file_path, service_name, "umask");
				break;
			}

			ichar[] normal_exit_code;
			if(try Object* list = value.get("normal_exit_code") && list.is_indexable()) {
				sz size = list.get_len();
				normal_exit_code = mem::new_array(ichar, size);
				io::printn(size);
				for (sz i = 0; i < size; i++){
					normal_exit_code[i] = list.get_ichar_at(i)!;
				}
			}
			else {
				normal_exit_code = mem::new_array(ichar, 1);
			}

			int num_proc = value.get_int("num_proc") ?? 1;
			bool auto_start = value.get_bool("auto_start") ?? false;
			int startup_grace_period = value.get_int("startup_grace_period") ?? 10;
			int num_retry = value.get_int("num_retry") ?? 3;
			int stop_timeout = value.get_int("stop_timeout") ?? 10;
			String logfile = value.get_string("logfile") ?? "";
			String errfile = value.get_string("errfile") ?? "";

			if (logfile == "discard") logfile = "";
			if (errfile == "discard") errfile = "";
			
			Service* service = daemon::new_service(
				cmd,
				num_proc,
				auto_start,
				auto_restart,
				startup_grace_period,
				num_retry,
				stop_signal,
				stop_timeout,
				logfile,
				errfile,
				umask,
				normal_exit_code
			);
			io::printn(*service);
		};
	};


	return io::FILE_NOT_FOUND~;
}


fn void missing_key(Path file_path, String service_name, String key)
{
	io::printfn("Error: `%s`: Missing key `%s` in service `%s`", file_path, key, service_name);
}
