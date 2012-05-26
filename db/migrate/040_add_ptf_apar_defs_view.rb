# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# This view essentially replicates the ptfapardef records.
class AddPtfAparDefsView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW ptfapardefs AS
SELECT
  abstract,
  apar,
  apar_id,
  defect,
  defect_id,
  family,
  family_id,
  fileset_id,
  lpp,
  lpp_id,
  lpp_base,
  lpp_base_id,
  ptf,
  ptf_id,
  service_pack,
  service_pack_id,
  release,
  release_id,
  version,
  version_id,
  vrmf
FROM
(
  (
    (
      (
        (
          (
            (
              (
                (
                  (
                    (
                      SELECT
                        adv.id AS adv_id,
                        a.name AS apar,
                        a.abstract AS abstract,
                        a.id AS apar_id,
                        d.name AS defect,
                        d.id AS defect_id,
                        v.name AS version,
                        v.id AS version_id
                      FROM
                        apar_defect_version_maps adv,
                        apars a,
                        defects d,
                        versions v
                      WHERE
                        adv.apar_id    = a.id AND
                        adv.defect_id  = d.id AND
                        adv.version_id = v.id
                    ) AS t1
                    LEFT OUTER JOIN
                    (
                      SELECT
                        apr.ptf_id,
                        apr.release_id,
                        apr.apar_defect_version_map_id AS adv_id
                      FROM
                        adv_ptf_release_maps apr
                    ) AS t2
                    USING ( adv_id )
                  ) AS t3
                  LEFT OUTER JOIN
                  (
                    SELECT
                      f2p.fileset_id,
                      f2p.ptf_id
                    FROM
                      fileset_ptf_maps f2p
                  ) AS t4
                  USING ( ptf_id )
                ) AS t5
                LEFT OUTER JOIN
                (
                  SELECT
                    ptfs.name AS ptf,
                    ptfs.id AS ptf_id
                  FROM
                    ptfs
                ) AS t6
                USING ( ptf_id )
              ) AS t7
              LEFT OUTER JOIN
              (
                SELECT
                  id AS fileset_id,
                  lpp_id,
                  vrmf
                FROM
                  filesets
              ) AS t8
              USING ( fileset_id )
            ) AS t9
            LEFT OUTER JOIN
            (
              SELECT
                name AS lpp,
                id AS lpp_id,
                lpp_base_id
              FROM
                lpps
            ) AS t10
            USING ( lpp_id )
          ) AS t11
          LEFT OUTER JOIN
          (
            SELECT
              id AS lpp_base_id,
              name AS lpp_base
            FROM
              lpp_bases
          ) AS t12
          USING ( lpp_base_id )
        ) AS t13
        LEFT OUTER JOIN
        (
          SELECT
            id AS release_id,
            name AS release,
            family_id
          FROM
            releases
        ) AS t14
        USING ( release_id )
      ) AS t15
      LEFT OUTER JOIN
      (
        SELECT
          id AS family_id,
          name as family
        FROM
          families
      ) AS t16
      USING ( family_id )
    ) AS t17
    LEFT OUTER JOIN
    (
      SELECT
        id AS version_id,
        name AS verion
      FROM
        versions
    ) AS t18
    USING ( version_id )
  ) AS t19
  LEFT OUTER JOIN
  (
    SELECT
      service_pack_id,
      fileset_id
    FROM
      service_pack_fileset_maps
  ) as t20
  USING ( fileset_id )
) as t21
LEFT OUTER JOIN
(
  SELECT
    id as service_pack_id,
    name as service_pack
  FROM
    service_packs
) as t22
USING ( service_pack_id )
;
"
  end

  def self.down
    execute "DROP VIEW ptfapardefs"
  end
end
