$(function() {
  // 予約登録フォームで、名前自動入力ボタンの動作について
  $("#autoInputNameButton").click(()=>{
    userName = $("#currentUserName").val();
    $("#nameField").val(userName);
  });
});