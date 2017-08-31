DROP TABLE products;

CREATE TABLE products (
	product_no integer,
	product boolean,
	name varchar(20), -- it's alias to character varying
	--name character varying(12),
	description text,
	count integer,
	price numeric,
	created_at timestamp
);
