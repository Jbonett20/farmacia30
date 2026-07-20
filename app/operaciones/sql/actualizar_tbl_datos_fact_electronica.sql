-- =====================================================
-- Ajuste de estructura para facturación electrónica (Factin/DIAN)
-- Tabla: tbl_datos_fact_electronica
-- =====================================================

-- 1) Agregar columnas necesarias (si tu MySQL soporta IF NOT EXISTS)
ALTER TABLE tbl_datos_fact_electronica
    ADD COLUMN IF NOT EXISTS nit VARCHAR(30) NULL,
    ADD COLUMN IF NOT EXISTS software_id VARCHAR(120) NULL,
    ADD COLUMN IF NOT EXISTS clave_certificado VARCHAR(120) NULL,
    ADD COLUMN IF NOT EXISTS llave_envio TEXT NULL;

-- 2) Cargar datos de configuración
--    Ajusta el WHERE según tu tabla si manejas múltiples registros.
UPDATE tbl_datos_fact_electronica
SET
    nit = '1193242195',
    software_id = 'b3f92402-01c6-4a9c-9c1b-7327e1fb7238',
    clave_certificado = 'BETSYGOMEZ2026',
    llave_envio = 'VQGEEELXBCTILSBIKMGEBYAD1193242195VOGGRFKWDXBOOVUOMIWOLVQAATLHTTPPJW'
WHERE id = (SELECT id_tmp FROM (SELECT id AS id_tmp FROM tbl_datos_fact_electronica ORDER BY id DESC LIMIT 1) t);

-- 3) Verificar resultado
SELECT id, prefijo, usuario, llaveusuario, nit, software_id, clave_certificado,
       CASE WHEN llave_envio IS NULL OR TRIM(llave_envio) = '' THEN 'FALTA' ELSE 'OK' END AS llave_envio_estado
FROM tbl_datos_fact_electronica
ORDER BY id DESC
LIMIT 1;


-- =====================================================
-- Si tu MySQL NO soporta "ADD COLUMN IF NOT EXISTS", usa este bloque alterno:
-- (Ejecuta línea por línea solo si falla el ALTER de arriba)
--
-- ALTER TABLE tbl_datos_fact_electronica ADD COLUMN nit VARCHAR(30) NULL;
-- ALTER TABLE tbl_datos_fact_electronica ADD COLUMN software_id VARCHAR(120) NULL;
-- ALTER TABLE tbl_datos_fact_electronica ADD COLUMN clave_certificado VARCHAR(120) NULL;
-- ALTER TABLE tbl_datos_fact_electronica ADD COLUMN llave_envio TEXT NULL;
-- =====================================================