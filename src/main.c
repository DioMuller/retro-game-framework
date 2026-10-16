#include "game.h"
#include "graphics.h"
#include "tiles/SampleTile.h"

int main()
{

    load_tileset(0, 4, SampleTile_tiles);
    // draw_tiles(0, 0, 8, 8, );
    commit_framebuffer();
    
    while(1)
    {
        wait_for_next_frame();
    }
    
    return 0;
}