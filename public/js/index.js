const nombreInput = document.querySelector('#nombre');
const btnComenzar = document.querySelector('#comenzar');
const errorMsg    = document.querySelector('#error-msg');

btnComenzar.addEventListener('click', iniciar);
nombreInput.addEventListener('keydown', (e) => { if (e.key === 'Enter') iniciar(); });

async function iniciar() {
  const nombre = nombreInput.value.trim();
  if (!nombre) {
    errorMsg.textContent = 'Por favor ingresa tu nombre.';
    errorMsg.style.display = 'block';
    return;
  }
  errorMsg.style.display = 'none';
  btnComenzar.disabled = true;
  btnComenzar.textContent = 'Cargando...';

  // Guardar nombre en sessionStorage y redirigir al menú
  sessionStorage.setItem('jugador_nombre', nombre);
  sessionStorage.setItem('puntaje_total',  0);
  sessionStorage.setItem('acertadas',      0);
  sessionStorage.setItem('incorrectas',    0);

  location.href = 'menu.html';
}
