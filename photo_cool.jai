main :: () {
    InitWindow(800, 450, "photo cool");
    defer CloseWindow();

    SetWindowState(.FLAG_WINDOW_RESIZABLE);

    image := LoadImage("photo.png");
    ImageFormat(*image, .PIXELFORMAT_UNCOMPRESSED_R8G8B8A8);
    texture := LoadTextureFromImage(image);

    pixels : [..] u8;
    pixels.data = image.data;
    pixels.count = image.width * image.height * 4;

    scale := 0.3;
    pixel_index := 0;

    while !WindowShouldClose() {
        wheel := GetMouseWheelMove();
        scale += (wheel/10);
        if (scale < 0) scale = 0;

        lower := pixel_index;
        upper := (pixel_index + pixels.count / 100) % pixels.count;
        pixel_index = (upper + 1) % pixels.count;
        for lower..upper {
            if it % 4 != 3 {
                pixels[it] = 255 - pixels[it];
            }
        }

        UpdateTexture(texture, xx pixels.data);

        BeginDrawing();
        defer EndDrawing();

        ClearBackground(RAYWHITE);

        wi := GetRenderWidth();
        hi := GetRenderHeight();

        pos := Vector2.{xx wi, xx hi} / 2;
        pos = pos - Vector2.{xx texture.width, xx texture.height} * scale / 2;

        DrawTextureEx(texture, pos, rotation=0, scale, WHITE);
    }
}

#import "raylib";
#import "Math";
#import "Basic";

#run {
    opts := get_build_options();
    if opts.user_data_string != "spawned" {
        w := compiler_create_workspace("photo_cool");

        child := get_build_options(w);
        child.output_executable_name = "photo_cool";
        child.user_data_string = "spawned";
        #if OS == .WINDOWS {
            child.additional_linker_arguments = .["/FORCE:MULTIPLE"];
        }
        set_build_options(child, w);

        add_build_file(#file, w);

        set_build_options_dc(.{do_output = false});
    }
}

#import "Compiler";
