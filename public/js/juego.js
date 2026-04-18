// ── Verificar sesión ─────────────────────────────────────────
const nombre    = sessionStorage.getItem('jugador_nombre');
const categoria = sessionStorage.getItem('categoria_actual');
const cantidad  = parseInt(sessionStorage.getItem('cantidad_preguntas')) || 10;
if (!nombre || !categoria) { location.href = 'index.html'; }

// ── Elementos HTML ───────────────────────────────────────────
const txtPuntaje      = document.querySelector('#puntos');
const nombreSpan      = document.querySelector('#nombre');
const numPreguntaSpan = document.querySelector('#num-pregunta');
const totalSpan       = document.querySelector('#total-preguntas');
const txtPregunta     = document.querySelector('#txt-pregunta');
const btnSiguiente    = document.querySelector('#siguiente');
const btnCancelar     = document.querySelector('#cancelar');
const temporizadorDiv = document.querySelector('#temporizador');
const opciones        = document.querySelectorAll('.opcion');

// ── Estado del juego ─────────────────────────────────────────
nombreSpan.textContent = nombre;
totalSpan.textContent  = cantidad;

let preguntas    = [];
let numActual    = 0;
let puntaje      = parseInt(sessionStorage.getItem('puntaje_total'))  || 0;
let acertadas    = parseInt(sessionStorage.getItem('acertadas'))      || 0;
let incorrectas  = parseInt(sessionStorage.getItem('incorrectas'))    || 0;
txtPuntaje.textContent = puntaje;

// ── Temporizador ─────────────────────────────────────────────
const TIEMPO_POR_PREGUNTA = 30;
let tiempoRestante = TIEMPO_POR_PREGUNTA;
let intervalo      = null;

function iniciarTemporizador() {
  clearInterval(intervalo);
  tiempoRestante = TIEMPO_POR_PREGUNTA;
  actualizarTemporizador();

  intervalo = setInterval(() => {
    tiempoRestante--;
    actualizarTemporizador();

    if (tiempoRestante <= 0) {
      clearInterval(intervalo);
      // Tiempo agotado: marcar como incorrecta automáticamente
      incorrectas++;
      // Mostrar la respuesta correcta
      const correcta = preguntas[numActual].correcta;
      document.querySelector('#' + correcta).classList.add('correcta');
      bloquearOpciones();
    }
  }, 1000);
}

function actualizarTemporizador() {
  temporizadorDiv.textContent = `⏱ ${tiempoRestante}s`;
  if (tiempoRestante <= 10) {
    temporizadorDiv.classList.add('urgente');
  } else {
    temporizadorDiv.classList.remove('urgente');
  }
}

// ── Cargar preguntas desde la BD ─────────────────────────────
async function cargarPreguntas() {
  try {
    const res = await fetch(`/api/preguntas/juego/${categoria}/${cantidad}`);
    if (!res.ok) throw new Error('Error al obtener preguntas');
    preguntas = await res.json();

    if (preguntas.length === 0) {
      txtPregunta.textContent = 'No hay preguntas disponibles para esta categoría.';
      return;
    }
    // Ajustar total real (puede haber menos en la BD)
    totalSpan.textContent = preguntas.length;
    mostrarPregunta(numActual);
  } catch (err) {
    console.error(err);
    txtPregunta.textContent = 'Error al cargar preguntas. Verifica la conexión con el servidor.';
  }
}

// ── Mostrar pregunta ─────────────────────────────────────────
function mostrarPregunta(num) {
  const p = preguntas[num];
  numPreguntaSpan.textContent = String(num + 1).padStart(2, '0');
  txtPregunta.textContent     = p.titulo;

  document.querySelector('#a').textContent = p.opcion_a;
  document.querySelector('#b').textContent = p.opcion_b;
  document.querySelector('#c').textContent = p.opcion_c;
  document.querySelector('#d').textContent = p.opcion_d;

  // Limpiar clases y re-asignar eventos
  opciones.forEach(op => {
    op.classList.remove('correcta', 'incorrecta', 'no-events');
    op.removeEventListener('click', responder);
    op.addEventListener('click', responder);
  });

  txtPuntaje.classList.remove('efecto');
  iniciarTemporizador();
}

// ── Evaluar respuesta ────────────────────────────────────────
function responder(e) {
  clearInterval(intervalo);
  const elegida  = e.currentTarget.id;
  const correcta = preguntas[numActual].correcta;

  if (elegida === correcta) {
    e.currentTarget.classList.add('correcta');
    puntaje++;
    acertadas++;
    txtPuntaje.textContent = puntaje;
    txtPuntaje.classList.add('efecto');
  } else {
    e.currentTarget.classList.add('incorrecta');
    document.querySelector('#' + correcta).classList.add('correcta');
    incorrectas++;
  }
  bloquearOpciones();
}

function bloquearOpciones() {
  opciones.forEach(op => {
    op.classList.add('no-events');
    op.removeEventListener('click', responder);
  });
}

// ── Botón Siguiente ──────────────────────────────────────────
btnSiguiente.addEventListener('click', () => {
  numActual++;
  if (numActual < preguntas.length) {
    mostrarPregunta(numActual);
  } else {
    clearInterval(intervalo);
    guardarYTerminar();
  }
});

// ── Cancelar partida ─────────────────────────────────────────
btnCancelar.addEventListener('click', () => {
  const confirmar = confirm('¿Estás seguro que deseas cancelar la partida? Se perderá el progreso actual.');
  if (confirmar) {
    clearInterval(intervalo);
    sessionStorage.clear();
    location.href = 'index.html';
  }
});

// ── Guardar resultado y redirigir ────────────────────────────
async function guardarYTerminar() {
  // Guardar en sessionStorage para la pantalla final
  sessionStorage.setItem('puntaje_total', puntaje);
  sessionStorage.setItem('acertadas',     acertadas);
  sessionStorage.setItem('incorrectas',   incorrectas);
  sessionStorage.setItem('num_preguntas', preguntas.length);

  // Guardar en la BD
  try {
    const res = await fetch('/api/jugadores', {
      method:  'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        nombre,
        puntaje,
        num_preguntas: preguntas.length,
      }),
    });
    const data = await res.json();
    sessionStorage.setItem('es_record',       data.esRecord ? 'si' : 'no');
    sessionStorage.setItem('record_anterior', data.recordAnterior || 0);
  } catch (err) {
    console.error('Error al guardar resultado:', err);
    sessionStorage.setItem('es_record', 'no');
  }

  location.href = 'final.html';
}

// ── Iniciar ──────────────────────────────────────────────────
cargarPreguntas();
