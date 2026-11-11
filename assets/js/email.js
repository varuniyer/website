(function () {
  document.querySelectorAll('a[data-email]').forEach(function (link) {
    function reveal() { link.href = 'mailto:' + atob(link.dataset.email); }
    link.addEventListener('mouseenter', reveal);
    link.addEventListener('focusin', reveal);
    link.addEventListener('touchstart', reveal, { passive: true });
    link.addEventListener('click', reveal);
  });
})();
