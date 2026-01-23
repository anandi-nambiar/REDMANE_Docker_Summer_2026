--
-- PostgreSQL database dump
-- Dumped from database version 14.19 (Homebrew)
-- Dumped by pg_dump version 14.19 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    status TEXT
);


--
-- Name: datasets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasets (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    abstract TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    site TEXT NOT NULL
);


--
-- Name: datasets_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasets_metadata (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL REFERENCES public.datasets(id) ON DELETE CASCADE,
    key TEXT,
    value TEXT
);


--
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL REFERENCES public.datasets(id) ON DELETE CASCADE,
    path TEXT,
    file_type TEXT,
    CONSTRAINT file_type_check CHECK ((file_type = ANY (ARRAY['raw'::text, 'processed'::text, 'summarised'::text])))
);


--
-- Name: files_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files_metadata (
    metadata_id SERIAL PRIMARY KEY,
    file_id INTEGER REFERENCES public.files(id) ON DELETE CASCADE,
    metadata_key TEXT NOT NULL,
    metadata_value TEXT NOT NULL
);


--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE,
    ext_patient_id TEXT,
    ext_patient_url TEXT,
    public_patient_id TEXT
);


--
-- Name: patients_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients_metadata (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES public.patients(id) ON DELETE CASCADE,
    key TEXT,
    value TEXT
);


--
-- Name: samples; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.samples (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES public.patients(id) ON DELETE CASCADE,
    ext_sample_id TEXT,
    ext_sample_url TEXT
);


--
-- Name: samples_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.samples_metadata (
    id SERIAL PRIMARY KEY,
    sample_id INTEGER NOT NULL REFERENCES public.samples(id) ON DELETE CASCADE,
    key TEXT,
    value TEXT
);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, name, status) FROM stdin;
1	Cancer Genomics Portal	In Progress
2	AI for Pathology	Completed
3	Brain Imaging Dashboard	Pending
\.


--
-- Data for Name: datasets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasets (id, project_id, name, abstract, created_at, site) FROM stdin;
1	1	Whole-exome sequencing of Lung Cancer Tumour-Normal pairs	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Porta nibh venenatis cras sed felis eget velit. Cum sociis natoque penatibus et magnis dis parturient montes. Egestas purus viverra accumsan in nisl nisi scelerisque eu. Arcu vitae elementum curabitur vitae nunc sed velit dignissim sodales. Risus quis varius quam quisque id diam vel quam elementum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit cursus risus at ultrices mi tempus imperdiet.\n\nSed pulvinar proin gravida hendrerit lectus a. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Non blandit massa enim nec dui nunc mattis enim ut. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Gravida arcu ac tortor dignissim convallis aenean et. Nulla at volutpat diam ut venenatis tellus in metus.\n\nTurpis egestas sed tempus urna et pharetra pharetra massa. Curabitur gravida arcu ac tortor dignissim convallis aenean et. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae.	2024-04-03 00:00:00	WEHI Milton
2	1	Lung Cancer CITE-Seq	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Porta nibh venenatis cras sed felis eget velit. Cum sociis natoque penatibus et magnis dis parturient montes. Egestas purus viverra accumsan in nisl nisi scelerisque eu. Arcu vitae elementum curabitur vitae nunc sed velit dignissim sodales. Risus quis varius quam quisque id diam vel quam elementum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit cursus risus at ultrices mi tempus imperdiet.\n\nSed pulvinar proin gravida hendrerit lectus a. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Non blandit massa enim nec dui nunc mattis enim ut. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Gravida arcu ac tortor dignissim convallis aenean et. Nulla at volutpat diam ut venenatis tellus in metus.\n\nTurpis egestas sed tempus urna et pharetra pharetra massa. Curabitur gravida arcu ac tortor dignissim convallis aenean et. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae.	2024-05-02 00:00:00	WEHI Milton
3	1	Lung Cancer Microbiome	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Porta nibh venenatis cras sed felis eget velit. Cum sociis natoque penatibus et magnis dis parturient montes. Egestas purus viverra accumsan in nisl nisi scelerisque eu. Arcu vitae elementum curabitur vitae nunc sed velit dignissim sodales. Risus quis varius quam quisque id diam vel quam elementum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit cursus risus at ultrices mi tempus imperdiet.\n\nSed pulvinar proin gravida hendrerit lectus a. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Non blandit massa enim nec dui nunc mattis enim ut. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Gravida arcu ac tortor dignissim convallis aenean et. Nulla at volutpat diam ut venenatis tellus in metus.\n\nTurpis egestas sed tempus urna et pharetra pharetra massa. Curabitur gravida arcu ac tortor dignissim convallis aenean et. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae.	2024-07-12 00:00:00	WEHI Milton
4	1	Lung Cancer Clinical Data at ONJ	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Porta nibh venenatis cras sed felis eget velit. Cum sociis natoque penatibus et magnis dis parturient montes. Egestas purus viverra accumsan in nisl nisi scelerisque eu. Arcu vitae elementum curabitur vitae nunc sed velit dignissim sodales. Risus quis varius quam quisque id diam vel quam elementum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit cursus risus at ultrices mi tempus imperdiet.\n\nSed pulvinar proin gravida hendrerit lectus a. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi. Non blandit massa enim nec dui nunc mattis enim ut. In nulla posuere sollicitudin aliquam ultrices sagittis orci a scelerisque. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Gravida arcu ac tortor dignissim convallis aenean et. Nulla at volutpat diam ut venenatis tellus in metus.\n\nTurpis egestas sed tempus urna et pharetra pharetra massa. Curabitur gravida arcu ac tortor dignissim convallis aenean et. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Ut faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae.	2024-08-15 00:00:00	WEHI Milton
\.


--
-- Data for Name: datasets_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasets_metadata (id, dataset_id, key, value) FROM stdin;
1	1	location	/vast/projects/P1/P1001
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files (id, dataset_id, path, file_type) FROM stdin;
\.


--
-- Data for Name: files_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files_metadata (metadata_id, file_id, metadata_key, metadata_value) FROM stdin;
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (id, project_id, ext_patient_id, ext_patient_url, public_patient_id) FROM stdin;
1	1	EXT-P001	https://example.org/patient/EXT-P001	PUB-001
2	1	EXT-P002	https://example.org/patient/EXT-P002	PUB-002
3	1	EXT-P003	https://example.org/patient/EXT-P003	PUB-003
7	2	EXT-P004	https://example.org/patient/EXT-P004	PUB-004
8	3	EXT-P005	https://example.org/patient/EXT-P005	PUB-005
9	3	EXT-P006	https://example.org/patient/EXT-P006	PUB-006
\.


--
-- Data for Name: patients_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients_metadata (id, patient_id, key, value) FROM stdin;
\.


--
-- Data for Name: samples; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.samples (id, patient_id, ext_sample_id, ext_sample_url) FROM stdin;
1	1	SAMPLE-001-A	https://example.org/sample/SAMPLE-001-A
2	2	SAMPLE-002-A	https://example.org/sample/SAMPLE-002-A
3	3	SAMPLE-003-A	https://example.org/sample/SAMPLE-003-A
\.


--
-- Data for Name: samples_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.samples_metadata (id, sample_id, key, value) FROM stdin;
\.


--
-- Sync all SERIAL sequences to the current MAX(id)
--

SELECT setval(pg_get_serial_sequence('public.projects','id'), COALESCE(MAX(id),1)) FROM public.projects;
SELECT setval(pg_get_serial_sequence('public.datasets','id'), COALESCE(MAX(id),1)) FROM public.datasets;
SELECT setval(pg_get_serial_sequence('public.datasets_metadata','id'), COALESCE(MAX(id),1)) FROM public.datasets_metadata;
SELECT setval(pg_get_serial_sequence('public.patients','id'), COALESCE(MAX(id),1)) FROM public.patients;
SELECT setval(pg_get_serial_sequence('public.patients_metadata','id'), COALESCE(MAX(id),1)) FROM public.patients_metadata;
SELECT setval(pg_get_serial_sequence('public.files','id'), COALESCE(MAX(id),1)) FROM public.files;
SELECT setval(pg_get_serial_sequence('public.files_metadata','metadata_id'), COALESCE(MAX(metadata_id),1)) FROM public.files_metadata;
SELECT setval(pg_get_serial_sequence('public.samples','id'), COALESCE(MAX(id),1)) FROM public.samples;
SELECT setval(pg_get_serial_sequence('public.samples_metadata','id'), COALESCE(MAX(id),1)) FROM public.samples_metadata;


--
-- PostgreSQL database dump complete

