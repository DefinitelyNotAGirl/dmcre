template<typename T>
struct DataBuffer {
    T data;
    size_t size;

    DataBuffer(T data, size_t size) : data(data), size(size) {}
};