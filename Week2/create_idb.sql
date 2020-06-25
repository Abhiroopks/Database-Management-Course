CREATE TABLE public."Customer"
(
    custno character varying(8) COLLATE pg_catalog."default" NOT NULL,
    custname text COLLATE pg_catalog."default" NOT NULL,
    address text COLLATE pg_catalog."default" NOT NULL,
    contact text COLLATE pg_catalog."default" NOT NULL,
    phone numeric(7,0) NOT NULL,
    city text COLLATE pg_catalog."default" NOT NULL,
    state character varying(2) COLLATE pg_catalog."default" NOT NULL,
    zip numeric(5,0) NOT NULL,
    internal "char" NOT NULL,
    CONSTRAINT "PK_custno" PRIMARY KEY (custno)
)

TABLESPACE pg_default;

ALTER TABLE public."Customer"
    OWNER to postgres;

CREATE TABLE public."Employee"
(
    empno character varying(4) COLLATE pg_catalog."default" NOT NULL,
    empname text COLLATE pg_catalog."default" NOT NULL,
    department text COLLATE pg_catalog."default" NOT NULL,
    email text COLLATE pg_catalog."default" NOT NULL,
    phone character varying(6) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Employee_pkey" PRIMARY KEY (empno)
)

TABLESPACE pg_default;

ALTER TABLE public."Employee"
    OWNER to postgres;

CREATE TABLE public."EventPlan"
(
    planno character(4) COLLATE pg_catalog."default" NOT NULL,
    eventno character(4) COLLATE pg_catalog."default" NOT NULL,
    workdate date NOT NULL,
    notes text COLLATE pg_catalog."default",
    activity text COLLATE pg_catalog."default" NOT NULL,
    empno character(4) COLLATE pg_catalog."default",
    CONSTRAINT pk_planno PRIMARY KEY (planno),
    CONSTRAINT fk_empno FOREIGN KEY (empno)
        REFERENCES public."Employee" (empno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_eventno FOREIGN KEY (eventno)
        REFERENCES public."EventRequest" (eventno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."EventPlan"
    OWNER to postgres;

CREATE TABLE public."EventPlanLine"
(
    planno character(4) COLLATE pg_catalog."default" NOT NULL,
    lineno integer NOT NULL,
    numberfld integer NOT NULL,
    locno character(4) COLLATE pg_catalog."default" NOT NULL,
    resno character(4) COLLATE pg_catalog."default" NOT NULL,
    timestart timestamp without time zone NOT NULL,
    timeend timestamp without time zone NOT NULL,
    CONSTRAINT "pk_planno,lineno" PRIMARY KEY (planno, lineno),
    CONSTRAINT fk_locno FOREIGN KEY (locno)
        REFERENCES public."Location" (locno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_planno FOREIGN KEY (planno)
        REFERENCES public."EventPlan" (planno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_resno FOREIGN KEY (resno)
        REFERENCES public."ResourceTbl" (resno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."EventPlanLine"
    OWNER to postgres;

CREATE TABLE public."EventRequest"
(
    eventno character(4) COLLATE pg_catalog."default" NOT NULL,
    dateheld date NOT NULL,
    datereq date NOT NULL,
    facno character(4) COLLATE pg_catalog."default" NOT NULL,
    custno character(4) COLLATE pg_catalog."default" NOT NULL,
    dateauth date,
    status text COLLATE pg_catalog."default" NOT NULL,
    estcost money NOT NULL,
    estaudience integer NOT NULL,
    budno character(5) COLLATE pg_catalog."default",
    CONSTRAINT pk_eventno PRIMARY KEY (eventno),
    CONSTRAINT fk_custno FOREIGN KEY (custno)
        REFERENCES public."Customer" (custno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_facno FOREIGN KEY (facno)
        REFERENCES public."Facility" (facno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT check_status CHECK (status = ANY (ARRAY['Pending'::text, 'Denied'::text, 'Approved'::text])) NOT VALID,
    CONSTRAINT check_estaudience CHECK (estaudience > 0) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."EventRequest"
    OWNER to postgres;

CREATE TABLE public."Facility"
(
    facno character varying(4) COLLATE pg_catalog."default" NOT NULL,
    facname text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_facno PRIMARY KEY (facno)
)

TABLESPACE pg_default;

ALTER TABLE public."Facility"
    OWNER to postgres;

CREATE TABLE public."Location"
(
    locno character varying(4) COLLATE pg_catalog."default" NOT NULL,
    facno character varying(4) COLLATE pg_catalog."default" NOT NULL,
    locname text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_locno PRIMARY KEY (locno),
    CONSTRAINT fk_facno FOREIGN KEY (facno)
        REFERENCES public."Facility" (facno) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Location"
    OWNER to postgres;

CREATE TABLE public."ResourceTbl"
(
    resno character varying(4) COLLATE pg_catalog."default" NOT NULL,
    resname text COLLATE pg_catalog."default" NOT NULL,
    rate money NOT NULL,
    CONSTRAINT "ResourceTbl_pkey" PRIMARY KEY (resno),
    CONSTRAINT check_rate CHECK (rate::numeric > 0.0) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."ResourceTbl"
    OWNER to postgres;