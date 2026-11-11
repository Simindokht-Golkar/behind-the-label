
CREATE INDEX idx_reports_cas     ON reports (cas_number);
CREATE INDEX idx_eu_cas_cas      ON eu_cas (cas_single);
CREATE INDEX idx_chem_name       ON chemicals (chemical_name);
CREATE INDEX idx_reports_removed ON reports (is_removed);

DROP FUNCTION IF EXISTS eu_status_of;

CREATE FUNCTION eu_status_of(p_cas VARCHAR(20)) RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE best INT;
    -- smallest rank wins: 1 = Annex II, 2 = Annex III, 3 = Annex IV-VI
    SELECT MIN(CASE annex WHEN 'II' THEN 1 WHEN 'III' THEN 2 ELSE 3 END)
      INTO best FROM eu_cas WHERE cas_single = p_cas;
    RETURN CASE best WHEN 1 THEN 'banned'
                     WHEN 2 THEN 'restricted'
                     WHEN 3 THEN 'listed (IV-VI)'
                     ELSE 'not listed' END;
END
;
