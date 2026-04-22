require('dotenv').config();
const express = require('express');
const cors    = require('cors');
const path    = require('path');

const app = express();

// ── Middleware ──────────────────────────────────────────────
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// ── Rutas API ───────────────────────────────────────────────
app.use('/api/admin',     require('./routes/admin'));
app.use('/api/preguntas', require('./routes/preguntas'));
app.use('/api/jugadores', require('./routes/jugadores'));

// ── Páginas HTML ────────────────────────────────────────────
const send = (f) => (_, res) => res.sendFile(path.join(__dirname, 'public', f));
app.get('/',         send('index.html'));
app.get('/menu',     send('menu.html'));
app.get('/juego',    send('juego.html'));
app.get('/final',    send('final.html'));
app.get('/ranking',  send('ranking.html'));
app.get('/admin',    send('admin.html'));
app.get('/admin/preguntas', send('admin-preguntas.html'));

// ── Start ───────────────────────────────────────────────────
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
  console.log(`Admin: http://localhost:${PORT}/admin`);
});