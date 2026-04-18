const express = require('express');
const router  = express.Router();
const pool    = require('../db/connection');

// GET /api/preguntas  – listar todas
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      'SELECT * FROM preguntas ORDER BY categoria, id'
    );
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener preguntas.' });
  }
});

// GET /api/preguntas/juego/:categoria/:cantidad
// categoria puede ser el nombre de categoría o "todas"
router.get('/juego/:categoria/:cantidad', async (req, res) => {
  try {
    const { categoria, cantidad } = req.params;
    // IMPORTANTE: mysql2 necesita número entero, no string, para LIMIT
    const limit = parseInt(cantidad, 10) || 10;

    let rows;
    if (categoria === 'todas') {
      [rows] = await pool.query(
        `SELECT * FROM preguntas ORDER BY RAND() LIMIT ${limit}`
      );
    } else {
      [rows] = await pool.query(
        `SELECT * FROM preguntas WHERE categoria = ? ORDER BY RAND() LIMIT ${limit}`,
        [categoria]
      );
    }
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al obtener preguntas.' });
  }
});

// POST /api/preguntas  – crear pregunta
router.post('/', async (req, res) => {
  try {
    const { categoria, titulo, opcion_a, opcion_b, opcion_c, opcion_d, correcta } = req.body;

    // Validar campos
    if (!categoria || !titulo || !opcion_a || !opcion_b || !opcion_c || !opcion_d || !correcta)
      return res.status(400).json({ error: 'Todos los campos son obligatorios.' });

    if (!['a','b','c','d'].includes(correcta.toLowerCase()))
      return res.status(400).json({ error: 'La respuesta correcta debe ser a, b, c o d.' });

    // Validar duplicados (mismo título)
    const [dup] = await pool.execute(
      'SELECT id FROM preguntas WHERE titulo = ?', [titulo.trim()]
    );
    if (dup.length > 0)
      return res.status(409).json({ error: 'Ya existe una pregunta con ese enunciado.' });

    const [result] = await pool.execute(
      'INSERT INTO preguntas (categoria, titulo, opcion_a, opcion_b, opcion_c, opcion_d, correcta) VALUES (?,?,?,?,?,?,?)',
      [categoria, titulo.trim(), opcion_a.trim(), opcion_b.trim(), opcion_c.trim(), opcion_d.trim(), correcta.toLowerCase()]
    );
    res.status(201).json({ id: result.insertId, mensaje: 'Pregunta registrada.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al registrar pregunta.' });
  }
});

// PUT /api/preguntas/:id  – modificar pregunta
router.put('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { categoria, titulo, opcion_a, opcion_b, opcion_c, opcion_d, correcta } = req.body;

    if (!categoria || !titulo || !opcion_a || !opcion_b || !opcion_c || !opcion_d || !correcta)
      return res.status(400).json({ error: 'Todos los campos son obligatorios.' });

    if (!['a','b','c','d'].includes(correcta.toLowerCase()))
      return res.status(400).json({ error: 'La respuesta correcta debe ser a, b, c o d.' });

    // Validar duplicados excluyendo la misma pregunta
    const [dup] = await pool.execute(
      'SELECT id FROM preguntas WHERE titulo = ? AND id != ?', [titulo.trim(), id]
    );
    if (dup.length > 0)
      return res.status(409).json({ error: 'Ya existe otra pregunta con ese enunciado.' });

    await pool.execute(
      'UPDATE preguntas SET categoria=?, titulo=?, opcion_a=?, opcion_b=?, opcion_c=?, opcion_d=?, correcta=? WHERE id=?',
      [categoria, titulo.trim(), opcion_a.trim(), opcion_b.trim(), opcion_c.trim(), opcion_d.trim(), correcta.toLowerCase(), id]
    );
    res.json({ mensaje: 'Pregunta actualizada.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al actualizar pregunta.' });
  }
});

// DELETE /api/preguntas/:id  – eliminar pregunta
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await pool.execute('DELETE FROM preguntas WHERE id = ?', [id]);
    res.json({ mensaje: 'Pregunta eliminada.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error al eliminar pregunta.' });
  }
});

module.exports = router;