--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: basename(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION basename(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
    SELECT regexp_replace($1, E'^(.*/)?([^/.]*)(\\..*)?$', E'\\2')
$_$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adv_ptf_release_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE adv_ptf_release_maps (
    id integer NOT NULL,
    apar_defect_version_map_id integer NOT NULL,
    ptf_id integer NOT NULL,
    release_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: adv_ptf_release_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE adv_ptf_release_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adv_ptf_release_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE adv_ptf_release_maps_id_seq OWNED BY adv_ptf_release_maps.id;


--
-- Name: aix_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE aix_files (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    sha1 character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: aix_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aix_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aix_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aix_files_id_seq OWNED BY aix_files.id;


--
-- Name: apar_defect_version_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE apar_defect_version_maps (
    id integer NOT NULL,
    apar_id integer NOT NULL,
    defect_id integer NOT NULL,
    version_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pc_id integer DEFAULT '-1'::integer NOT NULL
);


--
-- Name: apar_defect_version_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apar_defect_version_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: apar_defect_version_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apar_defect_version_maps_id_seq OWNED BY apar_defect_version_maps.id;


--
-- Name: apars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE apars (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    abstract character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: apars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: apars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apars_id_seq OWNED BY apars.id;


--
-- Name: cmvcs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cmvcs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    login character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cmvcs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cmvcs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cmvcs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cmvcs_id_seq OWNED BY cmvcs.id;


--
-- Name: defects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE defects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cq_defect character varying(255) DEFAULT 'NONE'::character varying NOT NULL,
    abstract character varying(255)
);


--
-- Name: defects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE defects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE defects_id_seq OWNED BY defects.id;


--
-- Name: families; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE families (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: families_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE families_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: families_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE families_id_seq OWNED BY families.id;


--
-- Name: fileset_aix_file_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fileset_aix_file_maps (
    id integer NOT NULL,
    fileset_id integer NOT NULL,
    aix_file_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fileset_aix_file_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fileset_aix_file_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fileset_aix_file_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fileset_aix_file_maps_id_seq OWNED BY fileset_aix_file_maps.id;


--
-- Name: fileset_ptf_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fileset_ptf_maps (
    id integer NOT NULL,
    fileset_id integer NOT NULL,
    ptf_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fileset_ptf_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fileset_ptf_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fileset_ptf_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fileset_ptf_maps_id_seq OWNED BY fileset_ptf_maps.id;


--
-- Name: filesets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE filesets (
    id integer NOT NULL,
    lpp_id integer NOT NULL,
    vrmf character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: filesets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filesets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: filesets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filesets_id_seq OWNED BY filesets.id;


--
-- Name: image_paths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE image_paths (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    package_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: image_paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: image_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE image_paths_id_seq OWNED BY image_paths.id;


--
-- Name: lpp_bases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lpp_bases (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: lpp_bases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lpp_bases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lpp_bases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lpp_bases_id_seq OWNED BY lpp_bases.id;


--
-- Name: lpps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE lpps (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    lpp_base_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: lpps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lpps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lpps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lpps_id_seq OWNED BY lpps.id;


--
-- Name: package_fileset_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE package_fileset_maps (
    id integer NOT NULL,
    package_id integer NOT NULL,
    fileset_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: package_fileset_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE package_fileset_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: package_fileset_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE package_fileset_maps_id_seq OWNED BY package_fileset_maps.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE packages (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    sha1 character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE packages_id_seq OWNED BY packages.id;


--
-- Name: ptfs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ptfs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: releases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE releases (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    family_id integer NOT NULL,
    version_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: service_pack_fileset_maps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE service_pack_fileset_maps (
    id integer NOT NULL,
    service_pack_id integer NOT NULL,
    fileset_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: service_packs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE service_packs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE versions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ptfapardefs; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ptfapardefs AS
 SELECT t21.abstract,
    t21.apar,
    t21.apar_id,
    t21.defect,
    t21.defect_id,
    t21.family,
    t21.family_id,
    t21.fileset_id,
    t21.lpp,
    t21.lpp_id,
    t21.lpp_base,
    t21.lpp_base_id,
    t21.ptf,
    t21.ptf_id,
    t22.service_pack,
    t21.service_pack_id,
    t21.release,
    t21.release_id,
    t21.version,
    t21.version_id,
    t21.vrmf
   FROM (((((((((((( SELECT adv.id AS adv_id,
            a.name AS apar,
            a.abstract,
            a.id AS apar_id,
            d.name AS defect,
            d.id AS defect_id,
            v.name AS version,
            v.id AS version_id
           FROM apar_defect_version_maps adv,
            apars a,
            defects d,
            versions v
          WHERE ((adv.apar_id = a.id) AND (adv.defect_id = d.id) AND (adv.version_id = v.id))) t1(adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1)
     LEFT JOIN ( SELECT apr.ptf_id,
            apr.release_id,
            apr.apar_defect_version_map_id AS adv_id
           FROM adv_ptf_release_maps apr) t2(ptf_id_1, release_id_1, adv_id) USING (adv_id)) t3(adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, ptf_id, release_id_1)
     LEFT JOIN ( SELECT f2p.fileset_id,
            f2p.ptf_id
           FROM fileset_ptf_maps f2p) t4(fileset_id_2, ptf_id) USING (ptf_id)) t5
     LEFT JOIN ( SELECT ptfs.name AS ptf,
            ptfs.id AS ptf_id
           FROM ptfs) t6 USING (ptf_id)) t7(ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, release_id_1, fileset_id_1, ptf)
     LEFT JOIN ( SELECT filesets.id AS fileset_id,
            filesets.lpp_id,
            filesets.vrmf
           FROM filesets) t8(fileset_id_1, lpp_id_1, vrmf) USING (fileset_id_1)) t9(fileset_id_1, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, release_id_1, ptf, lpp_id, vrmf)
     LEFT JOIN ( SELECT lpps.name AS lpp,
            lpps.id AS lpp_id,
            lpps.lpp_base_id
           FROM lpps) t10(lpp, lpp_id, lpp_base_id_1) USING (lpp_id)) t11(lpp_id, fileset_id_1, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, release_id_1, ptf, vrmf, lpp, lpp_base_id)
     LEFT JOIN ( SELECT lpp_bases.id AS lpp_base_id,
            lpp_bases.name AS lpp_base
           FROM lpp_bases) t12 USING (lpp_base_id)) t13(lpp_base_id, lpp_id, fileset_id_1, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, release_id, ptf, vrmf, lpp, lpp_base)
     LEFT JOIN ( SELECT releases.id AS release_id,
            releases.name AS release,
            releases.family_id
           FROM releases) t14(release_id, release, family_id_1) USING (release_id)) t15(release_id, lpp_base_id, lpp_id, fileset_id_1, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id_1, ptf, vrmf, lpp, lpp_base, release, family_id)
     LEFT JOIN ( SELECT families.id AS family_id,
            families.name AS family
           FROM families) t16 USING (family_id)) t17(family_id, release_id, lpp_base_id, lpp_id, fileset_id_1, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, version_id, ptf, vrmf, lpp, lpp_base, release, family)
     LEFT JOIN ( SELECT versions.id AS version_id,
            versions.name AS verion
           FROM versions) t18 USING (version_id)) t19(version_id, family_id, release_id, lpp_base_id, lpp_id, fileset_id, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, ptf, vrmf, lpp, lpp_base, release, family, verion)
     LEFT JOIN ( SELECT service_pack_fileset_maps.service_pack_id,
            service_pack_fileset_maps.fileset_id
           FROM service_pack_fileset_maps) t20(service_pack_id_1, fileset_id) USING (fileset_id)) t21(fileset_id, version_id, family_id, release_id, lpp_base_id, lpp_id, ptf_id, adv_id, apar, abstract, apar_id, defect, defect_id, version, ptf, vrmf, lpp, lpp_base, release, family, verion, service_pack_id)
     LEFT JOIN ( SELECT service_packs.id AS service_pack_id,
            service_packs.name AS service_pack
           FROM service_packs) t22 USING (service_pack_id));


--
-- Name: ptfs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ptfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ptfs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ptfs_id_seq OWNED BY ptfs.id;


--
-- Name: releases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE releases_id_seq OWNED BY releases.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: service_pack_fileset_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_pack_fileset_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_pack_fileset_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_pack_fileset_maps_id_seq OWNED BY service_pack_fileset_maps.id;


--
-- Name: service_packs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_packs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_packs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_packs_id_seq OWNED BY service_packs.id;


--
-- Name: shipped_files; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW shipped_files AS
 SELECT t3.aix_file,
    t3.aix_file_id,
    t3.fileset_id,
    t3.image_path,
    t3.image_path_id,
    t3.lpp,
    t3.lpp_id,
    t3.package,
    t3.package_id,
    t3.package_sha1,
    t4.service_pack,
    t3.service_pack_id,
    t3.aix_file_sha1,
    t3.vrmf
   FROM ((( SELECT af.path AS aix_file,
            af.id AS aix_file_id,
            fs.id AS fileset_id,
            ip.path AS image_path,
            ip.id AS image_path_id,
            lpp.name AS lpp,
            lpp.id AS lpp_id,
            p.name AS package,
            p.id AS package_id,
            p.sha1 AS package_sha1,
            af.sha1 AS aix_file_sha1,
            fs.vrmf
           FROM aix_files af,
            fileset_aix_file_maps fafm,
            filesets fs,
            image_paths ip,
            lpps lpp,
            package_fileset_maps pfm,
            packages p
          WHERE ((ip.package_id = p.id) AND (fs.lpp_id = lpp.id) AND (pfm.package_id = p.id) AND (pfm.fileset_id = fs.id) AND (fafm.fileset_id = fs.id) AND (fafm.aix_file_id = af.id))) t1
     LEFT JOIN ( SELECT service_pack_fileset_maps.service_pack_id,
            service_pack_fileset_maps.fileset_id
           FROM service_pack_fileset_maps) t2(service_pack_id_1, fileset_id) USING (fileset_id)) t3(fileset_id, aix_file, aix_file_id, image_path, image_path_id, lpp, lpp_id, package, package_id, package_sha1, aix_file_sha1, vrmf, service_pack_id)
     LEFT JOIN ( SELECT service_packs.id AS service_pack_id,
            service_packs.name AS service_pack
           FROM service_packs) t4 USING (service_pack_id));


--
-- Name: upd_pc_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE upd_pc_views (
    id integer NOT NULL,
    update_id integer,
    pc_id integer,
    bc_name character varying(255),
    ptf_id integer NOT NULL,
    fileset_id integer NOT NULL,
    defect_id integer NOT NULL,
    version_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: upd_apar_defs; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW upd_apar_defs AS
 SELECT t21.abstract,
    t21.apar,
    t21.apar_id,
    t21.build_name,
    t21.cq_defect,
    t21.defect,
    t21.defect_id,
    t21.fileset_id,
    t21.lpp,
    t21.lpp_id,
    t21.lpp_base,
    t21.lpp_base_id,
    t21.ptf,
    t21.ptf_id,
    t22.service_pack,
    t21.service_pack_id,
    t21.version,
    t21.version_id,
    t21.vrmf
   FROM ((((((((( SELECT adv.id AS adv_id,
            a.name AS apar,
            COALESCE(NULLIF((a.abstract)::text, 'REPLACED'::text), (d.abstract)::text, '(none)'::text) AS abstract,
            a.id AS apar_id,
            d.name AS defect,
            d.cq_defect,
            d.id AS defect_id,
            v.name AS version,
            v.id AS version_id
           FROM apar_defect_version_maps adv,
            apars a,
            defects d,
            versions v
          WHERE ((adv.apar_id = a.id) AND (adv.defect_id = d.id) AND (adv.version_id = v.id))) t1(adv_id, apar, abstract, apar_id, defect, cq_defect, defect_id, version, version_id_1)
     LEFT JOIN ( SELECT upd.bc_name AS build_name,
            upd.ptf_id,
            upd.fileset_id,
            upd.defect_id,
            upd.version_id
           FROM upd_pc_views upd) t2(build_name, ptf_id_1, fileset_id_2, defect_id, version_id_1) USING (defect_id, version_id_1)) t3(defect_id, version_id_1, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf_id, fileset_id_2)
     LEFT JOIN ( SELECT ptfs.name AS ptf,
            ptfs.id AS ptf_id
           FROM ptfs) t6 USING (ptf_id)) t7(ptf_id, defect_id, version_id_1, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, fileset_id_1, ptf)
     LEFT JOIN ( SELECT filesets.id AS fileset_id,
            filesets.lpp_id,
            filesets.vrmf
           FROM filesets) t8(fileset_id_1, lpp_id_1, vrmf) USING (fileset_id_1)) t9(fileset_id_1, ptf_id, defect_id, version_id_1, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf, lpp_id, vrmf)
     LEFT JOIN ( SELECT lpps.name AS lpp,
            lpps.id AS lpp_id,
            lpps.lpp_base_id
           FROM lpps) t10(lpp, lpp_id, lpp_base_id_1) USING (lpp_id)) t11(lpp_id, fileset_id_1, ptf_id, defect_id, version_id_1, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf, vrmf, lpp, lpp_base_id)
     LEFT JOIN ( SELECT lpp_bases.id AS lpp_base_id,
            lpp_bases.name AS lpp_base
           FROM lpp_bases) t12 USING (lpp_base_id)) t17(lpp_base_id, lpp_id, fileset_id_1, ptf_id, defect_id, version_id, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf, vrmf, lpp, lpp_base)
     LEFT JOIN ( SELECT versions.id AS version_id,
            versions.name AS verion
           FROM versions) t18 USING (version_id)) t19(version_id, lpp_base_id, lpp_id, fileset_id, ptf_id, defect_id, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf, vrmf, lpp, lpp_base, verion)
     LEFT JOIN ( SELECT service_pack_fileset_maps.service_pack_id,
            service_pack_fileset_maps.fileset_id
           FROM service_pack_fileset_maps) t20(service_pack_id_1, fileset_id) USING (fileset_id)) t21(fileset_id, version_id, lpp_base_id, lpp_id, ptf_id, defect_id, adv_id, apar, abstract, apar_id, defect, cq_defect, version, build_name, ptf, vrmf, lpp, lpp_base, verion, service_pack_id)
     LEFT JOIN ( SELECT service_packs.id AS service_pack_id,
            service_packs.name AS service_pack
           FROM service_packs) t22 USING (service_pack_id));


--
-- Name: upd_pc_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE upd_pc_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upd_pc_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE upd_pc_views_id_seq OWNED BY upd_pc_views.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    ldap_id character varying(255) NOT NULL,
    admin boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: adv_ptf_release_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps ALTER COLUMN id SET DEFAULT nextval('adv_ptf_release_maps_id_seq'::regclass);


--
-- Name: aix_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_files ALTER COLUMN id SET DEFAULT nextval('aix_files_id_seq'::regclass);


--
-- Name: apar_defect_version_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps ALTER COLUMN id SET DEFAULT nextval('apar_defect_version_maps_id_seq'::regclass);


--
-- Name: apars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY apars ALTER COLUMN id SET DEFAULT nextval('apars_id_seq'::regclass);


--
-- Name: cmvcs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmvcs ALTER COLUMN id SET DEFAULT nextval('cmvcs_id_seq'::regclass);


--
-- Name: defects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY defects ALTER COLUMN id SET DEFAULT nextval('defects_id_seq'::regclass);


--
-- Name: families id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY families ALTER COLUMN id SET DEFAULT nextval('families_id_seq'::regclass);


--
-- Name: fileset_aix_file_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps ALTER COLUMN id SET DEFAULT nextval('fileset_aix_file_maps_id_seq'::regclass);


--
-- Name: fileset_ptf_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps ALTER COLUMN id SET DEFAULT nextval('fileset_ptf_maps_id_seq'::regclass);


--
-- Name: filesets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY filesets ALTER COLUMN id SET DEFAULT nextval('filesets_id_seq'::regclass);


--
-- Name: image_paths id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_paths ALTER COLUMN id SET DEFAULT nextval('image_paths_id_seq'::regclass);


--
-- Name: lpp_bases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpp_bases ALTER COLUMN id SET DEFAULT nextval('lpp_bases_id_seq'::regclass);


--
-- Name: lpps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpps ALTER COLUMN id SET DEFAULT nextval('lpps_id_seq'::regclass);


--
-- Name: package_fileset_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps ALTER COLUMN id SET DEFAULT nextval('package_fileset_maps_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY packages ALTER COLUMN id SET DEFAULT nextval('packages_id_seq'::regclass);


--
-- Name: ptfs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ptfs ALTER COLUMN id SET DEFAULT nextval('ptfs_id_seq'::regclass);


--
-- Name: releases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases ALTER COLUMN id SET DEFAULT nextval('releases_id_seq'::regclass);


--
-- Name: service_pack_fileset_maps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps ALTER COLUMN id SET DEFAULT nextval('service_pack_fileset_maps_id_seq'::regclass);


--
-- Name: service_packs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_packs ALTER COLUMN id SET DEFAULT nextval('service_packs_id_seq'::regclass);


--
-- Name: upd_pc_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views ALTER COLUMN id SET DEFAULT nextval('upd_pc_views_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: adv_ptf_release_maps adv_ptf_release_maps_apar_defect_version_map_id_ptf_id_rele_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_apar_defect_version_map_id_ptf_id_rele_key UNIQUE (apar_defect_version_map_id, ptf_id, release_id);


--
-- Name: adv_ptf_release_maps adv_ptf_release_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_pkey PRIMARY KEY (id);


--
-- Name: aix_files aix_files_path_sha1_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_files
    ADD CONSTRAINT aix_files_path_sha1_key UNIQUE (path, sha1);


--
-- Name: aix_files aix_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_files
    ADD CONSTRAINT aix_files_pkey PRIMARY KEY (id);


--
-- Name: apar_defect_version_maps apar_defect_version_maps_apar_id_defect_id_version_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_apar_id_defect_id_version_id_key UNIQUE (apar_id, defect_id, version_id);


--
-- Name: apar_defect_version_maps apar_defect_version_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_pkey PRIMARY KEY (id);


--
-- Name: apars apars_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apars
    ADD CONSTRAINT apars_name_key UNIQUE (name);


--
-- Name: apars apars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apars
    ADD CONSTRAINT apars_pkey PRIMARY KEY (id);


--
-- Name: cmvcs cmvcs_login_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmvcs
    ADD CONSTRAINT cmvcs_login_key UNIQUE (login);


--
-- Name: cmvcs cmvcs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmvcs
    ADD CONSTRAINT cmvcs_pkey PRIMARY KEY (id);


--
-- Name: cmvcs cmvcs_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmvcs
    ADD CONSTRAINT cmvcs_user_id_key UNIQUE (user_id);


--
-- Name: defects defects_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY defects
    ADD CONSTRAINT defects_name_key UNIQUE (name);


--
-- Name: defects defects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY defects
    ADD CONSTRAINT defects_pkey PRIMARY KEY (id);


--
-- Name: families families_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY families
    ADD CONSTRAINT families_name_key UNIQUE (name);


--
-- Name: families families_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY families
    ADD CONSTRAINT families_pkey PRIMARY KEY (id);


--
-- Name: fileset_aix_file_maps fileset_aix_file_maps_fileset_id_aix_file_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_fileset_id_aix_file_id_key UNIQUE (fileset_id, aix_file_id);


--
-- Name: fileset_aix_file_maps fileset_aix_file_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_pkey PRIMARY KEY (id);


--
-- Name: fileset_ptf_maps fileset_ptf_maps_fileset_id_ptf_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_fileset_id_ptf_id_key UNIQUE (fileset_id, ptf_id);


--
-- Name: fileset_ptf_maps fileset_ptf_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_pkey PRIMARY KEY (id);


--
-- Name: filesets filesets_lpp_id_vrmf_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_lpp_id_vrmf_key UNIQUE (lpp_id, vrmf);


--
-- Name: filesets filesets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_pkey PRIMARY KEY (id);


--
-- Name: image_paths image_paths_path_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_path_key UNIQUE (path);


--
-- Name: image_paths image_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_pkey PRIMARY KEY (id);


--
-- Name: lpp_bases lpp_bases_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpp_bases
    ADD CONSTRAINT lpp_bases_name_key UNIQUE (name);


--
-- Name: lpp_bases lpp_bases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpp_bases
    ADD CONSTRAINT lpp_bases_pkey PRIMARY KEY (id);


--
-- Name: lpps lpps_name_lpp_base_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_name_lpp_base_id_key UNIQUE (name, lpp_base_id);


--
-- Name: lpps lpps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_pkey PRIMARY KEY (id);


--
-- Name: package_fileset_maps package_fileset_maps_package_id_fileset_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_package_id_fileset_id_key UNIQUE (package_id, fileset_id);


--
-- Name: package_fileset_maps package_fileset_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_pkey PRIMARY KEY (id);


--
-- Name: packages packages_name_sha1_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_name_sha1_key UNIQUE (name, sha1);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: ptfs ptfs_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ptfs
    ADD CONSTRAINT ptfs_name_key UNIQUE (name);


--
-- Name: ptfs ptfs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ptfs
    ADD CONSTRAINT ptfs_pkey PRIMARY KEY (id);


--
-- Name: releases releases_name_family_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_name_family_id_key UNIQUE (name, family_id);


--
-- Name: releases releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (id);


--
-- Name: service_pack_fileset_maps service_pack_fileset_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_pkey PRIMARY KEY (id);


--
-- Name: service_pack_fileset_maps service_pack_fileset_maps_service_pack_id_fileset_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_service_pack_id_fileset_id_key UNIQUE (service_pack_id, fileset_id);


--
-- Name: service_packs service_packs_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_packs
    ADD CONSTRAINT service_packs_name_key UNIQUE (name);


--
-- Name: service_packs service_packs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_packs
    ADD CONSTRAINT service_packs_pkey PRIMARY KEY (id);


--
-- Name: upd_pc_views upd_pc_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_pkey PRIMARY KEY (id);


--
-- Name: upd_pc_views upd_pc_views_update_id_pc_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_update_id_pc_id_key UNIQUE (update_id, pc_id);


--
-- Name: users users_ldap_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_ldap_id_key UNIQUE (ldap_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_name_key UNIQUE (name);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: base_file_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX base_file_name_idx ON aix_files USING btree (basename((path)::text));


--
-- Name: index_adv_ptf_release_maps_on_apar_defect_version_map_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adv_ptf_release_maps_on_apar_defect_version_map_id ON adv_ptf_release_maps USING btree (apar_defect_version_map_id);


--
-- Name: index_adv_ptf_release_maps_on_ptf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adv_ptf_release_maps_on_ptf_id ON adv_ptf_release_maps USING btree (ptf_id);


--
-- Name: index_adv_ptf_release_maps_on_release_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_adv_ptf_release_maps_on_release_id ON adv_ptf_release_maps USING btree (release_id);


--
-- Name: index_apar_defect_version_maps_on_defect_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_apar_defect_version_maps_on_defect_id ON apar_defect_version_maps USING btree (defect_id);


--
-- Name: index_apar_defect_version_maps_on_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_apar_defect_version_maps_on_version_id ON apar_defect_version_maps USING btree (version_id);


--
-- Name: index_fileset_ptf_maps_on_ptf_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_fileset_ptf_maps_on_ptf_id ON fileset_ptf_maps USING btree (ptf_id);


--
-- Name: index_service_pack_fileset_maps_on_fileset_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_service_pack_fileset_maps_on_fileset_id ON service_pack_fileset_maps USING btree (fileset_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: adv_ptf_release_maps adv_ptf_release_maps_apar_defect_version_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_apar_defect_version_map_id_fkey FOREIGN KEY (apar_defect_version_map_id) REFERENCES apar_defect_version_maps(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: adv_ptf_release_maps adv_ptf_release_maps_ptf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_ptf_id_fkey FOREIGN KEY (ptf_id) REFERENCES ptfs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: adv_ptf_release_maps adv_ptf_release_maps_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_release_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps apar_defect_version_maps_apar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_apar_id_fkey FOREIGN KEY (apar_id) REFERENCES apars(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps apar_defect_version_maps_defect_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_defect_id_fkey FOREIGN KEY (defect_id) REFERENCES defects(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps apar_defect_version_maps_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_version_id_fkey FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: cmvcs cmvcs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cmvcs
    ADD CONSTRAINT cmvcs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_aix_file_maps fileset_aix_file_maps_aix_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_aix_file_id_fkey FOREIGN KEY (aix_file_id) REFERENCES aix_files(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_aix_file_maps fileset_aix_file_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_ptf_maps fileset_ptf_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_ptf_maps fileset_ptf_maps_ptf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_ptf_id_fkey FOREIGN KEY (ptf_id) REFERENCES ptfs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: filesets filesets_lpp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_lpp_id_fkey FOREIGN KEY (lpp_id) REFERENCES lpps(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: image_paths image_paths_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_package_id_fkey FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: lpps lpps_lpp_base_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_lpp_base_id_fkey FOREIGN KEY (lpp_base_id) REFERENCES lpp_bases(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: package_fileset_maps package_fileset_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: package_fileset_maps package_fileset_maps_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_package_id_fkey FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: releases releases_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_family_id_fkey FOREIGN KEY (family_id) REFERENCES families(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: releases releases_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_version_id_fkey FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: service_pack_fileset_maps service_pack_fileset_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: service_pack_fileset_maps service_pack_fileset_maps_service_pack_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_service_pack_id_fkey FOREIGN KEY (service_pack_id) REFERENCES service_packs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: upd_pc_views upd_pc_views_defect_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_defect_id_fkey FOREIGN KEY (defect_id) REFERENCES defects(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: upd_pc_views upd_pc_views_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: upd_pc_views upd_pc_views_ptf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_ptf_id_fkey FOREIGN KEY (ptf_id) REFERENCES ptfs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: upd_pc_views upd_pc_views_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upd_pc_views
    ADD CONSTRAINT upd_pc_views_version_id_fkey FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE DEFERRABLE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('10');

INSERT INTO schema_migrations (version) VALUES ('13');

INSERT INTO schema_migrations (version) VALUES ('14');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('22');

INSERT INTO schema_migrations (version) VALUES ('23');

INSERT INTO schema_migrations (version) VALUES ('24');

INSERT INTO schema_migrations (version) VALUES ('26');

INSERT INTO schema_migrations (version) VALUES ('27');

INSERT INTO schema_migrations (version) VALUES ('28');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('34');

INSERT INTO schema_migrations (version) VALUES ('35');

INSERT INTO schema_migrations (version) VALUES ('4');

INSERT INTO schema_migrations (version) VALUES ('40');

INSERT INTO schema_migrations (version) VALUES ('41');

INSERT INTO schema_migrations (version) VALUES ('42');

INSERT INTO schema_migrations (version) VALUES ('43');

INSERT INTO schema_migrations (version) VALUES ('44');

INSERT INTO schema_migrations (version) VALUES ('45');

INSERT INTO schema_migrations (version) VALUES ('46');

INSERT INTO schema_migrations (version) VALUES ('47');

INSERT INTO schema_migrations (version) VALUES ('48');

INSERT INTO schema_migrations (version) VALUES ('49');

INSERT INTO schema_migrations (version) VALUES ('5');

INSERT INTO schema_migrations (version) VALUES ('6');

INSERT INTO schema_migrations (version) VALUES ('7');

INSERT INTO schema_migrations (version) VALUES ('8');

INSERT INTO schema_migrations (version) VALUES ('9');