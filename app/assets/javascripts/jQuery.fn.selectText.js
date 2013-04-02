/**
   From
   http://stackoverflow.com/questions/985272/
   jquery-selecting-text-in-an-element-akin-to-highlighting-with-your-mouse#answer-987376

   A jQuery function to select the text of an element.  This does not
   move it to the copy buffer.
 */
jQuery.fn.selectText = function(){
    var doc = document
        , element = this[0]
        , range, selection
    ;
    if (doc.body.createTextRange) {
        range = document.body.createTextRange();
        range.moveToElementText(element);
        range.select();
    } else if (window.getSelection) {
        selection = window.getSelection();        
        range = document.createRange();
        range.selectNodeContents(element);
        selection.removeAllRanges();
        selection.addRange(range);
    }
};
