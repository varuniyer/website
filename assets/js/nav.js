(function () {
  var toggle = document.querySelector('.narrow-nav-toggle');
  toggle.addEventListener('click', function () {
    toggle.setAttribute('aria-expanded', String(toggle.getAttribute('aria-expanded') !== 'true'));
  });
})();
