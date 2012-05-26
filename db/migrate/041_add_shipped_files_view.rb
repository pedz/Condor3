# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Tentative view for exploring shipped files.
class AddShippedFilesView < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW shipped_files AS
SELECT
  aix_file,
  aix_file_id,
  fileset_id,
  image_path,
  image_path_id,
  lpp,
  lpp_id,
  package,
  package_id,
  service_pack,
  service_pack_id,
  aix_file_sha1,
  vrmf
FROM
(
  (
    SELECT
      af.path as aix_file,
      af.id as aix_file_id,
      fs.id as fileset_id,
      ip.path as image_path,
      ip.id as image_path_id,
      lpp.name as lpp,
      lpp.id as lpp_id,
      p.name as package,
      p.id as package_id,
      af.sha1 as aix_file_sha1,
      fs.vrmf as vrmf
    FROM
      aix_files af,
      fileset_aix_file_maps fafm,
      filesets fs,
      image_paths ip,
      lpps lpp,
      package_fileset_maps pfm,
      packages p
    WHERE
      ip.package_id = p.id AND
      fs.lpp_id = lpp.id AND
      pfm.package_id = p.id AND
      pfm.fileset_id = fs.id AND
      fafm.fileset_id = fs.id AND
      fafm.aix_file_id = af.id
  ) AS t1
  LEFT OUTER JOIN
  (
    SELECT
      service_pack_id,
      fileset_id
    FROM
      service_pack_fileset_maps
  ) AS t2
  USING ( fileset_id )
) AS t3
LEFT OUTER JOIN
(
  SELECT
    id as service_pack_id,
    name as service_pack
  FROM
    service_packs
) as t4
USING ( service_pack_id )
;"
  end

  def self.down
    execute "DROP VIEW shipped_files"
  end
end
