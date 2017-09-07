jQuery.fn.best_in_place = function () {
    'use strict';
    function setBestInPlace(element) {
        if (!element.data('bestInPlaceEditor')) {
            element.data('bestInPlaceEditor', new BestInPlaceEditor(element));
            return true;
        }
    }

    jQuery(this.context).delegate(this.selector, 'click', function () {
        var el = jQuery(this);
        if (setBestInPlace(el)) {
            el.click();
        }
    });

    this.each(function () {
        setBestInPlace(jQuery(this));
    });

    return this;
};


$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
});
