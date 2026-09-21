#define OnPlayerDamage(dodge, damage) // Send death link when player dies
    if (dodge == 0){
        // Ignore dodged hits
        if (instance_exists(objPlayer) && objPlayer.hp == 0){
            send_death();
        }
    }

#define send_death() // Send a POST to the server to start a death link
    http_post_string(global.URL + "Death", "Test");

#define send_get_deathlink() // Senda GET to the server to receive a pending death link
    http_get(global.URL + "Deathlink");

#define get_death_response(str_json) // Show a popup when sending a death link
    jsonErrorHandling(str_json);
    
    variable_global_set("death", json_decode(str_json));
    var death = variable_global_get("death", "map");
    
    // Save kill time so we don't double kill
    global.previousDeathlinkTime = death[? "time"];
    initApPopup("you", "death to your friends", false, c_red);
    
#define get_deathlink(str_json) // Kill the player and show popup on receiving a death link
    jsonErrorHandling(str_json);
    
    variable_global_set("death", json_decode(str_json));
    var death = variable_global_get("death", "map");
    
    if (instance_exists(objPlayer) && !is_undefined(death[? "Time"]) && death[? "Time"] > global.previousDeathlinkTime){
        // Save kill time so we don't double kill
        global.previousDeathlinkTime = death[? "Time"];
        initApPopup(death[? "Source"], death[? "Cause"], true, c_red);
        
        // Kill player
        objPlayer.hp = 0;
    }
