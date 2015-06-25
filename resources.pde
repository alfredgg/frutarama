PImage right_img;
PImage wrong_img;
PImage gamestartLogo;
PImage te_toca;
PImage me_toca;
PImage recordboxImg;
PImage aprieta;

AudioPlayer right_sound;
AudioPlayer wrong_sound;
AudioPlayer little_right_sound;
AudioPlayer record_sound;
AudioPlayer bmusic;

PImage[] iOptions;
PImage[] recordParty;
int[] options; 
int record_party_size;

void load_resources() {
  gamestartLogo = loadImage("title.png");
  te_toca = loadImage("te_toca.png");
  me_toca = loadImage("me_toca.png");
  recordboxImg = loadImage("recordbox.png");
  aprieta = loadImage("aprieta.png");
  
  JSONObject json = loadJSONObject("settings.json");
  
  record_party_size = json.getInt("record_party_size");
  
  String right_img_name = json.getString("right_img");
  String wrong_img_name = json.getString("wrong_img");
  String n_right_sound = json.getString("right_sound");
  String n_wrong_sound = json.getString("wrong_sound");
  String nl_right_sound = json.getString("little_right_sound");
  String n_record = json.getString("record_sound");
  String n_music = json.getString("music");
  
  JSONArray party_images = json.getJSONArray("record_party");
  recordParty = new PImage[party_images.size()];
  for (int i=0; i<party_images.size(); i++) {
    String fname = party_images.getString(i);
    recordParty[i] = loadImage(fname);
  }
  
  right_sound = (n_right_sound.length() > 0) ? minim.loadFile(n_right_sound, 5000) : null;
  wrong_sound = (n_wrong_sound.length() > 0) ? minim.loadFile(n_wrong_sound, 5000) : null;
  little_right_sound = (nl_right_sound.length() > 0) ? minim.loadFile(nl_right_sound, 5000) : null;
  record_sound = (n_record.length() > 0) ? minim.loadFile(n_record, 5000) : null;
  bmusic = (n_music.length() > 0) ? minim.loadFile(n_music, 5000) : null;
  
  recordName = json.getString("ini_record_name");
  record = json.getInt("ini_record_value");
  time_try = json.getInt("seconds_try");
  
  right_img = loadImage(right_img_name);
  wrong_img = loadImage(wrong_img_name);
}

int decode_key(String key_name) {
  if (key_name.length() == 1) return (int)key_name.charAt(0);
  if (key_name.toUpperCase().equals("UP")) return 38;
  else if (key_name.toUpperCase().equals("DOWN")) return 40;
  else if (key_name.toUpperCase().equals("LEFT")) return 37;
  else if (key_name.toUpperCase().equals("RIGHT")) return 39;
  else if (key_name.toUpperCase().equals("CLICK")) return -5;
  return 0;
}

void load_options() {
  JSONObject json = loadJSONObject("settings.json");
  JSONArray _options = json.getJSONArray("options");
  
  iOptions = new PImage[_options.size()];
  options = new int[_options.size()];
  
  JSONObject _option;
  for (int i=0; i<_options.size(); i++) {
    _option = _options.getJSONObject(i);
    String key_name = _option.getString("key");
    String img_name = _option.getString("image");
    options[i] = decode_key(key_name);
    iOptions[i] = loadImage(img_name);
  }
}

void play_sound(AudioPlayer sound) {
  if (sound == null) return;
  sound.rewind();
  sound.play();
}
