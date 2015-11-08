(function () {
  "use strict";

  // C# becomes "c-1" as an identifier...
  var foldables = {c: 1, python: 1, ruby: 1, haskell: 1, nodejs: 1, 'c-1': 1};

  document.addEventListener('DOMContentLoaded', function () {
    var titles = document.getElementsByTagName('h2');
    for(var i = 0; i < titles.length; ++i) {
      var title = titles[i];
      var id = title.getAttribute('id');
      if (id in foldables) {
        title.className += ' foldable';
        if (localStorage.getItem(id)) {
          title.className += ' folded';
        }
      }
    }
  });

  document.addEventListener('click', function (e) {
    if (!(e && e.target && /\bfoldable\b/.test(e.target.className))) {
      return;
    }

    var cls = e.target.className;
    if (/\bfolded\b/.test(cls)) {
      e.target.className = cls.replace(/\bfolded\b/, '');
      localStorage.removeItem(e.target.getAttribute('id'));
    } else {
      e.target.className += ' folded';
      localStorage.setItem(e.target.getAttribute('id'), 1);
    }
  });
})();
