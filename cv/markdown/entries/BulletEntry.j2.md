{# Override of rendercv's built-in BulletEntry: adds an optional `blurb` (set by
   build/refresh_cv.py), styled by .cv-blurb in build/post_process_cv.py. Kept on one
   line so the list item stays a single <li><p>…</p></li>. #}
- {{entry.bullet}}{% if entry.blurb %} <span class="cv-blurb">{{entry.blurb}}</span>{% endif %}
