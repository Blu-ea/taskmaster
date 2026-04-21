module taskmaster;
import std::io;
import std::net;
import std::io::path;

fn void main(String[] args)
{
	Path file_path = path::new(mem, "/home/amiguez/Projects/taskmaster/config_exemple/TaskManager.cfg.json")!!;
	load(file_path)!!;
	// while (try String line = io::readline(mem)){
	// 	io::printfn("read line %s", line);
	// }
	// io::printn("no more to read");
}
