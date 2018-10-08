/* Global settings for jQuery 'Mask' plugin, see:
 * https://igorescobar.github.io/jQuery-Mask-Plugin/docs.html#global-options
 * All settings are defaults except dataMask and watchInputs are set to false.
 */
$.jMaskGlobals = {
  dataMask: false,
  watchInputs: false,
  maskElements: 'input,td,span,div',
  dataMaskAttr: '*[data-mask]',
  watchInterval: 300,
  watchDataMask: false,
  byPassKeys: [9, 16, 17, 18, 36, 37, 38, 39, 40, 91],
  translation: {
    '0': { pattern: /\d/ },
    '9': { pattern: /\d/, optional: true },
    '#': { pattern: /\d/, recursive: true },
    'A': { pattern: /[a-zA-Z0-9]/ },
    'S': { pattern: /[a-zA-Z]/ },
  }
};

function addressPositionModal() {
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

function addressLoadModal(itemId) {
  $('#modalBackground').show();
  $(itemId).show();
  addressPositionModal();
}

function addressCloseModal() {
  $('#modalBackground').hide();
  $('#new-modal>div').hide();
}

/**
* Clears and resets the contents of the user help modal
* (before it gets populated with results of AJAX call).
*/
function resetUserHelpModal(modalSelector) {
  var modal = document.querySelector(modalSelector);
  var modalTitle = modal.querySelector('.userHelpModalTitle');
  var modalBody = modal.querySelector('.userHelpModalBody');
  modalTitle.innerHTML = '';
  modalBody.innerHTML = 'Loading...';
}

/**
* Populates a user help modal with content.  With the first three
* arguments bound (using '.bind'), this is used as the callback
* function for AJAX calls that fetch a user help page.  It extracts
* the relevant content from the help page and adds it to the modal.
*
* @param modalId {string} - ID of the target modal.
* @param helpItemIds {array of strings} - IDs of the source help items.
* @param title {string or undefined} - modal title to use with multiple help items.
* @param helpPageString {string} - HTML of the help page.
*/
function populateUserHelpModal(modalId, helpItemIds, title, helpPageString) {
  var parser = new DOMParser();
  var helpPage = parser.parseFromString(helpPageString, "text/html");

  var modal = document.getElementById(modalId);
  var modalTitle = modal.querySelector(".userHelpModalTitle");
  var modalBody = modal.querySelector(".userHelpModalBody");

  if (title) {
    modalTitle.innerHTML = title;
    // Remove "Loading..." or other text from modal body.
    modalBody.innerHTML = "";

    helpItemIds.forEach(function (helpItemId) {
      var helpItem = helpPage.getElementById(helpItemId);

      // Remove the permalink anchor tag from the help title.
      var helpTitle = helpItem.querySelector("h2");
      helpTitle.innerHTML = helpTitle.firstChild.textContent;

      while (helpItem.firstChild) {
        modalBody.appendChild(helpItem.firstChild);
      }
    });

  } else {
    var helpItem = helpPage.getElementById(helpItemIds[0]);
    var helpTitle = helpItem.querySelector("h2");

    modalTitle.innerHTML = helpTitle.firstChild.textContent;

    helpItem.removeChild(helpTitle);
    modalBody.innerHTML = helpItem.innerHTML;
  }
};

function setFileUploadClickHandler() {
  $(".fileUploadLabel input")
    .off()
    .on('change', function (event) {
      var filename = event.target.files[0].name;

      var wrapper = $(event.target).closest('.fileUploadWrapper');
      wrapper
        .find('.fileUploadButton')
        .text('Replace...');
      wrapper
        .find('.previousFile')
        .text(filename);
    });
}

/**
* Add a click handler function to a user help modal link, and remove any
* existing click handler. Title is optional; is absent (undefined) to show a
* single help item.
*
* @param helpLinkSelector {string} - Selector for the help link.
* @param helpDocsPath {string} - Path to the help doc html file.
* @param helpItemIds {array of strings} - IDs of the source help items.
* @param title {string or undefined} - Title to use with multiple help items.
*/
function setUserHelpClickHandler(
    helpLinkSelector,
    helpDocsPath,
    helpItemIds,
    title
) {
  $(helpLinkSelector)
    .off("click")
    .click(function userHelpClickHandler() {
      resetUserHelpModal('#user-help-modal');
      addressLoadModal('#user-help-modal');
      $.get(
        ctx + helpDocsPath,
        populateUserHelpModal.bind(
          undefined,
          'user-help-modal',
          helpItemIds,
          title
        )
      );
    });
};

function postJson(settings) {
  var token = $("meta[name='_csrf']").attr("content");
  var header = $("meta[name='_csrf_header']").attr("content");
  $.extend(settings, {
    type: "post",
    dataType: "json",
    beforeSend: function (xhr) {
      xhr.setRequestHeader(header, token);
    },
  })
  $.ajax(settings);
}

/**
* Changes the page size to the given value
* @param size the new page size
*/
function changePageSize(size) {
  var form = $('form.paginationForm').first();
  form.find('input[name=pageSize]').val(size);
  form.find('input[name=pageNumber]').val(1);
  form.submit();
}

/**
* Changes the page number to the given value
* @param page the new page number
*/
function changePageNumber(page) {
  var form = $('form.paginationForm').first();
  form.find('input[name=pageNumber]').val(page);
  form.submit();
}

function updateLoginCsrfAndSubmit() {
  var form = $("#loginform");
  if (form.attr("submitting") == undefined) {
    form.attr("submitting", true);
    $.ajax({
      url: ctx + "/csrf",
      cache: false,
      success: function submitWithNewCsrf(data) {
        $("#loginForm input[name=_csrf]").val(data.token);
        $("#loginForm").off().submit();
      },

      error: function submissionFailed() {
        form.removeAttr("submitting");
      }
    })
  }

  return false;
}

/**
 * Submits the form with the given id.
 * @param id the id of the form to be submitted
 */
var submitFormById = (function IIFE() {
  // prevent double clicks from doing double submits
  var submitEnabled = true;

  return function submitFormById(id, url) {
    if (submitEnabled) {
      submitEnabled = false;
      var form = $("#" + id);
      if (url) {
        form.attr("action", url);
      }

      form.submit();
    }
  };
})();

$(document).ready(function () {

  $('.searchPanel input[type="checkbox"]')
    .css("border", "none")
    .css("background", "none")
    .css("position", "relative")
    .css('top', "-1px");

  $(".closeModal, .modalCloseButton").click(addressCloseModal);

  $(".submitApplicationModalBtn").click(function () {
    addressCloseModal();
    addressLoadModal('#submitApplicationModal');
  });

  $(".saveAsDraftModalBtn").click(function () {
    addressCloseModal();
    addressLoadModal('#saveAsDraftModal');
  });

  $("input.date").mask("00/00/0000");
  $("input.ssnMasked").mask("000-00-0000");
  $("input.npiMasked").mask("0000000000");
  $("input.umpiMasked").mask("AAAAAAAAAA");
  $("input.feinMasked").mask("00-0000000");
  $("input.taxIdMasked").mask("0000000");
  $("input.countyMask").mask("000");
  $("input.fiscalMonthInput, input.fiscalYearInput").mask("00");

  setFileUploadClickHandler();

  $("#loginForm").submit(updateLoginCsrfAndSubmit);
});
