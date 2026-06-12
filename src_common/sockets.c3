module taskmaster::common;
import std::net::os;

extern fn sz recvfrom(CInt sockfd, void* buf, usz len, CInt flags, SockAddrPtr src_addr, Socklen_t* addrlen);
extern fn sz sendto(CInt sockfd, void* buf, usz len, CInt flags, SockAddrPtr dest_addr, Socklen_t addrlen);

const SERVER_SOCKET_FILE = "/tmp/taskmaster.sock";

struct SockAddrUn
{
	short sun_family;
	char[108] sun_path;
}

fn NativeSocket? make_socket()
{
	NativeSocket fd = os::socket(os::AF_UNIX, os::SOCK_DGRAM, (os::AIProtocol)0);

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
	CInt ret = os::bind(fd, (SockAddrPtr)&sockaddr_un, SockAddrUn::size);

	if (ret < 0) return os::socket_error()~;
}

fn void? connect_socket(NativeSocket fd)
{
	SockAddrUn sockaddr_un = {(short)os::AF_UNIX, SERVER_SOCKET_FILE};
	CInt ret = os::connect(fd, (SockAddrPtr)&sockaddr_un, SockAddrUn::size);

	if (ret < 0) return os::socket_error()~;
}

import std::io;

macro sz @recvfrom(NativeSocket #socket, char[] #buff, SockAddrUn* #client_addr){
	Socklen_t client_addr_len = SockAddrUn::size;

	sz read_sz = recvfrom(#socket, #buff, #buff.len - 1, 0,
								(SockAddrPtr)#client_addr, &client_addr_len);
	return read_sz;

}

macro sz @sendto(NativeSocket #socket, String #buff, SockAddrUn* #client_addr){	
	sz read_sz = sendto(#socket, #buff, #buff.len, 0, (SockAddrPtr)&client_addr, client_addr_len);
	return read_sz;
}


