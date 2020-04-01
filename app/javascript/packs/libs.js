// SP版でcssのhoverが付くのを無効
var touch = 'ontouchstart' in document.documentElement
            || navigator.maxTouchPoints > 0
            || navigator.msMaxTouchPoints > 0;
if (touch) { // remove all :hover stylesheets
    try { // prevent exception on browsers not supporting DOM styleSheets properly
        for (var si in document.styleSheets) {
            var styleSheet = document.styleSheets[si];
            if (!styleSheet.rules) continue;
 
            for (var ri = styleSheet.rules.length - 1; ri >= 0; ri--) {
                if (!styleSheet.rules[ri].selectorText) continue;
 
                if (styleSheet.rules[ri].selectorText.match(':hover')) {
                    styleSheet.deleteRule(ri);
                }
            }
        }
    } catch (ex) {}
}

$(function () {
  // ハンバーガーメニュー開閉
  const toggleHamburger = () => {
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
  };
  $("#hamburgerBtn").click(() => {
    toggleHamburger();
  });
  $("#hamburgerBtn").on("keydown", (e) => {
    if(e.keyCode == 13) {
      toggleHamburger();
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
  $("#cancelModalBtn").click(() => {
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