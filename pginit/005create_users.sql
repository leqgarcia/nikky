--
-- PostgreSQL database cluster dump
--

-- Started on 2023-07-05 10:43:41

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE nikky;
ALTER ROLE nikky WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
