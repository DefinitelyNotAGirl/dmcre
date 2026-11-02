#include <dmcre/dmcred>

#include <cstring>
#include <limits>
#include <system_error>

#ifdef _WIN32
#include <winsock2.h>
#include <windows.h>
#else
#include <cerrno>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#endif

namespace dmcre {
	namespace dmcred {
		DMCRE_PUBLIC_API std::string SharedMemoryName = "C:/users/lilit/dmcre_2026100300/dmcredSharedMemory"; // this will later be set dynamically by the build system

		DMCRE_PUBLIC_API SharedMemory* getSharedMemory() {
			static HANDLE sharedMemoryHandle = [&]{
				auto handle = OpenFileMappingA(
					FILE_MAP_ALL_ACCESS,
					FALSE,
					SharedMemoryName.c_str()
				);

				if (handle == nullptr) {
					throw std::system_error(GetLastError(), std::system_category(), "Could not open shared memory object");
				}

				return handle;
			}();

			static SharedMemory* sharedMemory = [&]{
				auto mapping = MapViewOfFile(
					sharedMemoryHandle,
					FILE_MAP_ALL_ACCESS,
					0,
					0,
					sizeof(SharedMemory)
				);

				if (mapping == nullptr) {
					throw std::system_error(GetLastError(), std::system_category(), "Could not map shared memory object");
				}

				return static_cast<SharedMemory*>(mapping);
			}();

			struct SharedMemoryUnmapper {
				~SharedMemoryUnmapper() {
					if (sharedMemory != nullptr) {
						UnmapViewOfFile(sharedMemory);
					}
					if (sharedMemoryHandle != nullptr) {
						CloseHandle(sharedMemoryHandle);
					}
				}
			};

			static SharedMemoryUnmapper unmapper;

			return sharedMemory;
		}

		DMCRE_PUBLIC_API void post(std::byte* message, size_t size) {
			sockaddr address = getSharedMemory()->serverEndoint;

			if(size == 0) {
				return;
			}

			const char* data = reinterpret_cast<const char*>(message);

#ifdef _WIN32
			if (size > static_cast<size_t>(std::numeric_limits<int>::max())) {
				throw std::system_error(std::make_error_code(std::errc::message_size), "Message is too large for sendto");
			}

			WSADATA winsockData{};
			const int startupResult = WSAStartup(MAKEWORD(2, 2), &winsockData);
			if (startupResult != 0) {
				throw std::system_error(startupResult, std::system_category(), "WSAStartup failed");
			}

			const SOCKET socketHandle = ::socket(getSharedMemory()->serverEndoint.sa_family, SOCK_DGRAM, 0);
			if (socketHandle == INVALID_SOCKET) {
				const int error = WSAGetLastError();
				WSACleanup();
				throw std::system_error(error, std::system_category(), "socket creation failed");
			}

			const int result = ::sendto(socketHandle, data, static_cast<int>(size), 0,
				reinterpret_cast<const sockaddr*>(&address), static_cast<int>(sizeof(address)));
			const int error = result == SOCKET_ERROR ? WSAGetLastError() : 0;
			closesocket(socketHandle);
			WSACleanup();
			if (error != 0) {
				throw std::system_error(error, std::system_category(), "AF_UNIX datagram send failed");
			}
			if (static_cast<size_t>(result) != size) {
				throw std::system_error(std::make_error_code(std::errc::io_error), "Incomplete AF_UNIX datagram send");
			}
#else
			const int socketHandle = ::socket(AF_UNIX, SOCK_DGRAM, 0);
			if (socketHandle == -1) {
				throw std::system_error(errno, std::system_category(), "AF_UNIX socket creation failed");
			}

			const ssize_t result = ::sendto(socketHandle, data, message.size(), 0,
				reinterpret_cast<const sockaddr*>(&address), sizeof(address));
			const int error = result == -1 ? errno : 0;
			::close(socketHandle);
			if (error != 0) {
				throw std::system_error(error, std::system_category(), "AF_UNIX datagram send failed");
			}
			if (static_cast<size_t>(result) != message.size()) {
				throw std::system_error(std::make_error_code(std::errc::io_error), "Incomplete AF_UNIX datagram send");
			}
#endif
		}
	}
}