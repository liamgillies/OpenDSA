/*global ODSA */
$(document).ready(function() {
    "use strict";
    var av_name = "SkipListRmvCON";
    var interpret = ODSA.UTILS.loadConfig({av_name: av_name}).interpreter;
  
    var jsav = new JSAV(av_name);
    jsav.umsg("We start with an empty SkipList");
    var ll = new SkipList(jsav);
    jsav.displayInit();
    jsav.umsg("adding one key-value pair (0, D)");
    ll.insert(new KVPair(0, "D"));
    jsav.step();
    jsav.umsg("adding another key-value pair (3, C)");
    ll.insert(new KVPair(0, "E"));
    jsav.step();
    jsav.umsg("adding one key-value pair (1, A)");
    ll.insert(new KVPair(1, "A"));
    jsav.step();
    jsav.umsg("adding another key-value pair (2, G)");
    ll.insert(new KVPair(2, "G"));
    jsav.step();
    jsav.umsg("adding another key-value pair (3, C)");
    ll.insert(new KVPair(3, "C"));
    jsav.step();
    jsav.umsg("adding another key-value pair (9, B)");
    ll.insert(new KVPair(9, "B"));
    jsav.step();
    jsav.umsg("removing key 1");
    ll.removeKey(1);
    jsav.step();
    jsav.umsg("removing key 9");
    ll.removeKey(9);
    jsav.step();
    jsav.umsg("removing key 0");
    ll.removeKey(0);
    jsav.step();
    jsav.umsg("removing key 2");
    ll.removeKey(2);
    jsav.recorded();
   });
