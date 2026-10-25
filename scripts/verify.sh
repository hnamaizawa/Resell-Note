#!/usr/bin/env sh
set -eu
python - <<'PY'
from pathlib import Path
import re

page = Path('index.html').read_text(encoding='utf-8')
assert '<html lang="ja">' in page
assert '<title>Resell-Note' in page
assert 'fonts.googleapis.com' not in page
assert 'https://' not in page
assert "connect-src 'none'" in page
assert "default-src 'none'" in page
assert 'fetch(' not in page
assert 'XMLHttpRequest' not in page
assert 'WebSocket' not in page
assert 'fonts.googleapis.com' not in page
assert 'ローカル保存のみ' in page
assert 'id="guideBtn"' in page
assert '売上の推移' not in page
assert '発送する商品' not in page
assert 'function calc(p)' in page
assert 'price-price*fee/100-shipping-cost' in page
assert 'function escapeHtml(s)' in page
assert 'id="guideBtn"' in page
assert 'id="guideModal"' in page
assert 'editingProductId' in page
assert 'localStorage.setItem(KEY' in page
assert "type=\"number\" min=\"0\" max=\"100\"" in page
assert "new Blob(['\\ufeff'+csv]" in page
assert 'Math.round(c.profit)' in page
assert Path('使い方ガイド.txt').exists()
assert '販売済み' in Path('使い方ガイド.txt').read_text(encoding='utf-8')
print('Harness static checks passed.')
PY
