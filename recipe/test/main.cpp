#include <meshoptimizer.h>

#include <cstddef>

int main()
{
    const unsigned int indices[] = {0, 1, 2};
    const float vertices[] = {
        0.0f, 0.0f, 0.0f,
        1.0f, 0.0f, 0.0f,
        0.0f, 1.0f, 0.0f,
    };
    unsigned int remap[3] = {};

    const std::size_t vertex_count = meshopt_generateVertexRemap(
        remap, indices, 3, vertices, 3, 3 * sizeof(float));

    return vertex_count == 3 ? 0 : 1;
}
