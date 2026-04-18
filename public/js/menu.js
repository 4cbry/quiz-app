// ── Verificar sesión ─────────────────────────────────────────
const nombre = sessionStorage.getItem('jugador_nombre');
if (!nombre) { location.href = 'index.html'; }

// ── Elementos ────────────────────────────────────────────────
document.querySelector('#nombre').textContent         = nombre;
document.querySelector('#nombre-jugador').textContent = nombre;
document.querySelector('#puntos').textContent =
  sessionStorage.getItem('puntaje_total') || 0;

// ── Selector de cantidad ─────────────────────────────────────
let cantidadElegida = 10;
document.querySelectorAll('.btn-cantidad').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.btn-cantidad').forEach(b => b.classList.remove('activo'));
    btn.classList.add('activo');
    cantidadElegida = parseInt(btn.dataset.cantidad);
  });
});

// ── Seleccionar categoría ────────────────────────────────────
document.querySelectorAll('.categoria').forEach(cat => {
  cat.addEventListener('click', () => {
    sessionStorage.setItem('categoria_actual',   cat.id);
    sessionStorage.setItem('cantidad_preguntas', cantidadElegida);
    location.href = 'juego.html';
  });
});

// ── Botón ranking ────────────────────────────────────────────
document.querySelector('#btn-ranking').addEventListener('click', () => {
  location.href = 'ranking.html';
});
