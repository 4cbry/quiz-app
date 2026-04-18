// ── Verificar sesión admin ───────────────────────────────────
if (sessionStorage.getItem('admin_ok') !== 'true') {
  location.href = '/admin';
}

// ── Estado ───────────────────────────────────────────────────
let todasPreguntas = [];
let modoEdicion    = false;
let idEdicion      = null;

// ── Elementos ────────────────────────────────────────────────
const tablaBody     = document.querySelector('#tabla-body');
const modal         = document.querySelector('#modal');
const modalTitulo   = document.querySelector('#modal-titulo');
const msgForm       = document.querySelector('#msg-form');
const filtroCat     = document.querySelector('#filtro-cat');
const filtroBuscar  = document.querySelector('#filtro-buscar');
const conteo        = document.querySelector('#conteo');

// Campos del formulario
const fCategoria = document.querySelector('#f-categoria');
const fTitulo    = document.querySelector('#f-titulo');
const fA         = document.querySelector('#f-a');
const fB         = document.querySelector('#f-b');
const fC         = document.querySelector('#f-c');
const fD         = document.querySelector('#f-d');
const fCorrecta  = document.querySelector('#f-correcta');

// ── Cargar preguntas ─────────────────────────────────────────
async function cargarPreguntas() {
  try {
    const res = await fetch('/api/preguntas');
    todasPreguntas = await res.json();
    renderTabla();
  } catch (err) {
    tablaBody.innerHTML = `<tr><td colspan="5" style="color:red;text-align:center;">Error al cargar preguntas.</td></tr>`;
  }
}

// ── Renderizar tabla con filtros ─────────────────────────────
function renderTabla() {
  const catFiltro    = filtroCat.value;
  const textoBuscar  = filtroBuscar.value.toLowerCase();

  const filtradas = todasPreguntas.filter(p => {
    const pasaCat    = !catFiltro || p.categoria === catFiltro;
    const pasaBuscar = !textoBuscar || p.titulo.toLowerCase().includes(textoBuscar);
    return pasaCat && pasaBuscar;
  });

  conteo.textContent = `${filtradas.length} pregunta${filtradas.length !== 1 ? 's' : ''}`;

  if (!filtradas.length) {
    tablaBody.innerHTML = `<tr><td colspan="5" style="text-align:center;opacity:0.6;">Sin resultados.</td></tr>`;
    return;
  }

  const nombresCat = {
    general: 'General', musica: 'Música', peliculas: 'Películas',
    deportes: 'Deportes', programacion: 'Programación', juegos: 'Video Juegos'
  };

  tablaBody.innerHTML = filtradas.map(p => `
    <tr>
      <td>${p.id}</td>
      <td><span class="badge-cat">${nombresCat[p.categoria] || p.categoria}</span></td>
      <td style="max-width:320px;">${p.titulo}</td>
      <td style="text-transform:uppercase;font-weight:bold;color:#a78bfa;">${p.correcta}</td>
      <td style="white-space:nowrap;">
        <button class="btn-sm btn-azul" onclick="abrirEditar(${p.id})">✏ Editar</button>
        <button class="btn-sm btn-rojo" onclick="eliminar(${p.id})" style="margin-left:4px;">🗑 Eliminar</button>
      </td>
    </tr>
  `).join('');
}

// ── Abrir modal para nueva pregunta ─────────────────────────
document.querySelector('#btn-nueva').addEventListener('click', () => {
  modoEdicion = false;
  idEdicion   = null;
  modalTitulo.textContent = 'Nueva Pregunta';
  limpiarForm();
  msgForm.textContent = '';
  modal.style.display = 'flex';
});

// ── Abrir modal para editar ──────────────────────────────────
function abrirEditar(id) {
  const p = todasPreguntas.find(x => x.id === id);
  if (!p) return;
  modoEdicion = true;
  idEdicion   = id;
  modalTitulo.textContent = 'Editar Pregunta';
  msgForm.textContent = '';

  fCategoria.value = p.categoria;
  fTitulo.value    = p.titulo;
  fA.value         = p.opcion_a;
  fB.value         = p.opcion_b;
  fC.value         = p.opcion_c;
  fD.value         = p.opcion_d;
  fCorrecta.value  = p.correcta;

  modal.style.display = 'flex';
}

// ── Cerrar modal ─────────────────────────────────────────────
document.querySelector('#btn-cancelar-modal').addEventListener('click', cerrarModal);
modal.addEventListener('click', (e) => { if (e.target === modal) cerrarModal(); });

function cerrarModal() {
  modal.style.display = 'none';
  limpiarForm();
}

function limpiarForm() {
  fCategoria.value = 'general';
  fTitulo.value = fA.value = fB.value = fC.value = fD.value = '';
  fCorrecta.value = 'a';
}

// ── Guardar (crear o editar) ─────────────────────────────────
document.querySelector('#btn-guardar').addEventListener('click', async () => {
  msgForm.textContent = '';
  msgForm.className   = '';

  const body = {
    categoria: fCategoria.value,
    titulo:    fTitulo.value.trim(),
    opcion_a:  fA.value.trim(),
    opcion_b:  fB.value.trim(),
    opcion_c:  fC.value.trim(),
    opcion_d:  fD.value.trim(),
    correcta:  fCorrecta.value,
  };

  // Validación del lado del cliente
  if (!body.titulo || !body.opcion_a || !body.opcion_b || !body.opcion_c || !body.opcion_d) {
    msgForm.textContent = 'Todos los campos son obligatorios.';
    msgForm.className   = 'err';
    return;
  }

  try {
    const url    = modoEdicion ? `/api/preguntas/${idEdicion}` : '/api/preguntas';
    const method = modoEdicion ? 'PUT' : 'POST';

    const res  = await fetch(url, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body:    JSON.stringify(body),
    });
    const data = await res.json();

    if (!res.ok) {
      msgForm.textContent = data.error || 'Error al guardar.';
      msgForm.className   = 'err';
      return;
    }

    msgForm.textContent = modoEdicion ? '✅ Pregunta actualizada.' : '✅ Pregunta registrada.';
    msgForm.className   = 'ok';
    await cargarPreguntas();

    setTimeout(cerrarModal, 1000);
  } catch (err) {
    msgForm.textContent = 'Error de conexión con el servidor.';
    msgForm.className   = 'err';
  }
});

// ── Eliminar pregunta ────────────────────────────────────────
async function eliminar(id) {
  const p = todasPreguntas.find(x => x.id === id);
  if (!confirm(`¿Eliminar la pregunta:\n"${p?.titulo}"?`)) return;

  try {
    const res = await fetch(`/api/preguntas/${id}`, { method: 'DELETE' });
    if (!res.ok) throw new Error();
    await cargarPreguntas();
  } catch {
    alert('Error al eliminar la pregunta.');
  }
}

// ── Cerrar sesión ────────────────────────────────────────────
document.querySelector('#btn-salir').addEventListener('click', () => {
  sessionStorage.removeItem('admin_ok');
  location.href = '/admin';
});

// ── Filtros en tiempo real ───────────────────────────────────
filtroCat.addEventListener('change', renderTabla);
filtroBuscar.addEventListener('input', renderTabla);

// ── Iniciar ──────────────────────────────────────────────────
cargarPreguntas();
