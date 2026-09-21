#define initApPopup(player, item, receiving, color)
    global.apPopupOpacity = 1;
    global.apPopupItem = item;
    global.apPopupPlayer = player;
    global.apPopupReceiving = receiving;
    global.apPopupColor = color;
    
    //audio_is_playing(index)
    audio_stop_sound(sndFairyHeal);
    audio_play_sound(sndFairyHeal, 0, false);
    
#define apPopupDrawGUI() // Draws the pop-up for getting and sending AP items
    // Only draw if there's sth to display and we are in the overworld
    if (global.apPopupOpacity <= 0){
        exit;
    }
    if (instance_exists(objPlayer) == false){
        global.apPopupOpacity = 0;
    }
    
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_center);
    
    // Fade out over time
    if (global.apPopupOpacity > 0.98){
        global.apPopupOpacity -= 0.0001;
    } else if (global.apPopupOpacity > 0){
        global.apPopupOpacity -= 0.05;
    }
    
    // Black background square
    draw_set_alpha(global.apPopupOpacity / 2);
    draw_set_color(c_black);
    draw_rectangle_colour(0, global.apPopupY - 60, room_width, global.apPopupY + 15, c_black, c_black, c_black, c_black, false);
    
    // Text
    draw_set_alpha(global.apPopupOpacity);
    if (global.apPopupReceiving){ // Coloful name for others
        draw_set_color(global.apPopupColor);
    } else { // White name for you
        draw_set_color(c_white);
    }
    draw_text(global.apPopupX, global.apPopupY - 20, string_lower(global.apPopupPlayer));
    draw_set_color(c_white)
    draw_text(global.apPopupX, global.apPopupY, "sent");
    draw_set_color(global.apPopupColor);
    draw_text(global.apPopupX, global.apPopupY + 20, string_lower(string_replace_all(global.apPopupItem, "\n", " ")));
