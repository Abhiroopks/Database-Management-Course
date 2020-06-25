CREATE TABLE public."Lab"
(
    lab_no integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    street character varying(255) COLLATE pg_catalog."default" NOT NULL,
    city character varying(255) COLLATE pg_catalog."default" NOT NULL,
    state character(2) COLLATE pg_catalog."default" NOT NULL,
    zip numeric(5,0) NOT NULL,
    CONSTRAINT "Lab_pkey" PRIMARY KEY (lab_no)
)

TABLESPACE pg_default;

ALTER TABLE public."Lab"
    OWNER to postgres;

CREATE TABLE public."LabVisit"
(
    lv_no integer NOT NULL,
    lv_date date NOT NULL,
    lv_prov_no integer NOT NULL,
    lv_ord_no integer,
    pat_no integer NOT NULL,
    lab_no integer NOT NULL,
    CONSTRAINT "LabVisit_pkey" PRIMARY KEY (lv_no),
    CONSTRAINT fk_lab_no FOREIGN KEY (lab_no)
        REFERENCES public."Lab" (lab_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_pat_no FOREIGN KEY (pat_no)
        REFERENCES public."Patient" (pat_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."LabVisit"
    OWNER to postgres;

CREATE TABLE public."Patient"
(
    pat_no integer NOT NULL,
    last_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    dob date NOT NULL,
    CONSTRAINT "Patients_pkey" PRIMARY KEY (pat_no)
)

TABLESPACE pg_default;

ALTER TABLE public."Patient"
    OWNER to postgres;

CREATE TABLE public."Specimen"
(
    spec_no integer NOT NULL,
    area character varying(255) COLLATE pg_catalog."default" NOT NULL,
    coll_method character varying(255) COLLATE pg_catalog."default" NOT NULL,
    lv_no integer NOT NULL,
    CONSTRAINT "Specimen_pkey" PRIMARY KEY (spec_no),
    CONSTRAINT fk_lv_no FOREIGN KEY (lv_no)
        REFERENCES public."LabVisit" (lv_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_coll_method CHECK (coll_method::text = ANY (ARRAY['vaginal'::character varying, 'cervical'::character varying, 'endocervical'::character varying]::text[])) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."Specimen"
    OWNER to postgres;

CREATE TABLE public."Supply"
(
    supp_no integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    lot_no integer NOT NULL,
    qoh integer NOT NULL,
    CONSTRAINT "Supply_pkey" PRIMARY KEY (supp_no)
)

TABLESPACE pg_default;

ALTER TABLE public."Supply"
    OWNER to postgres;

CREATE TABLE public."SupplyAllotment"
(
    to_no integer NOT NULL,
    supp_no integer NOT NULL,
    CONSTRAINT "SupplyAllotment_pkey" PRIMARY KEY (to_no, supp_no),
    CONSTRAINT fk_supp_no FOREIGN KEY (supp_no)
        REFERENCES public."Supply" (supp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_to_no FOREIGN KEY (to_no)
        REFERENCES public."TestOrder" (to_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."SupplyAllotment"
    OWNER to postgres;

CREATE TABLE public."TestOrder"
(
    to_no integer NOT NULL,
    test_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    test_type character varying(255) COLLATE pg_catalog."default" NOT NULL,
    test_result character varying(255) COLLATE pg_catalog."default" NOT NULL,
    spec_no integer NOT NULL,
    CONSTRAINT "TestOrder_pkey" PRIMARY KEY (to_no),
    CONSTRAINT fk_spec_no FOREIGN KEY (spec_no)
        REFERENCES public."Specimen" (spec_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_test_type CHECK (test_type::text = ANY (ARRAY['HPV'::character varying, 'CT/GC'::character varying, 'CT'::character varying, 'GC'::character varying]::text[])) NOT VALID,
    CONSTRAINT check_test_result CHECK (test_result::text = ANY (ARRAY['positive'::character varying, 'negative'::character varying, 'equivocal'::character varying, 'failure'::character varying]::text[])) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."TestOrder"
    OWNER to postgres;