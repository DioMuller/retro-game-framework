#include "game.h"
#include "graphics.h"
#include "tiles/SampleTile.h"

int main()
{

    load_tileset(0, 4, SampleTile_tiles);    
    commit_framebuffer();
    
    while(1)
    {
        wait_for_next_frame();
    }
    
    return 0;
}