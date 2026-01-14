index.html
<!DOCTYPE html><html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>QueenBet — Plataforma Base</title>
  <style>
    :root{
      --bg:#0b1020;--card:#0f172a;--accent:#22c55e;--muted:#94a3b8;--danger:#ef4444;
    }
    *{box-sizing:border-box}
    body{margin:0;font-family:Inter,Arial,sans-serif;background:linear-gradient(180deg,#0b1020,#020617);color:#e5e7eb}
    header{display:flex;justify-content:space-between;align-items:center;padding:14px 18px;background:#020617;position:sticky;top:0}
    header h1{margin:0;font-size:18px}
    nav button{margin-left:8px}
    main{max-width:1100px;margin:auto;padding:18px}
    .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:14px}
    .card{background:var(--card);border-radius:14px;padding:14px;box-shadow:0 10px 24px rgba(0,0,0,.35)}
    .muted{color:var(--muted)}
    button{background:var(--accent);border:none;border-radius:10px;padding:10px 14px;font-weight:700;cursor:pointer}
    button.secondary{background:#1f2937;color:#e5e7eb}
    button.danger{background:var(--danger)}
    input,select{width:100%;padding:10px;border-radius:10px;border:none;margin-top:6px;background:#020617;color:#e5e7eb}
    .row{display:grid;grid-template-columns:1fr 1fr;gap:10px}
    .hidden{display:none}
    footer{padding:18px;text-align:center;color:#94a3b8}
    .badge{display:inline-block;padding:4px 8px;border-radius:999px;background:#020617;color:#a7f3d0;margin-left:6px;font-size:12px}
  </style>
</head>
<body>
<header>
  <h1>QueenBet <span class="badge">DEMO</span></h1>
  <nav>
    <button class="secondary" onclick="show('login')">Entrar</button>
    <button onclick="show('register')">Criar conta</button>
  </nav>
</header><main>
  <!-- SALDO -->
  <section class="grid">
    <div class="card">
      <h3>Saldo</h3>
      <p>R$ <strong id="saldo">100.00</strong></p>
      <p class="muted">Saldo virtual (sem dinheiro real)</p>
    </div>
    <div class="card">
      <h3>Ranking</h3>
      <ol id="ranking" class="muted"></ol>
    </div>
  </section>  <!-- JOGOS -->  <section class="card" style="margin-top:14px">
    <h3>Jogos</h3>
    <div class="grid">
      <div class="card">
        <p><strong>Time A x Time B</strong></p>
        <div class="row">
          <button onclick="bet('A',2)">A (2.0)</button>
          <button onclick="bet('B',2)">B (2.0)</button>
        </div>
        <label>Valor</label>
        <input id="valor" type="number" min="1" placeholder="10" />
        <p id="res" class="muted"></p>
      </div>
    </div>
  </section>  <!-- ADMIN -->  <section class="card" style="margin-top:14px">
    <h3>Painel Admin (base)</h3>
    <p class="muted">Aqui você controla jogos, odds e usuários (estrutura pronta).</p>
    <div class="row">
      <input placeholder="Criar novo jogo" />
      <button class="secondary">Salvar</button>
    </div>
  </section>
</main><footer>⚠️ Plataforma base educacional. Pronta para evoluir com back‑end, pagamentos e licença.</footer><!-- MODAIS --><div id="login" class="card hidden"><h3>Login</h3><input placeholder="Email"/><input type="password" placeholder="Senha"/><button onclick="hide('login')">Entrar</button></div>
<div id="register" class="card hidden"><h3>Cadastro</h3><input placeholder="Nome"/><input placeholder="Email"/><input type="password" placeholder="Senha"/><button onclick="hide('register')">Criar</button></div><script>
  let saldo=100; const users=[{name:'Você',saldo:100}];
  function bet(team,odd){
    const v=Number(document.getElementById('valor').value); if(!v||v>saldo) return alert('Valor inválido');
    const win=Math.random()<0.5; if(win){saldo+=v*(odd-1);res.innerText='Ganhou 😎';} else {saldo-=v;res.innerText='Perdeu 😭';}
    document.getElementById('saldo').innerText=saldo.toFixed(2); users[0].saldo=saldo; renderRanking();
  }
  function renderRanking(){const r=document.getElementById('ranking'); r.innerHTML=''; users.sort((a,b)=>b.saldo-a.saldo).forEach(u=>{const li=document.createElement('li'); li.textContent=`${u.name} — R$ ${u.saldo.toFixed(2)}`; r.appendChild(li);});}
  renderRanking();
  function show(id){document.getElementById(id).classList.remove('hidden')} function hide(id){document.getElementById(id).classList.add('hidden')}
</script></body>
</html>
