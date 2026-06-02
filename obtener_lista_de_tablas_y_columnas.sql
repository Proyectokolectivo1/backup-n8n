-- =====================================================
-- Vista: obtener_lista_de_tablas_y_columnas
-- =====================================================
-- Propósito: Resumir TODAS las tablas, columnas, tipos
-- de datos y claves foráneas de la base de datos en una
-- sola vista. Diseñada para ser usada como contexto
-- por el agente de IA.
--
-- Formato de salida por fila:
--   table_name  |  columns_with_types_and_fks
--   Prestamo    |  id (bigint), id_cliente (bigint FOREIGN KEY REFERENCES Clientes.id), ...
--
-- Proyecto Supabase: ipirourlmxfjxupxejgn
-- =====================================================

CREATE OR REPLACE VIEW obtener_lista_de_tablas_y_columnas AS
SELECT
    c.table_name,
    STRING_AGG(
        c.column_name
        || ' ('
        || c.data_type
        || COALESCE(
            ' FOREIGN KEY REFERENCES '
            || fk.foreign_table_name || '.' || fk.foreign_column_name,
            ''
           )
        || ')',
        ', '
        ORDER BY c.ordinal_position
    ) AS columns_with_types_and_fks
FROM
    information_schema.columns c
    LEFT JOIN (
        SELECT
            kcu.table_name,
            kcu.column_name,
            ccu.table_name  AS foreign_table_name,
            ccu.column_name AS foreign_column_name
        FROM
            information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema  = kcu.table_schema
            JOIN information_schema.constraint_column_usage ccu
                ON ccu.constraint_name = tc.constraint_name
                AND ccu.table_schema   = tc.table_schema
        WHERE
            tc.constraint_type = 'FOREIGN KEY'
            AND tc.table_schema = 'public'
    ) fk
    ON c.table_name  = fk.table_name
    AND c.column_name = fk.column_name
WHERE
    c.table_schema = 'public'
    AND c.table_name != 'obtener_lista_de_tablas_y_columnas'
GROUP BY
    c.table_name
ORDER BY
    c.table_name;
