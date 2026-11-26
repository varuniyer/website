(function () {
  document.querySelectorAll('a[data-email-base64]').forEach(function (link) {
    function setMailtoHref() { link.href = 'mailto:' + atob(link.dataset.emailBase64); }
    link.addEventListener('mouseenter', setMailtoHref);
    link.addEventListener('focusin', setMailtoHref);
    link.addEventListener('touchstart', setMailtoHref, { passive: true });
    link.addEventListener('click', setMailtoHref);
  });
})();
