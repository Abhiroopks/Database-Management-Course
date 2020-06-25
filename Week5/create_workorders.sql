CREATE TABLE public."Address"
(
    id integer NOT NULL,
    street character varying(255) COLLATE pg_catalog."default" NOT NULL,
    city character varying(255) COLLATE pg_catalog."default" NOT NULL,
    state character(2) COLLATE pg_catalog."default" NOT NULL,
    zip numeric(5,0) NOT NULL,
    CONSTRAINT "Address_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Address"
    OWNER to postgres;

CREATE TABLE public."Customer"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address_id integer NOT NULL,
    CONSTRAINT "Customer_pkey" PRIMARY KEY (id),
    CONSTRAINT fk_address_id FOREIGN KEY (address_id)
        REFERENCES public."Address" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."Customer"
    OWNER to postgres;

CREATE TABLE public."Employee"
(
    id integer NOT NULL,
    first_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phone numeric(10,0),
    email character varying(255) COLLATE pg_catalog."default",
    super_id integer,
    CONSTRAINT "Employee_pkey" PRIMARY KEY (id),
    CONSTRAINT fk_super_id FOREIGN KEY (super_id)
        REFERENCES public."Employee" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public."Employee"
    OWNER to postgres;


CREATE TABLE public."Material"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    est_cost numeric(19,2) NOT NULL,
    CONSTRAINT "Material_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Material"
    OWNER to postgres;

CREATE TABLE public."Task"
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    rate numeric(19,2) NOT NULL,
    est_hrs integer NOT NULL,
    CONSTRAINT "Task_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public."Task"
    OWNER to postgres;


CREATE TABLE public."WorkOrder"
(
    id integer NOT NULL,
    creation_date date NOT NULL,
    required_date date NOT NULL,
    completion_date date,
    customer_id integer NOT NULL,
    emp_id integer,
    address_id integer NOT NULL,
    CONSTRAINT "WorkOrder_pkey" PRIMARY KEY (id),
    CONSTRAINT fk_address_id FOREIGN KEY (address_id)
        REFERENCES public."Address" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_cust_id FOREIGN KEY (customer_id)
        REFERENCES public."Customer" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_emp_id FOREIGN KEY (emp_id)
        REFERENCES public."Employee" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."WorkOrder"
    OWNER to postgres;
-- Index: fki_fk_cust_id

-- DROP INDEX public.fki_fk_cust_id;

CREATE INDEX fki_fk_cust_id
    ON public."WorkOrder" USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE TABLE public."TaskAllocation"
(
    task_id integer NOT NULL,
    workorder_id integer NOT NULL,
    status character varying(255) COLLATE pg_catalog."default" NOT NULL,
    act_hrs integer,
    completion_date date,
    est_hrs integer NOT NULL,
    CONSTRAINT "TaskAllocation_pkey" PRIMARY KEY (task_id, workorder_id),
    CONSTRAINT fk_task_id FOREIGN KEY (task_id)
        REFERENCES public."Task" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_taskalloc_workorder_id FOREIGN KEY (workorder_id)
        REFERENCES public."WorkOrder" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."TaskAllocation"
    OWNER to postgres;

CREATE TABLE public."MaterialAllocation"
(
    material_id integer NOT NULL,
    workorder_id integer NOT NULL,
    est_quant integer NOT NULL,
    actual_quant integer,
    CONSTRAINT "MaterialAllocation_pkey" PRIMARY KEY (material_id, workorder_id),
    CONSTRAINT fk_material_id FOREIGN KEY (material_id)
        REFERENCES public."Material" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_workorder_id FOREIGN KEY (workorder_id)
        REFERENCES public."WorkOrder" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."MaterialAllocation"
    OWNER to postgres;




