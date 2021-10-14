SELECT type, m.totamt AS mtot, v.totamt AS vtot FROM tm m LEFT JOIN tv v USING (type) ORDER BY type;
