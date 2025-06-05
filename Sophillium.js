let lastScrollTop = 0;
const navbar = document.querySelector('.navbar');

window.addEventListener('scroll', function () {
  let st = window.pageYOffset || document.documentElement.scrollTop;
  if (st > lastScrollTop) {
    // スクロールダウン → ナビバー隠す
    navbar.style.top = '-56px';
  } else {
    // スクロールアップ → ナビバー表示
    navbar.style.top = '0';
  }
  lastScrollTop = st <= 0 ? 0 : st;
});
