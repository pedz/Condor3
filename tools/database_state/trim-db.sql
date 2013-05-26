
DELETE FROM lpps WHERE name NOT IN (
    'IPP',
    'bos.mp',
    'bos.mp64',
    'bos.net.nfs.client',
    'bos.net.nfs.server',
    'bos.net.tcp.client',
    'bos.net.tcp.server',
    'bos.rte.tty',
    'bos.up',
    'devices.pci.14106902.rte'
);

DELETE FROM defects WHERE id NOT IN (
    SELECT defect_id FROM upd_pc_views
);

DELETE FROM apars WHERE id NOT IN (
       SELECT apar_id FROM apar_defect_version_maps
);

DELETE FROM versions WHERE id NOT IN (
       SELECT version_id FROM apar_defect_version_maps
);

DELETE FROM ptfs WHERE id NOT IN (
       SELECT ptf_id FROM upd_pc_views
);

DELETE FROM aix_files WHERE id NOT IN (
       SELECT aix_file_id FROM fileset_aix_file_maps
);

DELETE FROM packages WHERE id NOT IN (
       SELECT package_id FROM package_fileset_maps
);

DELETE FROM families WHERE id NOT IN (
       SELECT family_id FROM releases
);

DELETE FROM lpp_bases WHERE id NOT IN (
       SELECT lpp_base_id FROM lpps
);

DELETE FROM service_packs WHERE id NOT IN (
       SELECT service_pack_id FROM service_pack_fileset_maps
);
