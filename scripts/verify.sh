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
assert 'Math.round(c.profit*qty)' in page
assert "const KEY='sedori-note-products-v1'" in page
assert 'function quantity(p){return Math.max(1,Math.floor(Number(p.quantity)||1))}' in page
assert "id=\"quantity\" type=\"number\" min=\"1\" step=\"1\"" in page
assert "calc(p).profit*quantity(p)" in page
assert "Number(p.price)||0)*quantity(p)" in page
assert "'数量','仕入れ単価'" in page
assert '商品を編集' in page
assert 'quantity' in page
assert Path('使い方ガイド.txt').exists()
guide = Path('使い方ガイド.txt').read_text(encoding='utf-8')
assert '数量' in guide
assert '同じ展開フォルダー' in guide
assert '販売済み' in guide
print('Harness static checks passed.')
PY
