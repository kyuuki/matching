    // �A�C�R�����N���b�N�����ꍇ�́A�t�@�C���I�����N���b�N���������Ƃ���.
    $('#file_select_icon').on('click', function() {
      $('#file_select').click();
    });

    // �t�@�C���I�����ɕ\���p�e�L�X�g�{�b�N�X�֒l��A��������.
    // �t�@�C���I��l�̃N���A�@�\�̎����ɂ��A#file_select ��DOM���������邱�Ƃ�����̂Őe�v�f����Z���N�^�w��ŃC�x���g�����蓖�Ă�.
    $('#file_select').parent().on('change', '#file_select', function() {
      // $('#file_name').val($(this).val());
      $('#file_name').val($('#file_select').prop('files')[0].name);
    });

    // �I�����ꂽ�t�@�C�������擾.
    $('#btn_filename').on('click', function() {
      // alert($('#file_select').val());
      if ($('#file_select').prop('files').length == 0) {
        alert('�t�@�C�����I������Ă��܂���.');
      } else {
        alert($('#file_select').prop('files')[0].name);
      }
    });

    // �t�@�C���I��l���N���A.
    $('#btn_clear_file').on('click', function() {
      //$('#file_select').val(''); // IE���Ɠ����Ȃ�.
      $('#file_select').html('<input type="file" id="file_select" class="form-control" style="display:none;">');
      $('#file_name').val('');
    });
