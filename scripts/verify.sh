#!/usr/bin/env sh
set -eu

tmp_js=$(mktemp --suffix=.js)
trap 'rm -f "$tmp_js"' EXIT
python - "$tmp_js" <<'PY'
from pathlib import Path
import sys
page = Path('index.html').read_text(encoding='utf-8')
start = page.rfind('<script')
end = page.find('</script>', start)
Path(sys.argv[1]).write_text(page[page.find('>', start) + 1:end], encoding='utf-8')
PY
node --check "$tmp_js"
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
assert 'storageLocation' in page
assert '保管場所' in page
assert "storageLocation:col('保管場所','storageLocation')" in page
assert "function renderTrends()" in page
assert 'chartBuckets(period)' in page
assert "id=\"soldDate\" type=\"date\"" in page
assert "soldDate:targetStatus==='販売済み'" in page
assert "remaining>0" in page
assert "p.soldDate" in page
assert Path('使い方ガイド.txt').exists()
guide = Path('使い方ガイド.txt').read_text(encoding='utf-8')
assert '数量' in guide
assert '同じ展開フォルダー' in guide
assert '販売日' in guide
assert 'ダッシュボードグラフ' in guide
assert '販売済み' in guide
print('Harness static checks passed.')
PY

python - <<'PY'
from pathlib import Path
page = Path('index.html').read_text(encoding='utf-8')
for text in ['id="importBtn"', 'id="addChartBtn"', 'form.reset();document.getElementById(\'quantity\').value=1', 'localStorage.setItem(KEY,JSON.stringify([...products,...imported]));products.push(...imported)', 'const min=Math.min(0,...data.map(d=>d.value)),max=Math.max(0,...data.map(d=>d.value))', "onclick=\"return addDashboardChart()\"", 'function addDashboardChart()', 'function normalizeChartConfig()', 'chart-error', 'function parseCsv(text)', 'function importCsv(file)', 'function renderChartSettings()', 'function drawChart(index,config)', 'chartConfig.count', "type:{line:'折れ線グラフ',bar:'棒グラフ',pie:'円グラフ'}", "localStorage.setItem(CHART_KEY"]:
    assert text in page, f'missing CSV/chart capability: {text}'
assert "accept=\".csv,text/csv\"" in page
assert '既存データは残ります' in page
assert 'new FileReader()' in page
assert 'let importedCount=0' in page
assert 'products.push(...imported);importedCount=imported.length' in page
assert '正の値がないため円グラフを表示できません' in page
assert 'function renderTrends()' in page
print('CSV import and configurable chart checks passed.')
PY

python - <<'PY'
from pathlib import Path
page = Path('index.html').read_text(encoding='utf-8')
for check in ['id="deleteProductBtn"', 'function setTableEditMode(enabled)', 'id="activeProductsBtn"', 'id="archivedProductsBtn"', 'id="archiveSelectedBtn"', 'function archiveSignature()', 'function exportProductsCsv(records,filename)', "archivedExportSignature!==archiveSignature()", "products.filter(p=>!p.archived)"]:
    assert check in page, f'missing table/archive behavior: {check}'
assert 'p.archived?' in page and "p.archived?'はい':'いいえ'" in page
assert 'const remainingProducts=products.filter(item=>item.id!==target.id);closeModal();' in page
assert 'グラフは最大4つまでです。表示数を3以下にしてから追加してください。' in page
assert "toast('先に最新のアーカイブCSVを出力してください')" in page
print('Inline table edit and archive checks passed.')
PY

python - <<'PY'
from pathlib import Path
page = Path('index.html').read_text(encoding='utf-8')
for check in ['id="userAvatar"', 'id="profileUserId"', "const PROFILE_KEY='resell-note-display-user-id-v1'", 'function initialFromUserId(value)', "localStorage.setItem(PROFILE_KEY,value)", 'function renderUserAvatar()']:
    assert check in page, f'missing local user ID avatar behavior: {check}'
assert "Array.from(String(value||'').trim())[0]?.toLocaleUpperCase('ja-JP')||'U'" in page
assert '表示用ユーザーIDは外部へ送信されません' in Path('使い方ガイド.txt').read_text(encoding='utf-8') or '表示用ユーザーID' in Path('使い方ガイド.txt').read_text(encoding='utf-8')
print('Local user ID avatar checks passed.')
PY
