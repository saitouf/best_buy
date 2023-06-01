// 使用してみた感想の入力残り文字数を表示
document.addEventListener('turbolinks:load', () => {
  let textarea = document.getElementById('textarea');
  let maxLength = textarea.maxLength;
  let currentLength = textarea.value.length;
  remainingLength = maxLength - currentLength;
  let message = document.getElementById('message');
  message.innerHTML = `${remainingLength}/${maxLength}文字`;

  textarea.addEventListener('keyup', function(){

    //現在の文字数を再取得する
   let currentLength = textarea.value.length
    //現在の文字数を再出力する
   message.innerHTML = `${maxLength - currentLength }/${maxLength}文字`
   }) 
})