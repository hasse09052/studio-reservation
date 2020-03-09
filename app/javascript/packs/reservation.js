$(function() {
  // 予約登録フォームで、名前自動入力ボタンの動作について
  $("#autoInputNameButton").click(()=>{
    userName = $("#currentUserName").val();
    $("#nameField").val(userName);
  });

  // 予約削除のモーダル
  $("#deleteReservationBtn").click(()=>{
    $("#overlay").fadeIn("fast");
    $("#deleteReservationModal").fadeIn("fast");
  })

  // モーダル非表示
  const hiddenModal = () => {
    $("#overlay").fadeOut("fast");
    $("#deleteReservationModal").fadeOut("fast");
  }

  $("#overlay").click(()=>{
    hiddenModal();
  })
  $("#overlayHiddenBtn").click(()=>{
    hiddenModal();
  })
});