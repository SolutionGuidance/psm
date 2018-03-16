/*
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 @author TCSASSEBMLER
 @version 1.0
 */
$(document).ready(function () {
  /**
   * Get parameter value from location URL.
   *
   * @param name the name of parameter
   * @return the value of parameter
   */
  function getURLParameter(name) {
    var aParams = document.location.search.substr(1).split('&');
    if ('' == aParams) {
      return '';
    }

    for (var i = 0; i < aParams.length; i++) {
      var aParam = aParams[i].split('=');
      if (name == aParam[0]) {
        return aParam[1];
      }
    }

    return '';
  }

  if ('yes' == getURLParameter("print")) {
    window.print();
  }

  $(".printEnrollment").click(function () {
    var url = ctx + '/agent/enrollment/details?id=' + $(this).attr('rel') + '&print=yes';
    window.open(url, '', 'height=800, width=800, top=50, left=50, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no')
  });

  $("#exportEnrollmentsToPDF").click(function () {
    setupSearchFormCriteria();
    $("#exportForm").html($('#searchForm').html());
    $('#exportForm .searchFormPageNumber').val("1");
    $('#exportForm .searchFormPageSize').val("-1");
    $("#exportForm").submit();
  });

  $("#printEnrollments").click(function () {
    setupSearchFormCriteria();
    $("#printForm").html($('#searchForm').html());
    $('#printForm .searchFormPageNumber').val("1");
    $('#printForm .searchFormPageSize').val("-1");
    $("#printForm").submit();
  });

  function setupSearchFormCriteria() {
    $("#exportForm").html('');
    $("#printForm").html('');
    $("#npiSearchField").val($.trim($("#npiInput").val()));
    $("#submissionDateStartSearchField").val($("#submissionDateStartInput").val());
    $("#submissionDateEndSearchField").val($("#submissionDateEndInput").val());
    $("#providerTypeSearchField").val($("#providerTypeInput").val());
    $("#providerNameSearchField").val($.trim($("#providerNameInput").val()));

    if ($("#enrollmentFilterPanel").size() > 0 || $("#quickEnrollmentFilterPanel").size() > 0) {
      $(".requestTypeValue").remove();
      $(".riskLevelValue").remove();

      if ($("#requestTypeInput").val() != '') {
        $('#searchForm').append('<input name="requestTypes[0]" value="' + $("#requestTypeInput").val() + '" type="hidden" />');
      }

      if ($("#riskLevelInput").val() != '') {
        $('#searchForm').append('<input name="riskLevels[0]" value="' + $("#riskLevelInput").val() + '" type="hidden" />');
      }
    }

    if ($("#quickEnrollmentFilterPanel").size() > 0) {
      $(".enrollmentStatusValue").remove();
      if ($("#enrollmentStatusesInput").val() != '') {
        $('#searchForm').append('<input name="statuses[0]" value="' + $("#enrollmentStatusesInput").val() + '" type="hidden" />');
      }
    }

    if ($("#advancedFilterPanel").size() > 0) {
      $(".requestTypeValue").remove();
      $(".riskLevelValue").remove();
      $(".enrollmentStatusValue").remove();
      $("#advancedFilterPanel .requestType:checked").each(function (index, element) {
        $('#searchForm').append('<input name="requestTypes[' + index + ']" value="' + $(this).val() + '" type="hidden" />');
      });

      $("#advancedFilterPanel .enrollmentStatus:checked").each(function (index, element) {
          $('#searchForm').append('<input name="statuses[' + index + ']" value="' + $(this).val() + '" type="hidden" />');
        });

      $("#advancedFilterPanel .riskLevel:checked").each(function (index, element) {
          $('#searchForm').append('<input name="riskLevels[' + index + ']" value="' + $(this).val() + '" type="hidden" />');
        });
    }
  }

  $("#showSearchEnrollmentsResultBtn").click(function () {
    $('#searchFormPageNumber').val("1");
    setupSearchFormCriteria();
    $('#searchForm').submit();
    return false;
  });

  $("#enrollmentQuickSearch").click(function () {
    var quickSearchInput = $.trim($("#quickSearchInput").val());
    if (quickSearchInput == 'Search Keyword') {
      quickSearchInput = '';
    }

    window.location.href = ctx + "/provider/search/quick?npi=" + quickSearchInput;
    return false;
  });

  $("#queryEnrollmentStatus").click(function () {
    var enrollmentNumber = $.trim($("#enrollmentNumber").val());
    if (enrollmentNumber == '') {
      $(".enrollmentNumberError").hide();
      $("#requiredEnrollmentNumberError").show();
      return;
    }

    window.location.href = ctx + "/agent/enrollment/status?npi=" + enrollmentNumber;
  });

  if ($("#invalidEnrollmentNumber").size() > 0 && $("#invalidEnrollmentNumber").val() == 'yes') {
    $("#invalidEnrollmentNumberError").show();
  }

  var profileIdForWritingNotes = 0;
  $('.writeNotes').live('click', function () {
    closeModal();
    $('#writeNotesModal .textarea').val('Write your note here...');
    profileIdForWritingNotes = $(this).attr("rel");
    loadModal('#writeNotesModal');
  });

  $('#saveNote').live('click', function () {
    if (!screenLock) {
      screenLock = true;
    }

    var input = $.trim($('#writeNotesModal .textarea').val());
    if (input == '' || input == 'Write your note here...') {
      alert("Please input notes.")
      return false;
    }

    $.ajax({
          url: ctx + "/agent/enrollment/note?id=" + profileIdForWritingNotes,
          data: { "id": profileIdForWritingNotes, "note": input },
          cache: false,
          type: "GET",
          dataType: "json",
          success: function (data) {
            closeModal();
            if (data.success) {
              $("#notesSection").append('<span class="note_' + profileIdForWritingNotes + '" id="note_' + profileIdForWritingNotes + '_' + ($(".note_" + profileIdForWritingNotes).size() + 1) + '">' + input + '</span>');
              $("a[rel='" + profileIdForWritingNotes + "'].viewNotes").removeClass("disabledLink");
              $("a[rel='" + profileIdForWritingNotes + "'].viewNotes").removeClass("hide");
              $("a[rel='" + profileIdForWritingNotes + "'].viewNotes").prev().removeClass("hide");
            } else {
              alert(data.message);
            }
          },

          complete: function () {
            screenLock = false;
          }
        });
  });

  var enrollmentIdForNotes = 0;
  var currentShowingNoteCount = 1;
  $('.viewNotes').live('click', function () {
    if ($(this).hasClass('disabledLink')) {
      return false;
    }

    closeModal();
    enrollmentIdForNotes = $(this).attr("rel");
    currentShowingNoteCount = 1;
    showNoteBody();
    loadModal('#viewNotesModal');
  });

  $("#nextNote").live("click", function () {
    currentShowingNoteCount++;
    showNoteBody();
  });

  $("#preNote").live("click", function () {
    currentShowingNoteCount--;
    showNoteBody();
  });

  function showNoteBody() {
    $("#viewNotesModalNotesBody").val($("#note_" + enrollmentIdForNotes + "_" + currentShowingNoteCount).text());
    if ($("#note_" + enrollmentIdForNotes + "_" + (currentShowingNoteCount + 1)).size() == 0) {
      $("#nextNote").hide();
    } else {
      $("#nextNote").show();
    }

    if ($("#note_" + enrollmentIdForNotes + "_" + (currentShowingNoteCount - 1)).size() == 0) {
      $("#preNote").hide();
    } else {
      $("#preNote").show();
    }
  }

  //Textarea
  $('#writeNotesModal .textarea').live('focus', function () {
    if ($(this).val() == 'Write your note here...') {
      $(this).val('');
    }
  });

  $('#writeNotesModal .textarea').live('blur', function () {
    if ($(this).val() == '') {
      $(this).val('Write your note here...');
    }
  });

  $("#providerTypeForm").validate({
        rules: {
          name: {
                required: true,
                maxlength: 45
              }
        }
      });

  $("#updateScreeningScheduleForm").validate({
    errorElement: 'p',
    rules: {
      interval: {
            required: true,
            digits: true
          },
      upcomingScreeningDateHourPart: {
          required: true,
          digits: true,
          range: [1, 12]
        },
      upcomingScreeningDateMinutePart: {
          required: true,
          digits: true,
          range: [0, 59]
        }
    },
    messages: {
      interval: {
          required: "The field 'interval' is required.",
          digits: "Please enter only digits for 'interval'."
        },
      upcomingScreeningDateHourPart: {
          required: "The hour part of the 'Upcoming screening Time' is required.",
          digits: "Please enter only digits for 'hour' part of the 'Upcoming screening Time'.",
          range: "Please enter a value between 1 and 12 for 'hour' part of the 'Upcoming screening Time'."
        },
      upcomingScreeningDateMinutePart: {
            required: "The minute part of the 'Upcoming screening Time' is required.",
            digits: "Please enter only digits for 'minute' part of the 'Upcoming screening Time'.",
            range: "Please enter a value between 0 and 59 for 'minute' part of the 'Upcoming screening Time'."
          }
    },
    errorPlacement: function (error, element) {
        if (element.attr("name") == 'interval') {
          $(error).insertAfter("#intervalRow");
        } else if (element.attr("name") == 'upcomingScreeningDateHourPart' || element.attr("name") == 'upcomingScreeningDateMinutePart') {
          $(error).insertAfter("#screeningTimeRow");
        } else {
          error.insertAfter(element);
        }
      }
  });

  $("#userForm").validate({
      rules: {
        username: {
          required: true,
          maxlength: 45
        },
        lastName: {
              required: true,
              maxlength: 45
            },
        firstName: {
            required: true,
            maxlength: 45
          },
        middleName: {
            maxlength: 45
          },
        email: {
            required: true,
            email: true,
            maxlength: 45
          },
        businessPhonePart1: {
          required: true,
          digits: true,
          exactlength: 3
        },
        businessPhonePart2: {
          required: true,
          digits: true,
          exactlength: 3
        },
        businessPhonePart3: {
          required: true,
          digits: true,
          exactlength: 4
        },
        businessPhoneExt: {
          digits: true,
          maxlength: 4
        }
      },
      messages: {
        businessPhonePart1: {
            required: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
            digits: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
            exactlength: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits."
          },
        businessPhonePart2: {
              required: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
              digits: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
              exactlength: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits."
            },
        businessPhonePart3: {
              required: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
              digits: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
              exactlength: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits."
            },
        businessPhoneExt: {
              digits: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits.",
              maxlength: "Valid phone format is xxx-xxx-xxxx (xxxx), ext. is optional and up to 4 digits."
            }

      },
      errorPlacement: function (error, element) {
          if (element.attr("name") == 'businessPhonePart1' || element.attr("name") == 'businessPhonePart2' || element.attr("name") == 'businessPhonePart3' || element.attr("name") == 'businessPhoneExt') {
            if ($('label[for="businessPhonePart1"].error:visible').size() > 0 || $('label[for="businessPhonePart2"].error:visible').size() > 0 || $('label[for="businessPhonePart3"].error:visible').size() > 0 || $('label[for="businessPhoneExt"].error:visible').size() > 0) {
              return;
            }

            $(error).insertAfter("#businessPhoneExt");
          } else {
            error.insertAfter(element);
          }
        }
    });
  $(".saveProviderTypeBtn").click(function (event) {
    event.preventDefault();

    if ($("#addTypeRadio1").is(":checked")) {
      $("#paymentRequiredField").val("true");
    } else {
      $("#paymentRequiredField").val("false");
    }

    var counter = 0;
    $(".requiredFieldsRightBoxes input::checked").each(function () {
      $("#providerTypeForm").prepend($('<input id="requiredFields' + counter + '.name" name="requiredFields[' + counter + '].name" value="' + $(this).next().text() + '" type="hidden">'));
      $("#providerTypeForm").prepend($('<input id="requiredFields' + counter + '.name" name="requiredFields[' + counter + '].type.name" value="' + $(this).closest('.col').parent().prev().find('h4').text() + '" type="hidden">'))
      counter++;
    });

    $("#providerTypeForm").submit();
  });

  if ($('#containedRequiredFields').size() > 0) {
    var containedRequiredFields = $('#containedRequiredFields').val();
    $('.requiredFieldsRightBoxes label').each(function () {
      var fieldId = $(this).attr("for");
      var labelText = $(this).text();
      var typeText = $(this).closest('.col').parent().prev().find('h4').text();
      if (containedRequiredFields.indexOf(typeText + labelText) != -1) {
        $("#" + fieldId).attr("checked", "checked");
      }
    });
  }

  if ($('#paymentRequiredField').size() > 0) {
    if ($('#paymentRequiredField').val() == 'true') {
      $('#addTypeRadio1').attr("checked", "checked");
    } else {
      $('#addTypeRadio2').attr("checked", "checked");
    }
  }

  $(".pageSizeSelect").change(function () {
    $('#searchFormPageNumber').val("1");
    $('#searchFormPageSize').val($(this).val());
    $('#searchForm').submit();
  });

  $(".pagination-page-number-clickable").click(function () {
    $('#searchFormPageNumber').val($(this).attr("rel"));
    $('#searchForm').submit();
    return false;
  });

  $(".sortable_column").click(function () {
    var newSortColumn = $(this).attr("rel");
    var oldSortColumn = $("#searchFormSortColumn").val();
    var oldAscending = $("#searchFormAscending").val();
    if (newSortColumn == oldSortColumn) {
      if (oldAscending == 'true') {
        $("#searchFormAscending").val('false');
      } else {
        $("#searchFormAscending").val('true');
      }

    }

    $("#searchFormSortColumn").val(newSortColumn);
    $('#searchForm').submit();
    return false;
  });

  $("#searchProviderTypes").click(function () {
    $("#searchFormProviderType").val($("#providerTypeFilterText").val());
    $('#searchForm').submit();
    return false;
  });

  $("#searchAgreementDocuments").click(function () {
    $("#searchFormAgreementDocumentTitle").val($("#agreementDocumentTitleFilterText").val());
    $("#searchFormAgreementType").val($("#agreementDocumentTypeFilterText").val());
    $('#searchForm').submit();
    return false;
  });

  $('.filterBtn').live('click', function () {
    if ($(this).hasClass('showFilter')) {
      $(this).parent().parent().parent().find('.filterPanel').show();
      $(this).find('.text').html('Hide Filter');
      $(this).removeClass('showFilter').addClass('hideFilter');
      $("#searchFormShowFilterPanel").val("true");
    } else {
      $(this).parent().parent().parent().find('.filterPanel').hide();
      $(this).find('.text').html('Filter');
      $(this).removeClass('hideFilter').addClass('showFilter');
      $("#searchFormShowFilterPanel").val("false");
    }
  });
  // delete provider types part
  var deleteProviderTypeIds = [];

  $('.deleteProviderTypeBtn').live('click', function () {
    closeModal();
    deleteProviderTypeIds = [$(this).attr("rel")];
    $("#deleteProviderTypesModal .modal_title").text("Are you sure you want to delete the selected provider type?");
    loadModal('#deleteProviderTypesModal');
  });

  $('.deleteProviderTypesBtn').live('click', function () {
    closeModal();
    var cbs = $(".providerTypeCheckBox:checked");
    if (cbs.length == 0) {
      loadModal('#noSelectedItemsModal');
      return false;
    }

    deleteProviderTypeIds = [];
    for (var i = 0; i < cbs.length; i++) {
      deleteProviderTypeIds[i] = $(cbs[i]).val();
    }

    $("#deleteProviderTypesModal .modal_title").text("Are you sure you want to delete the selected provider type" + (cbs.length > 1 ? "s" : "") + "?");
    loadModal('#deleteProviderTypesModal');
  });

  $('#deleteProviderTypesModal .saveBtn').live('click', function () {
    var urlParams = "?";
    for (var i = 0; i < deleteProviderTypeIds.length; i++) {
      urlParams += ("providerTypeIds=" + deleteProviderTypeIds[i]);
      if (i != deleteProviderTypeIds.length - 1) {
        urlParams += '&&';
      }
    }

    $.ajax({
          url: ctx + "/admin/deleteProviderTypes" + urlParams,
          cache: false,
          type: "GET",
          dataType: "text",
          success: function (data) {
            $('#searchForm').submit();
          }
        });
  });

  // delete agreement documents part
  var deleteAgreementDocumentIds = [];

  $('.deleteAgreementDocumentBtn').live('click', function () {
    closeModal();
    deleteAgreementDocumentIds = [$(this).attr("rel")];
    $("#deleteAgreementModal .modal_title").text("Are you sure you want to delete the selected agreement document?");
    loadModal('#deleteAgreementModal');
  });

  $('.deleteAgreementDocumentsBtn').live('click', function () {
    closeModal();
    var cbs = $(".agreementDocumentCheckBox:checked");
    if (cbs.length == 0) {
      loadModal('#noSelectedItemsModal');
      return false;
    }

    deleteAgreementDocumentIds = [];
    for (var i = 0; i < cbs.length; i++) {
      deleteAgreementDocumentIds[i] = $(cbs[i]).val();
    }

    $("#deleteAgreementModal .modal_title").text("Are you sure you want to delete the selected agreement document" + (cbs.length > 1 ? "s" : "") + "?");
    loadModal('#deleteAgreementModal');
  });

  $('#deleteAgreementModal .deleteOKBtn').live('click', function () {
    var urlParams = "?";
    for (var i = 0; i < deleteAgreementDocumentIds.length; i++) {
      urlParams += ("agreementIds=" + deleteAgreementDocumentIds[i]);
      if (i != deleteAgreementDocumentIds.length - 1) {
        urlParams += '&&';
      }
    }

    $.ajax({
          url: ctx + "/admin/deleteAgreementDocuments" + urlParams,
          cache: false,
          type: "GET",
          dataType: "text",
          success: function (data) {
            $('#searchForm').submit();
          }
        });
  });

  $('.saveScheduleBtn').click(function (event) {
    event.preventDefault();
    var upcomingScreeningDateDatePart = $("#upcomingScreeningDateDatePart").val();
    var upcomingScreeningDateHourPart = $("#upcomingScreeningDateHourPart").val();
    var upcomingScreeningDateMinutePart = $("#upcomingScreeningDateMinutePart").val();
    var upcomingScreeningDateSelect = $("#upcomingScreeningDateSelect").val();
    var dateString = upcomingScreeningDateDatePart + " " + upcomingScreeningDateHourPart + ":" + upcomingScreeningDateMinutePart + " " + upcomingScreeningDateSelect;
    $("#upcomingScreeningDateField").val(dateString);
    $('#updateScreeningScheduleForm').submit();
  });

  jQuery.ajaxSetup({
    dataType: 'text',
    cache: false,
    error: function (jqXHR, textStatus, errorThrown) {
      alert("processing failed,please try later.")
    }
  });

  /*new js*/

  $('.printModalBtn').click(function () {
      addressCloseModal();
      addressLoadModal('#printModal');
    });

  addUserHelpClickHandler(
    'a.agreementsAddendumsHelpLink',
    '/help/service-admin-help.html',
    'what-s-the-difference-between-an-agreement-and-an-addendum'
  );

  $('.editInfo').click(function () {
    $(this).parents('.tabContent').find('.editInfo').hide();
    $(this).parents('.tabContent').find('.plainInformation').hide();
    $(this).parents('.tabContent').find('.editContent').show();
  });

  $(window).resize(function () {
    addressPositionModal();
    if ($("body").height() > $("#modalBackground").height()) {
      $("#modalBackground").css("height", $("body").height() + "px");
    }

    if ($('#new-modal').height() > $("#modalBackground").height()) {
      $("#modalBackground").css("height", $('#new-modal').height() + 120 + "px");
    }
  });

  $('.searchBtn').click(function () {
    $(this).parents('.buttonBox').siblings('.contentT').show();
  });

  $('.checkAll').click(function () {
    if ($(this).attr('checked')) {
      $(this).parents('.requestTypeC').find('input').attr('checked', true);
    } else {
      $(this).parents('.requestTypeC').find('input').attr('checked', false);
    };
  });

  $('.requestTypeC input').click(function () {
    if ($(this).attr('checked') != "checked") {
      $(this).parents('.requestTypeC').find('.checkAll').attr('checked', false);
    }
  });
  /*end new*/
  $('.hint').focus(function () {
    $(this).removeClass('hint');
    if ($(this).val() == '' || $(this).val() == $(this).attr('title'))
     $(this).val('')
  }).blur(function () {
    if ($(this).val() == '' || $(this).val() == $(this).attr('title')) {
      $(this).addClass('hint');
      $(this).val($(this).attr('title'));
    }
  });

  $('.tabHead,.tabFoot').each(function () {
    $(this).css('width', ($('.contentWidth').width() - 2) + 'px');
  });

  $('#new-modal #printModal .modal-content .tabHead,#new-modal #printModal .modal-content .tabFoot').each(function () {
    $(this).css('width', ($('#new-modal #printModal .modal-content .tabContent').width() - 2) + 'px');
  });

  $('.detailPanel,.filterPanel .floatW').each(function () {
    $(this).css('width', ($('.contentWidth').width() - 20) + 'px');
  })

  $('#tabStatement .bottomPanel .wideCol').css('width', ($('.contentWidth').width() - 20) + 'px');
  $('input.date').datepicker({
    dateFormat: "mm/dd/yy",
    showOn: "button",
    buttonImage: ctx + "/i/calendar.png",
    buttonImageOnly: true,
    beforeShow: function (input, inst) {
      inst.dpDiv.css('margin-left', '-23px')
    }
  });
  $('input.date').click(function () {
    $(this).next('.ui-datepicker-trigger').click();
  });

  $('.ui-datepicker-trigger').attr('alt', '').attr('title', '');

  $('.table-sort').tablesorter({
    headers: { 0: { sorter: false }, 6: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });
  $('.searchTableSort').tablesorter({
    headers: { 0: { sorter: false }, 7: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });

  $('#draftTable').tablesorter({
    headers: { 0: { sorter: false }, 5: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });

  $('.dashboardTable').tablesorter({
    headers: { 6: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });

  $('.table-sort,#draftTable,.searchTableSort,.dashboardTable').bind('sortEnd', function () {
    stripTable();

  });

  $('input[type=checkbox]').click(function () {
    var name = $(this).attr('name');
    if (!$(this).attr('checked')) {
      $('input[name="' + $(this).attr('name') + '"].selectAll').attr('checked', false);
    }
  });

  //new script
  $('.stepWidget .lastStep').css('width', $('.stepWidget').width() - $('.stepWidget .personal').width() - $('.stepWidget .license').width() - $('.stepWidget .practice').width() - $('.stepWidget .payment').width() - $('.stepWidget .summary').width() - 2);

  //Save As Above
  $('#sameAsAbove').live('click', function () {
    if ($(this).attr('checked')) {
      var name = $('#firstName').val() + ' ' + $('#middleName').val() + ' ' + $('#lastName').val();
      $('#contactName').val(name.replace(/(^\s*)/g, ""));
      $('#contactEmail').val($('#emailAddress').val());
      $('#contactEmail').val($('#emailAddress').val());
      $('#contactPhoneNumber1').val($('#phoneNumber1').val());
      $('#contactPhoneNumber2').val($('#phoneNumber2').val());
      $('#contactPhoneNumber3').val($('#phoneNumber3').val());
      $('#contactPhoneNumber4').val($('#phoneNumber4').val());
      $('#contactFaxNumber1').val($('#faxNumber1').val());
      $('#contactFaxNumber2').val($('#faxNumber2').val());
      $('#contactFaxNumber3').val($('#faxNumber3').val());
      $('#contactFaxNumber4').val($('#faxNumber4').val());
    } else {
      $('#contactName').val('');
      $('#contactEmail').val('');
      $('#contactPhoneNumber1').val('');
      $('#contactPhoneNumber2').val('');
      $('#contactPhoneNumber3').val('');
      $('#contactPhoneNumber4').val('');
      $('#contactFaxNumber1').val('');
      $('#contactFaxNumber2').val('');
      $('#contactFaxNumber3').val('');
      $('#contactFaxNumber4').val('');
    }
  });

  //Next Button
  $('.nextBtn').live('click', function () {
    if ($('.flyout').is(':hidden')) {
      $('.flyout').show();
      if ($(this).offset().left + $('.flyout').width() > $('body').width() - 50) {
        $('.flyout').css('left', $(this).offset().left - $('.flyout').width());
      } else {
        $('.flyout').css('left', $(this).offset().left + 50);
      }
    } else {
      $('.flyout').hide();
    }
  });

  $('.flyout a').live('click', function () {
    $('.flyout').hide();
  });

  //Add License
  if ($('#tableLicense tbody tr').length < 2) {
    $('#tableLicense .remove').hide();
  }

  $('#addLicense').live('click', function () {
    var i = $('#tableLicense tbody tr').length;
    var $i = $('#tableLicense tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('input').val('');
    $i.find('select').val('');
    $i.find('.dateWrapper').append('<input class="date" type="text" readonly="readonly"/>');
    $('#tableLicense tbody').append($i);
    $('#tableLicense input.date').datepicker({
      dateFormat: "mm/dd/yy",
      showOn: "button",
      buttonImage: ctx + "/i/calendar.png",
      buttonImageOnly: true,
      beforeShow: function (input, inst) {
        inst.dpDiv.css('margin-left', '-23px')
      }
    });
    $('.disabledDate input.date').datepicker('disable');
    $('#tableLicense input.date').click(function () {
      $(this).next('.ui-datepicker-trigger').click();
    });

    $('#tableLicense .ui-datepicker-trigger').attr('alt', '').attr('title', '');
    $('#tableLicense .remove').show();
    stripTable();
  });

  //Remove License
  $('#tableLicense .remove').live('click', function () {
    var i = $('#tableLicense tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableLicense tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    if (i < 3) {
      $('#tableLicense .remove').hide();
    }

    stripTable();
  });

  //Add License
  if ($('#tableLicense2 tbody tr').length < 2) {
    $('#tableLicense2 .remove').hide();
  }

  $('#addLicense2').live('click', function () {
    var i = $('#tableLicense2 tbody tr').length;
    var $i = $('#tableLicense2 tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('input').val('');
    $i.find('select').val('');
    $i.find('.dateWrapper').append('<input class="date" type="text" readonly="readonly"/>');
    $('#tableLicense2 tbody').append($i);
    $('#tableLicense2 input.date').datepicker({
      dateFormat: "mm/dd/yy",
      showOn: "button",
      buttonImage: ctx + "/i/calendar.png",
      buttonImageOnly: true,
      beforeShow: function (input, inst) {
        inst.dpDiv.css('margin-left', '-23px')
      }
    });
    $('.disabledDate input.date').datepicker('disable');
    $('#tableLicense2 input.date').click(function () {
      $(this).next('.ui-datepicker-trigger').click();
    });

    $('#tableLicense2 .ui-datepicker-trigger').attr('alt', '').attr('title', '');
    $('#tableLicense2 .remove').show();
    stripTable();
  });

  //Remove License
  $('#tableLicense2 .remove').live('click', function () {
    var i = $('#tableLicense2 tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableLicense2 tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    if (i < 3) {
      $('#tableLicense2 .remove').hide();
    }

    stripTable();
  });

  //Radio
  $('#RadioWrapper input:radio').live('change', function () {
    if ($('#switchRadioWrapper input:checked').length) {
      if ($(this).val() == 'yes') {
        $('#practicePage .practicePanel').show();
        $('#privatePractice').show();
        $('#primaryOffice').hide();
        $('#practicePage .buttonBox').show();
        $('#additionalPractice').show();
      } else {
        $('#practicePage .practicePanel').show();
        $('#primaryOffice').show();
        $('#privatePractice').hide();
        $('#practicePage .buttonBox').show();
        $('#additionalPractice').show();
        $('#switchRadioWrapper input:radio:first').attr('checked', true);
      }
    }
  });

  $('#switchRadioWrapper input:radio').live('change', function () {
    if ($('#RadioWrapper input:radio').val() == 'yes') {
      $('#practicePage .practicePanel').show();
      $('#privatePractice').show();
      $('#primaryOffice').hide();
      $('#practicePage .buttonBox').show();
      $('#additionalPractice').show();
    } else {
      $('#practicePage .practicePanel').show();
      $('#primaryOffice').show();
      $('#privatePractice').hide();
      $('#practicePage .buttonBox').show();
      $('#additionalPractice').show();
      $('#switchRadioWrapper input:radio:first').attr('checked', true);
    }

    if ($(this).val() == 'no') {
      $('#RadioWrapper input:radio:first').attr('checked', true);
      $('#practicePage .practicePanel').show();
      $('#privatePractice').show();
      $('#primaryOffice').hide();
      $('#practicePage .buttonBox').show();
      $('#additionalPractice').hide();
    } else {
      $('#additionalPractice').show();
    }
  });

  //Get URL
  function getUrlPara(paraName) {
    var sUrl  =  location.href;
    var sReg  =  "(?:\\?|&){1}" + paraName + "=([^&]*)"
    var re = new RegExp(sReg, "gi");
    re.exec(sUrl);
    return RegExp.$1;
  }

  if (getUrlPara("tab") == 'no') {
    $('#practicePage .radioPanel').hide();
    $('#practicePage #privatePractice').hide();
    $('.practicePanel,#primaryOffice,#additionalPractice').show();
    $('.buttonBox').show();
  }

  //Add License
  if ($('#tablePractice tbody tr').length < 2) {
    $('#tablePractice .remove').hide();
  }

  $('#addPractice').live('click', function () {
    var i = $('#tablePractice tbody tr').length;
    var $i = $('#tablePractice tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('.dateWrapper').append('<input class="date" type="text" readonly="readonly"/>');
    $i.find('input').val('');
    $('#tablePractice tbody').append($i);
    $('#tablePractice input.date').datepicker({
      dateFormat: "mm/dd/yy",
      showOn: "button",
      buttonImage: ctx + "/i/calendar.png",
      buttonImageOnly: true,
      beforeShow: function (input, inst) {
        inst.dpDiv.css('margin-left', '-23px')
      }
    });
    $('#tablePractice input.date').click(function () {
      $(this).next('.ui-datepicker-trigger').click();
    });

    $('#tablePractice .ui-datepicker-trigger').attr('alt', '').attr('title', '');
    $('#tablePractice .remove').show();
    stripTable();
  });

  //Remove License
  $('#tablePractice .remove').live('click', function () {
    var i = $('#tablePractice tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tablePractice tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    if (i < 3) {
      $('#tablePractice .remove').hide();
    }

    stripTable();
  });

  //Add Group
  $('#addGroup').live('click', function () {
    var $i = $('.affiliationPanel table:last').clone(true);
    $i.find('input').val('');
    $('.affiliationPanel table:last').after($i);
  });

  $('#tabStatement input.date').datepicker('disable');
  $('.disabledDate input.date').datepicker('disable');

  if ($.browser.msie) {
    $('.practicePanel input.wholeInput').css('width', '726px');
  }

  if ($.browser.msie && ($.browser.version == "9.0")) {
    $('.practicePanel .inlineBox select,.practicePanel .reimbursementAddressRow select').css('width', '108px');
  }

  $('#urlRelead').live('change', function () {
    switch ($(this).val()){
    case 'Audiologist' :
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-audiologist-personal.html');
    break;
    case 'Certified Mental Health Rehab Prof':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Certified Professional Midwife':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Certified Registered Nurse Anesthetist':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-certified-registered-nurse-anesthetists-personal.html');
    break;
    case 'Chiropractor':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Clinical Nurse Specialist':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Community Health Care Worker':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-community-health-workers-personal.html');
    break;
    case 'Dental Hygienist':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Dentists':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Nurse':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Licensed Marriage and Family Therapist':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Licensed Psychologist':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-licensed-psychologist-personal.html');
    break;
    case 'PCA Individual':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Pharmacist':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Physician':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Physician Assistant':
      $('.nextBtn').attr('href', 'javascript:;');
    break;
    case 'Physical Therapist':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-physical-therapist-personal.html');
    break;
    case 'Podiatrist':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-podiatrist-personal.html');
    break;
    default:
      $('.nextBtn').attr('href', 'javascript:;');
  }
  });

  $('#verificationBtn').live('click', function () {
    var flag = true;
    var iArray = [];
    var iHref = $(this).attr('rel');
    $('.requireField').each(function () {
      $(this).find('input:text').removeClass('errorInput');
      if (!$(this).find('input:text').val()) {
        $(this).find('input:text').addClass('errorInput');
        iArray.push($(this).find('label').text());
        flag = false;
      }
    });

    if (!flag) {
      $('.errorInfo').show();
      $('.errorInfo p').remove();
      for (j = 0; j < iArray.length; j++) {
        $('.errorInfo').append('<p>- ' + iArray[j].replace('*', '') + '</p>');
      }
    } else {
      $(this).attr('href', iHref);
    }
  });

  // Submit COS Form
  $('.submitCosFormBtn').click(function submitCosForm(event) {
    event.preventDefault();

    // validate
    if ($('#startDate').val().trim().length == 0) {
      $('#startDate').addClass('errorInput');
      alert('Start Date is required');
      return false;
    }

    if ($('#cosSelect').val() == null || $('#cosSelect').val().length == 0) {
      alert('Please select at least one COS');
      return false;
    }

    submitFormById('cosForm');
  });

  /* START OF SERVICE AGENT SCRIPT ------------------------------------------------ */

  /*
  $('.table-enrollment-sort').tablesorter({
   headers:{0:{ sorter: false},8:{ sorter: false}},
   widgets        : ['zebra', 'columns'],
   usNumberFormat : false,
   sortRestart    : true
  });
  $('.table-enrollment-notes-sort').tablesorter({
   headers:{0:{ sorter: false},8:{ sorter: false},9:{ sorter: false}},
   widgets        : ['zebra', 'columns'],
   usNumberFormat : false,
   sortRestart    : true
  });
  $('#resultsTable').tablesorter({
   headers:{0:{ sorter: false},9:{ sorter: false}},
   widgets        : ['zebra', 'columns'],
   usNumberFormat : false,
   sortRestart    : true
  });
  */
  //Save As Above
  $('#sameAsAboveEditPanel').live('click', function () {
    if ($(this).attr('checked')) {
      var name = $('#firstName').val() + ' ' + $('#lastName').val();
      $('#contactName').val(name.replace(/(^\s*)/g, ""));
      $('#contactEmail').val($('#emailAddress').val());
      for (i = 0; i < 4; i++) {
        $('#contactPhoneNumber input:eq(' + i + ')').val($('#phoneNumber input:eq(' + i + ')').val());
        $('#contactFaxNumber input:eq(' + i + ')').val($('#faxNumber input:eq(' + i + ')').val());
      }
    } else {
      $('#contactName').val('');
      $('#contactEmail').val('');
      for (i = 0; i < 4; i++) {
        $('#contactPhoneNumber input:eq(' + i + ')').val('');
        $('#contactFaxNumber input:eq(' + i + ')').val('');
      }
    }
  });

  function helpPageClick(currentLink) {
    $(".helpHeaderLink").removeAttr("disabled").removeAttr("style");
    currentLink.attr("disabled", "disabled");
    currentLink.css("color", "black").css("font-weight", "bold").css("text-decoration", "none").css("cursor", "default");
  }

  //Scrollbar
  if ($('#scrollbar').length) {
    $('#scrollbar').tinyscrollbar({ sizethumb: 161 });
    $('#allHelp').click(function () {
      $('#scrollbar').tinyscrollbar_update(0);
      helpPageClick($(this));
      return false;
    });

    $('#letterA').click(function () {
      $('#scrollbar').tinyscrollbar_update(0);
      helpPageClick($(this));
      return false;
    });

    $('#letterB').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowB').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterC').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowC').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterD').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowD').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterE').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowE').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterF').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowF').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterG').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowG').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterH').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowH').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterI').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowI').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterJ').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowJ').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterK').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowK').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterL').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowL').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterM').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowM').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterN').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowN').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterO').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowO').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterP').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowP').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterQ').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowQ').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterR').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowR').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterS').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowS').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterT').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowT').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterU').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowU').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterV').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowV').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterW').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowW').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterX').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowX').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterY').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowY').position().top);
      helpPageClick($(this));
      return false;
    });

    $('#letterZ').click(function () {
      $('#scrollbar').tinyscrollbar_update($('.rowZ').position().top);
      helpPageClick($(this));
      return false;
    });
  }
  //Check All
  $('#advancedSearch .checkRow span.label').live('click', function () {
    if ($(this).prev().attr('checked')) {
      $(this).prev().attr('checked', false);
      $(this).parents('.checkWrapper').find('.checkAll').attr('checked', false);
      if ($(this).prev().hasClass('checkAll')) {
        $(this).parents('.checkWrapper').find('input').attr('checked', false);
      }
    } else {
      $(this).prev().attr('checked', true);
      if ($(this).prev().hasClass('checkAll')) {
        $(this).parents('.checkWrapper').find('input').attr('checked', true);
      } else {
        var $wrapper = $(this).parents('.checkWrapper');
        if ($wrapper.find('input:not(".checkAll")').size() == $wrapper.find('input:not(".checkAll"):checked').size()) {
          $wrapper.find('input').attr('checked', true);
        }
      }
    }
  });

  $('#advancedSearch input:not(".checkAll")').live('click', function () {
    if (!$(this).attr('checked')) {
      $(this).parents('.checkWrapper').find('.checkAll').attr('checked', false);
    }

    var $wrapper = $(this).parents('.checkWrapper');
    if ($wrapper.find('input:not(".checkAll")').size() == $wrapper.find('input:not(".checkAll"):checked').size()) {
      $wrapper.find('input').attr('checked', true);
    }
  });

  $('#advancedSearch .checkAll').live('click', function () {
    if ($(this).attr('checked')) {
      $(this).parents('.checkWrapper').find('input').attr('checked', true);
    } else {
      $(this).parents('.checkWrapper').find('input').attr('checked', false);
    }
  });

  $('#createEnrollment span.label').live('click', function () {
    $(this).prev().attr('checked', true);
    if ($(this).prev().hasClass('renewEnrollment')) {
      $('#createEnrollment .row:last').show();
    } else {
      $('#createEnrollment .row:last').hide();
    }
  });

  $('#createEnrollment input:radio').live('click', function () {
    if ($(this).hasClass('renewEnrollment')) {
      $('#createEnrollment .row:last').show();
    } else {
      $('#createEnrollment .row:last').hide();
    }
  });

  $('#renewalLicense').live('click', function () {
    var i = $('#tableLicense tbody tr').length;
    var $i = $('#tableLicense tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('.dateWrapper:first').append('<input class="date" type="text" readonly="readonly" value="01/01/2012" />');
    $i.find('.dateWrapper:last').append('<input class="date" type="text" readonly="readonly" value="01/01/2013" />');
    $('#tableLicense tbody').append($i);
    $('#tableLicense input.date').datepicker({
      dateFormat: "mm/dd/yy",
      showOn: "button",
      buttonImage: ctx + "/i/calendar.png",
      buttonImageOnly: true,
      beforeShow: function (input, inst) {
        inst.dpDiv.css('margin-left', '-23px')
      }
    });
    $('#tableLicense input.date').click(function () {
      $(this).next('.ui-datepicker-trigger').click();
    });

    $('#tableLicense .ui-datepicker-trigger').attr('alt', '').attr('title', '');
    $('#tableLicense .remove').show();
    stripTable();
  });

  //Filter button
  $('.showResultBtn').live('click', function () {
    $(this).parents('.tabContent').find('.tableWrapper').show();
    $(this).parents('.tabContent').find('.topPagination').show();
    $(this).parents('.tabContent').find('.tabCorner').hide();
  });

  //Select All
  $('input.selectAll').live('click', function () {
    if ($(this).attr('checked')) {
      $('input.' + $(this).attr('name')).each(function () {
        if ($(this).attr("disabled") != 'disabled') {
          $(this).attr('checked', true);
        }
      });
    } else
     $('input.' + $(this).attr('name')).attr('checked', false);
  });

  $('input[type=checkbox]').live('click', function () {
    var name = $(this).attr('name');
    if (!$(this).attr('checked')) {
      $('input[name="' + $(this).attr('name') + '"].selectAll').attr('checked', false);
    }
  });

  $('input.enrollmentRowCheckBox').live('click', function () {
    if ($('input.enrollmentRowCheckBox').size() == $('input.enrollmentRowCheckBox:checked').size()) {
      $('#enrollmentSelectAll').attr('checked', true);
    } else {
      $('#enrollmentSelectAll').attr('checked', false);
    }
  });

  $('.tabCorner').each(function () {
    $(this).css('width', ($('.contentWidth').width() - 2) + 'px');
  });

  //Modal
  positionModal = function () {
    var wWidth  = window.innerWidth;
    var wHeight = window.innerHeight;

    if (wWidth == undefined) {
      wWidth  = document.documentElement.clientWidth;
      wHeight = document.documentElement.clientHeight;
    }

    var boxLeft = parseInt((wWidth / 2) - ($("#modal").width() / 2));
    var boxTop  = parseInt((wHeight / 2) - ($("#modal").height() / 2));

    // position modal
    $("#modal").css({
      'margin': boxTop + 'px auto 0 ' + boxLeft + 'px'
    });

    $("#modalBackground").css("opacity", "0.7");

    if ($("body").height() > $("#modalBackground").height()) {
      $("#modalBackground").css("height", $("body").height() + "px");
    }
  }

  loadModal = function (itemId) {
        $('#modalBackground').show();
        $(itemId).show();
        positionModal();
      }

  closeModal = function () {
        $('#modalBackground').hide();
        $('.modal').hide();
        $('#practiceLookupModal .searchResult').hide();
      }

  //close modal
  $('.closeModal').live('click', function () {
    closeModal();
  });

  //Textarea
  $('#writeNotesModal .textarea').live('focus', function () {
    $(this).val('');
  });

  $('#writeNotesModal .textarea').live('blur', function () {
    if ($(this).val() == '') {
      $(this).val('Write your note here...');
    }
  });

  //Next Button
  $('.createEnrollmentBtn').live('click', function () {
    if ($('#createEnrollment .newEnrollment').attr('checked')) {
      if ($('#createEnrollment .row select').val() == 'Audiologist') {
        window.location.href = 'new-enrollment-no-payment-audiologist-personal.html';
      } else if ($('#createEnrollment .row select').val() == 'Please select') {
        window.location.href = 'javascript:;';
      } else {
        window.location.href = 'new-enrollment-payment-service-agent-personal.html';
      }
    }

    if ($('#createEnrollment .renewEnrollment').attr('checked')) {
      if ($('#createEnrollment .row select').val() == 'Audiologist') {
        window.location.href = 'renewal-enrollment-audiologist-personal.html';
      } else if ($('#createEnrollment .row select').val() == 'Please select') {
        window.location.href = 'javascript:;';
      } else {
        window.location.href = 'renewal-enrollment-payment-service-agent-personal.html';
      }
    }
  });

  /*
  $('.writeNotes').live('click',function(){
   closeModal();
   loadModal('#writeNotesModal');
  });
  $('.viewNotes').live('click',function(){
   closeModal();
   loadModal('#viewNotesModal');
  });
   */
  $('.newEnrollmentSaveDraftBtn').live('click', function () {
    closeModal();
    loadModal('#saveDraftModal');
  });

  $('.practiceLookupBtn').live('click', function () {
    closeModal();
    loadModal('#practiceLookupModal');
  });

  $('#practiceLookupModal .searchBtn').live('click', function () {
    $('#practiceLookupModal .searchResult').show();
    positionModal();
  });

  //Prev Button
  $('.submitEnrollmentBtn').live('click', function () {
    closeModal();
    loadModal('#submitModal');
  });

  $('.submitSuccessBtn,#submitModal .closeModal').live('click', function () {
    window.location.href = 'enrollment-service-agent.html';
  });

  if ($.browser.msie && ($.browser.version == "7.0")) {
    $('#createEnrollment input[type="radio"],#advancedSearch input[type="checkbox"]').css('margin', '5px 3px auto 3px');
    $('.helpSection .row li').css('width', $('.helpSection .row ul').width() / 3);
  }

  /* END OF SERVICE AGENT SCRIPT -------------------------------------------------- */

  $("#helpTopicForm").validate({
        rules: {
          title: {
                required: true,
                maxlength: 45
              },
          description: {
              required: true,
              maxlength: 2048
            }

        }
      });

  $("#agreementDocumentForm").validate({
        rules: {
          title: {
                required: true,
                maxlength: 100
              },
          content: {
              required: true,
              maxlength: 2048
            }

        }
      });

  $('.deleteHelpTopicBtn').live('click', function () {
    loadModal('#deleteHelpTopicModal');
  });

  $('#deleteHelpTopicModal .deleteOKBtn').click(function () {
    $.ajax({
          url: $(this).attr('rel'),
          cache: false,
          type: "GET",
          dataType: "text",
          success: function (data) {
            window.location.href = ctx + "/admin/searchHelp";
          }
        });
  });

  $('.deleteProviderTypesOnViewBtn').live('click', function () {
    loadModal('#deleteProviderTypesModal');
  });

  $('#deleteProviderTypesModal .deleteOKBtn').click(function () {
    $.ajax({
          url: $(this).attr('rel'),
          cache: false,
          type: "GET",
          dataType: "text",
          success: function (data) {
            window.location.href = ctx + "/admin/viewProviderTypes";
          }
        });
    return false;
  });

  $('.chzn-select').chosen();

  $("input.mdate").mask("99/99/9999");

  /* END OF SERVICE ADMIN SCRIPT -------------------------------------------------- */

  /* START OF SYSTEM ADMIN SCRIPT ------------------------------------------------- */

  /* END OF SYSTEM ADMIN SCRIPT --------------------------------------------------- */

  /* START OF ORGANIZATION PROVIDER TYPE SCRIPT ---------------------------------- */

  /* END OF ORGANIZATION PROVIDER TYPE SCRIPT ------------------------------------- */

});

function stripTable() {
  $('table .even').removeClass('even');
  $('table tr:nth-child(even)').addClass('even');
}

jQuery.validator.addMethod("exactlength", function (value, element, param) {
  return this.optional(element) || value.length == param;
}, jQuery.format("Please enter exactly {0} characters."));

var screenLock = false; // prevent double click on submit flows

/**
 * Submits the form with the given id.
 * @param id the id of the form to be submitted
 */
function submitFormById(id, url) {
  if (url) {
    $('#' + id).attr("action", url);
  }

  if (!screenLock) {
    screenLock = true;
    $('#' + id).submit();
  }
}

function renewSelections(url) {
  var selected = [];
  $("input.enrollmentRowCheckBox:checked").each(function () {
        selected.push($(this).val());
      });

  if (selected.length == 0) {
    alert("Please select an application to renew.");
    return;
  }

  if (confirm("Renewal applications will be submitted for the following requests: " + selected + ". Continue?")) {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $.ajax({
      url: url,
      data: { "ids": selected },
      cache: false,
      traditional: true,
      type: "POST",
      dataType: "json",

      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },

      success: function (data) {
        alert(data.message);
      }
    });
  }
}

function copyCOS(id) {
  $('#prevCosId').val(id);
  var endDate = $('#edt-' + id).text().trim();
  if (endDate.length == 0) {
    var prevDate = new Date();
    prevDate.setDate(prevDate.getDate() - 1);
    $('#prevCosEndDate').val(("0" + (prevDate.getMonth() + 1)).slice(-2) + "/" + ("0" + prevDate.getDate()).slice(-2) + "/" + prevDate.getFullYear());
    var joindate = new Date();
    $('#startDate').val(("0" + (joindate.getMonth() + 1)).slice(-2) + "/" + ("0" + joindate.getDate()).slice(-2) + "/" + joindate.getFullYear());
  } else {
    var dmy = endDate.split("/");
    var joindate = new Date(
     parseInt(dmy[2], 10),
     parseInt(dmy[0], 10) - 1,
     parseInt(dmy[1], 10)
    );
    joindate.setDate(joindate.getDate() + 1);
    $('#startDate').val(("0" + (joindate.getMonth() + 1)).slice(-2) + "/" + ("0" + joindate.getDate()).slice(-2) + "/" + joindate.getFullYear());
  }

  var cos = $('#cats-' + id).text().split(',');
  $.each(cos, function (index, value) {
    var selector = '#cosSelect option[value="' + value.trim() + '"]';
    $(selector).attr('selected', 'selected');
  });

  $('#cosSelect_chzn').remove();
  $('#cosSelect').removeClass('chzn-done');
  $('#cosSelect').css('display', 'block');
  $('#cosSelect').chosen();
}

function deleteCOS(id, profileId) {
  window.location = '/cms/agent/enrollment/deleteCOS?id=' + id + '&profileId=' + profileId;
}

function deleteCOSByTicketId(id, ticketId) {
  window.location = '/cms/agent/enrollment/deletePendingCOS?id=' + id + '&ticketId=' + ticketId;
}
