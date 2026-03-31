CREATE OR REPLACE FUNCTION get_restheart_data_media(
    p_url  IN VARCHAR2,
    p_auth IN VARCHAR2 DEFAULT NULL
) RETURN CLOB
IS
    req        UTL_HTTP.req;
    resp       UTL_HTTP.resp;
    buffer     VARCHAR2(32767);
    result_clob CLOB;
    v_user     VARCHAR2(200);
    v_pass     VARCHAR2(200);
    v_sep      PLS_INTEGER;
BEGIN
    DBMS_LOB.CREATETEMPORARY(result_clob, TRUE);

    req := UTL_HTTP.begin_request(p_url, 'GET', 'HTTP/1.1');
    UTL_HTTP.set_header(req, 'Accept', 'application/json');

    IF p_auth IS NOT NULL THEN
        v_sep := INSTR(p_auth, ':');
        v_user := SUBSTR(p_auth, 1, v_sep - 1);
        v_pass := SUBSTR(p_auth, v_sep + 1);
        UTL_HTTP.set_authentication(req, v_user, v_pass);
    END IF;

    resp := UTL_HTTP.get_response(req);

    BEGIN
        LOOP
            UTL_HTTP.read_text(resp, buffer, 32767);
            DBMS_LOB.writeappend(result_clob, LENGTH(buffer), buffer);
        END LOOP;
    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
            NULL;
    END;

    UTL_HTTP.end_response(resp);
    RETURN result_clob;
END;
/
