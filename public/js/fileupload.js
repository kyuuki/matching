    // アイコンをクリックした場合は、ファイル選択をクリックした挙動とする.
    $('#file_select_icon').on('click', function() {
      $('#file_select').click();
    });

    // ファイル選択時に表示用テキストボックスへ値を連動させる.
    // ファイル選択値のクリア機能の実装により、#file_select がDOMから消されることがあるので親要素からセレクタ指定でイベントを割り当てる.
    $('#file_select').parent().on('change', '#file_select', function() {
      // $('#file_name').val($(this).val());
      $('#file_name').val($('#file_select').prop('files')[0].name);
    });

    // 選択されたファイル名を取得.
    $('#btn_filename').on('click', function() {
      // alert($('#file_select').val());
      if ($('#file_select').prop('files').length == 0) {
        alert('ファイルが選択されていません.');
      } else {
        alert($('#file_select').prop('files')[0].name);
      }
    });

    // ファイル選択値をクリア.
    $('#btn_clear_file').on('click', function() {
      //$('#file_select').val(''); // IEだと動かない.
      $('#file_select').html('<input type="file" id="file_select" class="form-control" style="display:none;">');
      $('#file_name').val('');
    });
