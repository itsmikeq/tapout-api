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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: campaign_qualifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaign_qualifications (
    id bigint NOT NULL,
    campaign_quota_id bigint NOT NULL,
    question_id integer NOT NULL,
    pre_codes integer[] DEFAULT '{}'::integer[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: campaign_qualifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaign_qualifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaign_qualifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaign_qualifications_id_seq OWNED BY public.campaign_qualifications.id;


--
-- Name: campaign_quota; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaign_quota (
    id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: campaign_quota_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaign_quota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaign_quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaign_quota_id_seq OWNED BY public.campaign_quota.id;


--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campaigns (
    id bigint NOT NULL,
    length_of_interview integer NOT NULL,
    cpi character varying NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campaigns_id_seq OWNED BY public.campaigns.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: campaign_qualifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_qualifications ALTER COLUMN id SET DEFAULT nextval('public.campaign_qualifications_id_seq'::regclass);


--
-- Name: campaign_quota id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_quota ALTER COLUMN id SET DEFAULT nextval('public.campaign_quota_id_seq'::regclass);


--
-- Name: campaigns id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns ALTER COLUMN id SET DEFAULT nextval('public.campaigns_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: campaign_qualifications campaign_qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_qualifications
    ADD CONSTRAINT campaign_qualifications_pkey PRIMARY KEY (id);


--
-- Name: campaign_quota campaign_quota_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_quota
    ADD CONSTRAINT campaign_quota_pkey PRIMARY KEY (id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: cqa_question_id_campaign_quota_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX cqa_question_id_campaign_quota_id ON public.campaign_qualifications USING btree (question_id, campaign_quota_id);


--
-- Name: index_campaign_qualifications_on_campaign_quota_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_qualifications_on_campaign_quota_id ON public.campaign_qualifications USING btree (campaign_quota_id);


--
-- Name: index_campaign_quota_on_campaign_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_campaign_quota_on_campaign_id ON public.campaign_quota USING btree (campaign_id);


--
-- Name: campaign_quota fk_rails_3e78d37def; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_quota
    ADD CONSTRAINT fk_rails_3e78d37def FOREIGN KEY (campaign_id) REFERENCES public.campaigns(id);


--
-- Name: campaign_qualifications fk_rails_9586a32292; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campaign_qualifications
    ADD CONSTRAINT fk_rails_9586a32292 FOREIGN KEY (campaign_quota_id) REFERENCES public.campaign_quota(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210311214814'),
('20210311221540'),
('20210311235637');


