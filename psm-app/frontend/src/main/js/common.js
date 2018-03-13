$(document).ready(function () {

  $('.searchPanel input[type="checkbox"]')
    .css("border", "none")
    .css("background", "none")
    .css("position", "relative")
    .css('top', "-1px");

  addressPositionModal = function () {
    var wWidth  = window.innerWidth;
    var wHeight = window.innerHeight;

    if (wWidth == undefined) {
      wWidth  = document.documentElement.clientWidth;
      wHeight = document.documentElement.clientHeight;
    }

    boxLeft = parseInt((wWidth / 2) - ($("#new-modal").width() / 2));
    //var boxTop  = parseInt((wHeight / 2) - ( $("#new-modal").height() / 2 ));

    // position modal
    $("#new-modal").css({
      'margin': 120 + 'px auto 0 ' + boxLeft + 'px'
    });

    $("#modalBackground").css("opacity", "0.8");

    if ($("body").height() > $("#modalBackground").height()) {
      $("#modalBackground").css("height", $("body").height() + "px");
    }

    if ($('#new-modal').height() > $("#modalBackground").height()) {
      $("#modalBackground").css("height", $('#new-modal').height() + 120 + "px");
    }

    $(window).scrollTop(0);
  };

  addressLoadModal = function (itemId) {
    $('#modalBackground').show();
    $(itemId).show();
    addressPositionModal();
  }

  addresscloseModal = function () {
    $('#modalBackground').hide();
    $('#new-modal>div').hide();
  }

  /**
  * Clears and resets the contents of the user help modal
  * (before it gets populated with results of AJAX call).
  */
  resetUserHelpModal = function (modalSelector) {
    var modal = document.querySelector(modalSelector);
    var modalTitle = modal.querySelector('.userHelpModalTitle');
    var modalBody = modal.querySelector('.userHelpModalBody');
    modalTitle.innerHTML = '';
    modalBody.innerHTML = 'Loading...';
  }

  /**
  * Populates a user help modal with content.  With the first two
  * arguments bound (using '.bind'), this is used as the callback
  * function for AJAX calls that fetch a user help page.  It extracts
  * the relevant content from the help page and adds it to the modal.
  *
  * @param modalId {string} - ID of the target modal.
  * @param helpItemId {string} - ID of the source help item.
  * @param helpPageString {string} - HTML of the help page.
  */
  populateUserHelpModal = function (modalId, helpItemId, helpPageString) {
    var parser = new DOMParser();
    var helpPage = parser.parseFromString(helpPageString, "text/html");

    var helpItem = helpPage.getElementById(helpItemId);
    var helpTitle = helpItem.querySelector("h2");

    var modal = document.getElementById(modalId);
    var modalTitle = modal.querySelector(".userHelpModalTitle");
    var modalBody = modal.querySelector(".userHelpModalBody");

    modalTitle.innerHTML = helpTitle.firstChild.textContent;

    helpItem.removeChild(helpTitle);
    modalBody.innerHTML = helpItem.innerHTML;
  };

  /**
  * Add a click handler function to a user help modal link.
  *
  * @param helpLinkSelector {string} - Selector for the help link.
  * @param helpDocsPath {string} - Path to the help doc html file.
  * @param helpItemId {string} - ID of the source help item.
  */
  addUserHelpClickHandler = function (helpLinkSelector, helpDocsPath, helpItemId) {
    $(helpLinkSelector).click(function () {
      resetUserHelpModal('#user-help-modal');
      addressLoadModal('#user-help-modal');
      $.get(
        ctx + helpDocsPath,
        populateUserHelpModal.bind(
          undefined,
          'user-help-modal',
          helpItemId
        )
      );
    });
  };

  $(".closeModal, .modalCloseButton, #new-modal #printModal .modal-title a.greyBtn")
    .click(addresscloseModal);

});
