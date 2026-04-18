// ── Verificar sesión ─────────────────────────────────────────
const nombre = sessionStorage.getItem('jugador_nombre');
if (!nombre) { location.href = 'index.html'; }

// ── Datos de la partida ──────────────────────────────────────
const puntaje      = parseInt(sessionStorage.getItem('puntaje_total'))  || 0;
const acertadas    = parseInt(sessionStorage.getItem('acertadas'))      || 0;
const incorrectas  = parseInt(sessionStorage.getItem('incorrectas'))    || 0;
const esRecord     = sessionStorage.getItem('es_record') === 'si';

// ── Mostrar resultados ───────────────────────────────────────
document.querySelector('#nombre').textContent         = nombre;
document.querySelector('#nombre-jugador').textContent = nombre;
document.querySelector('#puntos').textContent         = puntaje;
document.querySelector('#puntaje-final').textContent  = `${puntaje} Punto${puntaje !== 1 ? 's' : ''}`;
document.querySelector('#total-acertadas').textContent  = acertadas;
document.querySelector('#total-incorrectas').textContent = incorrectas;

// ── Mensaje de récord ─────────────────────────────────────────
const msgRecord = document.querySelector('#mensaje-record');
if (esRecord) {
  msgRecord.textContent   = '🏆 ¡Nuevo récord alcanzado!';
  msgRecord.className     = 'mensaje-record record-nuevo';
  msgRecord.style.display = 'block';
} else {
  msgRecord.textContent   = '😅 No superaste el récord actual. ¡Intenta nuevamente!';
  msgRecord.className     = 'mensaje-record record-no';
  msgRecord.style.display = 'block';
}

// ── Botones ──────────────────────────────────────────────────
document.querySelector('#btn-comenzar').addEventListener('click', () => {
  sessionStorage.clear();
  location.href = 'index.html';
});

document.querySelector('#btn-ranking').addEventListener('click', () => {
  location.href = 'ranking.html';
});
