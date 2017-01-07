$( function()
  {
                        // クリックイベントを設定する
                        $( '#move-page-top' ).click(
                            function()
                            {
                                // スムーズにスクロールする
                                $( 'html,body' ).animate( {scrollTop:0} , 'slow' ) ;
                            }
                        ) ;
} ) ;