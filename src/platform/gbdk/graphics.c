#include "graphics.h"
#include <gb/gb.h>

void load_tileset(platform_size_t start, platform_size_t size, const byte_t *data)
{
    set_bkg_data(start, size, data);
}

void draw_tiles(platform_size_t x, platform_size_t y, platform_size_t width, platform_size_t height, const byte_t *data)
{
    set_bkg_tiles(x, y, width, height, data);
}

void commit_framebuffer()
{
    SHOW_BKG;
}