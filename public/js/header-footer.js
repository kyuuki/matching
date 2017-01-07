// JavaScript Document

        $(document).ready(function () {
            $('.navbar-toggle').click(function(event) {
                $('.menu-trigger').toggleClass('active');
                //ユーザー登録をタップされたときに、.collapse メニューを閉じる
                $(".navbar-nav li a").click(function(event) {
                    $(".navbar-collapse").collapse('hide');
                    $('.menu-trigger').removeClass('active');
                });
            });
        });