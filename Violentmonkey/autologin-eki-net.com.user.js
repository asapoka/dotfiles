// ==UserScript==
// @name        autologin-eki-net.com
// @namespace   Violentmonkey Scripts
// @match       https://www.eki-net.com/Personal/member/wb/Login/Login
// @grant       none
// @version     1.0
// @author      -
// @description 2023/3/29 21:58:05
// ==/UserScript==
const f1 = async function () {
  $('input[name="TxtUserID"]').val("aaaaaaaaaaa");
  $('input[name="TxtPassword"]').val("pppppppppp");
  $(".tmp_btn_h_l-auto:first").click();
};

async function exec_workflow() {
  // やりたいことの流れはここに記述する。
  await f1();
}
//////////////////////////////////////////////////////////////////////////////////////////////

// メイン処理の実行ﾀｲﾐﾝｸﾞが、windowのロード時となるように登録する
window.addEventListener("load", async function () {
  await exec_workflow();
});
