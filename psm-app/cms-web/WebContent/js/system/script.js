/**
 *Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 *
 * The js script makes the pages work.
 */
$(document).ready(function () {
  /*new js*/
  $('.searchPanel input[type="checkbox"]').css("border", "none").css("background", "none").css("position", "relative").css('top', "-1px");
  addressPositionModal = function () {
    var wWidth  = window.innerWidth;
    var wHeight = window.innerHeight;

    if (wWidth == undefined) {
      wWidth  = document.documentElement.clientWidth;
      wHeight = document.documentElement.clientHeight;
    }

    var boxLeft = parseInt((wWidth / 2) - ($("#new-modal").width() / 2));
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

    window.scrollTo(0, 0);
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

  $(".closeModal,#new-modal #printModal .modal-title a.greyBtn").click(function () {
    addresscloseModal();
  });

  $(".submitEnrollmentModalBtn").click(function () {
      addresscloseModal();
      addressLoadModal('#submitEnrollmentModal');
    });

  $(".saveAsDraftModalBtn").click(function () {
      addresscloseModal();
      addressLoadModal('#saveAsDraftModal');
    });

  $('.printModalBtn').click(function () {
      addresscloseModal();
      addressLoadModal('#printModal');
    });

  $('.editInfo').click(function () {
    $(this).parents('.tabContent').find('.editInfo').hide();
    $(this).parents('.tabContent').find('.plainInformation').hide();
    $(this).parents('.tabContent').find('.editContent').show();
  });

  $('.practiceLookupModalBtn').click(function () {
    addresscloseModal();
    addressLoadModal('#practiceLookupModal');
  });

  $('#practiceLookupModal .searchBtn').click(function () {
    $('#practiceLookupModal .tableContainer').show();
    addressPositionModal();
  });

  $('#practiceLookupModal a.closeModal').click(function () {
    $('#practiceLookupModal .tableContainer').hide();
  });

  $('.editContent .buttonBox a.editToPlain').click(function () {
    $(this).parents('.editContent').hide();
    $(this).parents('.tabContent').find('.plainInformation').show();
    $(this).parents('.tabContent').find('.editInfo').show();
  });

  $('#saveAsDraftModalLicense .editToPlain').click(function () {
    $('#tabLicense .editContent').hide();
    $('#tabLicense .plainInformation').show();
    $('#tabLicense .editInfo').show();
    addresscloseModal();
  });

  $('#saveAsDraftModalPersonal .editToPlain').click(function () {
    $('#tabPersonal .editContent').hide();
    $('#tabPersonal .plainInformation').show();
    $('#tabPersonal .editInfo').show();
    addresscloseModal();
  });

  $('#saveAsDraftModalPractice .editToPlain').click(function () {
    $('#tabPractice .editContent').hide();
    $('#tabPractice .plainInformation').show();
    $('#tabPractice .editInfo').show();
    addresscloseModal();
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
    buttonImage: "i/calendar.png",
    buttonImageOnly: true,
    beforeShow: function (input, inst) {
      inst.dpDiv.css('margin-left', '-23px')
    }
  });
  $('input.date').click(function () {
    $(this).next('.ui-datepicker-trigger').click();
  });

  $('.ui-datepicker-trigger').attr('alt', '').attr('title', '');

  $('.filterBtn').live('click', function () {
    if ($(this).hasClass('showFilter')) {
      $(this).parent().parent().parent().find('.filterPanel').toggle();
      $(this).find('.text').html('Hide Filter');
      $(this).removeClass('showFilter').addClass('hideFilter');
      $("#showFilterPanel").val("true");
    } else {
      $(this).parent().parent().parent().find('.filterPanel').toggle();
      $(this).find('.text').html('Filter');
      $(this).removeClass('hideFilter').addClass('showFilter');
      $("#showFilterPanel").val("false");
    }
  });

  stripTable();
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

  $('input.selectAll').click(function () {
    if ($(this).attr('checked'))
     $('input[name="' + $(this).attr('name') + '"]').attr('checked', true);
    else
     $('input[name="' + $(this).attr('name') + '"]').attr('checked', false);
  });

  $('input[type=checkbox]').click(function () {
    var name = $(this).attr('name');
    if (!$(this).attr('checked')) {
      $('input[name="' + $(this).attr('name') + '"].selectAll').attr('checked', false);
    }
  });

  $('.tabSection .tab').click(function (e) {
    $(this).parent().find('.active').removeClass('active');
    $('.tabContent').hide();
    $('#new-modal #printModal .modal-content .tabContent').show();
    $(this).addClass('active');
    $($(this).attr('href')).show();
    if ($(this).attr('href') == "#tabHelpTopics") {
      $('#scrollbar').tinyscrollbar({ sizethumb: 161 });
    }

    if ($(this).attr('href') == '#tabProviderTypes') {
      $('.addProviderBtn').show();
    } else {
      $('.addProviderBtn').hide();
    }

    e.preventDefault();
    return false;
  });

  //new script
  $('.stepWidget .lastSetp').css('width', $('.stepWidget').width() - $('.stepWidget .presonal').width() - $('.stepWidget .license').width() - $('.stepWidget .practice').width() - $('.stepWidget .payment').width() - $('.stepWidget .summary').width() - 2);

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
      buttonImage: "i/calendar.png",
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
      buttonImage: "i/calendar.png",
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
      buttonImage: "i/calendar.png",
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

  /* START OF SERVICE AGENT SCRIPT ------------------------------------------------ */

  $('#draftEnrollmentTable').tablesorter({
    headers: { 0: { sorter: false }, 8: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });
  $('.table-enrollment-sort').tablesorter({
    headers: { 0: { sorter: false }, 8: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });
  $('.table-enrollment-notes-sort').tablesorter({
    headers: { 0: { sorter: false }, 8: { sorter: false }, 9: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });
  $('#resultsTable').tablesorter({
    headers: { 0: { sorter: false }, 9: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });
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
  //Scrollbar
  if ($('#scrollbar').length) {
    $('#scrollbar').tinyscrollbar({ sizethumb: 161 });
    $('#letterA').click(function () {
      $('#scrollbar').tinyscrollbar_update(0);
      return false;
    });

    $('#letterB').click(function () {
      $('#scrollbar').tinyscrollbar_update(150);
      return false;
    });

    $('#letterC').click(function () {
      $('#scrollbar').tinyscrollbar_update(300);
      return false;
    });

    $('#letterD').click(function () {
      $('#scrollbar').tinyscrollbar_update(450);
      return false;
    });

    $('#letterE').click(function () {
      $('#scrollbar').tinyscrollbar_update(600);
      return false;
    });

    $('#letterF').click(function () {
      $('#scrollbar').tinyscrollbar_update(750);
      return false;
    });

    $('#letterG').click(function () {
      $('#scrollbar').tinyscrollbar_update(900);
      return false;
    });

    $('#letterH').click(function () {
      $('#scrollbar').tinyscrollbar_update(1050);
      return false;
    });

    $('#letterI').click(function () {
      $('#scrollbar').tinyscrollbar_update(1200);
      return false;
    });

    $('#letterJ').click(function () {
      $('#scrollbar').tinyscrollbar_update(1350);
      return false;
    });

    $('#letterK').click(function () {
      $('#scrollbar').tinyscrollbar_update(1500);
      return false;
    });

    $('#letterL').click(function () {
      $('#scrollbar').tinyscrollbar_update(1650);
      return false;
    });

    $('#letterM').click(function () {
      $('#scrollbar').tinyscrollbar_update(1800);
      return false;
    });

    $('#letterN').click(function () {
      $('#scrollbar').tinyscrollbar_update(1950);
      return false;
    });

    $('#letterO').click(function () {
      $('#scrollbar').tinyscrollbar_update(2100);
      return false;
    });

    $('#letterP').click(function () {
      $('#scrollbar').tinyscrollbar_update(2250);
      return false;
    });

    $('#letterQ').click(function () {
      $('#scrollbar').tinyscrollbar_update(2400);
      return false;
    });

    $('#letterR').click(function () {
      $('#scrollbar').tinyscrollbar_update(2550);
      return false;
    });

    $('#letterS').click(function () {
      $('#scrollbar').tinyscrollbar_update(2700);
      return false;
    });

    $('#letterT').click(function () {
      $('#scrollbar').tinyscrollbar_update(2850);
      return false;
    });

    $('#letterU').click(function () {
      $('#scrollbar').tinyscrollbar_update(3000);
      return false;
    });

    $('#letterV').click(function () {
      $('#scrollbar').tinyscrollbar_update(3150);
      return false;
    });

    $('#letterW').click(function () {
      $('#scrollbar').tinyscrollbar_update(3300);
      return false;
    });

    $('#letterX').click(function () {
      $('#scrollbar').tinyscrollbar_update(3300);
      return false;
    });

    $('#letterY').click(function () {
      $('#scrollbar').tinyscrollbar_update(3300);
      return false;
    });

    $('#letterZ').click(function () {
      $('#scrollbar').tinyscrollbar_update(3300);
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
      }
    }

    if ($('#advancedSearch .checkRow input:checked:not(".checkAll")').length == 4) {
      $('#advancedSearch input.checkAll').attr('checked', true);
    } else {
      $('#advancedSearch input.checkAll').attr('checked', false);
    }
  });

  $('#advancedSearch input:not(".checkAll")').live('click', function () {
    if (!$(this).attr('checked')) {
      $(this).parents('.checkWrapper').find('.checkAll').attr('checked', false);
    } else {
      if ($('#advancedSearch .checkRow input:checked:not(".checkAll")').length == 4) {
        $('#advancedSearch input.checkAll').attr('checked', true);
      } else {
        $('#advancedSearch input.checkAll').attr('checked', false);
      }
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
      buttonImage: "i/calendar.png",
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
    if ($(this).attr('checked'))
     $('input[name="' + $(this).attr('name') + '"]').attr('checked', true);
    else
     $('input[name="' + $(this).attr('name') + '"]').attr('checked', false);
  });

  $('input[type=checkbox]').live('click', function () {
    var name = $(this).attr('name');
    if (!$(this).attr('checked')) {
      $('input[name="' + $(this).attr('name') + '"].selectAll').attr('checked', false);
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

  $('.writeNotes').live('click', function () {
    closeModal();
    loadModal('#writeNotesModal');
  });

  $('.viewNotes').live('click', function () {
    closeModal();
    loadModal('#viewNotesModal');
  });

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

  $('.advancedSearchBtn').live('click', function () {
    $('#searchResultsSection').show();
  });

  if ($.browser.msie && ($.browser.version == "7.0")) {
    $('#createEnrollment input[type="radio"],#advancedSearch input[type="checkbox"]').css('margin', '5px 3px auto 3px');
    $('.helpSection .row li').css('width', $('.helpSection .row ul').width() / 3);
  }

  /* END OF SERVICE AGENT SCRIPT -------------------------------------------------- */

  /* START OF SERVICE ADMIN SCRIPT ------------------------------------------------ */
  $('.approveLink').live('click', function () {
    closeModal();
    loadModal('#approveModal');
  });

  $('.screenLink').live('click', function () {
    closeModal();
    loadModal('#screenModal');
  });

  $('.rejectLink').live('click', function () {
    closeModal();
    loadModal('#rejectModal');
  });

  $('#rejectModal .rejectBtn').live('click', function () {
    closeModal();
    loadModal('#rejectOKModal');
  });

  $('.scheduleScreenLink').live('click', function () {
    closeModal();
    loadModal('#scheduleModal');
  });

  $('.editEnrollmentLink').live('click', function () {
    closeModal();
    loadModal('#editModal');
  });

  $('.createEnrollmentBtn').live('click', function () {
    var url = "javascript:;";
    if ($('#newEnrollment').attr('checked'))url = "new-enrollment-payment-service-admin-personal.html";
    else if ($('#renewEnrollment').attr('checked'))url = "renewal-enrollment-payment-service-admin-personal.html";
    $(this).attr('href', url);
  });

  if ($('.functionTab .filterBtn').hasClass('hideFilter')) {
    $('.functionTab .filterBtn').click();
    $('.functionTab .filterPanel').hide();
  }

  $('.deleteProviderTypesBtn').live('click', function () {
    closeModal();
    loadModal('#deleteProviderTypesModal');
  })

  $('#deleteProviderTypesModal .saveBtn,.cancelEditBtn').live('click', function () {
    closeModal();
    $('#addProviderPanel').hide();
    $('#editProviderPanel').hide();
    $('#viewProviderPanel').hide();
    $('#providerTablePanel').show();
  });

  $('.editProviderLink').live('click', function () {
    $('#addProviderPanel').hide();
    $('#editProviderPanel').show();
    $('#viewProviderPanel').hide();
    $('#providerTablePanel').hide();
  });

  $('.saveEditBtn ,.viewProviderLink').live('click', function () {
    $('#addProviderPanel').hide();
    $('#editProviderPanel').hide();
    $('#viewProviderPanel').show();
    $('#providerTablePanel').hide();
  });

  $('.addProviderBtn').live('click', function () {
    $('#editProviderPanel').hide();
    $('#viewProviderPanel').hide();
    $('#providerTablePanel').hide();
    $('#addProviderPanel').show();
  });

  $('.changeScheduleBtn').live('click', function () {
    $('#screenSchedulePanel').hide();
    $('#changeScreenSchedulePanel').show();
  });

  $('.canceleScheduleBtn,.saveScheduleBtn').live('click', function () {
    $('#changeScreenSchedulePanel').hide();
    $('#screenSchedulePanel').show();
  });

  $('.addHelpTopicBtn').live('click', function () {
    $('#helpTopicsPanel').hide();
    $('#viewHelpTopicPanel').hide();
    $('#editHelpTopicPanel').hide();
    $('#addHelpTopicPanel').show();
  });

  $('.editHelpTopicBtn').live('click', function () {
    $('#helpTopicsPanel').hide();
    $('#viewHelpTopicPanel').hide();
    $('#addHelpTopicPanel').hide();
    $('#editHelpTopicPanel').show();
  });

  $('.cancelAddHelpTopicBtn,.backToHelpTopicBtn,.deleteOKBtn').live('click', function () {
    closeModal();
    $('#viewHelpTopicPanel').hide();
    $('#editHelpTopicPanel').hide();
    $('#addHelpTopicPanel').hide();
    $('#helpTopicsPanel').show();
  });

  $('.saveAddHelpTopicBtn,.cancelEditHelpTopicBtn,#helpTopicsPanel .overview li a').live('click', function () {
    $('#viewHelpTopicPanel').show();
    $('#editHelpTopicPanel').hide();
    $('#addHelpTopicPanel').hide();
    $('#helpTopicsPanel').hide();
  });

  $('.deleteHelpTopicBtn').live('click', function () {
    loadModal('#deleteHelpTopicModal');
  })

  $('.deleteAgreementBtn').live('click', function () {
    loadModal('#deleteAgreementModal');
  });

  $('.addAgreementBtn').live('click', function () {
    $('#viewAgreementPanel').hide();
    $('#editAgreementPanel').hide();
    $('#agreementPanel').hide();
    $('#addAgreementPanel').show();
  });

  $('.saveAddAgreementBtn,.viewAgreementLink,.saveEditAgreementBtn ').live('click', function () {
    $('#editAgreementPanel').hide();
    $('#agreementPanel').hide();
    $('#addAgreementPanel').hide();
    $('#viewAgreementPanel').show();
  });

  $('.closeViewAgreementBtn,.cancelEditAgreementBtn ,.cancelAddAgreementBtn ').live('click', function () {
    $('#editAgreementPanel').hide();
    $('#addAgreementPanel').hide();
    $('#viewAgreementPanel').hide();
    $('#agreementPanel').show();
  });

  $('.editAgreementLink ').live('click', function () {
    $('#addAgreementPanel').hide();
    $('#viewAgreementPanel').hide();
    $('#agreementPanel').hide();
    $('#editAgreementPanel').show();
  });

  $('.functionTab .tab.first').click();

  /* END OF SERVICE ADMIN SCRIPT -------------------------------------------------- */

  /* START OF SYSTEM ADMIN SCRIPT ------------------------------------------------- */
  var deleteSeletedFlag = false;
  $(".deleteUserAccountModalBtn").click(function () {
      var table = $(this).parent("div.right").parent("div.pagination").parent("div.tabContent").find("table.generalTable");

      if (table.find("tbody").find("input:checkbox:checked").length > 0) {
        $("a#deleteBtn").die().live("click", function () {
            var userIds = [];
            table.find("tbody").find("input:checkbox").each(function () {
              var chk = $(this).attr("checked");
              if (chk) {
                userIds.push($(this).val());
              }
            });

            deleteUserAccounts(userIds, false);
            addresscloseModal();
          });

        addresscloseModal();
        $('.deleteAccountSpan').html('the selected user account');
        if (table.find("tbody").find("input:checkbox:checked").length > 1) {
          $('.deleteAccountSpan').html('the selected user accounts');
        }

        deleteSeletedFlag = true;
        addressLoadModal('#deleteUserAccountModal');
      }
    });

  $(".deleteUserAccountModalBtnSingle").click(function () {
    var userId = $(this).attr('rel');
    addresscloseModal();
    $('.deleteAccountSpan').html('this user account');
    deleteSeletedFlag = false;
    $("a#deleteBtn").unbind().bind("click", function () {
              if (deleteSeletedFlag) {
                return;
              }

              deleteUserAccounts([userId], true);
              addresscloseModal();
            });

    addressLoadModal('#deleteUserAccountModal');
  });

  $("a.deleteLink").unbind().click(function () {
    var tr = $(this).parent("td").parent("tr");
    $("a#deleteBtn").unbind().bind("click", function () {
            if (deleteSeletedFlag) {
              return;
            }

            deleteUserAccounts([$('input[type="checkbox"]', tr).val()], false);
            addresscloseModal();
          });

    addresscloseModal();
    $('.deleteAccountSpan').html('this user account');
    deleteSeletedFlag = false;
    addressLoadModal('#deleteUserAccountModal');
  });

  function update() {
    if ($('.table-sort').length > 0)$('.table-sort').trigger("update");
    if ($('.searchTableSort').length > 0)$('.searchTableSort').trigger("update");
    if ($('#draftTable').length > 0)$('#draftTable').trigger("update");
    if ($('.dashboardTable').length > 0)$('.dashboardTable').trigger("update");
    if ($('#draftEnrollmentTable').length > 0)$('#draftEnrollmentTable').trigger("update");
    if ($('.table-enrollment-sort').length > 0)$('.table-enrollment-sort').trigger("update");
    if ($('.table-enrollment-notes-sort').length > 0)$('.table-enrollment-notes-sort').trigger("update");
    if ($('#resultsTable').length > 0)$('#resultsTable').trigger("update");
    if ($('#userAccountsTab .generalTable').length > 0)$('#userAccountsTab .generalTable').trigger("update");
    if ($('#userAccountResultsTable').length > 0)$('#userAccountResultsTable').trigger("update");
  }
  //Check All
  $('#advancedSearch .checkRow span.minWidth').live('click', function () {
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
      }
    }

    if ($('#advancedSearch .checkRow input:checked:not(".checkAll")').length == 4) {
      $('#advancedSearch input.checkAll').attr('checked', true);
    } else {
      $('#advancedSearch input.checkAll').attr('checked', false);
    }
  });

  $('input.selectAll').unbind().die().live("click", function () {
    var tbody = $(this).parent().parent().parent().parent().next("tbody");
    if ($(this).attr('checked'))
     tbody.find('input:checkbox').attr('checked', true);
    else
     tbody.find('input:checkbox').attr('checked', false);
  });

  /*
     $("#userAccountsTab .generalTable").tablesorter({
   headers:{0:{ sorter: false},4:{ sorter: false},5:{ sorter: false}},
   widgets        : ['zebra', 'columns'],
   usNumberFormat : false,
   sortRestart    : true
  });

  $("#userAccountResultsTable").tablesorter({
   headers:{0:{ sorter: false},4:{ sorter: false},5:{ sorter: false},6:{ sorter: false}},
   widgets        : ['zebra', 'columns'],
   usNumberFormat : false,
   sortRestart    : true
  });
  */

});
/**
 * Deletes specified user accounts.
 *
 * @param userIds the user ids
 */
function deleteUserAccounts(userIds, toUserAccounts) {
  var urlParams = '?role=' + roles + '&';
  for (var i = 0; i < userIds.length; i++) {
    urlParams += ("userIds=" + userIds[i]);
    if (i != userIds.length - 1) {
      urlParams += '&&';
    }
  }

  $.ajax({
      url: $('#deleteAccountsURL').val() + urlParams,
      cache: false,
      type: "GET",
      dataType: "text",
      success: function (data) {
          if (toUserAccounts) {
            window.location = $('#userAccountsURL').val();
          } else {
            setSearchConditions();
            $('#searchUserAccountsForm, #advancedSearch').submit();
          }
        }
    });
}

function setSearchConditions() {
  if ((typeof searchedResult != 'undefined') && (searchedResult)) {
    $('#initSearchBox').val(true);
    $('#searchUserAccountsForm input[name="and"]').val(false);
    $('#searchUserAccountsForm input[name="firstName"]').val(searchFirstName);
    $('#searchUserAccountsForm input[name="lastName"]').val(searchFirstName);
  }
}

$(document).ready(function () {
    $('.pagiBox .pagi .page').live('click', function () {
        $('#pageNumber').val($(this).html());
        setSearchConditions();
        $('#searchUserAccountsForm, #advancedSearch').submit();
      });

    $('.pagiBox .pagi .next').live('click', function () {
        var pageNumber = parseInt($('.pagiBox .pagi .current').html()) + 1;
        $('#pageNumber').val(pageNumber);
        setSearchConditions();
        $('#searchUserAccountsForm, #advancedSearch').submit();
      });

    $('.pagiBox .pagi .prev').live('click', function () {
        var pageNumber = parseInt($('.pagiBox .pagi .current').html()) - 1;
        $('#pageNumber').val(pageNumber);
        setSearchConditions();
        $('#searchUserAccountsForm, #advancedSearch').submit();
      });

    $('.pagination select').live('change', function () {
        $('#pageNumber').val("1");
        $('#pageSize').val($(this).val());
        setSearchConditions();
        $('#searchUserAccountsForm, #advancedSearch').submit();
      });

    $(".sortable_column").live('click', function () {
        var newSortColumn = $(this).attr("rel");
        var oldSortColumn = $("#sortColumn").val();
        var oldAscending = $("#ascending").val();
        if (newSortColumn == oldSortColumn) {
          if (oldAscending == 'true') {
            $("#ascending").val('false');
          } else {
            $("#ascending").val('true');
          }
        }

        $("#sortColumn").val(newSortColumn);
        setSearchConditions();
        $('#searchUserAccountsForm, #advancedSearch').submit();
        return false;
      });

    $('.editAccountSaveBtn').live('click', function () {
        $('#updateProfile').submit();
      });

    $('#filterBtn, .advancedSearchBtn').live('click', function () {
        $('#searchUserAccountsForm, #advancedSearch').submit();
        return false;
      });

    $('.searchBox').live('click', function () {
        var val = $.trim($('#searchBoxFirstName').val());
        if (val == 'Search Keyword') {
          val = '';
          $('#searchBoxFirstName').val(val);
        }

        $('#searchBoxLastName').val(val);
        $('#searchBoxForm').submit();
        return false;
      });
  });

function stripTable() {
  $('table .even').removeClass('even');
  $('table tr:nth-child(even)').addClass('even');
}
