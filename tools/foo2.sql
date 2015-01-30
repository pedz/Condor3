SELECT
  t2.*
FROM
  (
    SELECT
      defect, lpp, min(service_pack) as service_pack
    FROM
      "upd_apar_defs"
    WHERE
      "upd_apar_defs"."lpp" = 'devices.common.IBM.ethernet.rte'
    GROUP BY
      defect, lpp, substring(vrmf from 1 for 4)
  ) AS t1
LEFT OUTER JOIN
  (
    SELECT
      *
    FROM
      "upd_apar_defs"
  ) AS t2
USING ( defect, lpp, service_pack )
WHERE
  vrmf IS NOT NULL
ORDER BY
  service_pack,
  defect
;
