module taskmaster::common;
import std::net::os;
import std::io;

extern fn CInt unlink(ZString pathname);

fn void? loop_read_and_send(NativeSocket fd)
{
	while (true)
	{
		io::print("TaskMasterCli> ");
		@pool()
		{
			String? line = io::treadline();
			if (catch excuse = line)
			{
				if (excuse == io::EOF)
				{
					io::printn("quit");
					break;
				}

				io::eprintfn("\nFailed to read stdin: %s", excuse);
				return excuse~;
			}

			if (line.to_lower_tcopy() == "quit") break;

			isz ret = sendto(fd, line, line.len, 0, null, null);
			if (ret < 0)
			{
				io::eprintfn("\nFailed to send data to socket: %s", os::socket_error());
				return os::socket_error()~;
			}
		};
	}
	io::printn("Exiting...");
}