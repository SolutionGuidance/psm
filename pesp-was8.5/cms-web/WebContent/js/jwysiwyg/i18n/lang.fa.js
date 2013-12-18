/**
 * Internationalization: Persian language
 * 
 * Depends on jWYSIWYG, $.wysiwyg.i18n
 * 
 * By: seifzadeh on github.com
 */
(function ($) {
	if (undefined === $.wysiwyg) {
		throw "lang.fa.js depends on $.wysiwyg";
	}
	if (undefined === $.wysiwyg.i18n) {
		throw "lang.fa.js depends on $.wysiwyg.i18n";
	}

	$.wysiwyg.i18n.lang.fa = {
		controls: {
			"Bold": "پر رنگ",
			"Colorpicker": "انتخاب رنگ",
			"Copy": "کپی",
			"Create link": "درج لینک",
			"Cut": "برداشتن",
			"Decrease font size": "کوچک کردن اندازه متن",
			"File Manager": "مدیریت فایل",
			"Fullscreen": "تمام صفحه",
			"Header 1": "متن بسیار بزرگ",
			"Header 2": "متن بزرگ",
			"Header 3": "متن متوسط",
			"View source code": "نمایش کد",
			"Increase font size": "زیاد کردن اندازه متن",
			"Indent": "برجسته کردن",
			"Insert Horizontal Rule": "درج خط افقی",
			"Insert image": "درج عکس",
			"Insert Ordered List": " درج لیست ردیف دار",
			"Insert table": "درج جدول",
			"Insert Unordered List": "درج لیست بدون ردیف",
			"Italic": "متن کج",
			"Justify Center": "وسط چین",
			"Justify Full": "چیدن متن از دو طرف",
			"Justify Left": "چپ چین",
			"Justify Right": "راست چین",
			"Left to Right": "چپ به راست",
			"Outdent": "بیرون رفتگی متن",
			"Paste": "چسباندن",
			"Redo": "بازگشت",
			"Remove formatting": "حذف فرمت",
			"Right to Left": "راست به چپ",
			"Strike-through": "خط خرده",
			"Subscript": "زیرنویس",
			"Superscript": "سر نویس",
			"Underline": "زیر خط دار",
			"Undo": "جلو"
		},

		dialogs: {
			// for all
			"Apply": "اعمال تغییرات",
			"Cancel": "انصراف",

			colorpicker: {
				"Colorpicker": "انتخاب رنگ",
				"Color": "رنگ"
			},

			fileManager: {
				"file_manager": 		"مدیریت فایل",
				"upload_title":			"آپلود فایل",
				"rename_title":			"تغییر نام",
				"remove_title":			"حذف فایل",
				"mkdir_title":			"عنوان پوشه جدید",
				"upload_action": 		"آپلود در پوشه جدید",
				"mkdir_action": 		"ساخ پوشه جدید",
				"remove_action": 		"حذف فایل",
				"rename_action": 		"تغییر نام فایل" ,	
				"delete_message": 		"واقعا قصد حذف فایل رو دارید؟",
				"new_directory": 		"دایرکتوری جدید",
				"previous_directory": 	"بازگشت به دایرکتوری قبلی",
				"rename":				"تغییر نام",
				"select": 				"انتخاب",
				"create": 				"ساختن",
				"submit": 				"تایید",
				"cancel": 				"انصراف",
				"yes":					"قبول",
				"no":					"رد"
			},

			image: {
				"Insert Image": "درج تصویر",
				"Preview": "پیش نمایش",
				"URL": "لینک عکس",
				"Title": "عنوان",
				"Description": "توضیحات",
				"Width": "طول",
				"Height": "عرض",
				"Original W x H": "اندازه اصلی",
				"Float": "طرف نمایش",
				"None": "بدون طرف",
				"Left": "چپ",
				"Right": "راست",
				"Select file from server": "انتخاب فایل از سرور"
			},

			link: {
				"Insert Link": "درج لینک",
				"Link URL": "آدرس لینک",
				"Link Title": "عنوان",
				"Link Target": "نوع ارجاع"
			},

			table: {
				"Insert table": "درج جدول",
				"Count of columns": "تعداد ستون‌ها",
				"Count of rows": "تعداد سطرها"
			}
		}
	};
})(jQuery);


