// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var count_characters = function() {
  var post = $("#micropost_content").val();
  var characters = post.length;

  if (characters < 140) {
    $("#characters_remaining").html(140 - characters);
  } else {
    $("#characters_remaining").html("0");
    $("#micropost_content").val(post.substr(0, 140));
  }
};

$(function() {
  $("#micropost_content").change(count_characters);
  $("#micropost_content").keydown(count_characters);
  $("#micropost_content").keyup(count_characters);
  $("#micropost_content").click(count_characters);
});
