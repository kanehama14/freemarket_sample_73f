$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div class="js-file_group" data-index="${index}" >
                    <input class="js-file hidden-field" type="file"
                    name="item[images_attributes][${index}][image]"
                    id="item_images_attributes_${index}_src">
                    <br>
                    <div class="js-remove">削除 ccc</div>
                  </div>`;
                  return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div class="prepic" data-index="0">
                    <img data-index="${index}" class="tmpimg" src="${url}">
                    <div class="js-file_group" data-index="${index}">
                    <input class="js-file hidden-field" type="file" name="item[images_attributes][${index}][image]" id="item_images_attributes_${index}_image">
                    <div class="js-remove">削除 aaa</div>
                    </div>
                    <input name="item[images_attributes][${index}][_destroy]" type="hidden" value="0">
                    <input data-index="${index}" class="hidden-destroy" type="checkbox" value="1" name="item[images_attributes][${index}][_destroy]" id="item_images_attributes_${index}__destroy">
                  </div>`;
    return html;
  }
  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  // $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    console.log(targetIndex);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {  
      // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      //新規画面で画像追加したら添付ボタンにhiddenクラスを追加して非表示にする 
      $('#item_images_attributes_0_image').addClass("hidden-field");
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    // $(this).parent().remove();
    // $(`img[data-index="${targetIndex}"]`).remove();
    // $(`div class="js-file_group" data-index="${targetIndex}"`).remove();
    
    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});




// jquery書きはじめ
$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = 1000 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 1000) {
    $(".js-text-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-count").text(now_count + "/1000");

  $(".js-text").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 1000 - count;

    if (count > 1000) {
      $(".js-text-count").css("color","red");
    } else {
      $(".js-text-count").css("color","black");
    }
    $(".js-text-count").text( now_count + "/1000");
  });
});