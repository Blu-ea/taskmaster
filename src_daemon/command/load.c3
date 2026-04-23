module taskmaster::daemon::command;

import std::io::path;
import std::io::file;
import std::io;
import std::encoding::json;
import std::collections::object;
import std::collections::map;


// todo: set the result to be hashMap
fn void? load(Path file_path, HashMap {String, Service*}* service_map) {
	String file_content = (String) file::load_path(mem, file_path)!;
	defer free(file_content);

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

			// Object*? t_auto_restart = value.get("auto_restart");
			// if (catch err = t_auto_restart){
			// 	missing_key(file_path, service_name, "auto_restart");
			// 	break;
			// }
			// StartupPlan auto_restart = t_auto_restart.to_value(StartupPlan, strict: false)!!;
			StartupPlan auto_restart = NEVER;

			// Object*? t_stop_signal = value.get("stop_signal");
			// if (catch err = t_stop_signal){
			// 	missing_key(file_path, service_name, "stop_signal");
			// 	break;
			// }
			// Signal stop_signal = t_stop_signal.to_value(Signal, strict: false)!!;
			Signal stop_signal = TERM;

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
			// io::printn(*service);
			service_map.set(service_name, service);
		};
	};
}


fn void missing_key(Path file_path, String service_name, String key)
{
	io::printfn("Error: `%s`: Missing key `%s` in service `%s`", file_path, key, service_name);
}
