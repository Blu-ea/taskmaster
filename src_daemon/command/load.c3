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

			StartupPlan? auto_restart;
			@get_enum(StartupPlan, "str_value", "auto_restart", value, auto_restart);
			if (catch err = auto_restart){
				missing_key(file_path, service_name, "auto_restart");
				break;
			}

			Signal? stop_signal;
			@get_enum(Signal, "str_value", "stop_signal", value, stop_signal);
			if (catch err = stop_signal){
				missing_key(file_path, service_name, "stop_signal");
				break;
			}

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
			service_map.set(service_name, service);
		};
	};
}

macro void @get_enum($Type, $e_key, $o_key, #object, #ret)
{
	Object*? t_object = #object.get($o_key);
	if (catch err = t_object){
		#ret = NOT_FOUND~;
		return;
	}
	int ordinal_value;
	switch {
		case @ok(@try( ordinal_value, t_object.to_value(int, strict: false))):
			if (ordinal_value < $Type::len)
				{#ret = $Type::from_ordinal(ordinal_value);}
			else
				{#ret = NOT_FOUND~;}
		case t_object.is_string():
			#ret = runtime::@enum_lookup($Type, $e_key, t_object.to_value(String)); // not_found
		default:
			#ret = TYPE_MISMATCH~;
	}
	
}

fn void missing_key(Path file_path, String service_name, String key)
{
	io::printfn("Error: `%s`: Missing key `%s` in service `%s`", file_path, key, service_name);
}
