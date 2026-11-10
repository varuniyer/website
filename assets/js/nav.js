(function () {
  var toggle = document.querySelector('.mobile-nav-toggle');
  toggle.addEventListener('click', function () {
    var open = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!open));
  });
})();
