{# Override of rendercv's built-in BulletEntry: adds an optional indented, italic
   `blurb` (set by build/refresh_cv.py) under the bullet. #}
- {{entry.bullet}}
{% if entry.blurb %}
  #block(inset: (left: 1.5em), above: 0.45em)[#emph[{{entry.blurb}}]]
{% endif %}
