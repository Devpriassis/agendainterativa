<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Agenda de Plantões – Enfermagem</title>
  <style>
    :root{
      --bg:#0f172a;
      --card:#111827;
      --muted:#9ca3af;
      --text:#e5e7eb;
      --accent:#22c55e;
      --danger:#ef4444;
      --border:#1f2937;
      --sun:#f59e0b;
      --evening:#3b82f6;
      --night:#8b5cf6;
    }
    *{box-sizing:border-box}
    body{
      margin:0; font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,"Helvetica Neue",Arial;
      background:linear-gradient(180deg,#0b1225,#0f172a 35%,#0f172a);
      color:var(--text);
    }
    .container{
      max-width:1000px; margin:40px auto; padding:0 16px;
    }
    header{
      display:flex; align-items:center; justify-content:space-between; gap:12px; margin-bottom:20px;
    }
    h1{font-size:1.6rem; margin:0}
    .sub{color:var(--muted); font-size:.95rem}
    .card{
      background:var(--card); border:1px solid var(--border);
      border-radius:14px; padding:16px; box-shadow:0 10px 30px rgba(0,0,0,.25);
    }
    .grid{
      display:grid; grid-template-columns:1fr; gap:12px;
    }
    @media(min-width:700px){
      .grid{grid-template-columns:1.1fr 1fr}
    }
    label{font-weight:600; font-size:.9rem}
    input, select, textarea{
      width:100%; margin-top:6px; padding:10px 12px; border-radius:10px;
      border:1px solid var(--border); background:#0b1020; color:var(--text);
      outline:none; transition:border .2s ease;
    }
    input:focus, select:focus, textarea:focus{border-color:#4b5563}
    textarea{min-height:80px; resize:vertical}
    .row{display:grid; grid-template-columns:1fr 1fr; gap:12px}
    .actions{display:flex; gap:10px; align-items:center; margin-top:8px}
    .btn{
      padding:10px 14px; border:none; border-radius:10px; cursor:pointer; font-weight:700;
      transition:transform .05s ease, opacity .2s ease;
    }
    .btn:active{transform:scale(.98)}
    .primary{background:var(--accent); color:#052e12}
    .ghost{background:transparent; color:var(--text); border:1px solid var(--border)}
    .danger{background:var(--danger); color:#3b0d0d}
    .legend{
      display:flex; gap:10px; flex-wrap:wrap; margin-top:10px; color:var(--muted); font-size:.9rem;
    }
    .badge{
      display:inline-flex; align-items:center; gap:6px; padding:6px 10px; border-radius:999px;
      background:#0b1020; border:1px solid var(--border);
    }
    .dot{width:10px; height:10px; border-radius:50%}
    .dot.sun{background:var(--sun)}
    .dot.evening{background:var(--evening)}
    .dot.night{background:var(--night)}

    .tools{
      display:flex; gap:10px; flex-wrap:wrap; margin-bottom:12px;
    }
    .search{
      flex:1;
    }

    table{
      width:100%; border-collapse:collapse; overflow:hidden; border-radius:12px;
    }
    thead th{
      text-align:left; font-size:.85rem; color:var(--muted); padding:10px 12px; background:#0b1020;
      border-bottom:1px solid var(--border);
    }
    tbody td{
      padding:12px; border-bottom:1px solid var(--border); vertical-align:top;
    }
    tbody tr:hover{background:#0c1528}
    .turno-chip{
      display:inline-flex; align-items:center; gap:8px; padding:6px 10px; border-radius:999px;
      font-weight:700; font-size:.85rem;
    }
    .sun-chip{background:rgba(245,158,11,.15); color:#fbbf24; border:1px solid rgba(245,158,11,.35)}
    .evening-chip{background:rgba(59,130,246,.15); color:#93c5fd; border:1px solid rgba(59,130,246,.35)}
    .night-chip{background:rgba(139,92,246,.15); color:#c4b5fd; border:1px solid rgba(139,92,246,.35)}
    .cell-muted{color:var(--muted)}
    .table-actions{display:flex; gap:8px}
    .icon-btn{
      background:#0b1020; border:1px solid var(--border); color:var(--text);
      padding:8px 10px; border-radius:10px; cursor:pointer;
    }
    .icon-btn:hover{border-color:#4b5563}
    .empty{
      text-align:center; color:var(--muted); padding:18px;
    }
    footer{
      margin-top:24px; color:var(--muted); font-size:.9rem;
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <div>
        <h1>Agenda de Plantões – Enfermagem</h1>
        <div class="sub">Adicione, visualize e gerencie seus plantões com cores por turno e salvamento local.</div>
      </div>
      <button class="btn ghost" id="clearAllBtn" title="Limpar todos os plantões">Limpar tudo</button>
    </header>

    <div class="grid">
      <!-- Formulário -->
      <section class="card">
        <h2 style="margin-top:0">Novo plantão</h2>
        <form id="formPlantao">
          <div class="row">
            <div>
              <label for="data">Data</label>
              <input type="date" id="data" required />
            </div>
            <div>
              <label for="turno">Turno</label>
              <select id="turno" required>
                <option value="">Selecione...</option>
                <option value="manha">🌞 Manhã (07h–13h)</option>
                <option value="tarde">🌆 Tarde (13h–19h)</option>
                <option value="noite">🌙 Noite (19h–07h)</option>
              </select>
            </div>
          </div>
          <div class="row">
            <div>
              <label for="local">Local</label>
              <input type="text" id="local" placeholder="Hospital, UPA, unidade..." required />
            </div>
            <div>
              <label for="obs">Observações</label>
              <input type="text" id="obs" placeholder="Ex.: pediatria, troca com Ana, etc." />
            </div>
          </div>
          <div class="actions">
            <button type="submit" class="btn primary">Salvar plantão</button>
            <button type="reset" class="btn ghost">Limpar formulário</button>
          </div>
        </form>

        <div class="legend">
          <span class="badge"><span class="dot sun"></span> Manhã · 07h–13h</span>
          <span class="badge"><span class="dot evening"></span> Tarde · 13h–19h</span>
          <span class="badge"><span class="dot night"></span> Noite · 19h–07h</span>
        </div>
      </section>

      <!-- Lista -->
      <section class="card">
        <h2 style="margin-top:0">Plantões cadastrados</h2>
        <div class="tools">
          <input class="search" id="search" type="text" placeholder="Buscar por data (AAAA-MM-DD), turno, local ou observação..." />
          <button class="btn ghost" id="exportBtn" title="Exportar">Exportar (.json)</button>
          <label class="btn ghost" title="Importar">
            Importar (.json)
            <input id="importFile" type="file" accept="application/json" style="display:none" />
          </label>
        </div>
        <div style="overflow:auto">
