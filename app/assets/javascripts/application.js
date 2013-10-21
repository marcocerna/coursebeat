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
var subConceptCount = [1];

function addKeyConcept() {
    var keyConceptHolder = document.getElementById("keyConceptHolder");

    var textbox = document.createElement("input");
    textbox.type = "text";
    textbox.value = "Key Concept #" + keyConceptCount;
    textbox.name = "key_concept[info]";

    var subConceptButton = document.createElement("input");
    subConceptButton.id = "subConceptButton";
    subConceptButton.type = "button";
    subConceptButton.value = "Add Sub Concept";
    subConceptButton.className = "btn btn-primary btn-sm";
    subConceptButton.setAttribute('onClick','addSubConcept(' + keyConceptCount + ')');

    var subConceptHolder = document.createElement("div");
    subConceptHolder.id = "subConceptHolder" + keyConceptCount;

    var lineBreak = document.createElement("br");

    keyConceptHolder.appendChild(textbox);
    keyConceptHolder.appendChild(subConceptButton);
    keyConceptHolder.appendChild(subConceptHolder);
    keyConceptHolder.appendChild(lineBreak);

    keyConceptCount += 1;
}

var addSubConcept = function(count) {
		var subConceptHolder = document.getElementById("subConceptHolder" + count);

		var textbox = document.createElement("input");
  	  	textbox.type = "text";
   		textbox.value = "Sub Concept #" + count + '.';
    	textbox.name = "sub_concept[info]";

    	var lineBreak = document.createElement("br");

    	subConceptHolder.appendChild(textbox);
    	subConceptHolder.appendChild(lineBreak);

    	subConceptCount += 1;
	}
