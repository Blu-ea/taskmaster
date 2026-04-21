module taskmaster;

import std::io::path;
import std::io::file;
import std::io;
import std::encoding::json;
import std::collections::object;
import std::collections::map;


fn Type get_optval(Object* obj, String key, Type def_val) <Type>
{
	switch (Type)
	{
		case int:
			if (try int res = obj.get_int(key)) return res;
		case String:
			if (try String res = obj.get_string(key)) return res;
		case bool:
			if (try bool res = obj.get_bool(key)) return res;
		default:
			io::printn("don't know");
	}

	return def_val;
}


// macro Object.@get_optval(&self, $Type, #key, #def_val, void *ret)
// {
// 	switch ($Type)
// 	{
// 		case int:
// 			if (try int val = self.get_int(#key)) os::memval;
// 		case bool:
// 			if (try bool val = self.get_bool(#key)) (*ret) = val;
// 		case String:
// 			if (try String val = self.get_string(#key)) (*ret) = val;
// 		default:
// 			io::printn("Not int");
// 	}
// 	(*ret) = #def_val;
// }


// todo: set the result to be hashMap
fn Service[]? load(Path file_path) {
	String file_content = (String) file::load_path(mem, file_path)!;
	defer free(file_content);

	HashMap {String, Service} new_services;

	Object* a = json::parse(mem, file_content)!;

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
			// StartupPlan? auto_restart;
			// ichar*? normal_exit_code;
			
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

			// int num_proc 				= get_optval{int}	(value, "num_proc", 1);
			// bool auto_start				= get_optval{bool}	(value, "auto_start", false);
			// int startup_grace_period	= get_optval{bool}	(value, "startup_grace_period", 10);
			// int num_retry =				= get_optval{int}	(value, "num_retry", 3);
			// int stop_timeout =			= get_optval{int}	(value, "stop_timeout", 10);
			// String logfile =			= get_optval{String}(value, "logfile", "");
			// String errfile =			= get_optval{String}(value, "errfile", "");

			// if (logfile == "discard") logfile = "";
			// if (errfile == "discard") errfile = "";
		};
	};


	return io::FILE_NOT_FOUND~;
}

fn void missing_key(Path file_path, String service_name, String key)
{
	io::printfn("Error: `%s`: Missing key `%s` in service `%s`", file_path, key, service_name);
}
// fn String? Object.get_string(&self, String key)
