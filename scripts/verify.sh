#!/usr/bin/env sh
set -eu
python - <<'PY'
from pathlib import Path
import re

page = Path('index.html').read_text(encoding='utf-8')
assert '<html lang="ja">' in page
assert 'function calc(p)' in page
assert 'price-price*fee/100-shipping-cost' in page
assert 'function escapeHtml(s)' in page
assert 'localStorage.setItem(KEY' in page
assert "type=\"number\" min=\"0\" max=\"100\"" in page
assert "new Blob(['\\ufeff'+csv]" in page
assert 'Math.round(c.profit)' in page
print('Harness static checks passed.')
PY
