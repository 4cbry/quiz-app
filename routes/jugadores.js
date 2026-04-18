const express = require('express');
const router  = express.Router();
const pool    = require('../db/connection');

// POST /api/jugadores  – guardar resultado de partida
router.post('/', async (req, res) => {
  try {
    const { nombre, puntaje, num_preguntas } = req.body;
    if (!nombre || puntaje === undefined || !num_preguntas)
      return res.status(400).json({ error: 'Nombre, puntaje y num_preguntas son requeridos.' });

    const [result] = await pool.execute(
      'INSERT INTO jugadores (nombre, puntaje, num_preguntas) VALUES (?, ?, ?)',
      [nombre.trim(), puntaje, num_preguntas]
    );

    // Verificar si es nuevo récord
    const [record] = await pool.execute(
      'SELECT MAX(puntaje) as maximo FROM jugadores WHERE id != ?',
      [result.insertId]
    );
    const maxAnterior = record[0].maximo || 0;
    const esRecord    = puntaje > maxAnterior;

    res.json({ id: result.insertId, esRecord, recordAnterior: maxAnterior });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al guardar jugador.' });
  }
});

// GET /api/jugadores  – histórico completo (top 10 para ranking)
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      'SELECT nombre, puntaje, num_preguntas, jugado_en FROM jugadores ORDER BY puntaje DESC LIMIT 10'
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener histórico.' });
  }
});

// GET /api/jugadores/record  – obtener el puntaje más alto registrado
router.get('/record', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      'SELECT nombre, puntaje FROM jugadores ORDER BY puntaje DESC LIMIT 1'
    );
    res.json(rows[0] || { nombre: null, puntaje: 0 });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener récord.' });
  }
});

module.exports = router;
