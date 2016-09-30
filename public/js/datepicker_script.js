$(function() {
    $.fn.datepicker.language['jpn'] = {
        daysMin: ['日', '月', '火', '水', '木', '金', '土'],
        months: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月" ],
        monthsShort: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月" ],
        today: '今日',
        clear: '閉じる',
        dateFormat: 'yyyy/mm/dd',
        timeFormat: 'hh:ii',
        firstDay: 0,
    };
    $('.service-date').datepicker({
        language: 'jpn',
        minDate: new Date() // Now can select only dates, which goes after today
    });
    $('.reserve-date').datepicker({
        language: 'jpn',
        timepicker: true,
        minDate: new Date() // Now can select only dates, which goes after today
    });
});