--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

--
-- Name: basename(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION basename(text) RETURNS text
    AS $_$
    SELECT regexp_replace($1, E'^(.*/)?([^/.]*)(\\..*)?$', E'\\2')
$_$
    LANGUAGE sql IMMUTABLE STRICT;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: adv_ptf_release_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adv_ptf_release_maps (
    id integer NOT NULL,
    apar_defect_version_map_id integer NOT NULL,
    ptf_id integer NOT NULL,
    release_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: adv_ptf_release_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE adv_ptf_release_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: adv_ptf_release_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE adv_ptf_release_maps_id_seq OWNED BY adv_ptf_release_maps.id;


--
-- Name: aix_files; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aix_files (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    sha1 character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: aix_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aix_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: aix_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aix_files_id_seq OWNED BY aix_files.id;


--
-- Name: apar_defect_version_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE apar_defect_version_maps (
    id integer NOT NULL,
    apar_id integer NOT NULL,
    defect_id integer NOT NULL,
    version_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: apar_defect_version_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apar_defect_version_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: apar_defect_version_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apar_defect_version_maps_id_seq OWNED BY apar_defect_version_maps.id;


--
-- Name: apars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE apars (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    abstract character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: apars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: apars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apars_id_seq OWNED BY apars.id;


--
-- Name: defects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE defects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: defects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE defects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: defects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE defects_id_seq OWNED BY defects.id;


--
-- Name: families; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE families (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: families_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE families_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: families_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE families_id_seq OWNED BY families.id;


--
-- Name: fileset_aix_file_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fileset_aix_file_maps (
    id integer NOT NULL,
    fileset_id integer NOT NULL,
    aix_file_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: fileset_aix_file_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fileset_aix_file_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: fileset_aix_file_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fileset_aix_file_maps_id_seq OWNED BY fileset_aix_file_maps.id;


--
-- Name: fileset_ptf_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fileset_ptf_maps (
    id integer NOT NULL,
    fileset_id integer NOT NULL,
    ptf_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: fileset_ptf_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fileset_ptf_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: fileset_ptf_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fileset_ptf_maps_id_seq OWNED BY fileset_ptf_maps.id;


--
-- Name: filesets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE filesets (
    id integer NOT NULL,
    lpp_id integer NOT NULL,
    vrmf character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: filesets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE filesets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: filesets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE filesets_id_seq OWNED BY filesets.id;


--
-- Name: image_paths; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE image_paths (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    package_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: image_paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE image_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: image_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE image_paths_id_seq OWNED BY image_paths.id;


--
-- Name: lpp_bases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lpp_bases (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: lpp_bases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lpp_bases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lpp_bases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lpp_bases_id_seq OWNED BY lpp_bases.id;


--
-- Name: lpps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lpps (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    lpp_base_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: lpps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lpps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: lpps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lpps_id_seq OWNED BY lpps.id;


--
-- Name: package_fileset_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE package_fileset_maps (
    id integer NOT NULL,
    package_id integer NOT NULL,
    fileset_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: package_fileset_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE package_fileset_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: package_fileset_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE package_fileset_maps_id_seq OWNED BY package_fileset_maps.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE packages (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    sha1 character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE packages_id_seq OWNED BY packages.id;


--
-- Name: ptfs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ptfs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: releases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE releases (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    family_id integer NOT NULL,
    version_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: ptfapardefs; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW ptfapardefs AS
    SELECT p.name AS ptf, a.name AS apar, d.name AS defect, b.name AS lpp_base, l.name AS lpp, r.name AS "release", f.name AS family, a.abstract, fs.vrmf, a.id AS apar_id, d.id AS defect_id, f.id AS family_id, fs.id AS fileset_id, b.id AS lpp_base_id, l.id AS lpp_id, p.id AS ptf_id, r.id AS release_id FROM apar_defect_version_maps adv, adv_ptf_release_maps apr, apars a, defects d, families f, fileset_ptf_maps f2p, filesets fs, lpp_bases b, lpps l, ptfs p, releases r WHERE ((((((((((a.id = adv.apar_id) AND (d.id = adv.defect_id)) AND (adv.id = apr.apar_defect_version_map_id)) AND (r.id = apr.release_id)) AND (p.id = apr.ptf_id)) AND (fs.id = f2p.fileset_id)) AND (p.id = f2p.ptf_id)) AND (fs.lpp_id = l.id)) AND (l.lpp_base_id = b.id)) AND (r.family_id = f.id));


--
-- Name: ptfs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ptfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
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
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE releases_id_seq OWNED BY releases.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: service_pack_fileset_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE service_pack_fileset_maps (
    id integer NOT NULL,
    service_pack_id integer NOT NULL,
    fileset_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: service_pack_fileset_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_pack_fileset_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: service_pack_fileset_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_pack_fileset_maps_id_seq OWNED BY service_pack_fileset_maps.id;


--
-- Name: service_packs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE service_packs (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: service_packs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE service_packs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: service_packs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE service_packs_id_seq OWNED BY service_packs.id;


--
-- Name: shipped_files; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW shipped_files AS
    SELECT ip.path AS image, ip.id AS image_id, p.name AS package, p.id AS package_id, lpp.name AS lpp, lpp.id AS lpp_id, fs.vrmf, fs.id AS fileset_id, af.path AS aix_file, af.id AS aix_file_id FROM image_paths ip, packages p, lpps lpp, filesets fs, package_fileset_maps pfm, aix_files af, fileset_aix_file_maps fafm WHERE ((((((ip.package_id = p.id) AND (fs.lpp_id = lpp.id)) AND (pfm.package_id = p.id)) AND (pfm.fileset_id = fs.id)) AND (fafm.fileset_id = fs.id)) AND (fafm.aix_file_id = af.id));


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE adv_ptf_release_maps ALTER COLUMN id SET DEFAULT nextval('adv_ptf_release_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE aix_files ALTER COLUMN id SET DEFAULT nextval('aix_files_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE apar_defect_version_maps ALTER COLUMN id SET DEFAULT nextval('apar_defect_version_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE apars ALTER COLUMN id SET DEFAULT nextval('apars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE defects ALTER COLUMN id SET DEFAULT nextval('defects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE families ALTER COLUMN id SET DEFAULT nextval('families_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE fileset_aix_file_maps ALTER COLUMN id SET DEFAULT nextval('fileset_aix_file_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE fileset_ptf_maps ALTER COLUMN id SET DEFAULT nextval('fileset_ptf_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE filesets ALTER COLUMN id SET DEFAULT nextval('filesets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE image_paths ALTER COLUMN id SET DEFAULT nextval('image_paths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lpp_bases ALTER COLUMN id SET DEFAULT nextval('lpp_bases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE lpps ALTER COLUMN id SET DEFAULT nextval('lpps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE package_fileset_maps ALTER COLUMN id SET DEFAULT nextval('package_fileset_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE packages ALTER COLUMN id SET DEFAULT nextval('packages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ptfs ALTER COLUMN id SET DEFAULT nextval('ptfs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE releases ALTER COLUMN id SET DEFAULT nextval('releases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE service_pack_fileset_maps ALTER COLUMN id SET DEFAULT nextval('service_pack_fileset_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE service_packs ALTER COLUMN id SET DEFAULT nextval('service_packs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: adv_ptf_release_maps_apar_defect_version_map_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_apar_defect_version_map_id_key UNIQUE (apar_defect_version_map_id, ptf_id, release_id);


--
-- Name: adv_ptf_release_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_pkey PRIMARY KEY (id);


--
-- Name: aix_files_path_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aix_files
    ADD CONSTRAINT aix_files_path_key UNIQUE (path, sha1);


--
-- Name: aix_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aix_files
    ADD CONSTRAINT aix_files_pkey PRIMARY KEY (id);


--
-- Name: apar_defect_version_maps_apar_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_apar_id_key UNIQUE (apar_id, defect_id, version_id);


--
-- Name: apar_defect_version_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_pkey PRIMARY KEY (id);


--
-- Name: apars_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apars
    ADD CONSTRAINT apars_name_key UNIQUE (name);


--
-- Name: apars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apars
    ADD CONSTRAINT apars_pkey PRIMARY KEY (id);


--
-- Name: defects_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defects
    ADD CONSTRAINT defects_name_key UNIQUE (name);


--
-- Name: defects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY defects
    ADD CONSTRAINT defects_pkey PRIMARY KEY (id);


--
-- Name: families_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY families
    ADD CONSTRAINT families_name_key UNIQUE (name);


--
-- Name: families_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY families
    ADD CONSTRAINT families_pkey PRIMARY KEY (id);


--
-- Name: fileset_aix_file_maps_fileset_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_fileset_id_key UNIQUE (fileset_id, aix_file_id);


--
-- Name: fileset_aix_file_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_pkey PRIMARY KEY (id);


--
-- Name: fileset_ptf_maps_fileset_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_fileset_id_key UNIQUE (fileset_id, ptf_id);


--
-- Name: fileset_ptf_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_pkey PRIMARY KEY (id);


--
-- Name: filesets_lpp_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_lpp_id_key UNIQUE (lpp_id, vrmf);


--
-- Name: filesets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_pkey PRIMARY KEY (id);


--
-- Name: image_paths_path_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_path_key UNIQUE (path);


--
-- Name: image_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_pkey PRIMARY KEY (id);


--
-- Name: lpp_bases_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lpp_bases
    ADD CONSTRAINT lpp_bases_name_key UNIQUE (name);


--
-- Name: lpp_bases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lpp_bases
    ADD CONSTRAINT lpp_bases_pkey PRIMARY KEY (id);


--
-- Name: lpps_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_name_key UNIQUE (name, lpp_base_id);


--
-- Name: lpps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_pkey PRIMARY KEY (id);


--
-- Name: package_fileset_maps_package_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_package_id_key UNIQUE (package_id, fileset_id);


--
-- Name: package_fileset_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_pkey PRIMARY KEY (id);


--
-- Name: packages_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_name_key UNIQUE (name, sha1);


--
-- Name: packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: ptfs_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ptfs
    ADD CONSTRAINT ptfs_name_key UNIQUE (name);


--
-- Name: ptfs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ptfs
    ADD CONSTRAINT ptfs_pkey PRIMARY KEY (id);


--
-- Name: releases_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_name_key UNIQUE (name, family_id);


--
-- Name: releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_pkey PRIMARY KEY (id);


--
-- Name: service_pack_fileset_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_pkey PRIMARY KEY (id);


--
-- Name: service_pack_fileset_maps_service_pack_id_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_service_pack_id_key UNIQUE (service_pack_id, fileset_id);


--
-- Name: service_packs_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY service_packs
    ADD CONSTRAINT service_packs_name_key UNIQUE (name);


--
-- Name: service_packs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY service_packs
    ADD CONSTRAINT service_packs_pkey PRIMARY KEY (id);


--
-- Name: versions_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_name_key UNIQUE (name);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: base_file_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX base_file_name_idx ON aix_files USING btree (basename((path)::text));


--
-- Name: index_adv_ptf_release_maps_on_apar_defect_version_map_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_adv_ptf_release_maps_on_apar_defect_version_map_id ON adv_ptf_release_maps USING btree (apar_defect_version_map_id);


--
-- Name: index_adv_ptf_release_maps_on_ptf_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_adv_ptf_release_maps_on_ptf_id ON adv_ptf_release_maps USING btree (ptf_id);


--
-- Name: index_adv_ptf_release_maps_on_release_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_adv_ptf_release_maps_on_release_id ON adv_ptf_release_maps USING btree (release_id);


--
-- Name: index_apar_defect_version_maps_on_defect_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_apar_defect_version_maps_on_defect_id ON apar_defect_version_maps USING btree (defect_id);


--
-- Name: index_apar_defect_version_maps_on_version_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_apar_defect_version_maps_on_version_id ON apar_defect_version_maps USING btree (version_id);


--
-- Name: index_fileset_ptf_maps_on_ptf_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fileset_ptf_maps_on_ptf_id ON fileset_ptf_maps USING btree (ptf_id);


--
-- Name: index_service_pack_fileset_maps_on_fileset_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_service_pack_fileset_maps_on_fileset_id ON service_pack_fileset_maps USING btree (fileset_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: adv_ptf_release_maps_apar_defect_version_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_apar_defect_version_map_id_fkey FOREIGN KEY (apar_defect_version_map_id) REFERENCES apar_defect_version_maps(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: adv_ptf_release_maps_ptf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_ptf_id_fkey FOREIGN KEY (ptf_id) REFERENCES ptfs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: adv_ptf_release_maps_release_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adv_ptf_release_maps
    ADD CONSTRAINT adv_ptf_release_maps_release_id_fkey FOREIGN KEY (release_id) REFERENCES releases(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps_apar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_apar_id_fkey FOREIGN KEY (apar_id) REFERENCES apars(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps_defect_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_defect_id_fkey FOREIGN KEY (defect_id) REFERENCES defects(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: apar_defect_version_maps_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY apar_defect_version_maps
    ADD CONSTRAINT apar_defect_version_maps_version_id_fkey FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_aix_file_maps_aix_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_aix_file_id_fkey FOREIGN KEY (aix_file_id) REFERENCES aix_files(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_aix_file_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_aix_file_maps
    ADD CONSTRAINT fileset_aix_file_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_ptf_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: fileset_ptf_maps_ptf_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fileset_ptf_maps
    ADD CONSTRAINT fileset_ptf_maps_ptf_id_fkey FOREIGN KEY (ptf_id) REFERENCES ptfs(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: filesets_lpp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY filesets
    ADD CONSTRAINT filesets_lpp_id_fkey FOREIGN KEY (lpp_id) REFERENCES lpps(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: image_paths_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY image_paths
    ADD CONSTRAINT image_paths_package_id_fkey FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: lpps_lpp_base_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY lpps
    ADD CONSTRAINT lpps_lpp_base_id_fkey FOREIGN KEY (lpp_base_id) REFERENCES lpp_bases(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: package_fileset_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: package_fileset_maps_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY package_fileset_maps
    ADD CONSTRAINT package_fileset_maps_package_id_fkey FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: releases_family_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_family_id_fkey FOREIGN KEY (family_id) REFERENCES families(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: releases_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY releases
    ADD CONSTRAINT releases_version_id_fkey FOREIGN KEY (version_id) REFERENCES versions(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: service_pack_fileset_maps_fileset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_fileset_id_fkey FOREIGN KEY (fileset_id) REFERENCES filesets(id) ON DELETE CASCADE DEFERRABLE;


--
-- Name: service_pack_fileset_maps_service_pack_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY service_pack_fileset_maps
    ADD CONSTRAINT service_pack_fileset_maps_service_pack_id_fkey FOREIGN KEY (service_pack_id) REFERENCES service_packs(id) ON DELETE CASCADE DEFERRABLE;


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('4');

INSERT INTO schema_migrations (version) VALUES ('5');

INSERT INTO schema_migrations (version) VALUES ('6');

INSERT INTO schema_migrations (version) VALUES ('7');

INSERT INTO schema_migrations (version) VALUES ('8');

INSERT INTO schema_migrations (version) VALUES ('9');

INSERT INTO schema_migrations (version) VALUES ('10');

INSERT INTO schema_migrations (version) VALUES ('13');

INSERT INTO schema_migrations (version) VALUES ('14');

INSERT INTO schema_migrations (version) VALUES ('22');

INSERT INTO schema_migrations (version) VALUES ('23');

INSERT INTO schema_migrations (version) VALUES ('24');

INSERT INTO schema_migrations (version) VALUES ('26');

INSERT INTO schema_migrations (version) VALUES ('27');

INSERT INTO schema_migrations (version) VALUES ('28');

INSERT INTO schema_migrations (version) VALUES ('34');

INSERT INTO schema_migrations (version) VALUES ('35');

INSERT INTO schema_migrations (version) VALUES ('40');

INSERT INTO schema_migrations (version) VALUES ('41');