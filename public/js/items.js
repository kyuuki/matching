//p-items-search-tabのpにactiveを付与する

$(function () {    
    $(".p-items-search-tab p").click(function() {
        $('.p-items-search-tab p').removeClass('active');
		$(this).addClass('active')
    });
});


//select-boxから選択されたoptionのtextを取得する

$(function () { 
    $('[name=tab-service]').change(function() {
        var val = $('[name=tab-service]').val();
        var txt = $('[name=tab-service] option:selected').text();
               if($(this).val() !== ""){         
        $('.selected-tab__item').prepend('<li class="'+val+'"><a class="selected-tab__item-close">'+txt+'</a></li>');
               }
    });
    $('[name=tab-area]').change(function() {
        var val = $('[name=tab-area]').val();
        var txt = $('[name=tab-area] option:selected').text();
                if($(this).val() !== ""){   
        $('.selected-tab__item').prepend('<li class="'+val+'"><a class="selected-tab__item-close">'+txt+'</a></li>');
                }
    });
});


//.selected-tab__item-closeがクリックされたら、要素を削除する

$(document).on('click', '.selected-tab__item-close', function() {
    $(this).parent().remove();
});