module taskmaster::common;
import std::net::os;

extern fn isz recvfrom(CInt sockfd, void* buf, usz len, CInt flags, SockAddrPtr src_addr, Socklen_t* addrlen);
extern fn isz sendto(CInt sockfd, void* buf, usz len, CInt flags, SockAddrPtr dest_addr, Socklen_t* addrlen);

const SERVER_SOCKET_FILE = "/tmp/taskmaster.sock";

struct SockAddrUn
{
	short sun_family;
	char[108] sun_path;
}

fn NativeSocket? make_socket()
{
	NativeSocket fd = os::socket(os::AF_UNIX, os::SOCK_DGRAM, 0);

	if (!fd.is_valid()) return os::socket_error()~;

	return fd;
}

fn NativeSocket[2]? make_socketpair()
{
	NativeSocket[2] sv;

	CInt ret = os::socketpair(os::AF_UNIX, os::SOCK_DGRAM, 0, &sv);

	if (ret < 0) return os::socket_error()~;

	return sv;
}

fn void? bind_socket(NativeSocket fd)
{
	unlink(SERVER_SOCKET_FILE);

	SockAddrUn sockaddr_un = {(short)os::AF_UNIX, SERVER_SOCKET_FILE};
	CInt ret = os::bind(fd, (SockAddrPtr)&sockaddr_un, SockAddrUn.sizeof);

	if (ret < 0) return os::socket_error()~;
}

fn void? connect_socket(NativeSocket fd)
{
	SockAddrUn sockaddr_un = {(short)os::AF_UNIX, SERVER_SOCKET_FILE};
	CInt ret = os::connect(fd, (SockAddrPtr)&sockaddr_un, SockAddrUn.sizeof);

	if (ret < 0) return os::socket_error()~;
}