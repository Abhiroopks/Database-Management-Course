CREATE TABLE public."Test_Item"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    unit_of_measure character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Test_Item_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Test_Item"
    OWNER to postgres;

CREATE TABLE public."Test_Type"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    cost numeric(19,2) NOT NULL,
    code character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Test_Type_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Test_Type"
    OWNER to postgres;

CREATE TABLE public."Item_Alloc"
(
    item_id integer NOT NULL,
    type_id integer NOT NULL,
    CONSTRAINT "Item_Alloc_pkey" PRIMARY KEY (item_id, type_id),
    CONSTRAINT fk_item_id FOREIGN KEY (item_id)
        REFERENCES public."Test_Item" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_type_id FOREIGN KEY (type_id)
        REFERENCES public."Test_Type" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Item_Alloc"
    OWNER to postgres;
COMMENT ON TABLE public."Item_Alloc"
    IS 'Allows an M-N relationship between Test_Type and Test_Item. Thus, a single test type can utilize multiple items, and a single item can be used in multiple test types.';


CREATE TABLE public."Client"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    insurance character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    dob date NOT NULL,
    sex "char" NOT NULL,
    CONSTRAINT "Client_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Client"
    OWNER to postgres;


CREATE TABLE public."Employee"
(
    id integer NOT NULL,
    first_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phone numeric(10,0),
    email character varying(255) COLLATE pg_catalog."default",
    super_empid integer,
    CONSTRAINT "Employee_pkey" PRIMARY KEY (id),
    CONSTRAINT fk_super_id FOREIGN KEY (super_empid)
        REFERENCES public."Employee" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."Employee"
    OWNER to postgres;


CREATE TABLE public."Test"
(
    id integer NOT NULL,
    type_id integer NOT NULL,
    date_admin date NOT NULL,
    time_admin time(0) without time zone NOT NULL,
    emp_id integer NOT NULL,
    client_id integer NOT NULL,
    CONSTRAINT "Test_pkey" PRIMARY KEY (id),
    CONSTRAINT fk_client_id FOREIGN KEY (client_id)
        REFERENCES public."Client" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_emp_id FOREIGN KEY (emp_id)
        REFERENCES public."Employee" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_type_id FOREIGN KEY (type_id)
        REFERENCES public."Test_Type" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Test"
    OWNER to postgres;



