BEGIN
   EXECUTE IMMEDIATE 'DROP USER fdbo CASCADE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -01918 THEN
         RAISE;
      END IF;
END;
/

CREATE USER fdbo IDENTIFIED BY fdbo
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

GRANT CONNECT, RESOURCE TO fdbo;
GRANT CREATE VIEW TO fdbo;
GRANT CREATE SESSION TO fdbo;
GRANT CREATE TABLE TO fdbo;
GRANT CREATE SYNONYM TO fdbo;
GRANT CREATE DATABASE LINK TO fdbo;
GRANT CREATE ANY DIRECTORY TO fdbo;

GRANT EXECUTE ON UTL_HTTP TO fdbo;
GRANT EXECUTE ON DBMS_LOB TO fdbo;
GRANT EXECUTE ON DBMS_CRYPTO TO fdbo;

BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
      host => '*',
      ace  => xs$ace_type(
                privilege_list => xs$name_list('http'),
                principal_name => 'FDBO',
                principal_type => xs_acl.ptype_db
             )
   );
END;
/
