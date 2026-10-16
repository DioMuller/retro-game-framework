#ifndef GRAPHICS_H
#define GRAPHICS_H

#include "platform.h"

void load_tileset(platform_size_t start, platform_size_t size, const byte_t *data);
void draw_tiles(platform_size_t x, platform_size_t y, platform_size_t width, platform_size_t height, const byte_t *data);
void commit_framebuffer();

#endif
