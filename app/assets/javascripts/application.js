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
//= require_tree .

var keyConceptCount = 1;
var subConceptCount = 1;

var addKeyConcept = function() {
    var keyConceptHolder = document.getElementById("keyConceptHolder");

    var textbox = document.createElement("input");
    textbox.type = "text";
    textbox.value = "Key Concept #" + keyConceptCount;
    textbox.name = "key_concept[info]";
    textbox.className = "keyConcept";
    textbox.id = keyConceptCount;

    var subConceptButton = document.createElement("input");
    subConceptButton.id = "subConceptButton";
    subConceptButton.type = "button";
    subConceptButton.value = "Add Sub Concept";
    subConceptButton.className = "btn btn-primary btn-sm";
    subConceptButton.setAttribute('onClick','addSubConcept(' + keyConceptCount + ')');

    var subConceptHolder = document.createElement("div");
    subConceptHolder.id = "subConceptHolder" + keyConceptCount;
    subConceptHolder.className = "subConceptHolder";

    var lineBreak = document.createElement("br");

    keyConceptHolder.appendChild(textbox);
    keyConceptHolder.appendChild(subConceptButton);
    keyConceptHolder.appendChild(subConceptHolder);
    keyConceptHolder.appendChild(lineBreak);

    keyConceptCount += 1;
};

var addSubConcept = function(count) {
	var textbox = document.createElement("input");
  textbox.type = "text";
	textbox.value = "Sub Concept #" + subConceptCount;
	textbox.name = "sub_concept[info]";
	textbox.className = "subConcept";
	textbox.id = count;

	var lineBreak = document.createElement("br");

	subConceptHolder.append(textbox);
	subConceptHolder.append(lineBreak);

	subConceptCount += 1;
};

var instructorCount = 1;

var addInstructor = function() {
	var instructorHolder = document.getElementById("instructorHolder");

	var textbox = document.createElement("input");
	textbox.type = "text";
	textbox.value = "Instructor Username #" + instructorCount;
	textbox.className = "instructor";
	textbox.name = "instructors[" + instructorCount + "]";
	textbox.id = instructorCount;

  var lineBreak = document.createElement("br");

	instructorHolder.appendChild(textbox);
	instructorHolder.appendChild(lineBreak);

	instructorCount += 1;
};


$(function(){
 	$("#submitButton").on("click", function(event) {
 		event.preventDefault();
		var keyArray = $(".keyConcept");
		var keyHash = {};

		var subArray = $(".subConcept");
		var subHash = {};

		// Be careful: keyHash and subHash are in reverse order!
		for (i = 0; i < keyArray.length; i++) {
			keyHash[keyArray[i].id] = keyArray[i].value
		};

		// ID numbers are values here because keys can't be repeated
		// And we want repeatable ID numbers (e.g. several subs for key ID #1)
		for (i = 0; i < subArray.length; i++) {
			subHash[subArray[i].value] = subArray[i].id
		};

		var lesson = $(".title").val();
		var course = $("#submitButton").data("course");

		console.log(keyHash, subHash, course);
		$.post("/courses/" + course + "/lessons", {
		  keyHash: keyHash,
		  subHash: subHash,
		  lesson: lesson
		}, function(response) {
			window.location.href = '/courses/' + course;
		});
	});
});
