const express = require('express');
const router  = express.Router();
const pool    = require('../db/connection');

// POST /api/admin/login
router.post('/login', async (req, res) => {
  try {
    const { usuario, password } = req.body;
    if (!usuario || !password)
      return res.status(400).json({ error: 'Usuario y contraseña requeridos.' });

    const [rows] = await pool.execute(
      'SELECT id FROM admins WHERE usuario = ? AND password = ?',
      [usuario, password]
    );
    if (rows.length === 0)
      return res.status(401).json({ error: 'Credenciales incorrectas.' });

    res.json({ ok: true, adminId: rows[0].id });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Error del servidor.' });
  }
});

module.exports = router;
