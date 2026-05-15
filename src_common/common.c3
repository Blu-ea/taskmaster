module taskmaster::common;
import std::net::os;
import std::io;

extern fn CInt unlink(ZString pathname) @cname("unlink");
extern fn ZString readline(ZString prompt) @cname("readline");
extern fn void free(void *ptr) @cname("free");

fn void? loop_read_and_send(NativeSocket fd, ZString prompt)
{
	while (true) @pool()
	{
		ZString line = readline(prompt);
		defer free(line);
		if (line == null)
		{
			io::printn("quit");
			break;
		}

		if (line == "quit") break;

		sz ret = sendto(fd, line, line.len(), 0, (SockAddrPtr)null, null);
		if (ret < 0)
		{
			io::eprintfn("\nFailed to send data to socket: %s", os::socket_error());
			return os::socket_error()~;
		}
	};
	io::printn("Exiting...");
}