#define OnPlayerDamage(dodge, damage) // Send Death Link when player dies
    if (dodge == 0) {
        // Ignore dodged dmg
        if (instance_exists(objPlayer) && objPlayer.hp == 0) {
            Trace("Sending Death Link");
            send_death_link();
        }
    };

/*#define OnDig(x, y) // Method to test the kill function by magic shovel
    if (instance_exists(objPlayer)) {
        objPlayer.hp = 0;
        Trace("You killed me! x_x");
    }
*/
 
#define send_death_link() // Sends a POST to the server when a death occured
    var json = "{\"Death\": [" + string(id) + "]}";
    http_post_string(global.URL + "Death", json);


#define get_death_link(str_json) // Grabs a death link recieved by the server and kills the player
    if is_undefined(str_json) {
        global.errorcounter = global.errorcounter + 1
        if (global.errorcounter > 5) {
            Trace("A value seems to be constantly wrong, report this to Olixx")
            global.errorcounter = 0
        }
        return
    }
    global.errorcounter = 0
    
    if !is_string(str_json) {
        Trace("Something's off with this value, report this to Olixx")
        Trace(str_json)
    }
    
    variable_global_set("json",json_decode(str_json))
    global.json = variable_global_get("json","map")
    
    // Kill
    if (instance_exists(objPlayer)) {
        objPlayer.hp = 0;
            Trace("Receiving Death Link");
    }
