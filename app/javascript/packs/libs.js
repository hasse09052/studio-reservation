$(function () {
  // ハンバーガーメニュー開閉
  $("#hamburgerBtn").click(() => {
    const menus = $("#headerMenus");

    if (menus.hasClass("-open")) {
      $("#hamburgerBtn").toggleClass("-open");
      menus.toggleClass("-open");
      $("#hamburgerBtnText").text("Menu");
      menus.stop(1, 1).slideUp();
    }
    else {
      $("#hamburgerBtn").toggleClass("-open");
      menus.toggleClass("-open");
      $("#hamburgerBtnText").text("Close");
      menus.stop(1, 1).slideDown();
    }
  });

  // モーダル非表示の定義
  const hiddenDeleteModal = () => {
    $("#overlay").fadeOut("fast");
    $("#deleteModal").fadeOut("fast");
    $("#logoutModal").fadeOut("fast");
  };

  // キャンセルをクリックでモーダル非表示
  $("#overlayHiddenBtn").click(() => {
    hiddenDeleteModal();
  });

  // オーバーレイをクリックでモーダル非表示
  $("#overlay").click(() => {
    hiddenDeleteModal();
  });

  // ログアウトのモーダル表示
  $("#logoutBtn").click(() => {
    $("#overlay").fadeIn("fast");
    $("#logoutModal").fadeIn("fast");
  });

  // 予約削除のモーダル表示
  $("#deleteBtn").click(() => {
    $("#overlay").fadeIn("fast");
    $("#deleteModal").fadeIn("fast");
  });
});