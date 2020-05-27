$(document).on('turbolinks:load', () => {
  // 画像用のinputを生成する関数
  const buildFileField = (index) => {
    const html = `<label class="js-file_group" data-index="${index}">
                    <i class="fa fa-camera clkarea-icon"></i>
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][image]"
                    id="item_images_attributes_${index}_src">
                  </label>`;

    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url) => {
    const html = `<div class="prepic" data-index="${index}">
                    <img data-index="${index}" class="tmpimg" src="${url}">
                    <br>
                    <label>
                     <input data-index="${index}" class="hidden-destroy" type="checkbox" value="1" name="item[images_attributes][${index}][_destroy]" id="item_images_attributes_${index}__destroy">
                      <div class="js-remove">削除</div>
                    </label>
                  </div>`;
    return html;
  }
  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  $('.hidden-destroy').hide();
  // $(`div[data-index="10"]`).remove();
  $(`label[new="new"]`).css('width', `${120 * 5}`);
  // $(`div[edit="new"]`).css('width', `${120 * 5}`);
  if (fileIndex[0] <= 5) {
    $(`div[data-index="${fileIndex[0] - 1}"]`).css('width', `${120 * (6 - fileIndex[0])}`);
  } else if (fileIndex[0] <= 10) {
    $(`div[data-index="${fileIndex[0] - 1}"]`).css('width', `${120 * (11 - fileIndex[0])}`);
  } else {
    $(`div[data-index="10"]`).remove();
  }

  $('#image-box').on('change', '.js-file', function (e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // console.log(targetIndex);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {
      // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#previews').append(buildFileField(fileIndex[0]));
      fileIndex.shift();

      //新規画面で画像追加したら添付ボタンにhiddenクラスを追加して非表示にする 
      $(`label[new="new"]`).addClass("hidden-field");

      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);

      // 画像追加して呼び出された添付ボタンを非表示
      $(`input[name="item[images_attributes][${fileIndex[0] - 2}][image]"]`).addClass("hidden-field");
      $(`div[edit="new"]`).addClass("hidden-field");
      $(`label[data-index="${fileIndex[0] - 2}"]`).addClass("hidden-field");
      $('.hidden-destroy').hide();

      // $(`label[data-index="10"]`).remove();
      if (fileIndex[0] <= 5) {
        $(`label[data-index="${fileIndex[0] - 1}"]`).css('width', `${120 * (6 - fileIndex[0])}`);
      } else if (fileIndex[0] <= 10) {
        $(`label[data-index="${fileIndex[0] - 1}"]`).css('width', `${120 * (11 - fileIndex[0])}`);
      } else {
        $(`label[data-index="10"]`).remove();
      }

      // $(`label[data-index="5"]`).css('width', '100%');

      // console.log(fileIndex[0]);
    }
  });

  $('#image-box').on('click', '.js-remove', function () {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    // 削除ボタンを押したら対象の写真を非表示にする
    $(this).parent().parent().addClass("hidden-field");
    // $(this).remove();
    // $(`img[data-index="${targetIndex}"]`).remove();
    // $(`div class="js-file_group" data-index="${targetIndex}"`).remove();

    // fileIndex.shift();
    // console.log(fileIndex);
    fileIndex.push(fileIndex[fileIndex.length - 1] - 1);

    // 削除ボタンクリックで初期表示の添付エリアを非表示にする
    $(`div[edit="new"]`).remove();

    console.log(fileIndex[0] - 2);
    console.log(fileIndex);

    $('#previews').append(buildFileField(fileIndex[0] - 3));
    fileIndex.shift();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});




// jquery書きはじめ
$(function () {
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = 1000 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 1000) {
    $(".js-text-count").css("color", "red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-count").text(now_count + "/1000");

  $(".js-text").on("keyup", function () {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 1000 - count;

    if (count > 1000) {
      $(".js-text-count").css("color", "red");
    } else {
      $(".js-text-count").css("color", "black");
    }
    $(".js-text-count").text(now_count + "/1000");
  });
});
