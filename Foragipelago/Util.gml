#define string_split(str, delimiter) //Because this api doesn't have access to something like that
    ret = [];
    num = "";
    index = 0;
    
    for (var i = 0; i < string_length(str); i++){
        if (string_char_at(str, i) != delimiter){
            if (string_char_at(str, i) != "[" and string_char_at(str, i) != "]"){
                num += string_char_at(str, i);
            }
        } else {
            ret[index] = real(num);
            num = "";
            index++;
        }
    }
    ret[index] = real(num);
    return ret;
    
#define array_remove_value(array, value)
    ret = [];
    
    for (i = 0; i < array_length(array); i++){
        if (array[i] != value){
            array_push(ret, array[i]);
        }
    }
    
    return ret;
