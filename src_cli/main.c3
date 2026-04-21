module taskmaster::cli;
import taskmaster::common;
import std::net::os;
import std::io;

fn int main(String[] args)
{
	NativeSocket? fd = common::make_socket();
	if (catch fd)
	{
		io::eprintn("Failed to create Unix Domain socket");
		return 1;
	}
	defer (void)fd.close();

	if (catch common::connect_socket(fd))
	{
		io::eprintn("Failed to connect Unix Domain socket");
		return 1;
	}

	if (catch common::loop_read_and_send(fd)) return 1;

	return 0;
}
