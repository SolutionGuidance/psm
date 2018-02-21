$(document).ready(function () {
  $("#enrollmentQuickSearch").click(function () {
    var quickSearchInput = $.trim($("#quickSearchInput").val());
    if (quickSearchInput == 'Search Keyword') {
      quickSearchInput = '';
    }

    window.location.href = ctx + "/provider/search/quick?npi=" + quickSearchInput;
    return false;
  });

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

    $(window).scrollTop(0);
  }

  addressLoadModal = function (itemId) {
    $('#modalBackground').show();
    $(itemId).show();
    addressPositionModal();
  }

  addresscloseModal = function () {
      $('#modalBackground').hide();
      $('#new-modal>div').hide();
    }

  $(".closeModal,#new-modal #printModal .modal-title a.greyBtn,#new-modal .definitionsModal .modal-title a.greyBtn").click(function () {
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

  //	$('.printModalBtn').click(function(){
  //		addresscloseModal();
  //        addressLoadModal('#printModal');
  //    });

  $('.printMe').click(function () {
    printThis($(this).attr("href"));
    return false;
  });

  $('.editInfo').click(function () {
      $(this).parents('.tabContent').find('.editInfo').hide();
      $(this).parents('.tabContent').find('.plainInformation').hide();
      $(this).parents('.tabContent').find('.editContent').show();
    });

  //	$('.practiceLookupModalBtn').click(function(){
  //		addresscloseModal();
  //		addressLoadModal('#practiceLookupModal');
  //	});
  //		$('#practiceLookupModal .searchBtn').click(function(){
  //			$('#practiceLookupModal .tableContainer').show();
  //			addressPositionModal();
  //		});
  $('#practiceLookupModal .closeModal').click(function () {
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
    if ($("#new-modal").is(':visible')) {
      addressPositionModal();
    }

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

  //	$('input.date').datepicker({
  //		dateFormat:"mm/dd/yy",
  //		showOn: "button",
  //		buttonImage: "/cms/i/calendar.png",
  //		buttonImageOnly: true,
  //		beforeShow:function(input,inst){
  //			inst.dpDiv.css('margin-left','-23px')
  //		}
  //	});
  //	$('input.date').click(function() {
  //		$(this).next('.ui-datepicker-trigger').click();
  //	});

  $("input.date").mask("99/99/9999");
  $("input.ssnMasked").mask("999-99-9999");
  $("input.npiMasked").mask("9999999999");
  $("input.umpiMasked").mask("**********");
  $("input.feinMasked").mask("99-9999999");
  $("input.taxIdMasked").mask("9999999");
  $("input.countyMask").mask("999");
  $("input.fiscalMonthInput, input.fiscalYearInput").mask("99");

  //	$('.ui-datepicker-trigger').attr('alt','').attr('title','');

  $('.filterBtn').live('click', function () {
    if ($(this).hasClass('showFilter')) {
      $(this).parent().parent().parent().find('.filterPanel').toggle();
      $(this).find('.text').html('Hide Filter');
      $(this).removeClass('showFilter').addClass('hideFilter');
      $('#filterViewStateId').val('visible');
    } else {
      $(this).parent().parent().parent().find('.filterPanel').toggle();
      $(this).find('.text').html('Filter');
      $(this).removeClass('hideFilter').addClass('showFilter');
      $('#filterViewStateId').val('hidden');
    }
  });

  stripTable();
  /*
  $('.table-sort').tablesorter({
  headers:{0:{ sorter: false},6:{ sorter: false}},
  widgets        : ['zebra', 'columns'],
  usNumberFormat : false,
  sortRestart    : true
  });
  $('.searchTableSort').tablesorter({
  headers:{0:{ sorter: false},7:{ sorter: false}},
  widgets        : ['zebra', 'columns'],
  usNumberFormat : false,
  sortRestart    : true
  });

  $('#draftTable').tablesorter({
  headers:{0:{ sorter: false},5:{ sorter: false}},
  widgets        : ['zebra', 'columns'],
  usNumberFormat : false,
  sortRestart    : true
  });

  $('.dashboardTable').tablesorter({
  headers:{6:{ sorter: false}},
  widgets        : ['zebra', 'columns'],
  usNumberFormat : false,
  sortRestart    : true
  });

  $('.table-sort,#draftTable,.searchTableSort,.dashboardTable').bind('sortEnd',function(){
  stripTable();

  });
  */
  $('input.selectAll').click(function () {
    if ($(this).attr('checked'))
    $('input[name="' + $(this).attr('name') + '"]').attr('checked', true);
    else
    $('input[name="' + $(this).attr('name') + '"]').attr('checked', false);
  });

  $('input[name="providerIds"]:not(".selectAll")').live('click', function () {
    if ($('input[name="providerIds"]:not(".selectAll")').size() == $('input[name="providerIds"]:not(".selectAll"):checked').size()) {
      $('input[name="providerIds"].selectAll').attr('checked', true);
    } else {
      $('input[name="providerIds"].selectAll').attr('checked', false);
    }

  });

  $('input[type=checkbox]').click(function () {
    var name = $(this).attr('name');
    if (!$(this).attr('checked')) {
      $('input[name="' + $(this).attr('name') + '"].selectAll').attr('checked', false);
    }
  });
  /*
  $('.tabSection .tab').click(function(e){
  $(this).parent().find('.active').removeClass('active');
  $('.tabContent').hide();
  $('#new-modal #printModal .modal-content .tabContent').show();
  $(this).addClass('active');
  $($(this).attr('href')).show();
  if($(this).attr('href') == "#tabHelpTopics"){
  $('#scrollbar').tinyscrollbar({sizethumb:161});
  }
  if($(this).attr('href') == '#tabProviderTypes'){
  $('.addProviderBtn').show();
  }
  else{
  $('.addProviderBtn').hide();
  }
  e.preventDefault();
  return false;
  })
  */

  //new script
  $('.stepWidget .lastSetp').css('width', $('.stepWidget').width() - $('.stepWidget .presonal').width() - $('.stepWidget .license').width() - $('.stepWidget .practice').width() - $('.stepWidget .payment').width() - $('.stepWidget .summary').width() - $('.stepWidget .ownerShip').width() - 2);

  //Save As Above
  $('#sameAsAbove').live('click', function () {
    contactFormElements = [
      '#contactName',
      '#contactEmail',
      '#contactPhone1',
      '#contactPhone2',
      '#contactPhone3',
      '#contactPhone4'
    ];
    if ($(this).attr('checked')) {
      contactFormElements.forEach(function (element) {
        $(element).val('').addClass("disabled").prop('disabled', true);
      });
    } else {
      contactFormElements.forEach(function (element) {
        $(element).val('').removeClass("disabled").prop('disabled', false);
      });
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

  $('.medicareCheck').live('change', function () {
    var lval = $(this).val();
    if (lval == 'HCFA Medicare Certification') {
      // only MEDICARE should be in states
      var option = $('<option></option>').attr("value", "MEDICARE").text("Medicare");
      $(this).parents('tr').find('.licenseStates').empty().append(option);
    } else {
      var states = $(this).parents('tr').find('.licenseStates option').length;
      if (states == 1) {
        // relaod
        var options = $('#tableLicenseTemplate .licenseStates option');
        $(this).parents('tr').find('.licenseStates').empty().append(options);
      }
    }
  });

  //Add License
  //if($('#tableLicense tbody tr').length < 2){
  //$('#tableLicense .remove').hide();
  //}
  $('#addLicense').live('click', function () {
    var i = $('#tableLicense tbody tr').length;
    var $i = $('#tableLicenseTemplate tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('input').val('');
    $i.find('select').val('');
    $i.find('.dateWrapper').append('<input class="date" type="text" />');
    $('#tableLicense tbody').append($i);
    $('#tableLicense input.date').mask("99/99/9999");
    //		$('#tableLicense input.date').datepicker({
    //			dateFormat:"mm/dd/yy",
    //			showOn: "button",
    //			buttonImage: "/cms/i/calendar.png",
    //			buttonImageOnly: true,
    //			beforeShow:function(input,inst){
    //				inst.dpDiv.css('margin-left','-23px')
    //			}
    //		});
    //		$('.disabledDate input.date').datepicker('disable');
    //		$('#tableLicense input.date').click(function() {
    //			$(this).next('.ui-datepicker-trigger').click();
    //		});
    //		$('#tableLicense .ui-datepicker-trigger').attr('alt','').attr('title','');
    $('#tableLicense .remove').show();
    stripTable();

    reindexLicenseTable();
    // select default if only one option
    $('#tableLicense tbody tr:last td select').each(function (idx, select) {
      if ($(select).find('option').length == 2) {
        $(select).val($(select).find('option:last').attr("value"));
        $(select).change();
      }
    });
  });

  $('#addInService').live('click', function () {
    var i = $('#inServiceTable .in-services').length;
    var $i = $('#tableInServiceTemplate .in-services').clone();
    $('#inServiceTable').append($i);
    $('#inServiceTable input.date').mask("99/99/9999");
    $('#inServiceTable .remove').show();
    reindexInServiceTable();
  });

  $('#addOutService').live('click', function () {
    var i = $('#outServiceTable .out-services').length;
    var $i = $('#tableOutServiceTemplate .out-services').clone();
    $('#outServiceTable').append($i);
    $('#outServiceTable input.date').mask("99/99/9999");
    $('#outServiceTable .remove').show();
    reindexOutServiceTable();
  });

  $('#addFacilityLicense').live('click', function () {
    var i = $('#tableFacilityLicense tbody tr').length;
    var $i = $('#tableLicenseTemplate tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('.dateWrapper').append('<input class="date" type="text" />');
    $('#tableFacilityLicense tbody').append($i);
    $('#tableFacilityLicense input.date').mask("99/99/9999");
    //
    //		$('#tableFacilityLicense input.date').datepicker({
    //			dateFormat:"mm/dd/yy",
    //			showOn: "button",
    //			buttonImage: "/cms/i/calendar.png",
    //			buttonImageOnly: true,
    //			beforeShow:function(input,inst){
    //				inst.dpDiv.css('margin-left','-23px')
    //			}
    //		});
    //		$('.disabledDate input.date').datepicker('disable');
    //		$('#tableFacilityLicense input.date').click(function() {
    //			$(this).next('.ui-datepicker-trigger').click();
    //		});
    //		$('#tableFacilityLicense .ui-datepicker-trigger').attr('alt','').attr('title','');
    $('#tableFacilityLicense .remove').show();
    stripTable();

    reindexFacilityLicenseTable();
    // select default if only one option
    $('#tableFacilityLicense tbody tr:last td select').each(function (idx, select) {
      if ($(select).find('option').length == 2) {
        $(select).val($(select).find('option:last').attr("value"));
        $(select).change();
      }
    });
  });

  $('#addCLIALicense').live('click', function () {
    var i = $('#tableCLIA tbody tr').length;
    var $i = $('#cliaLicenseTemplate tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('input').val('');
    $i.find('select').val('');
    $('#tableCLIA tbody').append($i);
    $('#tableCLIA .remove').show();
    stripTable();
    reindexCLIALicenseTable();
  });

  reindexInServiceTable = function () {
    $('#inServiceTable .in-services').each(function (index) {
      var $i = $(this);
      $i.find('.row:eq(0) select').attr("name", "_41_inServiceType_" + index);
      var name = $i.find('.row:eq(1) input[type="checkbox"]').attr("name");
      if (name) {
        var len = name.lastIndexOf('_');
        name = name.substring(0, len);
        $i.find('.row:eq(1) input[type="checkbox"]').attr("name", name + '_' + index);
      }

      $i.find('.row:eq(2) input[type="radio"]').attr("name", "_41_inServiceTypeStatus_" + index);
      $i.find('.row:eq(3) input[type="text"]').attr("name", "_41_inServiceEffDt_" + index);
    });
  }

  reindexOutServiceTable = function () {
    $('#outServiceTable .out-services').each(function (index) {
      var $i = $(this);
      $i.find('.row:eq(0) select').attr("name", "_41_outServiceType_" + index);
      var name = $i.find('.row:eq(1) input[type="checkbox"]').attr("name");
      if (name) {
        var len = name.lastIndexOf('_');
        name = name.substring(0, len);
        $i.find('.row:eq(1) input[type="checkbox"]').attr("name", name + '_' + index);
      }

      $i.find('.row:eq(2) input[type="radio"]').attr("name", "_41_outServiceTypeStatus_" + index);
      $i.find('.row:eq(3) input[type="text"]').attr("name", "_41_outServiceEffDt_" + index);
    });
  }

  reindexLicenseTable = function (id) {
    // reindex form fields
    $('#tableLicense tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(1) select').attr("name", "_03_licenseType_" + index);
      $i.find('td:eq(2) input[type="hidden"]').attr("name", "_03_attachmentId_" + index);
      $i.find('td:eq(2) input[type="file"]').attr("name", "_03_attachment_" + index);
      $i.find('td:eq(3) input').attr("name", "_03_licenseNumber_" + index);
      $i.find('td:eq(4) input').attr("name", "_03_originalIssueDate_" + index);
      $i.find('td:eq(5) input').attr("name", "_03_renewalDate_" + index);
      $i.find('td:eq(6) select').attr("name", "_03_issuingState_" + index);
    });
  }

  reindexFacilityLicenseTable = function (id) {
    // reindex form fields
    $('#tableFacilityLicense tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(1) select').attr("name", "_21_licenseType_" + index);
      $i.find('td:eq(2) input').attr("name", "_21_licenseNumber_" + index);
      $i.find('td:eq(3) input').attr("name", "_21_originalIssueDate_" + index);
      $i.find('td:eq(4) input').attr("name", "_21_renewalDate_" + index);
      $i.find('td:eq(5) select').attr("name", "_21_issuingState_" + index);
      $i.find('td:eq(6) input[type="hidden"]').attr("name", "_21_attachmentId_" + index);
      $i.find('td:eq(6) input[type="file"]').attr("name", "_21_attachment_" + index);
    });
  }

  reindexCLIALicenseTable = function (id) {
    // reindex form fields
    $('#tableCLIA tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(1) input').attr("name", "_22_licenseNumber_" + index);
      $i.find('td:eq(2) input[type="hidden"]').attr("name", "_22_attachmentId_" + index);
      $i.find('td:eq(2) input[type="file"]').attr("name", "_22_attachment_" + index);
    });
  }

  $('.in-services .remove').live('click', function () {
    $(this).closest('.in-services').parent().remove();
    reindexInServiceTable();
  });

  $('.out-services .remove').live('click', function () {
    $(this).closest('.out-services').parent().remove();
    reindexOutServiceTable();
  });

  //Remove License
  $('#tableLicense .remove').live('click', function () {
    var i = $('#tableLicense tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableLicense tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    stripTable();
    reindexLicenseTable();
  });

  //Remove License
  $('#tableFacilityLicense .remove').live('click', function () {
    var i = $('#tablePractice tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableFacilityLicense tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    stripTable();
    reindexFacilityLicenseTable();
  });

  //Remove License
  $('#tableCLIA .remove').live('click', function () {
    var i = $('#tableCLIA tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableCLIA tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    stripTable();
    reindexCLIALicenseTable();
  });

  //Add License
  //if($('#tableLicense2 tbody tr').length < 2){
  //	$('#tableLicense2 .remove').hide();
  //}
  $('#addLicense2').live('click', function () {
    var i = $('#tableLicense2 tbody tr').length;
    var $i = $('#tableLicenseTemplate2 tbody tr:first').clone();
    $i.find('td:first span').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('input').val('');
    $i.find('select').val('');
    $i.find('.dateWrapper').append('<input class="date" type="text" />');
    $('#tableLicense2 tbody').append($i);
    $('#tableLicense2 input.date').mask("99/99/9999");
    //		$('#tableLicense2 input.date').datepicker({
    //			dateFormat:"mm/dd/yy",
    //			showOn: "button",
    //			buttonImage: "/cms/i/calendar.png",
    //			buttonImageOnly: true,
    //			beforeShow:function(input,inst){
    //				inst.dpDiv.css('margin-left','-23px')
    //			}
    //		});
    //		$('.disabledDate input.date').datepicker('disable');
    //		$('#tableLicense2 input.date').click(function() {
    //			$(this).next('.ui-datepicker-trigger').click();
    //		});
    //		$('#tableLicense2 .ui-datepicker-trigger').attr('alt','').attr('title','');
    $('#tableLicense2 .remove').show();
    stripTable();

    reindexLicense2Table();
    // select default if only one option
    $('#tableLicense2 tbody tr:last td select').each(function (idx, select) {
      if ($(select).find('option').length == 2) {
        $(select).val($(select).find('option:last').attr("value"));
        $(select).change();
      }
    });
  });

  reindexLicense2Table = function (id) {
    // reindex form fields
    $('#tableLicense2 tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(1) select').attr("name", "_09_specialtyType_" + index);
      $i.find('td:eq(2) input[type="hidden"]').attr("name", "_09_attachmentId_" + index);
      $i.find('td:eq(2) input[type="file"]').attr("name", "_09_attachment_" + index);
      $i.find('td:eq(3) input').attr("name", "_09_licenseNumber_" + index);
      $i.find('td:eq(4) input').attr("name", "_09_originalIssueDate_" + index);
      $i.find('td:eq(5) input').attr("name", "_09_renewalDate_" + index);
      $i.find('td:eq(6) select').attr("name", "_09_issuingBoard_" + index);
    });
  }

  //Remove License
  $('#tableLicense2 .remove').live('click', function () {
    var i = $('#tableLicense2 tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableLicense2 tbody tr:eq(' + j + ') td:first span').text(j + 1);
    }

    stripTable();
    reindexLicense2Table();
  });

  //Radio
  //	$('#RadioWrapper input:radio').live('change',function(){
  //		if($('#switchRadioWrapper input:checked').length){
  //			if($(this).val() == 'yes'){
  //				$('#practicePage .practicePanel').show();
  //				$('#privatePractice').show();
  //				$('#primaryOffice').hide();
  //				$('#practicePage .buttonBox').show();
  //				$('#additionalPractice').show();
  //			}else{
  //				$('#practicePage .practicePanel').show();
  //				$('#primaryOffice').show();
  //				$('#privatePractice').hide();
  //				$('#practicePage .buttonBox').show();
  //				$('#additionalPractice').show();
  //				$('#switchRadioWrapper input:radio:first').attr('checked',true);
  //			}
  //		}
  //	});

  //	$('#switchRadioWrapper input:radio').live('change',function(){
  //		if($('#RadioWrapper input:radio').val() == 'yes'){
  //			$('#practicePage .practicePanel').show();
  //			$('#privatePractice').show();
  //			$('#primaryOffice').hide();
  //			$('#practicePage .buttonBox').show();
  //			$('#additionalPractice').show();
  //		}else{
  //			$('#practicePage .practicePanel').show();
  //			$('#primaryOffice').show();
  //			$('#privatePractice').hide();
  //			$('#practicePage .buttonBox').show();
  //			$('#additionalPractice').show();
  //			$('#switchRadioWrapper input:radio:first').attr('checked',true);
  //		}
  //		if($(this).val() == 'no'){
  //			$('#RadioWrapper input:radio:first').attr('checked',true);
  //			$('#practicePage .practicePanel').show();
  //			$('#privatePractice').show();
  //			$('#primaryOffice').hide();
  //			$('#practicePage .buttonBox').show();
  //			$('#additionalPractice').hide();
  //		}else{
  //			$('#additionalPractice').show();
  //		}
  //	});

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

  // Same As Above
  $('.reimbursementAddressRow .checkbox').live('click', function () {
    if ($(this).attr('checked')) {
      $(this).parents('.reimbursementAddressRow').find('input:text, select').each(function () {
        $(this).val('').addClass("disabled").prop("disabled", true);
      });
    } else {
      $(this).parents('.reimbursementAddressRow').find('input:text, select').each(function () {
        $(this).val('').removeClass("disabled").prop('disabled', false);
      });
    }
  });

  //Add License
  if ($('#tablePractice tbody tr').length < 2) {
    $('#tablePractice .remove').hide();
  }

  $('#addPractice').live('click', function () {
      var i = $('#tablePractice tbody tr').length;
      var $i = $('#tablePracticeTemplate tbody tr:first').clone();
      $i.find('td:first span').html(i + 1);
      $i.find('.dateWrapper').empty();
      $i.find('.dateWrapper').append('<input class="date" type="text" />');
      $i.find('input').val('');
      $('#tablePractice tbody').append($i);
      $('#tablePractice input.date').mask("99/99/9999");
      $('#tablePractice input.npiMasked').mask("9999999999");
      $("#tablePractice input.umpiMasked").mask("**********");
      //		$('#tablePractice input.date').datepicker({
      //			dateFormat:"mm/dd/yy",
      //			showOn: "button",
      //			buttonImage: "/cms/i/calendar.png",
      //			buttonImageOnly: true,
      //			beforeShow:function(input,inst){
      //				inst.dpDiv.css('margin-left','-23px')
      //			}
      //		});
      //		$('#tablePractice input.date').click(function() {
      //			$(this).next('.ui-datepicker-trigger').click();
      //		});
      //		$('#tablePractice .ui-datepicker-trigger').attr('alt','').attr('title','');
      $('#tablePractice .remove').show();
      stripTable();
      reindexAdditionalPracticeTable();
    });

  reindexAdditionalPracticeTable = function () {
    $('#tablePractice tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(0) input:eq(0)').attr("name", "_07_objectId_" + index);
      $i.find('td:eq(0) input:eq(1)').attr("name", "_07_objectIdHash_" + index);
      $i.find('td:eq(1) input').attr("name", "_07_npi_" + index);
      $i.find('td:eq(2) input').attr("name", "_07_name_" + index);
      $i.find('td:eq(3) input').attr("name", "_07_effectiveDate_" + index);
      $i.find('td:eq(4) input:eq(0)').attr("name", "_07_addressLine1_" + index);
      $i.find('td:eq(4) input:eq(1)').attr("name", "_07_addressLine2_" + index);
      $i.find('td:eq(5) input').attr("name", "_07_city_" + index);
      $i.find('td:eq(6) select').attr("name", "_07_state_" + index);
      $i.find('td:eq(7) input').attr("name", "_07_zip_" + index);
      $i.find('td:eq(8) input').attr("name", "_07_county_" + index);
    });
  };

  //Remove License
  $('#tablePractice .remove').live('click', function () {
    var i = $('#tablePractice tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tablePractice tbody tr:eq(' + j + ') td:first span').text(j + 1);
    }

    if (i < 3) {
      $('#tablePractice .remove').hide();
    }

    stripTable();
    reindexAdditionalPracticeTable();
  });

  $('#addAgency').live('click', function () {
    var i = $('#tableAgency tbody tr').length;
    var $i = $('#tableAgencyTemplate tbody tr:first').clone();
    $i.find('td:first span').html(i + 1);
    $i.find('input').val('');
    $('#tableAgency tbody').append($i);
    $('#tableAgency input.date').mask("99/99/9999");
    $('#tableAgency .remove').show();
    stripTable();
    reindexAdditionalAgencyTable();
  });

  reindexAdditionalAgencyTable = function () {
    $('#tableAgency tbody tr').each(function (index) {
      var $i = $(this);
      $i.find('td:eq(0) input:eq(0)').attr("name", "_12_objectId_" + index);
      $i.find('td:eq(0) input:eq(1)').attr("name", "_12_objectIdHash_" + index);
      $i.find('td:eq(1) input').attr("name", "_12_name_" + index);
      $i.find('td:eq(2) input').attr("name", "_12_npi_" + index);
      $i.find('td:eq(3) input').attr("name", "_12_studyId_" + index);
      $i.find('td:eq(4) input').attr("name", "_12_clearanceDate_" + index);
    });
  };

  //Remove License
  $('#tableAgency .remove').live('click', function () {
    var i = $('#tableAgency tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $('#tableAgency tbody tr:eq(' + j + ') td:first span').text(j + 1);
    }

    if (i < 3) {
      $('#tableAgency .remove').hide();
    }

    stripTable();
    reindexAdditionalAgencyTable();
  });

  //Add Group
  $('#addGroup').live('click', function () {
    var $i = $('.affiliationPanel table:last').clone(true);
    $i.find('input').val('');
    $('.affiliationPanel table:last').after($i);
  });

  //	$('#tabStatement input.date').datepicker('disable');
  //	$('.disabledDate input.date').datepicker('disable');

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
    case 'Home Health Agency':
      $('.nextBtn').attr('href', 'new-enrollment-no-payment-required-home-health-agency.html');
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
        if (!$(this).find('input:text').val() && !$(this).find('input').is(':disabled')) {
          $(this).find('input:text').addClass('errorInput');
          if ($(this).find('label').length > 0)
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

  // Practice Lookup
  $('.performPracticeLookupBtn').click(function performPracticeLookup(event) {
    event.preventDefault();

    var $form = $("#practiceLookupForm");
    $('#practiceLookupForm input[name="agency"]').val(isAgencyLookup);

    postJson({
      url: $form.attr("action"),
      async: false, // we are in modal anyway
      data: $form.serialize(),
      success: function (response, textStatus, jqXHR) {
        practiceLookupResults = response;
      },

      error: function (jqXHR, textStatus, errorThrown) {
        alert("There was an error encountered while performing lookup.");
      }
    });

    populatePracticeLookupResults();

    $('#practiceLookupModal .tableContainer').show();
    repositionModal();
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
  });

  $('#advancedSearch input:not(".checkAll")').live('click', function () {
    if (!$(this).attr('checked')) {
      $(this).parents('.checkWrapper').find('.checkAll').attr('checked', false);
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
    $i.find('.dateWrapper:first').append('<input class="date" type="text"  value="01/01/2012" />');
    $i.find('.dateWrapper:last').append('<input class="date" type="text"  value="01/01/2013" />');
    $('#tableLicense tbody').append($i);
    $('#tableLicense input.date').mask("99/99/9999");
    //
    //		$('#tableLicense input.date').datepicker({
    //			dateFormat:"mm/dd/yy",
    //			showOn: "button",
    //			buttonImage: "/cms/i/calendar.png",
    //			buttonImageOnly: true,
    //			beforeShow:function(input,inst){
    //				inst.dpDiv.css('margin-left','-23px')
    //			}
    //		});
    //		$('#tableLicense input.date').click(function() {
    //			$(this).next('.ui-datepicker-trigger').click();
    //		});
    //		$('#tableLicense .ui-datepicker-trigger').attr('alt','').attr('title','');
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
  $(".deleteUserAccountModalBtn").click(function () {
    var table = $(this).parent("div.right").parent("div.pagination").parent("div.tabContent").find("table.generalTable");

    if (table.find("tbody").find("input:checkbox:checked").length > 0) {
      $("a#deleteBtn").die().live("click", function () {
        table.find("tbody").find("input:checkbox").each(function () {
          var chk = $(this).attr("checked");
          if (chk) {
            $(this).parent("td").parent("tr").remove();
          }
        });

        stripTable();
        update();
        addresscloseModal();
      });

      addresscloseModal();
      addressLoadModal('#deleteUserAccountModal');
    }
  });

  $(".deleteUserAccountModalBtnSingle").click(function () {
      addresscloseModal();
      addressLoadModal('#deleteUserAccountModal');
      $("a#deleteBtn").unbind();
    })

  $("a.deleteLink").unbind().click(function () {
      var tr = $(this).parent("td").parent("tr");
      $("a#deleteBtn").unbind().bind("click", function () {
        tr.remove();
        stripTable();
        update();
        addresscloseModal();
      });

      addresscloseModal();
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
  });

  $('input.selectAll').unbind().die().live("click", function () {
    var tbody = $(this).parent().parent().parent().parent().next("tbody");
    if ($(this).attr('checked'))
    tbody.find('input:checkbox').attr('checked', true);
    else
    tbody.find('input:checkbox').attr('checked', false);
  });

  $("#userAccountsTab .generalTable").tablesorter({
    headers: { 0: { sorter: false }, 4: { sorter: false }, 5: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });

  $("#userAccountResultsTable").tablesorter({
    headers: { 0: { sorter: false }, 4: { sorter: false }, 5: { sorter: false }, 6: { sorter: false } },
    widgets: ['zebra', 'columns'],
    usNumberFormat: false,
    sortRestart: true
  });

  /* END OF SYSTEM ADMIN SCRIPT --------------------------------------------------- */

  /* START OF ORGANIZATION PROVIDER TYPE SCRIPT ---------------------------------- */

  //$('.alternateTable td input[type=text], .alternateTable td select, .facility tr:last-child td input[type=text], .facility tr:last-child td select').addClass('disabled').attr('disabled','disabled');
  //$('.alternateTable td input[type=checkbox]').attr('checked','checked');
  //$('.facility tr:last-child td input[type=checkbox]').removeAttr('checked');
  $('.alternateTable td input[type=checkbox]').click(function () {
    var parent = $(this).parent();
    if (!$(this).is(':checked')) {
      $(parent).siblings().find('input, select').removeClass('disabled').removeAttr('disabled');
    } else {
      populateData(this);
      $(parent).siblings().find('input, select').addClass('disabled').attr('disabled', 'disabled');
    }
  });

  //    $('.facility tr:last-child td input[type=text], .facility tr:last-child td input[type=file], .facility tr:last-child td select').addClass('disabled').attr('disabled','disabled');
  //    $('.facility tr:last-child td input.date').datepicker('disable');
  //    $('.facility tr:last-child td input[type=checkbox]').click(function(){
  //        var parent = $(this).parent().parent().parent();
  //        if($(this).is(':checked')){
  //            $(parent).find('input[type=text], input[type=file], select').removeAttr('disabled').removeClass('disabled');
  //            $(parent).find('input.date').datepicker('enable');
  //        }else{
  //            $(parent).find('input[type=text], input[type=file], select').attr('disabled','disabled').addClass('disabled');
  //            $(parent).find('input.date').datepicker('disable');
  //        }
  //    });

  $('a.addPractice').live('click', function () {
    var i = $(this).parent().siblings('table').find('tbody tr').length;
    var $i = $(this).parent().siblings('table').find('tbody tr:first').clone();
    $i.find('td:first').html(i + 1);
    $i.find('.dateWrapper').empty();
    $i.find('a.viewCopy, input[type=checkbox] ').remove();
    $i.find('.dateWrapper').append('<input class="date" type="text" />');
    $i.find('input').removeClass('disabled').val('');
    $i.find('select').removeClass('disabled').removeAttr('disabled');
    $i.find('select').removeClass('hide');
    $i.find('span.typeL').remove();
    $(this).parent().siblings('table').find('tbody').append($i);
    $(this).parent().siblings('table').find('input.date').mask("99/99/9999");
    $(this).parent().siblings('table').find('.remove').show();
    stripTable();
  });

  /*add individual member*/
  $('.closeSection').live('click', function () {
    $(this).parent().remove();
    reindexMembers();
    reindexSetup();
    reindexQPs();
  });

  $('#addPayTo').live('click', function () {
    var html = $('#setupTemplate').clone();
    html.attr('id', '');
    html.find('[type=text]').val('');
    $(html).removeAttr('style');
    html.find('.dateWrapper').empty();
    html.find('.dateWrapper').append('<input class="date" type="text" />');

    $('#setupTable').append(html);
    $(html).find('input.date').mask("99/99/9999");
    $(html).find('input.npiMasked').mask("9999999999");
    $(html).find("input.umpiMasked").mask("**********");
    reindexSetup();
  });

  $('#addMember').live('click', function () {
    var html = $('#memberPanelTemplate').clone();
    html.attr('id', '');
    html.find('[type=text]').val('');
    $(html).removeAttr('style');
    html.find('.dateWrapper').empty();
    html.find('.dateWrapper').append('<input class="date" type="text" />');
    $('#membersTable').append(html);
    $(html).find('input.date').mask("99/99/9999");
    $(html).find('input.npiMasked').mask("9999999999");
    $(html).find("input.umpiMasked").mask("**********");
    $(html).find('input.ssnMasked').mask("999-99-9999");
    reindexMembers();
  });

  $('#addQP').live('click', function () {
    createQPs();
  });

  $('.qpTypeSelect').live('change', function () {
    if ($(this).val() == "Mental Health Professional") {
      $(this).parents('.section').find('.mhpType').show();
    } else {
      $(this).parents('.section').find('.mhpType').hide();
    }
  });

  reindexQPs = function () {
    // reindex form fields
    $('#qpsTable .memberInfoPanel').each(function (index) {
      var $i = $(this);
      $i.find('select:eq(0)').attr("name", "_29_qpType_" + index);
      $i.find('input:eq(0)').attr("name", "_29_name_" + index);
      $i.find('input:eq(1)').attr("name", "_29_npi_" + index);
      $i.find('input:eq(2)').attr("name", "_29_startDate_" + index);
      $i.find('input:eq(3)').attr("name", "_29_qpSubType_" + index);
      $i.find('input:eq(4)').attr("name", "_29_dob_" + index);
      $i.find('input:eq(5)').attr("name", "_29_ssn_" + index);
      $i.find('input:eq(6)').attr("name", "_29_ended_" + index);
      $i.find('input:eq(7)').attr("name", "_29_endDate_" + index);
      $i.find('input:eq(8)').attr("name", "_29_addressLine1_" + index);
      $i.find('input:eq(9)').attr("name", "_29_addressLine2_" + index);
      $i.find('input:eq(10)').attr("name", "_29_city_" + index);
      $i.find('select:eq(1)').attr("name", "_29_state_" + index);
      $i.find('input:eq(11)').attr("name", "_29_zip_" + index);
      $i.find('select:eq(1)').attr("name", "_29_county_" + index);
      $i.find('input:eq(12)').attr("name", "_29_bgsNumber_" + index);
      $i.find('input:eq(13)').attr("name", "_29_bgsClearanceDate_" + index);

      $i.find('table tbody tr').each(function (rid, row) {
        var $r = $(row);
        $r.find('td:eq(1) select').attr("name", "_29_licenseType_" + index + '_' + rid);
        $r.find('td:eq(1) input').attr("name", "_29_licenseType_" + index + '_' + rid);
        $r.find('td:eq(2) input[type="hidden"]').attr("name", "_29_attachmentId_" + index + '_' + rid);
        $r.find('td:eq(2) input[type="file"]').attr("name", "_29_attachment_" + index + '_' + rid);
        $r.find('td:eq(3) input').attr("name", "_29_licenseNumber_" + index + '_' + rid);
        $r.find('td:eq(4) input').attr("name", "_29_originalIssueDate_" + index + '_' + rid);
        $r.find('td:eq(5) input').attr("name", "_29_renewalDate_" + index + '_' + rid);
        $r.find('td:eq(6) select').attr("name", "_29_issuingState_" + index + '_' + rid);
      });
    });
  }

  reindexMembers = function () {
    // reindex form fields
    $('#membersTable .memberInfoPanel').each(function (index) {
      var $i = $(this);
      $i.find('input:eq(0)').attr("name", "_16_objectId_" + index);
      $i.find('input:eq(1)').attr("name", "_16_npi_" + index);
      $i.find('select:eq(0)').attr("name", "_16_providerType_" + index);
      $i.find('input:eq(2)').attr("name", "_16_dob_" + index);
      $i.find('input:eq(3)').attr("name", "_16_startDate_" + index);
      $i.find('input:eq(4)').attr("name", "_16_name_" + index);
      $i.find('input:eq(5)').attr("name", "_16_ssn_" + index);
      $i.find('input:eq(6)').attr("name", "_16_bgsStudyId_" + index);
      $i.find('input:eq(7)').attr("name", "_16_bgsClearanceDate_" + index);
    });
  }

  reindexSetup = function () {
    // reindex form fields
    $('#setupTable .memberInfoPanel').each(function (index) {
      var $i = $(this);
      $i.find('input:eq(0)').attr("name", "_20_objectId_" + index);
      $i.find('input:eq(1)').attr("name", "_20_npi_" + index);
      $i.find('input:eq(2)').attr("name", "_20_name_" + index);
      $i.find('input:eq(3)').attr("name", "_20_contactName_" + index);
      $i.find('input:eq(4)').attr("name", "_20_effectiveDate_" + index);
      $i.find('input:eq(5)').attr("name", "_20_phone1_" + index);
      $i.find('input:eq(6)').attr("name", "_20_phone2_" + index);
      $i.find('input:eq(7)').attr("name", "_20_phone3_" + index);
      $i.find('input:eq(8)').attr("name", "_20_phone4_" + index);
      $i.find('input:eq(9)').attr("name", "_20_type_" + index);
      $i.find('input:eq(10)').attr("name", "_20_type_" + index);
      $i.find('input:eq(11)').attr("name", "_20_type_" + index);
      $i.find('input:eq(12)').attr("name", "_20_type_" + index);
    });
  }

  /*NPI lookup function*/
  $('.purpleBtn.NPILook').live('click', function () {
    performMemberLookup($(this));
  });

  $('.purpleBtn.NPISetupLookup').live('click', function () {
    performSetupLookup($(this));
  });

  /*entity type change function*/
  //$('input[name="_17_entityDescription"]').attr('disabled','disabled').addClass('disabled').siblings('label').addClass('disabled');
  $('#entityType').change(function () {
    if ($(this).val() == 'Other') {
      $('input[name="_17_entityDescription"]').removeAttr('disabled').removeClass('disabled').siblings('label').removeClass('disabled');
    } else {
      $('input[name="_17_entityDescription"]').attr('disabled', 'disabled').addClass('disabled').siblings('label').addClass('disabled');
    }

    updateBeneficialOwnerTypes($(this).val());
  });

  /*ownershipType change*/
  $('.ownershipType, .businessOwnershipType').live('change', function () {
    $(this).siblings('.subType').hide();
    if ($(this).val() == 'Other') {
      $(this).siblings('.other').show();
    } else if ($(this).val() == 'Owner - 5% or more') {
      $(this).siblings('.owner').show();
    } else if ($(this).val() == 'Subcontractor') {
      $(this).siblings('.subcontractor').show();
    }

  }).trigger('change');

  reindexPersonOwners = function () {
    // reindex form fields
    $('.personOwnersTable .personOwner').each(function (index) {
      var $i = $(this);
      $i.find('select:eq(0)').attr("name", "_17_iboType_" + index);
      $i.find('input:eq(0)').attr("name", "_17_iboSubcontractorName_" + index);
      $i.find('input:eq(1)').attr("name", "_17_iboPercentOwnership_" + index);
      $i.find('input:eq(2)').attr("name", "_17_iboOtherType_" + index);
      $i.find('input:eq(3)').attr("name", "_17_iboFirstName_" + index);
      $i.find('input:eq(4)').attr("name", "_17_iboMiddleName_" + index);
      $i.find('input:eq(5)').attr("name", "_17_iboLastName_" + index);
      $i.find('input:eq(6)').attr("name", "_17_iboSSN_" + index);
      $i.find('input:eq(7)').attr("name", "_17_iboDOB_" + index);
      $i.find('input:eq(8)').attr("name", "_17_iboHireDate_" + index);
      $i.find('input:eq(9)').attr("name", "_17_iboRelationship_" + index);
      $i.find('input:eq(10)').attr("name", "_17_iboRelationship_" + index);
      $i.find('input:eq(11)').attr("name", "_17_iboRelationship_" + index);
      $i.find('input:eq(12)').attr("name", "_17_iboRelationship_" + index);
      $i.find('input:eq(13)').attr("name", "_17_iboAddressLine1_" + index);
      $i.find('input:eq(14)').attr("name", "_17_iboAddressLine2_" + index);
      $i.find('input:eq(15)').attr("name", "_17_iboCity_" + index);
      $i.find('select:eq(1)').attr("name", "_17_iboState_" + index);
      $i.find('input:eq(16)').attr("name", "_17_iboZip_" + index);
      $i.find('select:eq(2)').attr("name", "_17_iboCounty_" + index);
      $i.find('input:eq(17)').attr("name", "_17_iboOtherInterestInd_" + index);
      $i.find('input:eq(18)').attr("name", "_17_iboOtherInterestName_" + index);
      $i.find('input:eq(19)').attr("name", "_17_iboOtherInterestPct_" + index);
      $i.find('input:eq(20)').attr("name", "_17_iboOtherAddressLine1_" + index);
      $i.find('input:eq(21)').attr("name", "_17_iboOtherAddressLine2_" + index);
      $i.find('input:eq(22)').attr("name", "_17_iboOtherCity_" + index);
      $i.find('select:eq(3)').attr("name", "_17_iboOtherCounty" + index);
      $i.find('select:eq(4)').attr("name", "_17_iboOtherState_" + index);
      $i.find('input:eq(23)').attr("name", "_17_iboOtherZip_" + index);
    });
  }

  reindexCorpOwners = function () {
    // reindex form fields
    $('.corpOwnersTable .corpOwner').each(function (index) {
      var $i = $(this);
      $i.find('select:eq(0)').attr("name", "_17_cboType_" + index);
      $i.find('input:eq(0)').attr("name", "_17_cboSubcontractorName_" + index);
      $i.find('input:eq(1)').attr("name", "_17_cboPercentOwnership_" + index);
      $i.find('input:eq(2)').attr("name", "_17_cboOtherType_" + index);
      $i.find('input:eq(3)').attr("name", "_17_cboLegalName_" + index);
      $i.find('input:eq(4)').attr("name", "_17_cboFEIN_" + index);
      $i.find('input:eq(5)').attr("name", "_17_cboAddressLine1_" + index);
      $i.find('input:eq(6)').attr("name", "_17_cboAddressLine2_" + index);
      $i.find('input:eq(7)').attr("name", "_17_cboCity_" + index);
      $i.find('select:eq(1)').attr("name", "_17_cboState_" + index);
      $i.find('input:eq(8)').attr("name", "_17_cboZip_" + index);
      $i.find('input:eq(9)').attr("name", "_17_cboCounty_" + index);
      $i.find('input:eq(10)').attr("name", "_17_cboOtherInterestInd_" + index);
      $i.find('input:eq(11)').attr("name", "_17_cboOtherInterestName_" + index);
      $i.find('input:eq(12)').attr("name", "_17_cboOtherAddressLine1_" + index);
      $i.find('input:eq(13)').attr("name", "_17_cboOtherAddressLine2_" + index);
      $i.find('input:eq(14)').attr("name", "_17_cboOtherCity_" + index);
      $i.find('select:eq(2)').attr("name", "_17_cboOtherState_" + index);
      $i.find('input:eq(15)').attr("name", "_17_cboOtherZip_" + index);
    });
  }

  /*add ownership*/
  $('#addIndividualOwnership').live('click', function () {
    var html = $('#ownerTemplate').clone();
    html.attr('id', '');
    html.find('[type=text]').val('');
    html.find('.dateWrapper').empty();
    html.find('.dateWrapper').append('<input class="date" type="text" />');
    html.find('.subType').hide();
    html.find('select').removeAttr('selected');

    $('.personOwnersTable').find('.section:last').after(html);
    $(html).find('input.date').mask("99/99/9999");
    $(html).find('input.npiMasked').mask("9999999999");
    $(html).find('input.ssnMasked').mask("999-99-9999");
    reindexPersonOwners();
  });

  $('#addBusinessOwnership').live('click', function () {
    var html = $('#corpOwnerTemplate').clone();
    html.attr('id', '');
    html.find('[type=text]').val('');
    html.find('.dateWrapper').empty();
    html.find('.dateWrapper').append('<input class="date" type="text" />');
    html.find('input').val('').removeAttr('checked');
    html.find('.subType').hide();
    html.find('select').removeAttr('selected');

    $('.corpOwnersTable').find('.section:last').after(html);
    $(html).find('input.date').mask("99/99/9999");
    $(html).find('input.npiMasked').mask("9999999999");
    $(html).find('input.ssnMasked').mask("999-99-9999");
    $(html).find("input.feinMasked").mask("99-9999999");
    reindexCorpOwners();
  });

  /*add ownership*/
  $('#addEditOwnership, #addEditBusinessOwnership').live('click', function () {
    var html = $(this).parent().prev().clone();
    html.find('.dateWrapper').empty();
    html.find('.dateWrapper').append('<input class="date" type="text" />');
    html.find('input').val('').removeAttr('checked');
    html.find('.subType').hide();
    //        html.find('select').val('Please select');
    html.find('select').removeAttr('selected');

    $(this).parent().before(html);
    $(html).find('input.date').mask("99/99/9999");
    $(html).find('input.npiMasked').mask("9999999999");
    $(html).find('input.ssnMasked').mask("999-99-9999");
    //        $(html).find('input.date').datepicker({
    //            dateFormat:"mm/dd/yy",
    //            showOn: "button",
    //            buttonImage: "/cms/i/calendar.png",
    //            buttonImageOnly: true,
    //            beforeShow:function(input,inst){
    //                inst.dpDiv.css('margin-left','-23px')
    //            }
    //        });
    //        $(html).find('input.date').click(function() {
    //            $(this).next('.ui-datepicker-trigger').click();
    //        });
    $(html).attr('alt', '').attr('title', '');
  });

  /*show definitions modal*/
  $('a.definition').live('click', function () {
    addressLoadModal('#definitionsModal');
  });

  /*show NPI definition modal*/
  $('a.NPIdefinition').live('click', function () {
    addressLoadModal('#NPIdefinitionModal');
  });

  //$('.inline input[type=radio]').removeAttr('checked');
  //    $('.inline input[name=civilMoney]').click(function(){
  //        if($(this).val()=="yes"){
  //            $(this).parent().parent().addClass('showHide');
  //        }else{
  //            $(this).parent().parent().removeClass('showHide');
  //        }
  //    });

  $('.homeHealthAgency .filterPanel').hide();

  $('a.viewCopy').live('click', function () {
    addressLoadModal('#viewCopyModal');
  });

  //Remove License
  $('tr td a.remove').unbind('click');
  $('tr td a.remove').live('click', function () {
    var table = $(this).parents('table');
    var i = $(table).find('tbody tr').length;
    $(this).parents('tr').remove();
    for (j = 0; j < i - 1; j++) {
      $(table).find('tbody tr:eq(' + j + ') td:first').text(j + 1);
    }

    if (i < 3) {
      $(table).find('.remove').hide();
    }

    stripTable();
  });

  /*show hide panel*/
  $('input.showHidePanel').live('click', function () {
    if ($(this).is(':checked')) {
      $(this).closest('.memberInfoPanel').find('.hiddenSection').show();
    } else {
      $(this).closest('.memberInfoPanel').find('.hiddenSection').hide();
    }
  })

  /*show hide panel*/
  $('input.showHidePanelSection').live('click', function () {
    if ($(this).is(':checked')) {
      $(this).closest('.section').find('.hiddenSection').show();
    } else {
      $(this).closest('.section').find('.hiddenSection').hide();
    }
  })

  /*populate data*/
  function populateData(th) {
    var row = $(th).closest('tr');

    $(row).find('input[name=npi]').val($('.organizationInfo').find('input[name=npi]').val());
    $(row).find('input[name=address]').val($('.organizationInfo').find('input[name=address]').val());
    $(row).find('input[name=city]').val($('.organizationInfo').find('input[name=city]').val());
    $(row).find('input[name=zip]').val($('.organizationInfo').find('input[name=zip]').val());
    $(row).find('input[name=country]').val($('.organizationInfo').find('input[name=country]').val());
    $(row).find('select[name=state]').val($('.organizationInfo').find('select[name=state]').val());

  }

  /* END OF ORGANIZATION PROVIDER TYPE SCRIPT ------------------------------------- */

  // mark fields that triggered error messages
  $('.formErrorMarker p').each(function () {
    var errors = $(this).attr("class").split(" ");
    $.each(errors, function (idx, el) {
      if (el != "") {
        $("input[name='" + el + "']").addClass("errorInput");
        $("select[name='" + el + "']").addClass("errorInput");
      }
    });
  })

  $('#flashPopUp').each(function () {
    addresscloseModal();
    addressLoadModal('#' + $(this).val());
  });

  $('#changeProviderTypeForm select').change(function () {
    $('#changeProviderTypeForm').submit();
  });

  $(".autotab").live('keyup', function () {
    if ($(this).val().length == $(this).attr("maxlength")) {

      var next_idx = $(':focusable').index(this) + 1;
      var tot_idx = $('body').find(':focusable').length;
      if (tot_idx == next_idx) {
        $(':focusable:eq(0)').focus();
        $(':focusable:eq(0)').select();
      } else {
        $(':focusable:eq(' + next_idx + ')').focus();
        $(':focusable:eq(' + next_idx + ')').select();
      }
    }
  });

  // get array of elements
  var fieldErrors = $(".formErrorMarker:eq(0) p");
  $(".formErrorMarker p").remove();

  // sort error messages based on document position
  fieldErrors.sort(function (a, b) {
    var clsA =  $(a).attr('class').split(' ');
    var clsB =  $(b).attr('class').split(' ');

    var fClassA = clsA.length > 0 ? clsA[0] : "zzzzzzzzzz";
    var fClassB = clsB.length > 0 ? clsB[0] : "zzzzzzzzzz";

    var sizeA = $("*[name='" + fClassA + "']").size();
    var sizeB = $("*[name='" + fClassB + "']").size();
    if (sizeA == 0 && sizeB == 0) {
      return 0;
    }

    if (sizeA == 0) {
      return -1;
    } else if (sizeB == 0) {
      return -1;
    }

    var res = $("*[name='" + fClassA + "']").first().compare($("*[name='" + fClassB + "']").first());
    if (res == 2 || res == 8) {
      return 1;
    } else if (res == 4 || res == 16) {
      return -1;
    } else {
      return 0;
    }
  });

  $(".formErrorMarker .tl").before(fieldErrors);
});

function stripTable() {
  $('table .even').removeClass('even');
  $('table tr:nth-child(even)').addClass('even');
}

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

/**
* Changes the sort column to the specified index
* @param idx the result index
*/
function changeSort(idx) {
  var cur = $('#paginationForm input[name=sortColumn]').val();
  var dir = $('#paginationForm input[name=ascending]').val();
  if (cur == idx) {
    // switch direction only
    if (dir === 'true') {
      $('#paginationForm input[name=ascending]').val('false');
    } else {
      $('#paginationForm input[name=ascending]').val('true');
    }
  } else {
    $('#paginationForm input[name=sortColumn]').val(idx);
    $('#paginationForm input[name=ascending]').val('false');
  }

  $('#paginationForm').submit();
}

/**
* Changes the page size to the given value
* @param size the new page size
*/
function changePageSize(size) {
  $('#paginationForm input[name=pageSize]').val(size);
  $('#paginationForm input[name=pageNumber]').val(1);
  $('#paginationForm').submit();
}

/**
* Changes the page number to the given value
* @param page the new page number
*/
function changePageNumber(page) {
  $('#paginationForm input[name=pageNumber]').val(page);
  $('#paginationForm').submit();
}

function disableElement(el, cond) {
  if (cond) {
    $('#' + el).prop('disabled', true);
  } else {
    $('#' + el).prop('disabled', false);
  }
}

var isPrimaryPracticeLookup = false;
var isPrivatePracticeForm = false;
var practiceLookupResults = {};
var isAgencyLookup = false;

function openPracticeLookup(primary, privatePractice) {
  isPrimaryPracticeLookup = primary === true;
  isAgencyLookup = false;
  isPrivatePracticeForm = privatePractice === true;
  practiceLookupResults = {};

  $('#practiceLookupModal .tableContainer').hide();
  // show popup
  removeModal();
  openModal('#practiceLookupModal');
}

function openAgencyLookup(primary) {
  isAgencyLookup = true;
  isPrimaryPracticeLookup = primary === true;
  isPrivatePracticeForm = false;
  practiceLookupResults = {};

  $('#practiceLookupModal .tableContainer').hide();
  // show popup
  removeModal();
  openModal('#practiceLookupModal');
}

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

function populatePracticeLookupResults() {
  var rs = practiceLookupResults;
  if (rs.total === 0) {
    $('#practiceLookupMatches').text("No matches found.");
  } else {
    $('#practiceLookupMatches').text(rs.total + " matching practices found:");
  }

  $('.tableContainer #draftTable tbody tr').remove();
  var rows = rs.items;
  for (var i = 0; i < rows.length; i++) {
    var row = rows[i];
    var $i = $('#practiceLookupTableTemplate tbody tr:first').clone();
    $i.find('td:eq(0)').html('<input type="radio" name="practicelookup" value="' + row.profileId + '"/>');
    $i.find('td:eq(1)').text(row.name);
    $i.find('td:eq(2)').text(row.npi);
    $i.find('td:eq(3)').text(row.addressLine2);
    $i.find('td:eq(4)').text(row.city);
    $i.find('td:eq(5)').text(row.state);
    $i.find('td:eq(6)').text(row.zip);
    $('.tableContainer #draftTable tbody').append($i);
  }
}

function copySelectedPracticeData() {
  var selected = $('input[name="practicelookup"]:checked').val();
  if (!selected) {
    alert("Please select a row.")
    return;
  }

  var rs = practiceLookupResults;
  var rows = rs.items;
  var row;
  for (var i = 0; i < rows.length; i++) {
    if (rows[i].profileId == selected) {
      row = rows[i]
      break;
    }
  }

  if (isAgencyLookup) {
    if (isPrimaryPracticeLookup) {
      var namespace = "_11_";

      copyPrimaryAgencyFields(namespace, row);
      togglePrimaryAgencyFields(namespace, true);
    } else {
      $('#addAgency').click();
      var $i = $('#tableAgency tbody tr:last').first();
      $i.find('td:eq(0) input:eq(0)').val(row.profileId);
      $i.find('td:eq(0) input:eq(1)').val(row.profileIdHash);
      $i.find('td:eq(1) input').val(row.name);
      $i.find('td:eq(2) input').val(row.npi);
      $i.find('td:eq(3) input').val(row.bgsId);

      // disable added row
      $i.find('td:eq(1) input').prop('disabled', true);
      $i.find('td:eq(2) input').prop('disabled', true);
      $i.find('td:eq(3) input').prop('disabled', true);
    }
  } else {
    if (isPrimaryPracticeLookup) {
      var namespace = "_06_";
      if (isPrivatePracticeForm) {
        namespace = "_05_";
      }

      copyPrimaryPracticeFields(namespace, row);

      // disable fields
      togglePrimaryPracticeFields(namespace, true);
    } else {
      $('#addPractice').click();

      var $i = $('#tablePractice tbody tr:last').first();
      $i.find('td:eq(0) input:eq(0)').val(row.profileId);
      $i.find('td:eq(0) input:eq(1)').val(row.profileIdHash);
      $i.find('td:eq(1) input').val(row.npi);
      $i.find('td:eq(2) input').val(row.name);

      $i.find('td:eq(4) input').val(row.addressLine2);
      $i.find('td:eq(5) input').val(row.city);
      $i.find('td:eq(6) select').val(row.state);
      $i.find('td:eq(7) input').val(row.zip);
      $i.find('td:eq(8) input').val(row.county);

      // disable added row
      $i.find('td:eq(1) input').val(row.npi).prop('disabled', true);
      $i.find('td:eq(2) input').val(row.name).prop('disabled', true);

      $i.find('td:eq(4) input').val(row.addressLine2).prop('disabled', true);
      $i.find('td:eq(5) input').val(row.city).prop('disabled', true);
      $i.find('td:eq(6) select').val(row.state).prop('disabled', true);
      $i.find('td:eq(7) input').val(row.zip).prop('disabled', true);
      $i.find('td:eq(8) input').val(row.county).prop('disabled', true);
    }
  }

  removeModal();
}

function copyPrimaryAgencyFields(namespace, row) {
  $('.practicePanel input[name="' + namespace + 'objectId"]').val(row.profileId);
  $('.practicePanel input[name="' + namespace + 'objectIdHash"]').val(row.profileIdHash);
  $('.practicePanel input[name="' + namespace + 'name"]').val(row.name);
  $('.practicePanel input[name="' + namespace + 'npi"]').val(row.npi);
  $('.practicePanel input[name="' + namespace + 'agencyId"]').val(row.agencyId);
  $('.practicePanel input[name="' + namespace + 'fax1"]').val(row.fax[0]);
  $('.practicePanel input[name="' + namespace + 'fax2"]').val(row.fax[1]);
  $('.practicePanel input[name="' + namespace + 'fax3"]').val(row.fax[2]);

  $('.practicePanel input[name="' + namespace + 'contactName"]').val(row.contactName);
  $('.practicePanel input[name="' + namespace + 'bgsId"]').val(row.bgsId);
  $('.practicePanel input[name="' + namespace + 'clearanceDate"]').val(row.clearanceDateAsString);
}

function togglePrimaryAgencyFields(namespace, disabled) {
  if (disabled) {
    $('#unlinkAgencyButton').show();
  } else {
    $('#unlinkAgencyButton').hide();
  }

  $('.practicePanel input[name="' + namespace + 'name"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'name"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'npi"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'agencyId"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fax1"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fax2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fax3"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'contactName"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'bgsId"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'clearanceDate"]').prop('disabled', disabled);
}

function copyPrimaryPracticeFields(namespace, row) {
  $('.practicePanel input[name="' + namespace + 'objectId"]').val(row.profileId);
  $('.practicePanel input[name="' + namespace + 'objectIdHash"]').val(row.profileIdHash);

  $('.practicePanel input[name="' + namespace + 'name"]').val(row.name);
  $('.practicePanel input[name="' + namespace + 'npi"]').val(row.npi);

  $('.practicePanel input[name="' + namespace + 'addressLine2"]').val(row.addressLine2);
  $('.practicePanel input[name="' + namespace + 'city"]').val(row.city);
  $('.practicePanel select[name="' + namespace + 'state"]').val(row.state);
  $('.practicePanel input[name="' + namespace + 'zip"]').val(row.zip);
  $('.practicePanel input[name="' + namespace + 'county"]').val(row.county);

  $('.practicePanel input[name="' + namespace + 'phone1"]').val(row.phone[0]);
  $('.practicePanel input[name="' + namespace + 'phone2"]').val(row.phone[1]);
  $('.practicePanel input[name="' + namespace + 'phone3"]').val(row.phone[2]);
  $('.practicePanel input[name="' + namespace + 'phone4"]').val(row.phone[3]);

  $('.practicePanel input[name="' + namespace + 'fax1"]').val(row.fax[0]);
  $('.practicePanel input[name="' + namespace + 'fax2"]').val(row.fax[1]);
  $('.practicePanel input[name="' + namespace + 'fax3"]').val(row.fax[2]);

  $('.practicePanel input[name="' + namespace + 'billingSameAsPrimary"]').prop('checked', true);
  $('.practicePanel input[name="' + namespace + 'billingCity"]').val('');
  $('.practicePanel select[name="' + namespace + 'billingState"]').val('');
  $('.practicePanel input[name="' + namespace + 'billingZip"]').val('');
  $('.practicePanel input[name="' + namespace + 'billingCounty"]').val('');

  $('.practicePanel input[name="' + namespace + 'fein"]').val('');
  $('.practicePanel input[name="' + namespace + 'stateTaxId"]').val('');
  $('.practicePanel input[name="' + namespace + 'fye1"]').val('');
  $('.practicePanel input[name="' + namespace + 'fye2"]').val('');
  $('.practicePanel input[name="' + namespace + 'eftAccepted"]').val('');
  $('.practicePanel input[name="' + namespace + 'remittanceSequence"]').val('');

  $('.practicePanel input[name="' + namespace + 'reimbursementSameAsPrimary"]').prop('checked', true);
  $('.practicePanel input[name="' + namespace + 'reimbursementAddressLine1"]').val('');
  $('.practicePanel input[name="' + namespace + 'reimbursementAddressLine2"]').val('');
  $('.practicePanel input[name="' + namespace + 'reimbursementCity"]').val('');
  $('.practicePanel select[name="' + namespace + 'reimbursementState"]').val('');
  $('.practicePanel input[name="' + namespace + 'reimbursementZip"]').val('');
  $('.practicePanel input[name="' + namespace + 'reimbursementCounty"]').val('');
}

function unlinkPractice(namespace) {
  $('.practicePanel input[name="' + namespace + 'objectId"]').val('');
  $('.practicePanel input[name="' + namespace + 'objectIdHash"]').val('');

  togglePrimaryPracticeFields(namespace, false);
}

function togglePrimaryPracticeFields(namespace, disabled) {
  if (disabled) {
    $('#unlinkPracticeButton').show();
  } else {
    $('#unlinkPracticeButton').hide();
  }

  $('.practicePanel input[name="' + namespace + 'name"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'npi"]').prop('disabled', disabled);
  //	$('.practicePanel input[name="' + namespace + 'effectiveDate"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'addressLine2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'city"]').prop('disabled', disabled);
  $('.practicePanel select[name="' + namespace + 'state"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'zip"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'county"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'phone1"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'phone2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'phone3"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'phone4"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'fax1"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fax2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fax3"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'billingSameAsPrimary"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'billingCity"]').prop('disabled', disabled);
  $('.practicePanel select[name="' + namespace + 'billingState"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'billingZip"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'billingCounty"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'fein"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'stateTaxId"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fye1"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'fye2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'eftAccepted"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'remittanceSequence"]').prop('disabled', disabled);

  $('.practicePanel input[name="' + namespace + 'reimbursementSameAsPrimary"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'reimbursementAddressLine1"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'reimbursementAddressLine2"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'reimbursementCity"]').prop('disabled', disabled);
  $('.practicePanel select[name="' + namespace + 'reimbursementState"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'reimbursementZip"]').prop('disabled', disabled);
  $('.practicePanel input[name="' + namespace + 'reimbursementCounty"]').prop('disabled', disabled);
}

function repositionModal() {
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

  $(window).scrollTop(0);
}

function openModal(itemId) {
  $('#modalBackground').show();
  $(itemId).show();
  repositionModal();
}

function removeModal() {
  $('#modalBackground').hide();
  $('#new-modal>div').hide();
}

function printThis(url) {
  $.ajax({
    url: url || '/cms/provider/enrollment/print',
    type: "get",
    dataType: "html",
    success: function (response, textStatus, jqXHR) {
      $('#printModal .modal-content').html(response);
      openModal('#printModal');
    },

    error: function (jqXHR, textStatus, errorThrown) {
      alert("There was an error encountered while getting print preview.");
    }
  });
}

function updateSpecialties() {
  // gather specialties
  var i = 0;
  var found = $('select[name="_09_specialtyType_' + i + '"]').size() > 0;
  var specialties = [];
  while (found) {
    specialties.push($('select[name="_09_specialtyType_' + i + '"]').val());

    i++;
    found = $('select[name="_09_specialtyType_' + i + '"]').size() > 0;
  }

  // enable selected
  $('input[name="specialtyTrigger"]').each(function (idx, el) {
    var trigger = $(this).val();
    if ($.inArray($(this).val(), specialties) > -1) {
      $(this).parent().show();
    } else {
      $(this).parent().hide();
      $(this).parent().find('input').val('');
      $(this).parent().find('select').val('');
      $(this).val(trigger);
    }
  });
}

function showHideForm(elId, show) {
  if (show) {
    $("#" + elId).show();
  } else {
    $("#" + elId).hide();
  }
}

function performMemberLookup(el) {
  var $url = $("#memberLookupURL").val();
  var val = $(el).prev().val();
  var parent = $(el).closest('.memberInfoPanel');

  postJson({
    url: $url + "?npi=" + val,
    success: function (response, textStatus, jqXHR) {
      if (response.length > 0) {
        $(el).next().hide();
        $(parent).find('.nameInput').val(response[0]['name']);
        $(parent).find('select option[value="' + response[0]['providerType'] + '"]').attr('selected', true);
      } else {
        $(el).next().show().find('span').html('<' + val + '>');
        $(parent).find('.nameInput').val('');
        $(parent).find('select option:first-child').attr('selected', true);
      }
    },

    error: function (jqXHR, textStatus, errorThrown) {
      alert("There was an error encountered while performing lookup.");
    }
  });
}

function performSetupLookup(el) {
  var $url = $("#setupLookupURL").val();
  var val = $(el).prev().val();
  var parent = $(el).closest('.memberInfoPanel');

  postJson({
    url: $url + "?npi=" + val,
    success: function (response, textStatus, jqXHR) {
      if (response.length > 0) {
        $(el).next().hide();
        $(parent).find('.objectIdInput').val(response[0]['profileId']);
        $(parent).find('.nameInput').val(response[0]['name']);
        $(parent).find('.contactNameInput').val(response[0]['contactName']);
        $(parent).find('.phone1Input').val(response[0]['phone1']);
        $(parent).find('.phone2Input').val(response[0]['phone2']);
        $(parent).find('.phone3Input').val(response[0]['phone3']);
        $(parent).find('.phone4Input').val(response[0]['phone4']);
        $(parent).find('select option[value="' + response[0]['providerType'] + '"]').attr('selected', true);
      } else {
        $(el).next().show().find('span').html('<' + val + '>');
        $(parent).find('.objectIdInput').val('');
        $(parent).find('.nameInput').val('');
        $(parent).find('.contactNameInput').val('');
        $(parent).find('.phone1Input').val('');
        $(parent).find('.phone2Input').val('');
        $(parent).find('.phone3Input').val('');
        $(parent).find('.phone4Input').val('');
        $(parent).find('select option:first-child').attr('selected', true);
      }
    },

    error: function (jqXHR, textStatus, errorThrown) {
      alert("There was an error encountered while performing lookup.");
    }
  });
}

function updateBeneficialOwnerTypes(val) {
  var $url = $("#ownerTypeLookupURL").val();

  postJson({
    url: $url + "?entityType=" + val,
    success: function (response, textStatus, jqXHR) {

      // update person owners
      $('.personOwner .ownershipType').each(function (index, select) {
        var cVal = $(select).val();
        $(select).find('option:gt(0)').remove();

        $.each(response, function (i, o) {
          if (o['ownerType'] != 'O') {
            $(select).append($("<option></option>").attr("value", o['description']).text(o['description']));
          }
        });

        $(select).val(cVal);
      });

      // update person owners
      $('.corpOwner .ownershipType').each(function (index, select) {
        var cVal = $(select).val();
        $(select).find('option:gt(0)').remove();

        $.each(response, function (i, o) {
          if (o['ownerType'] != 'P') {
            $(select).append($("<option></option>").attr("value", o['description']).text(o['description']));
          }
        });

        $(select).val(cVal);
      });
    },

    error: function (jqXHR, textStatus, errorThrown) {
      alert("There was an error encountered while performing lookup.");
    }
  });

}

function doIndividualLicenseSelect(el) {
  var parentRow = $(el).closest('tr');
  var licenseTypeFieldName = $(el).attr("name");
  var renewalEndDateFieldName = licenseTypeFieldName.replace("licenseType", "renewalDate");

  var renewalEndDate = $(parentRow).find('input[name="' + renewalEndDateFieldName + '"]').first();
  if ($(el).val() == 'PCA Training Certificate') {
    $(renewalEndDate).addClass('disabled').attr('disabled', 'disabled');
  } else {
    $(renewalEndDate).removeClass('disabled').removeAttr('disabled');
  }
}

function doInServiceSelect(el) {
  var code = $(el).val();
  $(el).closest('.assuredServicePanel').find('.ext-services').addClass('hide');
  var targetRow = $(el).closest('.assuredServicePanel').find('.ext-services-' + code);
  $(targetRow).removeClass('hide');
}

function createQPs() {
  var html = $('#qpTemplate').clone();
  $(html).removeAttr('style');
  html.find('.dateWrapper').empty();
  html.find('.dateWrapper').append('<input class="date" type="text" />');

  $('#qpsTable').append(html);
  $(html).find('input.date').mask("99/99/9999");
  $(html).find('input.npiMasked').mask("9999999999");
  $(html).find("input.umpiMasked").mask("**********");
  $(html).find('input.ssnMasked').mask("999-99-9999");
  reindexQPs();
}
